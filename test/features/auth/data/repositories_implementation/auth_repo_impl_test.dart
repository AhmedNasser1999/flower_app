import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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
      test('returns success when datasource returns value', () async {
        when(mockDatasource.forgetPassword(any)).thenAnswer((_) async => 'success');
      test('returns success when datasource returns success response', () async {
        final successResponse = AuthResponse<String>.success('success');
        when(mockDatasource.forgetPassword(any))
            .thenAnswer((_) async => successResponse);

        final result = await repo.forgetPassword('test@example.com');

        expect(result, isA<AuthResponse<String>>());
        expect(result.data, 'success');
        expect(result.isSuccess, true);

        final captured = verify(mockDatasource.forgetPassword(captureAny))
            .captured
            .single;
        expect(captured.email, 'test@example.com');
        verify(mockDatasource.forgetPassword(any)).called(1);
      });

      test('returns error when datasource returns error response', () async {
        final errorResponse = AuthResponse<String>.error('Network error');
        when(mockDatasource.forgetPassword(any))
            .thenAnswer((_) async => errorResponse);
      test('returns error when DioException is thrown', () async {
        when(mockDatasource.forgetPassword(any)).thenThrow(
          DioException(requestOptions: RequestOptions(path: '')),
        );

        final result = await repo.forgetPassword('test@example.com');

        expect(result, isA<AuthResponse<String>>());
        expect(result.error, 'Network error');
        expect(result.isSuccess, false);
      });
    });

    group('verifyCode', () {
      test('returns success when datasource returns success response', () async {
        final successResponse = AuthResponse<String>.success('verified');
        when(mockDatasource.verifyResetPassword(any))
            .thenAnswer((_) async => successResponse);
      test('returns success when datasource returns value', () async {
        when(mockDatasource.verifyResetPassword(any)).thenAnswer((_) async => 'verified');

        final result = await repo.verifyCode('12345');

        expect(result, isA<AuthResponse<String>>());
        expect(result.data, 'verified');
        expect(result.isSuccess, true);

        final captured = verify(mockDatasource.verifyResetPassword(captureAny))
            .captured
            .single;
        expect(captured.resetCode, '12345');
        verify(mockDatasource.verifyResetPassword(any)).called(1);
      });

      test('returns error when datasource returns error response', () async {
        final errorResponse = AuthResponse<String>.error('Invalid code');
        when(mockDatasource.verifyResetPassword(any))
            .thenAnswer((_) async => errorResponse);
      test('returns error when DioException is thrown', () async {
        when(mockDatasource.verifyResetPassword(any)).thenThrow(
          DioException(requestOptions: RequestOptions(path: '')),
        );

        final result = await repo.verifyCode('12345');

        expect(result, isA<AuthResponse<String>>());
        expect(result.error, 'Invalid code');
        expect(result.isSuccess, false);
      });
    });

    group('resetPassword', () {
      test('returns success when datasource returns value', () async {
        when(mockDatasource.resetPassword(any)).thenAnswer((_) async => 'reset done');
      test('returns success when datasource returns success response', () async {
        final successResponse = AuthResponse<String>.success('reset done');
        when(mockDatasource.resetPassword(any))
            .thenAnswer((_) async => successResponse);

        final result = await repo.resetPassword('test@example.com', 'newPass123');

        expect(result, isA<AuthResponse<String>>());
        expect(result.data, 'reset done');
        expect(result.isSuccess, true);

        final captured = verify(mockDatasource.resetPassword(captureAny))
            .captured
            .single;
        expect(captured.email, 'test@example.com');
        expect(captured.newPassword, 'newPass123');
        verify(mockDatasource.resetPassword(any)).called(1);
      });

      test('returns error when DioException is thrown', () async {
        when(mockDatasource.resetPassword(any)).thenThrow(
          DioException(requestOptions: RequestOptions(path: '')),
        );
      test('returns error when datasource returns error response', () async {
        final errorResponse = AuthResponse<String>.error('Password reset failed');
        when(mockDatasource.resetPassword(any))
            .thenAnswer((_) async => errorResponse);

        final result = await repo.resetPassword('test@example.com', 'newPass123');

        expect(result, isA<AuthResponse<String>>());
        expect(result.error, 'Password reset failed');
        expect(result.isSuccess, false);
      });
    });

    group('login', () {
      test('returns LoginResponse when datasource succeeds', () async {
        final loginRequest = LoginRequest(
          email: "test@example.com",
          password: "password123",
        );
  group('AuthRepoImpl login', () {
    test('Should call remote datasource and return AuthResponse with LoginResponse', () async {
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

      final successResponse = AuthResponse<LoginResponse>.success(loginResponse);
      when(mockDatasource.login(loginRequest))
          .thenAnswer((_) async => successResponse);
        when(mockDatasource.login(any)).thenAnswer((_) async => loginResponse);

        final result = await repo.login(loginRequest);

        expect(result.message, "success");
        expect(result.token, "fakeToken");
        expect(result.user?.firstName, "Test");
        verify(mockDatasource.login(any)).called(1);
      });
      // Assert
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.data?.message, "success");
      expect(result.data?.token, "fakeToken");
      expect(result.data?.user?.firstName, "Test");
      expect(result.isSuccess, true);
      verify(mockDatasource.login(loginRequest)).called(1);
    });

      test('throws exception when datasource fails', () async {
        final loginRequest = LoginRequest(
          email: "wrong@example.com",
          password: "wrongpass",
        );
    test('Should return error AuthResponse when remote datasource returns error', () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "wrong@example.com",
        password: "wrongpass",
      );

        when(mockDatasource.login(any)).thenThrow(Exception("Login failed"));
      final errorResponse = AuthResponse<LoginResponse>.error("Login failed");
      when(mockDatasource.login(loginRequest))
          .thenAnswer((_) async => errorResponse);

        expect(() => repo.login(loginRequest), throwsA(isA<Exception>()));
        verify(mockDatasource.login(any)).called(1);
      });
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
