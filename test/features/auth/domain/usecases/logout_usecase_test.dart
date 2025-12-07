import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:flower_app/features/auth/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_use_cases_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockAuthRepo;
  late LogoutUseCase logoutUseCase;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    logoutUseCase = LogoutUseCase(mockAuthRepo);
  });

  group('LogoutUseCase', () {
    test('should return success message when repo.logout is successful',
        () async {
      // Arrange
      when(mockAuthRepo.logout()).thenAnswer((_) async => "Logout Success");

      // Act
      final result = await logoutUseCase();

      // Assert
      expect(result, "Logout Success");
      verify(mockAuthRepo.logout()).called(1);
    });

    test('should throw exception when repo.logout fails', () async {
      // Arrange
      when(mockAuthRepo.logout()).thenThrow(Exception("Logout Failed"));

      // Act
      Future<String> call() => logoutUseCase();

      // Assert
      expect(call, throwsA(isA<Exception>()));
      verify(mockAuthRepo.logout()).called(1);
    });
  });
}
