import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/api_result.dart';
import '../../data/models/edit_profile_request_model.dart';
import '../../data/models/edit_profile_response_model.dart';

@injectable
class EditProfileDataUseCase {
  final ProfileRepository _profileRepo;

  EditProfileDataUseCase(this._profileRepo);

  Future<ApiResult<EditProfileResponseModel>> call(
      EditProfileRequestModel model) async {
    return await _profileRepo.editProfile(model);
  }
}
