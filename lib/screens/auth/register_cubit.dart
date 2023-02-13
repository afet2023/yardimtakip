
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubitState {
  final String? nameSurnameErrorText;
  final String? phoneNumberErrorText;
  final String? mailErrorText;
  final String? passwordErrorText;
  final bool passwordObscure;
  final bool registerButtonEnablement;
  RegisterCubitState({
    this.nameSurnameErrorText,
    this.phoneNumberErrorText,
    this.mailErrorText,
    this.passwordErrorText,
    required this.passwordObscure,
    required this.registerButtonEnablement,
  });
}

class RegisterCubit extends Cubit<RegisterCubitState> {
  RegisterCubit(): super(RegisterCubitState(passwordObscure: false, registerButtonEnablement: false));
  bool isInitStatePassed = false;

  void changeEmailErrorText(String? newErrorText){
    isInitStatePassed = true;
    emit(
      RegisterCubitState(
        nameSurnameErrorText: state.nameSurnameErrorText,
        phoneNumberErrorText: state.phoneNumberErrorText,
        mailErrorText: newErrorText,
        passwordErrorText: state.passwordErrorText,
        passwordObscure: state.passwordObscure, 
        registerButtonEnablement: state.registerButtonEnablement,
      )
    );
  _checkErrorsAndTrigger();
  }
  void changePhoneNumberErrorText(String? newErrorText){
    isInitStatePassed = true;
    emit(
      RegisterCubitState(
        nameSurnameErrorText: state.nameSurnameErrorText,
        phoneNumberErrorText: newErrorText,
        mailErrorText: state.mailErrorText,
        passwordErrorText: state.passwordErrorText,
        passwordObscure: state.passwordObscure, 
        registerButtonEnablement: state.registerButtonEnablement,
      )
    );
  _checkErrorsAndTrigger();
  }
  void changeNameSurnameErrorText(String? newErrorText){
    isInitStatePassed = true;
    emit(
      RegisterCubitState(
        nameSurnameErrorText: newErrorText,
        phoneNumberErrorText: state.nameSurnameErrorText,
        mailErrorText: state.mailErrorText,
        passwordErrorText: state.passwordErrorText,
        passwordObscure: state.passwordObscure, 
        registerButtonEnablement: state.registerButtonEnablement,
      )
    );
  _checkErrorsAndTrigger();
  }
  void changePasswordErrorText(String? newErrorText){
    isInitStatePassed = true;
    emit(
      RegisterCubitState(
        nameSurnameErrorText: state.nameSurnameErrorText,
        phoneNumberErrorText: state.nameSurnameErrorText,
        mailErrorText: state.mailErrorText,
        passwordErrorText: newErrorText,
        passwordObscure: state.passwordObscure, 
        registerButtonEnablement: state.registerButtonEnablement,
      )
    );
  _checkErrorsAndTrigger();
  }

  void changeObscureText(bool newValue){
    emit(
      RegisterCubitState(
        nameSurnameErrorText: state.nameSurnameErrorText,
        phoneNumberErrorText: state.nameSurnameErrorText,
        mailErrorText: state.mailErrorText,
        passwordErrorText: state.passwordErrorText,
        passwordObscure: newValue, 
        registerButtonEnablement: state.registerButtonEnablement,
      )
    );
  }

  void changeButtonEnablement(bool newValue){
    isInitStatePassed = true;
    emit(
      RegisterCubitState(
        nameSurnameErrorText: state.nameSurnameErrorText,
        phoneNumberErrorText: state.phoneNumberErrorText,
        mailErrorText: state.mailErrorText,
        passwordErrorText: state.passwordErrorText,
        passwordObscure: state.passwordObscure, 
        registerButtonEnablement: newValue,
      )
    );
  }

  void _checkErrorsAndTrigger(){
    bool newValue = false;
    if(state.mailErrorText == null && state.passwordErrorText == null && isInitStatePassed && state.nameSurnameErrorText == null &&  state.phoneNumberErrorText == null) newValue = true;
    changeButtonEnablement(newValue);
  }


}
