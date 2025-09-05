
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
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
    test("Should return LoginResponse when repo call is Successful", () async {
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

      when(mockAuthRepo.login(loginRequest))
          .thenAnswer((_) async => loginResponse);

      // Act
      final result = await loginUseCase(loginRequest);

      // Assert
      expect(result.message, "success");
      expect(result.token, "fakeToken");
      expect(result.user?.firstName, "Test");
      verify(mockAuthRepo.login(loginRequest)).called(1);

    });
  });

}