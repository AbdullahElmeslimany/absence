import 'package:absence/LoginPage/login.dart';
import 'package:absence/screens/homepage/student/personedata.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerStudent extends StatelessWidget {
  final studentdata;
  const DrawerStudent({super.key,required this.studentdata});

  @override
  Widget build(BuildContext context) {
    return   Drawer(
                child: ListView(
              children: [
                const DrawerHeader(
                    child: Icon(
                  Icons.person,
                  size: 80,
                )),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonData(data: studentdata),
                        ));
                  },
                  child: const ListTile(
                    leading: Icon(Icons.co_present_outlined, size: 26),
                    title: Text(
                      'بيانات الطالب',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
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
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
              ],
            ));
  }
}