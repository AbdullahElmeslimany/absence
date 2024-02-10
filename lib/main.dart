import 'package:absence/LoginPage/login.dart';
import 'package:absence/constant/constant.dart';
import 'package:absence/finger_auth/finger_auth_logic.dart';
import 'package:absence/logic_main_page.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/teachhomepage.dart';
import 'package:absence/screens/homepage/student/show_day_attendance_page/show_page_attendance.dart';
import 'package:absence/screens/homepage/student/studenthomepage.dart';
import 'package:absence/test/dailogtest.dart';
import 'package:absence/test/reftest.dart';
import 'package:absence/test/test_finger_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/homepage/assestant teach/AttendanceRecordPage/cubit/random_update_cubit.dart';

GetDataFromMemoey _dataFromMemoey = GetDataFromMemoey();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _dataFromMemoey.getdatahelp();
  runApp(const MyApp());
  // _dataFromMemoey.saved == true ? null : fingerAuth();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RandomUpdateCubit(),
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // home: DialogTest()));

    // home: StudentAttendance(subjectname: "null",)
    // home: TechHomePage(
    //   idmail: id,
    // )
    //  user == false ? StudentHomePage() : TechHomePage(),
    //////////////////////////

    home: _dataFromMemoey.saved == true
        ? _dataFromMemoey.rank == 0
            ? StudentHomePage(
                idmail: _dataFromMemoey.id,
              )
            : TechHomePage(idmail: _dataFromMemoey.id)
        : const LoginPage()));
  }
}
