import 'package:absence/LoginPage/login.dart';
import 'package:absence/screens/homepage/assestant%20teach/addsection.dart';
import 'package:absence/screens/homepage/assestant%20teach/appBar/personteach.dart';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatelessWidget {
  final idTeach;
  final fullnameTeach;
  final data;
  const DrawerPage(
      {super.key,
      required this.idTeach,
      required this.fullnameTeach,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        const DrawerHeader(
            child: Icon(
          Icons.person,
          size: 80,
        )),
        ListTile(
          leading: const Icon(Icons.co_present_outlined, size: 26),
          title: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersionTeachData(data: data),
                  ));
            },
            child: const Text(
              'بيانات المدرس',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        InkWell(
          child: const ListTile(
            leading: Icon(Icons.co_present_outlined, size: 26),
            title: Text(
              'اضافة سكشن',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSection(
                      idTeach: idTeach, fullnameTeach: fullnameTeach),
                ));
          },
        ),
        InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();

            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          },
          child: const ListTile(
            leading: Icon(Icons.exit_to_app_rounded, size: 26),
            title: Text(
              'تسجيل الخروج',
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
        ),
      ],
    ));
  }
}
