import 'package:flower_app/features/auth/api/client/auth_api_client.dart';
import 'package:flower_app/features/auth/api/datasource_implemenation/auth_remote_datasource_impl.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  late MockAuthApiClient mockAuthApiClient;
  late AuthRemoteDatasourceImpl datasourceImpl;

  setUp(() {
    mockAuthApiClient = MockAuthApiClient();
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
      expect(result.message, "success");
      expect(result.token, "fakeToken");
      expect(result.user?.firstName, "Elevate121");
      verify(mockAuthApiClient.login(loginRequest)).called(1);
      //verifyNoMoreInteractions(mockAuthApiClient);
    });

    test('Failure State for Login Response (throws Exception)', () async {
      // Arrange
      final loginRequest = LoginRequest(
        email: "wrong@test.com",
        password: "wrongpass",
      );

      when(mockAuthApiClient.login(loginRequest))
          .thenThrow(Exception('Login failed'));

      //Act
      expect(
        () async => await datasourceImpl.login(loginRequest),
        throwsA(isA<Exception>()),
      );

      //Asserts
      verify(mockAuthApiClient.login(loginRequest)).called(1);
      //verifyNoMoreInteractions(mockAuthApiClient);
    });
  });
}
