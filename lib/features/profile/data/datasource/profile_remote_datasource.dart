import 'package:flower_app/core/errors/api_result.dart';

import '../models/change_password_request_model.dart';
import '../models/change_password_response_model.dart';
import '../models/profile_response.dart';

abstract class ProfileRemoteDatasource {
  Future<ApiResult<ProfileResponse>> getProfile();
  Future<ChangePasswordResponseModel> changePassword(ChangePasswordRequestModel changePasswordRequestModel);
}