import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';

abstract class LoginStates{}

class LoginInitialStates extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginResponse loginResponse;

  LoginSuccessState(this.loginResponse);
}
class LoginErrorState extends LoginStates{

  final String errorMsg;
  LoginErrorState(this.errorMsg);

}