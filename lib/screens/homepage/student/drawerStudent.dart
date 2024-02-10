import 'package:absence/LoginPage/login.dart';
import 'package:absence/Privacypage/privacypolicy.dart';
import 'package:absence/Privacypage/termsandconditions.dart';
import 'package:absence/screens/homepage/student/personedata.dart';
import 'package:absence/screens/homepage/student/show_day_attendance_page/show_page_attendance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerStudent extends StatelessWidget {
  final studentdata;
  const DrawerStudent({super.key, required this.studentdata});

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
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        InkWell(
          child: const ListTile(
            leading: Icon(Icons.checklist_rounded, size: 26),
            title: Text(
              'غيابك',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            Get.to(ShowDayAttendance(
              data: studentdata,
            ));
          },
        ),
        InkWell(
          child: const ListTile(
            leading: Icon(Icons.privacy_tip_outlined, size: 26),
            title: Text(
              'سياسة الخصوصية',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
          },
        ),
        InkWell(
          child: const ListTile(
            leading: Icon(Icons.text_snippet_rounded, size: 26),
            title: Text(
              'الشروط والاحكام',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TermsandConditions()));
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
