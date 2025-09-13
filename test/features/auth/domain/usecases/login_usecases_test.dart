import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:flower_app/features/auth/domain/responses/auth_response.dart';
import 'package:flower_app/features/auth/domain/usecases/login_usecase/login_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecases_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main(){

  late MockAuthRepo mockAuthRepo;
  late LoginUseCase loginUseCase;

  setUp((){
    mockAuthRepo = MockAuthRepo();
    loginUseCase = LoginUseCase(mockAuthRepo);
  });

  group('LoginUseCases', (){
    test("Should return AuthResponse with LoginResponse when repo call is Successful", () async {
      //Arrange
      final loginRequest= LoginRequest(
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

      final authResponse = AuthResponse<LoginResponse>.success(loginResponse);
      when(mockAuthRepo.login(loginRequest))
          .thenAnswer((_) async => authResponse);

      // Act
      final result = await loginUseCase(loginRequest);

      // Assert
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.data?.message, "success");
      expect(result.data?.token, "fakeToken");
      expect(result.data?.user?.firstName, "Test");
      expect(result.isSuccess, true);
      verify(mockAuthRepo.login(loginRequest)).called(1);
    });

    test("Should return AuthResponse with error when repo call fails", () async {
      //Arrange
      final loginRequest= LoginRequest(
        email: "wrong@example.com",
        password: "wrongpass",
      );

      final authResponse = AuthResponse<LoginResponse>.error("Login failed");
      when(mockAuthRepo.login(loginRequest))
          .thenAnswer((_) async => authResponse);

      // Act
      final result = await loginUseCase(loginRequest);

      // Assert
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.error, "Login failed");
      expect(result.isSuccess, false);
      verify(mockAuthRepo.login(loginRequest)).called(1);
    });
  });

}