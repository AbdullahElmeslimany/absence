import 'package:absence/screens/homepage/assestant%20teach/addsection.dart';
import 'package:absence/screens/homepage/student/studenthomepage.dart';

import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
            child: Icon(
          Icons.person,
          size: 80,
        )),
        ListTile(
          leading: Icon(Icons.co_present_outlined, size: 26),
          title: Text(
            'بيانات المدرس',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        InkWell(
          child: ListTile(
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
                  builder: (context) => AddSection(),
                ));
          },
        ),
        InkWell(
          child: ListTile(
            leading: Icon(Icons.co_present_outlined, size: 26),
            title: Text(
              'الطالب',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentHomePage(),
                ));
          },
        ),
      ],
    ));
  }
}
