import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'radio_custon_cubit_state.dart';

enum RadioButtonOption {
  FirstOption,
  SecondOption;
}

class RadioCustonCubit extends Cubit<RadioCustonCubitState> {
  RadioCustonCubit() : super(RadioCustonCubitInitial());

  void changeOption(RadioButtonOption newOption) {
    emit(NewOPtionState());
  }
}
