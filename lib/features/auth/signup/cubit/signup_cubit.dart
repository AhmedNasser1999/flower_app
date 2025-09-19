import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/signup/cubit/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/signup_usecase/signup_usecase.dart';

@injectable
class SignupCubit extends Cubit<SignupStates> {
  final SignupUsecase signupUsecase;
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  SignupCubit({required this.signupUsecase})
      : super(SignupInitialState());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController = TextEditingController();
  final TextEditingController signUpConfirmPasswordController = TextEditingController();

  String? selectedGender;
  bool isObscure = true;

  void changeGender(String? value) {
    selectedGender = value;
    emit(ChangeGenderState());
  }

  Future<void> signUp({
    required String? selectedGender,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (!signUpFormKey.currentState!.validate()) {
      return;
    }
    emit(SignupLoadingState());
    try {
      final request = RegisterRequest(
        rePassword: confirmPassword.trim(),
        email: email.trim(),
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        password: password.trim(),
        phone: phoneNumber.trim(),
        gender: selectedGender,
      );
      await signupUsecase.invoke(request);
      emit(SignupSuccessState());
    } catch (e) {
      emit(SignupErrorState(errorMessage: "Failed to sign up"));
    }
  }

  @override
  Future<void> close() {
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    phoneNumberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    return super.close();
  }
}
