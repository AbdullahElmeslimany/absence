import 'package:absence/constant/constant.dart';
import 'package:absence/screens/homepage/assestant%20teach/teachhomepage.dart';
import 'package:absence/screens/homepage/student/studenthomepage.dart';

import 'package:absence/testapp/conectstream.dart';
import 'package:absence/testapp/test1.dart';
import 'package:absence/testapp/test2.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

bool user = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: StudentHomePage(),
      // home: HomePageTest(),
      // home: TechHomePage()
      //  user == false ? StudentHomePage() : TechHomePage(),
    );
  }
}
