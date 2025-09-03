import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flower_app/core/errors/api_result.dart';
import 'package:flower_app/features/profile/data/models/profile_response.dart';
import 'package:injectable/injectable.dart';
import '../../data/datasource/profile_remote_datasource.dart';
import '../../data/models/edit_profile_request_model.dart';
import '../../data/models/edit_profile_response_model.dart';
import '../../data/models/upload_photo_response.dart';
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

  @override
  Future<ApiResult<EditProfileResponseModel>> editProfile(EditProfileRequestModel model)async {
    try {
      final response = await _profileApiClient.editProfile(model);
      return ApiSuccessResult(response);
    } catch (e) {
      return ApiErrorResult(e.toString());
    }
  }

  @override
  Future<ApiResult<UploadPhotoResponse>> uploadPhoto(File photo) async {
    try {
      final response = await _profileApiClient.uploadPhoto(photo);
      return ApiSuccessResult(response);
    } catch (e) {
      return ApiErrorResult(e.toString());
    }
  }

}
