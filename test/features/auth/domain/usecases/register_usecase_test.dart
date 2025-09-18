import 'package:flower_app/core/utils/error/exceptions.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:flower_app/features/auth/domain/usecases/signup_usecase/signup_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_usecase_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockAuthRepo;
  late SignupUsecase signupUsecase;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    signupUsecase = SignupUsecase(mockAuthRepo);
  });

  final tRegisterRequest = RegisterRequest(
    firstName: "John",
    lastName: "Doe",
    email: "john.doe@example.com",
    phone: "1234567890",
    password: "Password123",
    rePassword: "Password123",
    gender: "Male",
  );

  final tRegisterResponse = RegisterResponse(
    token: "fake_token",
    message: "User registered successfully",
  );

  test("should call AuthRepo.signUp and return RegisterResponse", () async {
    // arrange
    when(mockAuthRepo.signUp(tRegisterRequest))
        .thenAnswer((_) async => tRegisterResponse);

    // act
    final result = await signupUsecase.invoke(tRegisterRequest);

    // assert
    expect(result, equals(tRegisterResponse));
    verify(mockAuthRepo.signUp(tRegisterRequest));
    verifyNoMoreInteractions(mockAuthRepo);
  });

  test("should throw when AuthRepo.signUp throws", () async {
    // arrange
    when(mockAuthRepo.signUp(tRegisterRequest))
        .thenThrow(const ServerException("error", "Network error"));

    // act
    final call = signupUsecase.invoke;

    // assert
    expect(() => call(tRegisterRequest),
        throwsA(const TypeMatcher<ServerException>()));
    verify(mockAuthRepo.signUp(tRegisterRequest));
    verifyNoMoreInteractions(mockAuthRepo);
  });
}
