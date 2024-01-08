import 'dart:convert';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/teachhomepage.dart';
import 'package:http/http.dart' as http;
import 'package:absence/constant/link.dart';

class GetDataFromApi {
  getdatafromApi({required table, required idmail}) async {
    try {
      var responce = await http.post(Uri.parse(Link.getdatalink),
          body: {"table": table, "nattional_id": (idmail).toString()});

      // check is connect or no
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Map responsebody = jsonDecode(responce.body);
        print(responsebody);
        if (responsebody["status"] == "success") {
          // dataTeach.addAll(responsebody["data"]);
        } else if (responsebody["status"] == "failure") {
          print("failure");
        }

        // loadingsta();
      }
    } catch (e) {
      print(e);
    }
  }
}
