import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test LoginRequest Tojson should return correctMap", () {
    //Arrange
    final request = LoginRequest(
        email: "mohamedyasser192023@gmail.com", password: "Test@123");

    //Act
    final json = request.toJson();

    //Assert

    expect(json['email'], "mohamedyasser192023@gmail.com");
    expect(json['password'], "Test@123");
  });
}
