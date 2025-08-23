import 'package:flower_app/features/auth/data/models/forget_password_models/forget_password_request.dart';
import 'package:flower_app/features/auth/data/models/forget_password_models/reset_password_request_model.dart';
import 'package:flower_app/features/auth/data/models/forget_password_models/verify_code_request_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:flower_app/features/auth/api/datasource_implemenation/auth_remote_datasource_impl.dart';
import 'package:flower_app/features/auth/api/client/auth_api_client.dart';

import 'auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late MockAuthApiClient mockAuthApiClient;
  late AuthRemoteDatasourceImpl datasource;

  setUp(() {
    mockAuthApiClient = MockAuthApiClient();
    datasource = AuthRemoteDatasourceImpl(mockAuthApiClient);
  });

  group('AuthRemoteDatasourceImpl', () {
    test('forgetPassword should call AuthApiClient.forgetPassword and return result', () async {
      // Arrange
      final request = ForgetPasswordRequestModel(email: 'test@example.com');
      when(mockAuthApiClient.forgetPassword(request))
          .thenAnswer((_) async => "success");

      // Act
      final result = await datasource.forgetPassword(request);

      // Assert
      expect(result, "success");
      verify(mockAuthApiClient.forgetPassword(request)).called(1);
      verifyNoMoreInteractions(mockAuthApiClient);
    });

    test('resetPassword should call AuthApiClient.resetPassword and return result', () async {
      final request = ResetPasswordRequestModel(
        email: 'test@example.com',
        newPassword: 'Pass123!',
      );
      when(mockAuthApiClient.resetPassword(request))
          .thenAnswer((_) async => "reset_success");

      final result = await datasource.resetPassword(request);

      expect(result, "reset_success");
      verify(mockAuthApiClient.resetPassword(request)).called(1);
      verifyNoMoreInteractions(mockAuthApiClient);
    });

    test('verifyResetPassword should call AuthApiClient.verifyResetCode and return result', () async {
      final request = VerifyCodeRequestModel(resetCode: '1234');
      when(mockAuthApiClient.verifyResetCode(request))
          .thenAnswer((_) async => "verified");

      final result = await datasource.verifyResetPassword(request);

      expect(result, "verified");
      verify(mockAuthApiClient.verifyResetCode(request)).called(1);
      verifyNoMoreInteractions(mockAuthApiClient);
    });
  });

  group('AuthRemoteDatasourceImpl Error Cases', () {
    test('forgetPassword should throw DioException when API fails', () async {
      final request = ForgetPasswordRequestModel(email: 'test@example.com');

      when(mockAuthApiClient.forgetPassword(request))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/forget-password'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/forget-password'),
          statusCode: 400,
          statusMessage: "Bad Request",
        ),
      ));

      expect(
            () => datasource.forgetPassword(request),
        throwsA(isA<DioException>()),
      );

      verify(mockAuthApiClient.forgetPassword(request)).called(1);
    });

    test('resetPassword should throw DioException when API fails', () async {
      final request = ResetPasswordRequestModel(
        email: 'test@example.com',
        newPassword: 'Pass123!',
      );

      when(mockAuthApiClient.resetPassword(request))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/reset-password'),
        type: DioExceptionType.badResponse,
      ));

      expect(
            () => datasource.resetPassword(request),
        throwsA(isA<DioException>()),
      );

      verify(mockAuthApiClient.resetPassword(request)).called(1);
    });

    test('verifyResetPassword should throw DioException when API fails', () async {
      final request = VerifyCodeRequestModel(resetCode: '1234');

      when(mockAuthApiClient.verifyResetCode(request))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/verify-code'),
        type: DioExceptionType.connectionError,
      ));

      expect(
            () => datasource.verifyResetPassword(request),
        throwsA(isA<DioException>()),
      );

      verify(mockAuthApiClient.verifyResetCode(request)).called(1);
    });
  });

}
