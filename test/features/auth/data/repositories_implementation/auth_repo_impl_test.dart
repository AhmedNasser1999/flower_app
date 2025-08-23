import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDatasource])
void main() {
  late MockAuthRemoteDatasource mockAuthRemoteDatasource;
  late AuthRepoImpl authRepoImpl;

  setUp(() {
    mockAuthRemoteDatasource = MockAuthRemoteDatasource();
    authRepoImpl = AuthRepoImpl(mockAuthRemoteDatasource);
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

  group('AuthRepoImpl login', () {
    test('Should call remote datasource and return LoginResponse', () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "test@example.com",
        password: "password123",
      );
      test('returns error when DioException is thrown', () async {
        when(mockDatasource.forgetPassword(any))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

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
        final result = await repo.forgetPassword('test@example.com');

      when(mockAuthRemoteDatasource.login(loginRequest))
          .thenAnswer((_) async => loginResponse);
        expect(result, isA<AuthResponse<String>>());
        expect(result.error, isNotNull);
      });
    });

      // Act
      final result = await authRepoImpl.login(loginRequest);
    group('verifyCode', () {
      test('returns success when datasource returns value', () async {
        when(mockDatasource.verifyResetPassword(any))
            .thenAnswer((_) async => 'verified');

      // Assert
      expect(result.message, "success");
      expect(result.token, "fakeToken");
      expect(result.user?.firstName, "Test");
      verify(mockAuthRemoteDatasource.login(loginRequest)).called(1);
    });
        final result = await repo.verifyCode('12345');

        expect(result, isA<AuthResponse<String>>());
        expect(result.data, 'verified');

        final captured = verify(mockDatasource.verifyResetPassword(captureAny))
            .captured
            .single;
        expect(captured.resetCode, '12345');
      });

    test('Should throw exception when remote datasource fails', () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "wrong@example.com",
        password: "wrongpass",
      );
      test('returns error when DioException is thrown', () async {
        when(mockDatasource.verifyResetPassword(any))
            .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      when(mockAuthRemoteDatasource.login(loginRequest))
          .thenThrow(Exception("Login failed"));
        final result = await repo.verifyCode('12345');

      // Act & Assert
      expect(
            () => authRepoImpl.login(loginRequest),
        throwsA(isA<Exception>()),
      );
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

      verify(mockAuthRemoteDatasource.login(loginRequest)).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
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
}
