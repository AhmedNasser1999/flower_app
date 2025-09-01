import 'package:flower_app/core/errors/api_result.dart';
import '../../data/models/edit_profile_request_model.dart';
import '../../data/models/edit_profile_response_model.dart';
import '../entity/user_entity.dart';

abstract class ProfileRepository {
  Future<ApiResult<UserEntity>> getProfile();
  Future<EditProfileResponseModel> editProfile(EditProfileRequestModel model);
}