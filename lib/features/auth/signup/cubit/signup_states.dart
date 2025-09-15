sealed class SignupStates {}

final class SignupInitialState extends SignupStates {}

final class SignupSuccessState extends SignupStates {}

final class SignupErrorState extends SignupStates {
  final String errorMessage;
  SignupErrorState({required this.errorMessage});
}

final class SignupLoadingState extends SignupStates {}

final class ChangeGenderState extends SignupStates {}
