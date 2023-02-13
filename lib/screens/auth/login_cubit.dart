

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubitState {
  final String? emailErrorText;
  final String? passwordErrorText;
  final bool passwordObscureText;
  final bool? loginButtonEnablement;
  LoginCubitState({
    this.emailErrorText,
    this.passwordErrorText,
    required this.passwordObscureText,
    this.loginButtonEnablement,
  });
}

class LoginCubit extends Cubit<LoginCubitState> {
  bool isInitStatePassed = false;
  LoginCubit(): super(LoginCubitState(passwordObscureText: true));

  void changeEmailErrorText(String? newErrorText){
    isInitStatePassed = true;
    emit(LoginCubitState(emailErrorText: newErrorText, passwordErrorText: state.passwordErrorText, passwordObscureText: state.passwordObscureText, loginButtonEnablement: state.loginButtonEnablement));
    _checkAndchangeButtonEnablement();
  }

  void changePasswordErrorText(String? newErrorText){
    isInitStatePassed = true;
    emit(LoginCubitState(passwordErrorText: newErrorText, emailErrorText: state.emailErrorText, passwordObscureText: state.passwordObscureText, loginButtonEnablement: state.loginButtonEnablement));
    _checkAndchangeButtonEnablement();
  }

  void changePasswordObscureText(bool newValue){
    emit(LoginCubitState(passwordObscureText: newValue, passwordErrorText: state.passwordErrorText, emailErrorText: state.emailErrorText, loginButtonEnablement: state.loginButtonEnablement));
    _checkAndchangeButtonEnablement();
  }

  void _checkAndchangeButtonEnablement(){
    bool newValue = false;
    if(state.emailErrorText == null && state.passwordErrorText == null && isInitStatePassed) newValue = true;
    emit(LoginCubitState(passwordObscureText: state.passwordObscureText, passwordErrorText: state.passwordErrorText, emailErrorText: state.emailErrorText, loginButtonEnablement: newValue));
  }

}


