import 'dart:io';
import 'package:flower_app/features/auth/data/models/login_models/user_model.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request_model.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_response_model.dart';
import 'package:flower_app/features/profile/data/models/profile_response.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flower_app/features/profile/domain/entity/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/core/errors/api_result.dart';
import 'package:flower_app/features/profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:flower_app/features/profile/data/datasource/profile_remote_datasource.dart';

import 'profile_repositories_impl_test.mocks.dart';


@GenerateMocks([ProfileRemoteDatasource])
void main() {
  late MockProfileRemoteDatasource mockRemoteDatasource;
  late ProfileRepository repository;

  setUpAll(() {
    provideDummy<ApiResult<ProfileResponse>>(
      ApiSuccessResult(
        ProfileResponse(
          message: "dummy",
          user: User(
            Id: "0",
            firstName: "Dummy",
            lastName: "User",
            email: "dummy@example.com",
            gender: "unknown",
            phone: "0000000000",
            photo: "",
            role: "test",
            wishlist: [],
            addresses: [],
            createdAt: "2025-01-01T00:00:00Z",
          ),
        ),
      ),
    );

    provideDummy<ApiResult<EditProfileResponseModel>>(
      ApiSuccessResult(
        EditProfileResponseModel(
          message: "ok",
          user: User(
            Id: "1",
            firstName: "X",
            lastName: "Y",
            email: "x@example.com",
            gender: "male",
            phone: "123",
            photo: "",
            role: "customer",
            wishlist: [],
            addresses: [],
            createdAt: "2025-01-01T00:00:00Z",
          ),
        ),
      ),
    );

    provideDummy<ApiResult<UploadPhotoResponse>>(
      ApiSuccessResult(UploadPhotoResponse(message: "uploaded")),
    );
  });

  setUp(() {
    mockRemoteDatasource = MockProfileRemoteDatasource();
    repository = ProfileRepositoryImpl(mockRemoteDatasource);
  });

  group('ProfileRepositoryImpl - getProfile', () {
    test('should return ApiSuccessResult<UserEntity> when datasource succeeds', () async {
      // arrange
      final fakeUser = User(
        Id: "123",
        firstName: "Mouayed",
        lastName: "Mohamed",
        email: "mouayed@example.com",
        gender: "male",
        phone: "01000000000",
        photo: "https://example.com/photo.jpg",
        role: "customer",
        wishlist: [],
        addresses: [],
        createdAt: "2025-09-01T00:00:00Z",
      );

      final fakeResponse = ProfileResponse(
        message: "Profile fetched successfully",
        user: fakeUser,
      );

      when(mockRemoteDatasource.getProfile())
          .thenAnswer((_) async => ApiSuccessResult(fakeResponse));

      // act
      final result = await repository.getProfile();
      final success = result as ApiSuccessResult<UserEntity>;

      // assert
      expect(result, isA<ApiSuccessResult<UserEntity>>());
      expect(success.data.id, "123");
      expect(success.data.firstName, "Mouayed");
      expect(success.data.lastName, "Mohamed");
      expect(success.data.email, "mouayed@example.com");

      verify(mockRemoteDatasource.getProfile()).called(1);
    });

    test('should return ApiErrorResult when datasource returns error', () async {
      // arrange
      when(mockRemoteDatasource.getProfile())
          .thenAnswer((_) async => ApiErrorResult("Unauthorized"));

      // act
      final result = await repository.getProfile();

      // assert
      expect(result, isA<ApiErrorResult>());
      final error = result as ApiErrorResult;
      expect(error.errorMessage, "Unauthorized");

      verify(mockRemoteDatasource.getProfile()).called(1);
    });
  });

  group('ProfileRepositoryImpl - editProfile', () {
    final fakeUser = User(
      Id: "123",
      firstName: "Mouayed",
      lastName: "Mohamed",
      email: "mouayed@example.com",
      gender: "male",
      phone: "01000000000",
      photo: "https://example.com/photo.jpg",
      role: "customer",
      wishlist: [],
      addresses: [],
      createdAt: "2025-09-01T00:00:00Z",
    );

    final fakeRequest = EditProfileRequestModel(
      firstName: "John",
      lastName: "Doe",
      email: "john@example.com",
      phone: "01000000000",
    );

    final fakeResponse = EditProfileResponseModel(
      message: "Profile updated",
      user: fakeUser,
    );

    test('should return ApiSuccessResult when datasource succeeds', () async {
      // arrange
      when(mockRemoteDatasource.editProfile(fakeRequest))
          .thenAnswer((_) async => ApiSuccessResult(fakeResponse));

      // act
      final result = await repository.editProfile(fakeRequest);
      final success = result as ApiSuccessResult<EditProfileResponseModel>;


      // assert
      expect(result, isA<ApiSuccessResult<EditProfileResponseModel>>());
      expect(success.data.message, "Profile updated");
      expect(success.data.user.email, "mouayed@example.com");
      verify(mockRemoteDatasource.editProfile(fakeRequest)).called(1);
    });

    test('should return ApiErrorResult when datasource fails', () async {
      // arrange
      when(mockRemoteDatasource.editProfile(fakeRequest))
          .thenAnswer((_) async => ApiErrorResult("Bad request"));

      // act
      final result = await repository.editProfile(fakeRequest);

      // assert
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, "Bad request");
      verify(mockRemoteDatasource.editProfile(fakeRequest)).called(1);
    });
  });

  group('ProfileRepositoryImpl - uploadPhoto', () {
    final fakeFile = File("test.jpg");
    final fakeResponse = UploadPhotoResponse(message: "Photo uploaded");

    test('should return ApiSuccessResult when datasource succeeds', () async {
      // arrange
      when(mockRemoteDatasource.uploadPhoto(fakeFile))
          .thenAnswer((_) async => ApiSuccessResult(fakeResponse));

      // act
      final result = await repository.uploadPhoto(fakeFile);
      final success = result as ApiSuccessResult<UploadPhotoResponse>;

      // assert
      expect(result, isA<ApiSuccessResult<UploadPhotoResponse>>());
      expect(success.data.message, "Photo uploaded");
      verify(mockRemoteDatasource.uploadPhoto(fakeFile)).called(1);
    });

    test('should return ApiErrorResult when datasource fails', () async {
      // arrange
      when(mockRemoteDatasource.uploadPhoto(fakeFile))
          .thenAnswer((_) async => ApiErrorResult("Upload failed"));

      // act
      final result = await repository.uploadPhoto(fakeFile);

      // assert
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, "Upload failed");
      verify(mockRemoteDatasource.uploadPhoto(fakeFile)).called(1);
    });
  });
}
