import 'package:dio/dio.dart';
import 'package:flower_app/features/profile/api/client/profile_api_client.dart';
import 'package:flower_app/features/profile/api/datasource_impl/profile_remote_datasource_impl.dart';
import 'package:flower_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:flower_app/features/profile/data/models/change_password_request_model.dart';
import 'package:flower_app/features/profile/data/models/change_password_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ProfileApiClient])
void main() {
  late MockProfileApiClient mockProfileApiClient;
  late ProfileRemoteDatasource datasource;

  setUp(() {
    mockProfileApiClient = MockProfileApiClient();
    datasource = ProfileRemoteDatasourceImpl(apiClient: mockProfileApiClient);
  });

  group('ProfileRemoteDatasourceImpl - changePassword', () {
    test('should return ChangePasswordResponseModel when API call is successful', () async {
      // Arrange
      final request = ChangePasswordRequestModel(
        password: "old123",
        newPassword: "new123",
      );

      final response = ChangePasswordResponseModel(
        message: "Password changed successfully",
        token: "newToken123",
      );

      when(mockProfileApiClient.changePassword(request))
          .thenAnswer((_) async => response);

      // Act
      final result = await datasource.changePassword(request);

      // Assert
      expect(result.message, "Password changed successfully");
      expect(result.token, "newToken123");
      verify(mockProfileApiClient.changePassword(request)).called(1);
      verifyNoMoreInteractions(mockProfileApiClient);
    });

    test('should throw DioException when API call fails', () async {
      final request = ChangePasswordRequestModel(
        password: "old123",
        newPassword: "new123",
      );

      when(mockProfileApiClient.changePassword(request))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/change-password'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/change-password'),
          statusCode: 400,
          statusMessage: "Bad Request",
        ),
      ));

      // Assert
      expect(
            () => datasource.changePassword(request),
        throwsA(isA<DioException>()),
      );

      verify(mockProfileApiClient.changePassword(request)).called(1);
    });
  });
}
