import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/domain/usecases/login_usecases.dart';
import 'package:flower_app/features/auth/login/presentation/viewmodel/login_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(LoginInitialStates());


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());
    try{
      final request = LoginRequest(email: email , password: password);
      final response = await _loginUseCase(request);

      print(response);
      emit(LoginSuccessState(response));

    }catch(e){
      emit(LoginErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }




}