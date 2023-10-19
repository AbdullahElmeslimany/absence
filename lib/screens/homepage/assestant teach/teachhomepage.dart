import 'package:absence/constant/constant.dart';
import 'package:absence/screens/homepage/assestant%20teach/Attendance%20Record%20Page/AttendanceRecordPage.dart';
import 'package:absence/screens/homepage/assestant%20teach/addsection.dart';
import 'package:absence/screens/homepage/assestant%20teach/appBar/drawerPage.dart';
import 'package:absence/screens/homepage/assestant%20teach/table/tableday.dart';
import 'package:absence/screens/homepage/assestant%20teach/table/tablesubject.dart';
import 'package:absence/screens/homepage/student/studenthomepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder(
        stream: sectionsteaher,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("erorr");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendanceRecordPage(
                            mapdata: snapshot.data!.docs[index]["section"],
                            idteach: snapshot.data!.docs[index].id,
                            namesubject: snapshot.data!.docs[index]["section"]
                                ["namesubject"]),
                      ));
                },
                child: Card(
                  child: ListTile(
                      subtitle: Text(snapshot.data!.docs[index]["section"]
                          ["numbersubject"]),
                      title: Text(snapshot.data!.docs[index]["section"]
                          ["nameteacher"])),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
