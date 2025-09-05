import 'dart:io';
import 'package:flower_app/core/errors/api_result.dart';

import '../models/change_password_request_model.dart';
import '../models/change_password_response_model.dart';
import '../models/edit_profile_request_model.dart';
import '../models/edit_profile_response_model.dart';
import '../models/profile_response.dart';
import '../models/upload_photo_response.dart';

abstract class ProfileRemoteDatasource {
  Future<ApiResult<ProfileResponse>> getProfile();
  Future<ChangePasswordResponseModel> changePassword(ChangePasswordRequestModel changePasswordRequestModel);
  Future<ApiResult<EditProfileResponseModel>>  editProfile(EditProfileRequestModel model);
  Future<ApiResult<UploadPhotoResponse>> uploadPhoto(File photo);
}