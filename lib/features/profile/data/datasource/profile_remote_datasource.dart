import 'package:flower_app/core/errors/api_result.dart';
import '../models/edit_profile_request_model.dart';
import '../models/edit_profile_response_model.dart';
import '../models/profile_response.dart';

abstract class ProfileRemoteDatasource {
  Future<ApiResult<ProfileResponse>> getProfile();
  Future<EditProfileResponseModel> editProfile(EditProfileRequestModel model);
}