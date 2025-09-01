import 'package:flower_app/core/errors/api_result.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_datasource.dart';
import 'package:injectable/injectable.dart';

import '../models/edit_profile_request_model.dart';
import '../models/edit_profile_response_model.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImpl(this.remoteDatasource);

  @override
  Future<ApiResult<UserEntity>> getProfile() async {
    final result = await remoteDatasource.getProfile();

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
  Future<EditProfileResponseModel> editProfile(EditProfileRequestModel model) async{
    try {
      return await remoteDatasource.editProfile(model);
    } catch(e) {
      throw e.toString();
    }
  }
}
