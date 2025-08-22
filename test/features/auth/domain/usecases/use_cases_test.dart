import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:flower_app/features/auth/domain/responses/auth_response.dart';
import 'package:flower_app/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:flower_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:flower_app/features/auth/domain/usecases/verify_code_usecase.dart';

import 'use_cases_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockAuthRepo;
  late ForgetPasswordUseCase forgetPasswordUseCase;
  late ResetPasswordUseCase resetPasswordUseCase;
  late VerifyCodeUseCase verifyCodeUseCase;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    forgetPasswordUseCase = ForgetPasswordUseCase(mockAuthRepo);
    resetPasswordUseCase = ResetPasswordUseCase(mockAuthRepo);
    verifyCodeUseCase = VerifyCodeUseCase(mockAuthRepo);
  });

  group('ForgetPasswordUseCase', () {
    test('should return success', () async {
      when(mockAuthRepo.forgetPassword(any))
          .thenAnswer((_) async => AuthResponse.success('email sent'));

      final result = await forgetPasswordUseCase('test@example.com');

      expect(result.data, 'email sent');
      verify(mockAuthRepo.forgetPassword('test@example.com')).called(1);
    });

    test('should return error', () async {
      when(mockAuthRepo.forgetPassword(any))
          .thenAnswer((_) async => AuthResponse.error('error message'));

      final result = await forgetPasswordUseCase('test@example.com');

      expect(result.error, 'error message');
    });
  });

  group('ResetPasswordUseCase', () {
    test('should return success', () async {
      when(mockAuthRepo.resetPassword(any, any))
          .thenAnswer((_) async => AuthResponse.success('reset done'));

      final result =
      await resetPasswordUseCase('test@example.com', 'newPass123');

      expect(result.data, 'reset done');
      verify(mockAuthRepo.resetPassword('test@example.com', 'newPass123'))
          .called(1);
    });

    test('should return error', () async {
      when(mockAuthRepo.resetPassword(any, any))
          .thenAnswer((_) async => AuthResponse.error('reset error'));

      final result =
      await resetPasswordUseCase('test@example.com', 'newPass123');

      expect(result.error, 'reset error');
    });
  });

  group('VerifyCodeUseCase', () {
    test('should return success', () async {
      when(mockAuthRepo.verifyCode(any))
          .thenAnswer((_) async => AuthResponse.success('verified'));

      final result = await verifyCodeUseCase('123456');

      expect(result.data, 'verified');
      verify(mockAuthRepo.verifyCode('123456')).called(1);
    });

    test('should return error', () async {
      when(mockAuthRepo.verifyCode(any))
          .thenAnswer((_) async => AuthResponse.error('invalid code'));

      final result = await verifyCodeUseCase('123456');

      expect(result.error, 'invalid code');
    });
  });
}
