import 'dart:convert';

import 'package:absence/constant/link.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class ShowDayAttendance extends StatefulWidget {
  final data;
  const ShowDayAttendance({super.key, required this.data});

  @override
  State<ShowDayAttendance> createState() => _ShowDayAttendanceState();
}

class _ShowDayAttendanceState extends State<ShowDayAttendance> {
  List? data = [];
  bool active = true;
  int id = 20231212;

  getDataFromAPI({required link, required id, required mapdata}) async {
    try {
      var responce =
          await http.post(Uri.parse(link), body: {"id": id.toString()});
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Map responsebody = jsonDecode(responce.body);
        if (responsebody["status"] == "success") {
          for (var i = 0; i < 9; i++) {
            mapdata.insert(i, {"day": responsebody["data"][0]["s_${i + 1}"]});
          }
          setState(() {
            active = false;
          });
          print("success");
        } else if (responsebody["status"] == "failure") {
          print("failure");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getDataFromAPI(
        link: Link.test, id: widget.data[0]["id_university"], mapdata: data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: active == true
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("برمجة هيكلية متقدمة"),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                color: Colors.grey[200],
                                height: 70,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 9,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        dayOption(
                                            active: data?[index]["day"],
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
              ),
            ),
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
