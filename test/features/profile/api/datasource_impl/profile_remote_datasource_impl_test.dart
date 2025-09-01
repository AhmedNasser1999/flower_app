import 'package:dio/dio.dart';
import 'package:flower_app/core/errors/api_result.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/profile/data/models/profile_response.dart';
import 'package:flower_app/features/profile/api/client/profile_api_client.dart';
import 'package:flower_app/features/profile/api/datasource_impl/profile_remote_datasource_impl.dart';
import 'package:flower_app/features/profile/data/datasource/profile_remote_datasource.dart';
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

  group('ProfileRemoteDatasourceImpl - getProfile', () {
    test('should returns ApiSuccessResult when API call succeeds', () async {

      final fakeUser = User(
        Id: "123",
        firstName: "Mouayed",
        lastName: "Mohamed",
        email: "mouayed@example.com",
        gender: "male",
        phone: "01000000000",
        photo: "https://example.com/photo.jpg",
        role: "customer",
        wishlist: [],
        addresses: [],
        createdAt: "2025-09-01T00:00:00Z",
      );

      final fakeResponse = ProfileResponse(
        message: "Profile fetched successfully",
        user: fakeUser,
      );

      when(mockProfileApiClient.getProfile()).thenAnswer((_) async => fakeResponse);

      // act
      final result = await datasource.getProfile();

      // assert
      expect(result, isA<ApiSuccessResult<ProfileResponse>>());
      final successResult = result as ApiSuccessResult<ProfileResponse>;
      expect(successResult.data.message, "Profile fetched successfully");
      expect(successResult.data.user.email, "mouayed@example.com");
      verify(mockProfileApiClient.getProfile()).called(1);
    });

    test('should returns ApiErrorResult with server message when DioException thrown', () async {
      // arrange
      final dioError = DioException(
        requestOptions: RequestOptions(path: '/profile'),
        response: Response(
          requestOptions: RequestOptions(path: '/profile'),
          data: {'message': 'Unauthorized'},
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
      );

      when(mockProfileApiClient.getProfile()).thenThrow(dioError);

      // act
      final result = await datasource.getProfile();

      // assert
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, 'Unauthorized');
    });

    test('should returns ApiErrorResult with "Unexpected error" on generic exception', () async {
      // arrange
      when(mockProfileApiClient.getProfile()).thenThrow(Exception('Something went wrong'));

      // act
      final result = await datasource.getProfile();

      // assert
      expect(result, isA<ApiErrorResult>());
      expect((result as ApiErrorResult).errorMessage, 'Unexpected error');
    });
  });
}
