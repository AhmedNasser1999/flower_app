

import 'package:flower_app/features/profile/data/models/change_password_request_model.dart';
import 'package:flower_app/features/profile/data/models/change_password_response_model.dart';
import 'package:injectable/injectable.dart';

import '../repositories/profile_repository.dart';

@lazySingleton
class ChangePasswordUseCases {
  final ProfileRepository _profileRepository;

  ChangePasswordUseCases(this._profileRepository);

  Future<ChangePasswordResponseModel> call(ChangePasswordRequestModel request) {
    return _profileRepository.changePassword(request);
  }

}