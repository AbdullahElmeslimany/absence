import 'package:absence/constant/constant.dart';
import 'package:absence/screens/homepage/assestant%20teach/addsection.dart';
import 'package:absence/screens/homepage/assestant%20teach/appBar/drawerPage.dart';
import 'package:absence/screens/homepage/assestant%20teach/table/tableday.dart';
import 'package:absence/screens/homepage/assestant%20teach/table/tablesubject.dart';
import 'package:absence/screens/homepage/student/studenthomepage.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TechHomePage extends StatefulWidget {
  const TechHomePage({super.key});

  @override
  State<TechHomePage> createState() => _TechHomePageState();
}

class _TechHomePageState extends State<TechHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerPage(),
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Center(child: Text("المدرس"))),
      body: SingleChildScrollView(
          child: Column(
        children: [],
      )),
    );
  }
}
