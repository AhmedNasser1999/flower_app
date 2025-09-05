import 'package:flower_app/core/errors/api_result.dart';

import '../models/profile_response.dart';

abstract class ProfileRemoteDatasource {
  Future<ApiResult<ProfileResponse>> getProfile();
}