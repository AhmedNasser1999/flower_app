import 'package:flower_app/features/profile/data/models/change_password_request_model.dart';
import 'package:flower_app/features/profile/data/models/change_password_response_model.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:flower_app/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_password_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late MockProfileRepository mockProfileRepository;
  late ChangePasswordUseCases changePasswordUseCases;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    changePasswordUseCases = ChangePasswordUseCases(mockProfileRepository);
  });

  group('ChangePasswordUseCases', () {
    test('should return ChangePasswordResponseModel when repository call is successful', () async {
      // Arrange
      final request = ChangePasswordRequestModel(
        password: "old123",
        newPassword: "new123",
      );

      final response = ChangePasswordResponseModel(
        message: "Password updated successfully",
        token: "newToken456",
      );

      when(mockProfileRepository.changePassword(request))
          .thenAnswer((_) async => response);

      // Act
      final result = await changePasswordUseCases(request);

      // Assert
      expect(result.message, "Password updated successfully");
      expect(result.token, "newToken456");
      verify(mockProfileRepository.changePassword(request)).called(1);
      verifyNoMoreInteractions(mockProfileRepository);
    });

    test('should throw Exception when repository throws error', () async {
      final request = ChangePasswordRequestModel(
        password: "old123",
        newPassword: "new123",
      );

      when(mockProfileRepository.changePassword(request))
          .thenThrow(Exception("Something went wrong"));

      // Assert
      expect(
            () => changePasswordUseCases(request),
        throwsA(isA<Exception>()),
      );

      verify(mockProfileRepository.changePassword(request)).called(1);
    });
  });
}
