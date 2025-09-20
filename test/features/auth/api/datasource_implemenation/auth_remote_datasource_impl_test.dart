import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/features/auth/api/datasource_implemenation/auth_remote_datasource_impl.dart';
import 'package:flower_app/features/auth/data/models/forget_password_models/forget_password_request.dart';
import 'package:flower_app/features/auth/data/models/forget_password_models/reset_password_request_model.dart';
import 'package:flower_app/features/auth/data/models/forget_password_models/verify_code_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/domain/responses/auth_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockAuthApiClient;
  late AuthRemoteDatasourceImpl datasourceImpl;

  setUp(() {
    mockAuthApiClient = MockApiClient();
    datasourceImpl = AuthRemoteDatasourceImpl(mockAuthApiClient);
  });

  group('Test login_models response in Login Function', () {
    test('Success State for Login Response', () async {
      //Arrange
      final loginRequest = LoginRequest(
          email: "mohamedyasser192023@gmail.com",
          password: "Mohamedyasser@2003");

      final loginResponse = LoginResponse(
        message: "success",
        token: "fakeToken",
        user: User(
          Id: "68a7033aa8bca307f9df564d",
          firstName: "Elevate121",
          lastName: "Tech121",
          email: "mohamedyasser192023@gmail.com",
        ),
      );

      when(mockAuthApiClient.login(loginRequest))
          .thenAnswer((_) async => loginResponse);

      //act
      final result = await datasourceImpl.login(loginRequest);

      // Assert
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.data?.message, "success");
      expect(result.data?.token, "fakeToken");
      expect(result.data?.user?.firstName, "Elevate121");
      expect(result.isSuccess, true);
      verify(mockAuthApiClient.login(loginRequest)).called(1);
    });

    test('Failure State for Login Response (returns error AuthResponse)',
        () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "wrong@test.com",
        password: "wrongpass",
      );

      when(mockAuthApiClient.login(loginRequest)).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/login'),
        response: Response(
          requestOptions: RequestOptions(path: '/login'),
          statusCode: 401,
          data: {'error': 'Invalid credentials'},
        ),
      ));

      //Act
      final result = await datasourceImpl.login(loginRequest);

      //Asserts
      expect(result, isA<AuthResponse<LoginResponse>>());
      expect(result.error, isNotNull);
      expect(result.isSuccess, false);
      verify(mockAuthApiClient.login(loginRequest)).called(1);
    });
  });

  group('AuthRemoteDatasourceImpl - forget password', () {
    test(
        'forgetPassword should call AuthApiClient.forgetPassword and return AuthResponse',
        () async {
      // Arrange
      final request = ForgetPasswordRequestModel(email: 'test@example.com');
      when(mockAuthApiClient.forgetPassword(request))
          .thenAnswer((_) async => "success");

      // Act
      final result = await datasourceImpl.forgetPassword(request);

      // Assert
      expect(result, isA<AuthResponse<String>>());
      expect(result.data, "success");
      expect(result.isSuccess, true);
      verify(mockAuthApiClient.forgetPassword(request)).called(1);
      verifyNoMoreInteractions(mockAuthApiClient);
    });

    test(
        'resetPassword should call AuthApiClient.resetPassword and return AuthResponse',
        () async {
      final request = ResetPasswordRequestModel(
        email: 'test@example.com',
        newPassword: 'Pass123!',
      );
      when(mockAuthApiClient.resetPassword(request))
          .thenAnswer((_) async => "reset_success");

      final result = await datasourceImpl.resetPassword(request);

      expect(result, isA<AuthResponse<String>>());
      expect(result.data, "reset_success");
      expect(result.isSuccess, true);
      verify(mockAuthApiClient.resetPassword(request)).called(1);
      verifyNoMoreInteractions(mockAuthApiClient);
    });

    test(
        'verifyResetPassword should call AuthApiClient.verifyResetCode and return AuthResponse',
        () async {
      final request = VerifyCodeRequestModel(resetCode: '1234');
      when(mockAuthApiClient.verifyResetCode(request))
          .thenAnswer((_) async => "verified");

      final result = await datasourceImpl.verifyResetPassword(request);

      expect(result, isA<AuthResponse<String>>());
      expect(result.data, "verified");
      expect(result.isSuccess, true);
      verify(mockAuthApiClient.verifyResetCode(request)).called(1);
      verifyNoMoreInteractions(mockAuthApiClient);
    });
  });

  group('AuthRemoteDatasourceImpl Error Cases', () {
    test('forgetPassword should return AuthResponse.error when API fails',
        () async {
      final request = ForgetPasswordRequestModel(email: 'test@example.com');

      when(mockAuthApiClient.forgetPassword(request)).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/forget-password'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/forget-password'),
          statusCode: 400,
          statusMessage: "Bad Request",
          data: {'error': 'Email not found'},
        ),
      ));

      final result = await datasourceImpl.forgetPassword(request);

      expect(result, isA<AuthResponse<String>>());
      expect(result.error, isNotNull);
      expect(result.isSuccess, false);
      verify(mockAuthApiClient.forgetPassword(request)).called(1);
    });

    test('resetPassword should return AuthResponse.error when API fails',
        () async {
      final request = ResetPasswordRequestModel(
        email: 'test@example.com',
        newPassword: 'Pass123!',
      );

      when(mockAuthApiClient.resetPassword(request)).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/reset-password'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/reset-password'),
          statusCode: 400,
          data: {'error': 'Invalid token'},
        ),
      ));

      final result = await datasourceImpl.resetPassword(request);

      expect(result, isA<AuthResponse<String>>());
      expect(result.error, isNotNull);
      expect(result.isSuccess, false);
      verify(mockAuthApiClient.resetPassword(request)).called(1);
    });

    test('verifyResetPassword should return AuthResponse.error when API fails',
        () async {
      final request = VerifyCodeRequestModel(resetCode: '1234');

      when(mockAuthApiClient.verifyResetCode(request)).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/verify-code'),
        type: DioExceptionType.connectionError,
        response: Response(
          requestOptions: RequestOptions(path: '/verify-code'),
          statusCode: 500,
          data: {'error': 'Server error'},
        ),
      ));

      final result = await datasourceImpl.verifyResetPassword(request);

      expect(result, isA<AuthResponse<String>>());
      expect(result.error, isNotNull);
      expect(result.isSuccess, false);
      verify(mockAuthApiClient.verifyResetCode(request)).called(1);
    });
  });
}
