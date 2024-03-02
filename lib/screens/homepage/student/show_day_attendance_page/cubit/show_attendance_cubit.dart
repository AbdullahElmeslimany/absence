import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'show_attendance_state.dart';

class ShowAttendanceCubit extends Cubit<ShowAttendanceState> {
  ShowAttendanceCubit() : super(ShowAttendanceInitial());

  static ShowAttendanceCubit get(context) => ShowAttendanceCubit();

  List datasection = [];
  List datalecture = [];
  bool active = true;
  int id = 20231212;

  getDataFromAPI(
      {required link,
      required id,
      required mapdatasection,
      required mapdatalecture}) async {
    try {
      emit(LoadingState());
      var responce =
          await http.post(Uri.parse(link), body: {"id": id.toString()});
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Map responsebody = jsonDecode(responce.body);
        if (responsebody["status"] == "success") {
          for (var i = 0; i <= 9; i++) {
            mapdatasection
                .insert(i, {"day": responsebody["data"][0]["s_${i + 1}"]});
            mapdatalecture
                .insert(i, {"day": responsebody["data"][0]["l_${i + 1}"]});
            // datatest.insert(i, {
            //   "name": "h",
            //   "day": [responsebody["data"][0]["s_${i + 1}"]]
            // });
            // print(datatest);
          }
          active = false;
          emit(SuccessDataState());
          for (var i = 0; i < 3; i++) {}
          print("success");
        } else if (responsebody["status"] == "failure") {
          emit(FailureDataState("failure"));
        }
      }
    } catch (e) {
      emit(FailureDataState("failure"));
    }
  }
}
