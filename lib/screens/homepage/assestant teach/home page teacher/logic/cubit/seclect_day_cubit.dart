import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'seclect_day_state.dart';

class SeclectDayCubit extends Cubit<SeclectDayState> {
  SeclectDayCubit() : super(SeclectDayInitial());
  var selectday;
  changeDay({day}) {
    selectday = day;
    emit(ChangeDayState(day: selectday));
  }
}
