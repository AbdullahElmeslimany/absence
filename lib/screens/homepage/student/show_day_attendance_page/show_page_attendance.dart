import 'dart:convert';

import 'package:absence/constant/link.dart';
import 'package:absence/screens/homepage/student/show_day_attendance_page/cubit/helper/dayoption.dart';
import 'package:absence/screens/homepage/student/show_day_attendance_page/cubit/show_attendance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class ShowDayAttendance extends StatefulWidget {
  final data;
  const ShowDayAttendance({super.key, required this.data});

  @override
  State<ShowDayAttendance> createState() => _ShowDayAttendanceState();
}

class _ShowDayAttendanceState extends State<ShowDayAttendance> {
  @override
  void initState() {
    BlocProvider.of<ShowAttendanceCubit>(context).getDataFromAPI(
        link: Link.test,
        id: widget.data[0]["id_university"],
        mapdatalecture:
            BlocProvider.of<ShowAttendanceCubit>(context).datalecture,
        mapdatasection:
            BlocProvider.of<ShowAttendanceCubit>(context).datasection);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowAttendanceCubit, ShowAttendanceState>(
      listener: (context, state) {
        if (state is SuccessDataState) {}
        if (state is LoadingState) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: BlocProvider.of<ShowAttendanceCubit>(context).active == true
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        const Text(
                          "سجل الغياب",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 270,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(123, 158, 158, 158),
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            children: [
                              const Text("برمجة هيكلية متقدمة",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("سكشن",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 60,
                                    child: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              height: 56,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: 10,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      dayOption(
                                                          active: BlocProvider.of<
                                                                          ShowAttendanceCubit>(
                                                                      context)
                                                                  .datasection[
                                                              index]["day"],
                                                          day: index + 1),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            const Gap(3)
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(7),
                              Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("محاضرات",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 60,
                                    child: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Container(
                                              height: 56,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: 10,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Column(
                                                    children: [
                                                      dayOption(
                                                          active: BlocProvider.of<
                                                                          ShowAttendanceCubit>(
                                                                      context)
                                                                  .datalecture[
                                                              index]["day"],
                                                          day: index + 1),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            const Gap(3)
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
