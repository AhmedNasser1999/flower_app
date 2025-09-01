import 'package:flower_app/core/errors/api_result.dart';

import '../../data/models/change_password_request_model.dart';
import '../../data/models/change_password_response_model.dart';
import '../entity/user_entity.dart';

abstract class ProfileRepository {
  Future<ApiResult<UserEntity>> getProfile();
  Future<ChangePasswordResponseModel> changePassword(ChangePasswordRequestModel changePasswordRequestModel);
}