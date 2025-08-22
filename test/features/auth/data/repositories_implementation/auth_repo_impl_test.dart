import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/data/repositories_implementation/auth_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
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
