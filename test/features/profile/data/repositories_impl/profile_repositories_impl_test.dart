import 'package:dio/dio.dart';
import 'package:flower_app/features/profile/data/models/change_password_request_model.dart';
import 'package:flower_app/features/profile/data/models/change_password_response_model.dart';
import 'package:flower_app/features/profile/data/repositories_impl/profile_repository_impl.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:flower_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repositories_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDatasource])
void main() {
  late MockProfileRemoteDatasource mockRemoteDatasource;
  late ProfileRepository repository;

  setUp(() {
    mockRemoteDatasource = MockProfileRemoteDatasource();
    repository = ProfileRepositoryImpl(mockRemoteDatasource);
  });

  group('ProfileRepositoryImpl - changePassword', () {
    test('should return ChangePasswordResponseModel when remoteDatasource call is successful', () async {
      // Arrange
      final request = ChangePasswordRequestModel(
        password: "old123",
        newPassword: "new123",
      );

      final response = ChangePasswordResponseModel(
        message: "Password updated successfully",
        token: "newToken456",
      );

      when(mockRemoteDatasource.changePassword(request))
          .thenAnswer((_) async => response);

      // Act
      final result = await repository.changePassword(request);

      // Assert
      expect(result.message, "Password updated successfully");
      expect(result.token, "newToken456");
      verify(mockRemoteDatasource.changePassword(request)).called(1);
      verifyNoMoreInteractions(mockRemoteDatasource);
    });

    test('should throw DioException when remoteDatasource throws DioException', () async {
      final request = ChangePasswordRequestModel(
        password: "old123",
        newPassword: "new123",
      );

      when(mockRemoteDatasource.changePassword(request))
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
            () => repository.changePassword(request),
        throwsA(isA<DioException>()),
      );

      verify(mockRemoteDatasource.changePassword(request)).called(1);
    });
  });
}
