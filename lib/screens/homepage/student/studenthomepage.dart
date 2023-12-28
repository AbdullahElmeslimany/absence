import 'dart:convert';

import 'package:absence/constant/constant.dart';
import 'package:absence/constant/link.dart';
import 'package:absence/constant/subject.dart';
import 'package:absence/screens/homepage/student/StudentAttendanceCamira.dart';
import 'package:absence/screens/homepage/student/drawerStudent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudentHomePage extends StatefulWidget {
  final firstname;
  final idmail;
  final group;
  final section;
  final specialty;
  const StudentHomePage(
      {super.key,
      this.firstname,
      required this.idmail,
      this.group,
      this.section,
      this.specialty});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  bool enable = true;
  bool latetime = true;
  List datasubject = [];
  List datastudent = [];
  getsubject() async {
    QuerySnapshot quiry =
        await FirebaseFirestore.instance.collection("subject").get();
  }

  List datasection = [];
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
          // dataTeach.addAll(responsebody["data"]);
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
          print("success");
          print(responsebody["data"]);
        } else if (responsebody["status"] == "failure") {
          print("failure");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  ///
  ///
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
    print("yesssssssssssssssssssssssssssssss");
    print(sectionsteaheractive);
    setState(() {
      enable = false;
    });
  }

  @override
  void initState() {
    getdatafromApi();
    //   getdata();
    // getshared();
    //   print(idusershared);
    //   print(studentdata);
    //  print(prefshared.getString("firstname"));
    //  print(pref.getString("firstname"));
    //   print(subjectClasses["firstterm"]["Informationsystems"]["second"]);
    //  // // getdatachectactivesction();
    //   getsubject();
    //   print("id ++-+-+-+-+----+-+-+");
    //   print(idusershared);
    //   print("id ++-+-+----+-+----+-+-+");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return enable == true
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(),
            endDrawer: DrawerStudent(studentdata: "studentdata"),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SafeArea(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(10),
                      cardinfo(context),
                      const Gap(20),
                      /////////////////////////////////////////////////////

                      Container(
                        color: Colors.grey[300],
                        height: 500,
                        child: Center(
                          child: StreamBuilder(
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

                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: InkWell(
                                        onTap: () {
                                          print(snapshot.data!.docs[index]
                                              ["table"]);
                                          print(
                                              datastudent[0]["id_university"]);
                                          print(snapshot.data!.docs[index]
                                              ["daytablename"]);
                                          checkdata(
                                              table: snapshot.data!.docs[index]
                                                  ["table"],
                                              iduniversity: (datastudent[0]
                                                      ["id_university"])
                                                  .toString(),
                                              day: snapshot.data!.docs[index]
                                                  ["daytablename"]);
                                          print(snapshot.data!.docs[index].id);
                                          if (snapshot.data!.docs[index]
                                                  ["active"] ==
                                              true) {
                                            // print(snapshot.data!.docs[index]["idRandom"]);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             StudentAttendance(
                                            //                 idstudent:
                                            //                     datastudent[0]
                                            //                         [
                                            //                         "id_university"],
                                            //                 datasection:
                                            //                     snapshot.data!
                                            //                             .docs[
                                            //                         index],
                                            //                 subjectname: snapshot
                                            //                         .data!
                                            //                         .docs[index]
                                            //                     ["nameSubject"],
                                            //                 idRandom: snapshot
                                            //                     .data!
                                            //                     .docs[index]
                                            //                     .id)));
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
                                                decoration: const BoxDecoration(
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
                                                                color:
                                                                    Colors.grey,
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
                                                      snapshot.data!.docs[index]
                                                          ["nameSubject"],
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
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
    //  Scaffold(
    //     endDrawer: DrawerStudent(studentdata: studentdata),
    //     appBar: AppBar(
    //         backgroundColor: Colors.blueGrey,
    //         title: Padding(
    //           padding: const EdgeInsets.only(left: 50.0),
    //           child: Center(
    //               child: Text("مرحبا بك  ${studentdata[0]["name"]}")),
    //         )),
    //     body: Padding(
    //       padding: const EdgeInsets.only(top: 20.0),
    //       child:
    // StreamBuilder(
    //         stream: sectionsteaheractive,
    //         builder: (BuildContext context,
    //             AsyncSnapshot<QuerySnapshot> snapshot) {
    //           if (snapshot.hasError) {
    //             return const Text("erorr");
    //           }
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const Center(child: CircularProgressIndicator());
    //           }

    //           return ListView.builder(
    //             itemCount: snapshot.data!.docs.length,
    //             itemBuilder: (context, index) {
    //               return InkWell(
    //                   onTap: () {
    //                     if (snapshot.data!.docs[index]["active"] == true) {
    //                       // print(snapshot.data!.docs[index]["idRandom"]);
    //                       Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) => StudentAttendance(
    //                                   idstudent: studentuser.docs[0].id,
    //                                   dataStudent: studentdata,
    //                                   subjectname: snapshot
    //                                       .data!.docs[index]["namesubject"],
    //                                   idRandom: snapshot.data!.docs[index]
    //                                       ["idRandom"])));
    //                     } else {
    //                       print("غير متاج");
    //                     }
    //                   },
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.end,
    //                     crossAxisAlignment: CrossAxisAlignment.stretch,
    //                     children: [
    //                       Container(
    //                           padding:
    //                               const EdgeInsetsDirectional.symmetric(
    //                                   horizontal: 20),
    //                           alignment: Alignment.centerRight,
    //                           height: 70,
    //                           width: MediaQuery.sizeOf(context).width - 20,
    //                           decoration:
    //                               const BoxDecoration(color: Colors.white),
    //                           child: Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceBetween,
    //                             children: [
    //                               snapshot.data!.docs[index]["active"] ==
    //                                       true
    //                                   ? const Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.end,
    //                                       children: [
    //                                         Icon(
    //                                           Icons.check_circle_outlined,
    //                                           color: Color.fromARGB(
    //                                               255, 2, 136, 53),
    //                                           size: 30,
    //                                           weight: 50,
    //                                         ),
    //                                         Text(
    //                                           "متاح",
    //                                           style: TextStyle(
    //                                               fontSize: 15,
    //                                               fontWeight:
    //                                                   FontWeight.bold),
    //                                         )
    //                                       ],
    //                                     )
    //                                   : const Column(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.end,
    //                                       children: [
    //                                         Icon(
    //                                           Icons
    //                                               .dnd_forwardslash_outlined,
    //                                           color: Colors.grey,
    //                                           size: 30,
    //                                         ),
    //                                         Text(
    //                                           "غير متاح",
    //                                           style: TextStyle(
    //                                               fontSize: 15,
    //                                               fontWeight:
    //                                                   FontWeight.bold),
    //                                         )
    //                                       ],
    //                                     ),
    //                               Text(
    //                                 snapshot.data!.docs[index]
    //                                     ["namesubject"],
    //                                 style: const TextStyle(
    //                                     fontSize: 20,
    //                                     fontWeight: FontWeight.bold),
    //                               ),
    //                             ],
    //                           )),
    //                       const SizedBox(
    //                         height: 7,
    //                       )
    //                     ],
    //                   ));
    //             },
    //           );
    //         },
    //       ),
    //     ),
    //   );
  }

  Container cardinfo(BuildContext context) {
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
          Text("${datastudent[0]['username']}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("سكشن : ${datastudent[0]['section']}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold)),
              Text("${datastudent[0]['group_s']} : المجموعة",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold)),
              Text("${datastudent[0]['year']}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold)),
            ],
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
