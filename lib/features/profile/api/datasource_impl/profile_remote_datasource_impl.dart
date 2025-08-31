import 'package:dio/dio.dart';
import 'package:flower_app/core/errors/api_result.dart';
import 'package:flower_app/features/profile/data/models/profile_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasource/profile_remote_datasource.dart';
import '../client/profile_api_client.dart';

@LazySingleton(as: ProfileRemoteDatasource)
class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final ProfileApiClient _profileApiClient;

  ProfileRemoteDatasourceImpl({required ProfileApiClient apiClient}) : _profileApiClient = apiClient;

  @override
  Future<ApiResult<ProfileResponse>> getProfile() async{
    try {
      final response = await _profileApiClient.getProfile();
      return ApiSuccessResult(response);
    } on DioException catch (e) {
      return ApiErrorResult(e.response?.data['message'] ?? 'Server error');
    } catch (_) {
      return ApiErrorResult('Unexpected error');
    }
  }
}