import 'package:absence/screens/homepage/assestant%20teach/AttendanceRecordPage/cubit/random_update_cubit.dart';
import 'package:absence/screens/homepage/assestant%20teach/AttendanceRecordPage/logic/refresh_ui_attendance.dart';
import 'package:absence/screens/homepage/assestant%20teach/AttendanceRecordPage/views/appbarattendanse.dart';
import 'package:absence/screens/homepage/assestant%20teach/AttendanceRecordPage/views/button_end.dart';
import 'package:absence/screens/homepage/assestant%20teach/AttendanceRecordPage/views/cardstudentattendace.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late Stream<QuerySnapshot> userstudent;
  streamData() {
    userstudent =
        FirebaseFirestore.instance.collection("usersStudent").snapshots();
  }

  @override
  void initState() {
    BlocProvider.of<RandomUpdateCubit>(context)
        .rondomUpDate(id: widget.idrandom);
    streamData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RefreshUiAttendance refreshUiAttendance = RefreshUiAttendance();
    late int randomCount;
    return BlocConsumer<RandomUpdateCubit, RandomUpdateState>(
      listener: (context, state) {
        print(state);
        if (state is StartMethodState) {
          randomCount = BlocProvider.of<RandomUpdateCubit>(context).randomCount;
        }
        if (state is LoopMethodState) {
          BlocProvider.of<RandomUpdateCubit>(context)
              .rondomUpDate(id: widget.idrandom);
        }
      },
      builder: (context, state) {
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
                      // data: widget.numberrandom.toString(),
                      data: (BlocProvider.of<RandomUpdateCubit>(context)
                              .randomCount)
                          .toString(),
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
                                controller: refreshUiAttendance
                                    .refreshControllerteacher,
                                onRefresh: refreshUiAttendance.onRefresh,
                                onLoading: refreshUiAttendance.onLoading,
                                enablePullDown: true,
                                header: const WaterDropHeader(
                                    waterDropColor: Colors.red),
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
      },
    );
  }
}
