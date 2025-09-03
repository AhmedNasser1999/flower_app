import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/api_result.dart';
import '../../data/models/edit_profile_request_model.dart';
import '../../data/models/edit_profile_response_model.dart';
import '../../data/models/upload_photo_response.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecases/edit_profile_data_usecase.dart';
import '../../domain/usecases/upload_photo_usecase.dart';
import '../viewmodel/states/edit_profile_states.dart';

class EditProfileViewModel extends Cubit<EditProfileStates> {
  final EditProfileDataUseCase _editProfileDataUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;

  EditProfileViewModel(
    this._editProfileDataUseCase,
    this._uploadPhotoUseCase,
  ) : super(EditProfileInitialState());

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? currentPhotoUrl;

  void setInitialData(UserEntity user) {
    firstnameController.text = user.firstName;
    lastnameController.text = user.lastName;
    emailController.text = user.email;
    phoneController.text = user.phone;
    currentPhotoUrl = user.photo;
    if (currentPhotoUrl != null) {
      emit(ProfilePhotoUpdatedState(currentPhotoUrl!));
    }
  }

  Future<void> submitProfileUpdate() async {
    emit(EditProfileInitialState());
    final request = EditProfileRequestModel(
      firstName: firstnameController.text,
      lastName: lastnameController.text,
      email: emailController.text,
      phone: phoneController.text,
    );
    final response = await _editProfileDataUseCase(request);
    if (response is ApiSuccessResult<EditProfileResponseModel>) {
      emit(EditProfileSuccessState(message: response.data.message));
    } else if (response is ApiErrorResult<EditProfileResponseModel>) {
      emit(EditProfileErrorState(message: response.errorMessage));
    } else {
      emit(EditProfileErrorState(message: 'Unexpected error'));
    }
  }

  Future<void> uploadPhoto(File file) async {
    emit(ProfilePhotoLoadingState());

    final result = await _uploadPhotoUseCase(file);

    if (result is ApiSuccessResult<UploadPhotoResponse>) {
      currentPhotoUrl = file.path;
      emit(ProfilePhotoUpdatedState(result.data.message));
    } else if (result is ApiErrorResult<UploadPhotoResponse>) {
      emit(ProfilePhotoErrorState(message: result.errorMessage));
    } else {
      emit(ProfilePhotoErrorState(message: 'Unexpected error'));
    }
  }

  @override
  Future<void> close() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
