import 'dart:io';
import 'package:flower_app/core/errors/api_result.dart';
import 'package:flower_app/features/profile/data/models/change_password_request_model.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_datasource.dart';
import 'package:injectable/injectable.dart';
import '../models/edit_profile_request_model.dart';
import '../models/edit_profile_response_model.dart';
import '../models/upload_photo_response.dart';

import '../models/change_password_response_model.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _remoteDatasource;

  ProfileRepositoryImpl(this._remoteDatasource);

  @override
  Future<ApiResult<UserEntity>> getProfile() async {
    final result = await _remoteDatasource.getProfile();

    return switch (result) {
      ApiSuccessResult(:final data) => ApiSuccessResult(UserEntity(
          id: data.user.Id ?? '',
          firstName: data.user.firstName ?? '',
          lastName: data.user.lastName ?? '',
          email: data.user.email ?? '',
          gender: data.user.gender ?? '',
          phone: data.user.phone ?? '',
          photo: data.user.photo ?? '',
          role: data.user.role ?? '',
        )),
      ApiErrorResult(:final errorMessage) => ApiErrorResult(errorMessage),
    };
  }

  @override
  Future<ChangePasswordResponseModel> changePassword(
      ChangePasswordRequestModel changePasswordRequestModel) {
    return _remoteDatasource.changePassword(changePasswordRequestModel);
  }

  @override
  Future<ApiResult<EditProfileResponseModel>> editProfile(
      EditProfileRequestModel model) async {
    final result = await _remoteDatasource.editProfile(model);
    return switch (result) {
      ApiSuccessResult(:final data) => ApiSuccessResult(data),
      ApiErrorResult(:final errorMessage) => ApiErrorResult(errorMessage),
    };
  }

  @override
  Future<ApiResult<UploadPhotoResponse>> uploadPhoto(File photo) {
    return _remoteDatasource.uploadPhoto(photo);
  }
}
