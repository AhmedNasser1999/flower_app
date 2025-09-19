import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:flower_app/features/auth/domain/usecases/signup_usecase/signup_usecase.dart';
import 'package:flower_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:flower_app/features/auth/signup/cubit/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_cubit_test.mocks.dart';

@GenerateMocks([SignupUsecase, FormState, GlobalKey])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSignupUsecase mockSignupUsecase;
  late MockFormState mockFormState;
  late MockGlobalKey<FormState> mockFormKey;

  setUp(() {
    mockSignupUsecase = MockSignupUsecase();
    mockFormState = MockFormState();
    mockFormKey = MockGlobalKey<FormState>();

    when(mockFormKey.currentState).thenReturn(mockFormState);
    when(mockFormState.validate()).thenReturn(true);
  });

  test('initial state is SignupInitialState', () {
    final signupCubit = SignupCubit(
      signupUsecase: mockSignupUsecase,
    );
    expect(signupCubit.state, isA<SignupInitialState>());
    signupCubit.close();
  });

  group('signUp', () {
    final registerRequest = RegisterRequest(
      firstName: "John",
      lastName: "Doe",
      email: "john.doe@example.com",
      phone: "1234567890",
      password: "Password123",
      rePassword: "Password123",
      gender: "Male",
    );

    final registerResponse = RegisterResponse(
      message: "Success",
    );

    blocTest<SignupCubit, SignupStates>(
      'emits [SignupLoadingState, SignupSuccessState] when signUp is successful',
      build: () {
        when(mockSignupUsecase.invoke(any))
            .thenAnswer((_) async => registerResponse);
        return SignupCubit(
          signupUsecase: mockSignupUsecase,
        );
      },
      act: (cubit) => cubit.signUp(
        selectedGender: registerRequest.gender,
        firstName: registerRequest.firstName!,
        lastName: registerRequest.lastName!,
        phoneNumber: registerRequest.phone!,
        email: registerRequest.email!,
        password: registerRequest.password!,
        confirmPassword: registerRequest.rePassword!,
      ),
      expect: () => [
        isA<SignupLoadingState>(),
        isA<SignupSuccessState>(),
      ],
      verify: (_) {
        final captured = verify(mockSignupUsecase.invoke(captureAny)).captured;
        final request = captured.first as RegisterRequest;
        expect(request.firstName, registerRequest.firstName);
        expect(request.lastName, registerRequest.lastName);
        expect(request.email, registerRequest.email);
        expect(request.phone, registerRequest.phone);
        expect(request.password, registerRequest.password);
        expect(request.rePassword, registerRequest.rePassword);
        expect(request.gender, registerRequest.gender);
      },
    );

    blocTest<SignupCubit, SignupStates>(
      'emits [SignupLoadingState, SignupErrorState] when signUp fails',
      build: () {
        when(mockSignupUsecase.invoke(any))
            .thenThrow(Exception('Failed to sign up'));
        return SignupCubit(
          signupUsecase: mockSignupUsecase,
        );
      },
      act: (cubit) => cubit.signUp(
        selectedGender: registerRequest.gender,
        firstName: registerRequest.firstName!,
        lastName: registerRequest.lastName!,
        phoneNumber: registerRequest.phone!,
        email: registerRequest.email!,
        password: registerRequest.password!,
        confirmPassword: registerRequest.rePassword!,
      ),
      expect: () => [
        isA<SignupLoadingState>(),
        isA<SignupErrorState>(),
      ],
      verify: (_) {
        final captured = verify(mockSignupUsecase.invoke(captureAny)).captured;
        final request = captured.first as RegisterRequest;
        expect(request.firstName, registerRequest.firstName);
        expect(request.lastName, registerRequest.lastName);
        expect(request.email, registerRequest.email);
        expect(request.phone, registerRequest.phone);
        expect(request.password, registerRequest.password);
        expect(request.rePassword, registerRequest.rePassword);
        expect(request.gender, registerRequest.gender);
      },
    );
  });
}
