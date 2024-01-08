import 'package:shared_preferences/shared_preferences.dart';

class GetDataFromMemoey {
  bool? saved;
  int? rank;
  int? id;
  getdatahelp() async {
    SharedPreferences prefget = await SharedPreferences.getInstance();
    saved = prefget.getBool("repeat");
    rank = prefget.getInt("rank");
    id = prefget.getInt("idmail");
  }
}