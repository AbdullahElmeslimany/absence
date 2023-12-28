import 'package:absence/LoginPage/login.dart';

import 'package:absence/constant/constant.dart';
import 'package:absence/screens/homepage/assestant%20teach/teachhomepage.dart';

import 'package:absence/screens/homepage/student/studenthomepage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

bool user = false;
bool? saved;
String? rank;
int? id;
String? firstname;
String? group;
String? section;
String? specialty;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefget = await SharedPreferences.getInstance();
  saved = prefget.getBool("repeat");
  rank = prefget.getString("rank");
  id = prefget.getInt("idmail");
  firstname = prefget.getString("firstname");
  group = prefget.getString("group");
  section = prefget.getString("section");
  specialty = prefget.getString("specialty");


  runApp(const MyApp());
  getData();
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: StudentHomePage(),
        // home: StudentAttendance(subjectname: "null",)
        // home: TechHomePage(
        //   idmail: id,
        // )
        //  user == false ? StudentHomePage() : TechHomePage(),
        //////////////////////////
        home: saved == true
            ? rank == "0"
                ? StudentHomePage(
                    idmail: id,
                    firstname: firstname,
                    group: group,
                    section: section,
                    specialty: specialty,
                  )
                : TechHomePage(idmail: id)
            : const LoginPage());
  }
}
