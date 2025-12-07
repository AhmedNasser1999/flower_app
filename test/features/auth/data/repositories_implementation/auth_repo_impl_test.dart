import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/data/repositories_implementation/auth_repo_impl.dart';
import 'package:flower_app/features/auth/domain/responses/auth_response.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDatasource])
void main() {
  late MockAuthRemoteDatasource mockDatasource;
  late AuthRepoImpl repo;

  setUp(() {
    mockDatasource = MockAuthRemoteDatasource();
    repo = AuthRepoImpl(mockDatasource);
  });

  group('AuthRepoImpl', () {
    group('forgetPassword', () {
      test('returns success when datasource returns success response',
          () async {
        final successResponse = AuthResponse<String>.success('success');
        when(mockDatasource.forgetPassword(any))
            .thenAnswer((_) async => successResponse);

        final result = await repo.forgetPassword('test@example.com');

        expect(result, isA<AuthResponse<String>>());
        expect(result.data, 'success');
        expect(result.isSuccess, true);

        final captured =
            verify(mockDatasource.forgetPassword(captureAny)).captured.single;
        expect(captured.email, 'test@example.com');
      });

      test('returns error when datasource returns error response', () async {
        final errorResponse = AuthResponse<String>.error('Network error');
        when(mockDatasource.forgetPassword(any))
            .thenAnswer((_) async => errorResponse);

        final result = await repo.forgetPassword('test@example.com');

        expect(result, isA<AuthResponse<String>>());
        expect(result.error, 'Network error');
        expect(result.isSuccess, false);
      });
    });

    group('verifyCode', () {
      test('returns success when datasource returns success response',
          () async {
        final successResponse = AuthResponse<String>.success('verified');
        when(mockDatasource.verifyResetPassword(any))
            .thenAnswer((_) async => successResponse);

        final result = await repo.verifyCode('12345');

        expect(result, isA<AuthResponse<String>>());
        expect(result.data, 'verified');
        expect(result.isSuccess, true);

        final captured = verify(mockDatasource.verifyResetPassword(captureAny))
            .captured
            .single;
        expect(captured.resetCode, '12345');
      });

      test('returns error when datasource returns error response', () async {
        final errorResponse = AuthResponse<String>.error('Invalid code');
        when(mockDatasource.verifyResetPassword(any))
            .thenAnswer((_) async => errorResponse);

        final result = await repo.verifyCode('12345');

        expect(result, isA<AuthResponse<String>>());
        expect(result.error, 'Invalid code');
        expect(result.isSuccess, false);
      });
    });

    group('resetPassword', () {
      test('returns success when datasource returns success response',
          () async {
        final successResponse = AuthResponse<String>.success('reset done');
        when(mockDatasource.resetPassword(any))
            .thenAnswer((_) async => successResponse);

        final result = await repo.resetPassword(
          'test@example.com',
          'newPass123',
        );

        expect(result, isA<AuthResponse<String>>());
        expect(result.data, 'reset done');
        expect(result.isSuccess, true);

        final captured =
            verify(mockDatasource.resetPassword(captureAny)).captured.single;
        expect(captured.email, 'test@example.com');
        expect(captured.newPassword, 'newPass123');
      });

      test('returns error when datasource returns error response', () async {
        final errorResponse =
            AuthResponse<String>.error('Password reset failed');
        when(mockDatasource.resetPassword(any))
            .thenAnswer((_) async => errorResponse);

        final result =
            await repo.resetPassword('test@example.com', 'newPass123');

        expect(result, isA<AuthResponse<String>>());
        expect(result.error, 'Password reset failed');
        expect(result.isSuccess, false);
      });
    });
  });

  group('AuthRepoImpl login', () {
    test(
        'Should call remote datasource and return AuthResponse with LoginResponse',
        () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "test@example.com",
        password: "password123",
      );

      final loginResponse = LoginResponse(
        message: "success",
        token: "fakeToken",
        user: User(
          Id: "68a7033aa8bca307f9df564d",
          firstName: "Test",
          lastName: "User",
          email: "test@example.com",
        ),
      );

      final successResponse =
          AuthResponse<LoginResponse>.success(loginResponse);
      when(mockDatasource.login(loginRequest))
          .thenAnswer((_) async => successResponse);

      // Act
      final result = await repo.login(loginRequest);

      // Assert
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.data?.message, "success");
      expect(result.data?.token, "fakeToken");
      expect(result.data?.user?.firstName, "Test");
      expect(result.isSuccess, true);
      verify(mockDatasource.login(loginRequest)).called(1);
    });

    test(
        'Should return error AuthResponse when remote datasource returns error',
        () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "wrong@example.com",
        password: "wrongpass",
      );

      final errorResponse = AuthResponse<LoginResponse>.error("Login failed");
      when(mockDatasource.login(loginRequest))
          .thenAnswer((_) async => errorResponse);

      // Act
      final result = await repo.login(loginRequest);

      // Assert
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.error, "Login failed");
      expect(result.isSuccess, false);
      verify(mockDatasource.login(loginRequest)).called(1);
    });
  });
}
