import 'dart:convert';

import 'package:absence/constant/link.dart';
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
        mapdata: BlocProvider.of<ShowAttendanceCubit>(context).data);
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "كشف غيابك",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
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
                                    color: Colors.grey[200],
                                    height: 70,
                                    child: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Container(
                                              color: Colors.grey[200],
                                              height: 70,
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
                                                          active: BlocProvider
                                                                  .of<ShowAttendanceCubit>(
                                                                      context)
                                                              .data?[index]["day"],
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
                                    color: Colors.grey[200],
                                    height: 70,
                                    child: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Container(
                                              color: Colors.grey[200],
                                              height: 70,
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
                                                          active: BlocProvider
                                                                  .of<ShowAttendanceCubit>(
                                                                      context)
                                                              .data?[index]["day"],
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

  Padding dayOption({required active, required day}) {
    Color colorsactive = Colors.green;
    Color colorsunactive = Colors.red;
    Color colorsnull = Colors.grey;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: active == 1
                ? colorsactive
                : active == 0
                    ? colorsunactive
                    : colorsnull),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      child: Icon(
                        active == 1
                            ? Icons.check_circle_outlined
                            : active == 0
                                ? Icons.do_disturb_outlined
                                : Icons.info_outlined,
                        size: 27,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "$day",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
