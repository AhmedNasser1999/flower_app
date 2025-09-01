import 'package:flower_app/features/profile/domain/entity/user_entity.dart';
import 'package:flower_app/features/profile/presentation/viewmodel/states/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/edit_profile_request_model.dart';
import '../../domain/usecases/edit_profile_data_usecase.dart';

class EditProfileViewModel extends Cubit<EditProfileStates>{
  final EditProfileDataUseCase _editProfileDataUseCase;

  EditProfileViewModel(this._editProfileDataUseCase) : super(EditProfileInitialState());

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  void setInitialData(UserEntity user) {
    firstnameController.text = user.firstName;
    lastnameController.text = user.lastName;
    emailController.text = user.email;
    phoneController.text = user.phone;
  }


  Future<void> submitProfileUpdate() async {
    emit(EditProfileInitialState());

    try {
      final request = EditProfileRequestModel(
        firstName: firstnameController.text,
        lastName: lastnameController.text,
        email: emailController.text,
        phone: phoneController.text,
      );


      final response = await _editProfileDataUseCase(request);

      emit(EditProfileSuccessState(message: response.message!));
    } catch (e) {
      emit(EditProfileErrorState(message: e.toString()));
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