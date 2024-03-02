import 'package:absence/LoginPage/login.dart';
import 'package:absence/logic_main_page.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/cubit_radio/radio_custon_cubit_cubit.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/logic/cubit/seclect_day_cubit.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/teachhomepage.dart';
import 'package:absence/screens/homepage/student/show_day_attendance_page/cubit/show_attendance_cubit.dart';
import 'package:absence/screens/homepage/student/studenthomepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/homepage/assestant teach/AttendanceRecordPage/cubit/random_update_cubit.dart';

GetDataFromMemoey _dataFromMemoey = GetDataFromMemoey();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBdT2-IHEylvoTLVHD02VBWo4Vr06NwpXw",
          appId: "1:925747815350:web:dba130ebddcc016ed25717",
          messagingSenderId: "925747815350",
          projectId: "absence-of-salab"),
    );
  }
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
    return MultiBlocProvider(
        providers: [
          BlocProvider<RandomUpdateCubit>(
            create: (BuildContext context) => RandomUpdateCubit(),
          ),
          BlocProvider<ShowAttendanceCubit>(
            create: (BuildContext context) => ShowAttendanceCubit(),
          ),
          BlocProvider<RadioCustonCubit>(
            create: (context) => RadioCustonCubit(),
          ),
          BlocProvider<SeclectDayCubit>(
            create: (context) => SeclectDayCubit(),
          )
        ],
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
