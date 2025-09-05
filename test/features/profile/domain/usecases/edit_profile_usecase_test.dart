import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/core/errors/api_result.dart';
import 'package:flower_app/features/auth/data/models/login_models/user_model.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request_model.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_response_model.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:flower_app/features/profile/domain/usecases/edit_profile_data_usecase.dart';


import 'edit_profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late MockProfileRepository mockProfileRepository;
  late EditProfileDataUseCase useCase;

  setUpAll(() {
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
  });


  setUp(() {
    mockProfileRepository = MockProfileRepository();
    useCase = EditProfileDataUseCase(mockProfileRepository);
  });

  final fakeRequest = EditProfileRequestModel(
    firstName: "John",
    lastName: "Doe",
    email: "john@example.com",
    phone: "01000000000",
  );

  final fakeUser = User(
    Id: "123",
    firstName: "John",
    lastName: "Doe",
    email: "john@example.com",
    gender: "male",
    phone: "01000000000",
    photo: "https://example.com/photo.jpg",
    role: "customer",
    wishlist: [],
    addresses: [],
    createdAt: "2025-09-01T00:00:00Z",
  );

  final fakeResponse = EditProfileResponseModel(
    message: "Profile updated",
    user: fakeUser,
  );

  group('EditProfileDataUseCase', () {
    test('should return ApiSuccessResult when repository succeeds', () async {
      // arrange
      when(mockProfileRepository.editProfile(fakeRequest))
          .thenAnswer((_) async => ApiSuccessResult(fakeResponse));

      // act
      final result = await useCase(fakeRequest);
      final success = result as ApiSuccessResult<EditProfileResponseModel>;

      // assert
      expect(result, isA<ApiSuccessResult<EditProfileResponseModel>>());
      expect(success.data.message, "Profile updated");
      expect(success.data.user.email, "john@example.com");
      verify(mockProfileRepository.editProfile(fakeRequest)).called(1);
    });

    test('should return ApiErrorResult when repository fails', () async {
      // arrange
      when(mockProfileRepository.editProfile(fakeRequest))
          .thenAnswer((_) async => ApiErrorResult("Update failed"));

      // act
      final result = await useCase(fakeRequest);

      // assert
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, "Update failed");
      verify(mockProfileRepository.editProfile(fakeRequest)).called(1);
    });
  });
}
