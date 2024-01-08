import 'package:absence/screens/homepage/assestant%20teach/Attendance%20Record%20Page/logic/attendancetrueorfalse.dart';
import 'package:absence/screens/homepage/assestant%20teach/Attendance%20Record%20Page/logic/refresh_ui_attendance.dart';
import 'package:absence/screens/homepage/assestant%20teach/Attendance%20Record%20Page/views/appbarattendanse.dart';
import 'package:absence/screens/homepage/assestant%20teach/Attendance%20Record%20Page/views/button_end.dart';
import 'package:absence/screens/homepage/assestant%20teach/Attendance%20Record%20Page/views/cardstudentattendace.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AttendanceRecordPage extends StatefulWidget {
  final idrandom;
  final String namesubject;
  final mapdata;
  final numberrandom;
  const AttendanceRecordPage(
      {super.key,
      required this.idrandom,
      required this.namesubject,
      required this.mapdata,
      required this.numberrandom});

  @override
  State<AttendanceRecordPage> createState() => _AttendanceRecordPageState();
}

class _AttendanceRecordPageState extends State<AttendanceRecordPage> {
  RefreshUiAttendance _refreshUiAttendance = RefreshUiAttendance();
  late Stream<QuerySnapshot> userstudent;
  streamData() {
    userstudent =
        FirebaseFirestore.instance.collection("usersStudent").snapshots();
  }

  @override
  void initState() {
    streamData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBarAttendance(context, nameSubject: widget.namesubject),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(20),
              Center(
                child: QrImageView(
                  data: widget.numberrandom.toString(),
                  size: MediaQuery.sizeOf(context).width - 120,
                  version: QrVersions.auto,
                ),
              ),
              const Gap(20),
              //Button_END_Student_Record
              buttonEndRecordStudent(context, idrandom: widget.idrandom),
              const Gap(20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  children: [
                    const Gap(10),
                    SizedBox(
                      height: 1000,
                      child: StreamBuilder(
                        stream: userstudent,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("erorr");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          }

                          return SmartRefresher(
                            controller:
                                _refreshUiAttendance.refreshControllerteacher,
                            onRefresh: _refreshUiAttendance.onRefresh,
                            onLoading: _refreshUiAttendance.onLoading,
                            enablePullDown: true,
                            header: const WaterDropHeader(
                                waterDropColor: Colors.red),
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: cardStudentAttendanse(
                                      condtion: snapshot.data!.docs[index]
                                          ["active"],
                                      id: snapshot.data!.docs[index].id,
                                      fullName: snapshot.data!.docs[index]
                                          ["fullname"]),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

// nameSubject = widget.namesubject
}
