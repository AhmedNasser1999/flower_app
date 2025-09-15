import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/core/errors/api_result.dart';
import 'package:flower_app/features/profile/domain/entity/user_entity.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:flower_app/features/profile/domain/usecases/get_profile_data_usecase.dart';

import 'get_profile_data_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late MockProfileRepository mockProfileRepository;
  late GetProfileDataUseCase getProfileDataUseCase;

  setUpAll(() {
    provideDummy<ApiResult<UserEntity>>(
      ApiSuccessResult(
        UserEntity(
          id: "0",
          firstName: "Dummy",
          lastName: "User",
          email: "dummy@example.com",
          gender: "unknown",
          phone: "0000000000",
          photo: "",
          role: "test",
        ),
      ),
    );
  });

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    getProfileDataUseCase = GetProfileDataUseCase(mockProfileRepository);
  });

  group('GetProfileDataUseCase', () {
    test('should return ApiSuccessResult<UserEntity> when repository succeeds',
        () async {
      // arrange
      final fakeUser = UserEntity(
        id: "123",
        firstName: "Mouayed",
        lastName: "Mohamed",
        email: "mouayed@example.com",
        gender: "male",
        phone: "01000000000",
        photo: "https://example.com/photo.jpg",
        role: "customer",
      );

      when(mockProfileRepository.getProfile())
          .thenAnswer((_) async => ApiSuccessResult(fakeUser));

      // act
      final result = await getProfileDataUseCase();

      // assert
      expect(result, isA<ApiSuccessResult<UserEntity>>());
      final success = result as ApiSuccessResult<UserEntity>;
      expect(success.data.id, "123");
      expect(success.data.firstName, "Mouayed");
      expect(success.data.email, "mouayed@example.com");
      verify(mockProfileRepository.getProfile()).called(1);
    });

    test('should return ApiErrorResult when repository fails', () async {
      // arrange
      when(mockProfileRepository.getProfile())
          .thenAnswer((_) async => ApiErrorResult("Unauthorized"));

      // act
      final result = await getProfileDataUseCase();

      // assert
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, "Unauthorized");
      verify(mockProfileRepository.getProfile()).called(1);
    });
  });
}
