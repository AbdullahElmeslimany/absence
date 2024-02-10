import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:absence/constant/constant.dart';
import 'package:absence/constant/link.dart';
import 'package:absence/constant/subject.dart';
import 'package:absence/screens/homepage/student/studentattendanceCamira.dart';
import 'package:absence/screens/homepage/student/drawerStudent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHomePage extends StatefulWidget {
  final idmail;
  const StudentHomePage({
    super.key,
    required this.idmail,
  });

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  bool enable = true;
  List datastudent = [];
  bool loading = true;
  ///////////////////////////////////////////////////
  static const String table = "student";
  late SharedPreferences prefs;
  getdatafromApi() async {
    try {
      prefs = await SharedPreferences.getInstance();
      int id = prefs.getInt("idmail")!;
      var responce = await http.post(Uri.parse(Link.getdatalink),
          body: {"table": table, "nattional_id": (widget.idmail).toString()});

      // check is connect or no
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Map responsebody = jsonDecode(responce.body);

        print(responsebody);
        if (responsebody["status"] == "success") {
          datastudent.addAll(responsebody["data"]);
          print("success");
          print(responsebody["data"]);
          print(datastudent[0]["username"]);
          getstream();
        } else if (responsebody["status"] == "failure") {
          print("failure");
        }
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  ////////////////////////////////////////////////////////
  ///
  ///
  checkdata(
      {required String table,
      required String iduniversity,
      required String day}) async {
    try {
      var responce = await http.post(Uri.parse(Link.checkactive), body: {
        "table": table,
        "id_university": (iduniversity).toString(),
        "day": day
      });
      // check is connect or no
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Map responsebody = jsonDecode(responce.body);
        print(responsebody);
        if (responsebody["status"] == "success") {
          datastudent.addAll(responsebody["data"]);
        } else if (responsebody["status"] == "failure") {
          print("failure");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  ////////////////////////////////////////////////////////////

  String? idusershared;
  SharedPreferences? prefget;
  getshared() async {
    prefget = await SharedPreferences.getInstance();

    idusershared = prefget!.getString("idmail");

    print(prefget!.getString("idmail"));
  }

  late Stream<QuerySnapshot> sectionsteaheractive;
  getstream() {
    sectionsteaheractive = FirebaseFirestore.instance
        .collection("random")
        .where('numbersection', arrayContains: "${datastudent[0]['section']}")
        .where("group", isEqualTo: datastudent[0]["group_s"])
        .where("year", isEqualTo: datastudent[0]["year"])
        .snapshots();
    setState(() {
      enable = false;
    });
  }

/////////////////////////////////////////////////////////
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RefreshController refreshController = RefreshController(initialRefresh: true);

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    refreshController.loadComplete();
  }

  ////////////////////////////////////////////////////
  getdataformmemory() async {
    SharedPreferences prefsAdd = await SharedPreferences.getInstance();
    print("id mail===============================");
    print("data...................................");
    print("id =  ${prefsAdd.getInt("idmail")}");
    print("rank =  ${prefsAdd.getInt("rank")}");
    print("repeat =  ${prefsAdd.getBool("repeat")}");
    print("data..............................");
  }

  @override
  void initState() {
    getdatafromApi();
    getdataformmemory();
    super.initState();
  }

  final GlobalKey streamKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return enable == true
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            key: scaffoldKey,
            appBar: AppBar(),
            endDrawer: DrawerStudent(studentdata: datastudent),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SafeArea(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(10),
                      cardinfo(
                          username: datastudent[0]['username'],
                          section: datastudent[0]['section'],
                          group: datastudent[0]['group_s'],
                          year: datastudent[0]['year']),
                      const Gap(20),
                      /////////////////////////////////////////////////////
                      Container(
                        color: Colors.grey[300],
                        height: 500,
                        child: Center(
                          child: StreamBuilder(
                            key: streamKey,
                            stream: sectionsteaheractive,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child:
                                        const Text("erorrrrrrrrrrrrrrrrrrr"));
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              return SmartRefresher(
                                controller: refreshController,
                                onRefresh: onRefresh,
                                onLoading: onLoading,
                                enablePullDown: true,
                                header:
                                    WaterDropHeader(waterDropColor: Colors.red),
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: InkWell(
                                          onTap: () {
                                            print(snapshot.data!.docs[index]
                                                ["table"]);
                                            print(datastudent[0]
                                                ["id_university"]);
                                            print(snapshot.data!.docs[index]
                                                ["daytablename"]);
                                            checkdata(
                                                table: snapshot
                                                    .data!.docs[index]["table"],
                                                iduniversity: (datastudent[0]
                                                        ["id_university"])
                                                    .toString(),
                                                day: snapshot.data!.docs[index]
                                                    ["daytablename"]);
                                            print(
                                                snapshot.data!.docs[index].id);
                                            if (snapshot.data!.docs[index]
                                                    ["active"] ==
                                                true) {
                                              // print(snapshot.data!.docs[index]["idRandom"]);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => StudentAttendance(
                                                          idstudent: datastudent[
                                                                  0]
                                                              ["id_university"],
                                                          datasection: snapshot
                                                              .data!
                                                              .docs[index],
                                                          subjectname: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["nameSubject"],
                                                          idRandom: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id)));
                                            } else {
                                              print("غير متاج");
                                            }
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .symmetric(
                                                          horizontal: 20),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  height: 70,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width -
                                                          20,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      snapshot.data!.docs[index]
                                                                  ["active"] ==
                                                              true
                                                          ? const Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .check_circle_outlined,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          2,
                                                                          136,
                                                                          53),
                                                                  size: 30,
                                                                  weight: 50,
                                                                ),
                                                                Text(
                                                                  "متاح",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            )
                                                          : const Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .dnd_forwardslash_outlined,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 30,
                                                                ),
                                                                Text(
                                                                  "غير متاح",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            ),
                                                      Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ["nameSubject"],
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  )),
                                              const SizedBox(
                                                height: 7,
                                              )
                                            ],
                                          )),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      //////////////////////////////////////
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Container cardinfo(
      {required username, required section, required group, required year}) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 30,
      height: 170,
      decoration: BoxDecoration(
          color: darkcolor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "!مرحبا بك",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("$username",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const Gap(15),
          Container(
            height: 32,
            width: MediaQuery.sizeOf(context).width - 37,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("سكشن : $section",
                    style: const TextStyle(
                        // color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                Container(
                  color: Colors.grey,
                  width: 1,
                  height: 27,
                ),
                Text("$group : المجموعة",
                    style: const TextStyle(
                        // color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
                Container(
                  color: Colors.grey,
                  width: 1,
                  height: 27,
                ),
                Text("$year",
                    style: const TextStyle(
                        // color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Gap(15),
          const Text("نسعد اليوم بوجودك معنا نتمني ان تكون في افضل حال",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
