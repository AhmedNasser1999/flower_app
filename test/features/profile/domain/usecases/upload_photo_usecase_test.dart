import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/core/errors/api_result.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:flower_app/features/profile/domain/usecases/upload_photo_usecase.dart';

import 'upload_photo_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late MockProfileRepository mockProfileRepository;
  late UploadPhotoUseCase useCase;

  setUpAll(() {
    provideDummy<ApiResult<UploadPhotoResponse>>(
      ApiSuccessResult(UploadPhotoResponse(message: "uploaded")),
    );
  });

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    useCase = UploadPhotoUseCase(mockProfileRepository);
  });

  final fakeFile = File("test.jpg");
  final fakeResponse = UploadPhotoResponse(message: "Photo uploaded");

  group('UploadPhotoUseCase', () {
    test('should return ApiSuccessResult when repository succeeds', () async {
      // arrange
      when(mockProfileRepository.uploadPhoto(fakeFile))
          .thenAnswer((_) async => ApiSuccessResult(fakeResponse));

      // act
      final result = await useCase(fakeFile);
      final success = result as ApiSuccessResult<UploadPhotoResponse>;

      // assert
      expect(result, isA<ApiSuccessResult<UploadPhotoResponse>>());
      expect(success.data.message, "Photo uploaded");
      verify(mockProfileRepository.uploadPhoto(fakeFile)).called(1);
    });

    test('should return ApiErrorResult when repository fails', () async {
      // arrange
      when(mockProfileRepository.uploadPhoto(fakeFile))
          .thenAnswer((_) async => ApiErrorResult("Upload failed"));

      // act
      final result = await useCase(fakeFile);

      // assert
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, "Upload failed");
      verify(mockProfileRepository.uploadPhoto(fakeFile)).called(1);
    });
  });
}
