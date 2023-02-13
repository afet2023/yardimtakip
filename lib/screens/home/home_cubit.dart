


import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubitState {
  final bool isContinueButtonEnabled;
  HomeCubitState({
    required this.isContinueButtonEnabled,
  });

  HomeCubitState copyWith({
    bool? isContinueButtonEnabled,
  }) {
    return HomeCubitState(
      isContinueButtonEnabled: isContinueButtonEnabled ?? this.isContinueButtonEnabled,
    );
  }
}


class HomeCubit extends Cubit<HomeCubitState>{
  HomeCubit(): super(HomeCubitState(isContinueButtonEnabled: false));

  void changeContinueButtonEnablement(bool newValue){
    emit(
      HomeCubitState(isContinueButtonEnabled: newValue)
    );
  }

}

