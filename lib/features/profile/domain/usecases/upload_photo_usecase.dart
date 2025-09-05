import 'dart:io';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/api_result.dart';
import '../../data/models/upload_photo_response.dart';
import '../repositories/profile_repository.dart';

@injectable
class UploadPhotoUseCase {
  final ProfileRepository _repo;

  UploadPhotoUseCase(this._repo);

  Future<ApiResult<UploadPhotoResponse>> call(File photo) {
    return _repo.uploadPhoto(photo);
  }
}
