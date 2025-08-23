import 'package:dio/dio.dart';
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
      test('returns success when datasource returns value', () async {
        when(mockDatasource.forgetPassword(any))
            .thenAnswer((_) async => 'success');

        final result = await repo.forgetPassword('test@example.com');

        expect(result, isA<AuthResponse<String>>());
        expect(result.data, 'success');

        final captured = verify(mockDatasource.forgetPassword(captureAny))
            .captured
            .single;
        expect(captured.email, 'test@example.com');
      });

      test('returns error when DioException is thrown', () async {
        when(mockDatasource.forgetPassword(any))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        final result = await repo.forgetPassword('test@example.com');

        expect(result, isA<AuthResponse<String>>());
        expect(result.error, isNotNull);
      });
    });

    group('verifyCode', () {
      test('returns success when datasource returns value', () async {
        when(mockDatasource.verifyResetPassword(any))
            .thenAnswer((_) async => 'verified');

        final result = await repo.verifyCode('12345');

        expect(result, isA<AuthResponse<String>>());
        expect(result.data, 'verified');

        final captured = verify(mockDatasource.verifyResetPassword(captureAny))
            .captured
            .single;
        expect(captured.resetCode, '12345');
      });

      test('returns error when DioException is thrown', () async {
        when(mockDatasource.verifyResetPassword(any))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        final result = await repo.verifyCode('12345');

        expect(result, isA<AuthResponse<String>>());
        expect(result.error, isNotNull);
      });
    });

    group('resetPassword', () {
      test('returns success when datasource returns value', () async {
        when(mockDatasource.resetPassword(any))
            .thenAnswer((_) async => 'reset done');

        final result = await repo.resetPassword(
          'test@example.com',
          'newPass123',
        );

        expect(result, isA<AuthResponse<String>>());
        expect(result.data, 'reset done');

        final captured = verify(mockDatasource.resetPassword(captureAny))
            .captured
            .single;
        expect(captured.email, 'test@example.com');
        expect(captured.newPassword, 'newPass123');
      });

      test('returns error when DioException is thrown', () async {
        when(mockDatasource.resetPassword(any))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

        final result =
        await repo.resetPassword('test@example.com', 'newPass123');

        expect(result, isA<AuthResponse<String>>());
        expect(result.error, isNotNull);
      });
    });
  });

  group('AuthRepoImpl login', () {
    test('Should call remote datasource and return LoginResponse', () async {
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

      when(mockAuthRemoteDatasource.login(loginRequest))
          .thenAnswer((_) async => loginResponse);

      // Act
      final result = await authRepoImpl.login(loginRequest);

      // Assert
      expect(result.message, "success");
      expect(result.token, "fakeToken");
      expect(result.user?.firstName, "Test");
      verify(mockAuthRemoteDatasource.login(loginRequest)).called(1);
    });

    test('Should throw exception when remote datasource fails', () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "wrong@example.com",
        password: "wrongpass",
      );

      when(mockAuthRemoteDatasource.login(loginRequest))
          .thenThrow(Exception("Login failed"));

      // Act & Assert
      expect(
            () => authRepoImpl.login(loginRequest),
        throwsA(isA<Exception>()),
      );

      verify(mockAuthRemoteDatasource.login(loginRequest)).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });
  });
}
