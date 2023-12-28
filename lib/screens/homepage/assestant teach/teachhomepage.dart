import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:absence/constant/link.dart';
import 'package:absence/screens/homepage/assestant%20teach/appBar/drawerPage.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:absence/constant/constant.dart';
import 'package:absence/screens/homepage/assestant%20teach/Attendance%20Record%20Page/AttendanceRecordPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class TechHomePage extends StatefulWidget {
  final idmail;

  const TechHomePage({super.key, required this.idmail});

  @override
  State<TechHomePage> createState() => _TechHomePageState();
}

class _TechHomePageState extends State<TechHomePage> {
  static const String table = "teacher";
  // static const int idt = 29903031201631;
  List dataTeach = [];
  bool loading = true;
// late int id;
  getdatafromApi() async {
    try {
      prefs = await SharedPreferences.getInstance();
      // int id = prefs.getInt("idmail")!;
      var responce = await http.post(Uri.parse(Link.getdatalink),
          body: {"table": table, "nattional_id": (widget.idmail).toString()});

      // check is connect or no
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Map responsebody = jsonDecode(responce.body);
        print(responsebody);
        if (responsebody["status"] == "success") {
          print("success");
          print(responsebody["data"]);
          dataTeach.addAll(responsebody["data"]);
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

  late SharedPreferences prefs;

  @override
  void initState() {
    getdatafromApi();
    print(dataTeach);
    super.initState();
  }

  final controller = StreamController<SwipeRefreshState>.broadcast();
  Stream<SwipeRefreshState> get stream => controller.stream;

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    // when all needed is done change state
    controller.sink.add(SwipeRefreshState.hidden);
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> sectionsteaher = FirebaseFirestore.instance
        .collection("random")
        .where('idteacher', isEqualTo: "${widget.idmail}")
        .snapshots();
    return Scaffold(
      appBar: AppBar(),
      endDrawer: DrawerPage(
          /////////////////////////////////////////////
          ///
          ///edittttttt
          ///
          idTeach: "idTeach",
          fullnameTeach: "fullnameTeach",
          data: "data"),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: SafeArea(
                  child: Center(
                child: Column(
                  children: [
                    const Gap(10),
                    cardinfo(context),
                    const Gap(20),
                    const Text(
                      "السكاشن المتاحة",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Gap(5),
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: StreamBuilder(
                        stream: sectionsteaher,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("erorr");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () async {
                                  print(snapshot.data!.docs[index].id);
                                  // if (snapshot.data!.docs[index]["active"] == true) {
                                  FirebaseFirestore.instance
                                      .collection("random")
                                      .doc(snapshot.data!.docs[index].id)
                                      .update({"active": true});
                                  final refrandom = FirebaseFirestore.instance
                                      .collection('random')
                                      .doc(snapshot.data!.docs[index].id);
                                  await refrandom.update({
                                    "randomSubject":
                                        Random().nextInt(100000) * 9965999
                                  });
                                  DocumentSnapshot getrandom =
                                      await refrandom.get();
                                  List datasubject = [];
                                  datasubject.add(getrandom);
                                  // ignore: use_build_context_synchronously
                                  print(datasubject[0]["randomSubject"]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AttendanceRecordPage(
                                                numberrandom: datasubject[0]
                                                    ["randomSubject"],
                                                mapdata: datasubject,
                                                idrandom: snapshot
                                                    .data!.docs[index].id,
                                                namesubject:
                                                    snapshot.data!.docs[index]
                                                        ["nameSubject"]),
                                      ));
                                },
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: ListTile(
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                snapshot.data!.docs[index]
                                                    ["nameteather"],
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                          ["numbersection"][0] +
                                                      " - " +
                                                      snapshot.data!.docs[index]
                                                          ["numbersection"][1],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      title: Center(
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              ["nameSubject"],
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )),
            ),
    );

    // Stream<QuerySnapshot> sectionsteahe = FirebaseFirestore.instance
    //     .collection("section")
    //     .where('id', isEqualTo: "${widget.idmail}")
    //     .snapshots();
    // return loading == true
    //     ? const Scaffold(
    //         body: Center(child: CircularProgressIndicator()),
    //       )
    //     : Scaffold(
    //         endDrawer: DrawerPage(
    //             data: dataTeach,
    //             idTeach: widget.idmail,
    //             fullnameTeach: dataTeach[0]["fullname"]),
    //         appBar: AppBar(
    //             backgroundColor: Colors.grey[200],
    //             title: Center(
    //                 child: InkWell(
    //                     onTap: () {
    //                       print(DateTime.utc(2023, 12, 02, 12, 03, 0));
    //                     },
    //                     child: Text("مرحبا م.${dataTeach[0]["name"]}")))),
    //         body: Container(
    //           color: Colors.grey[300],
    //           child: StreamBuilder(
    //             stream: sectionsteaher,
    //             builder: (BuildContext context,
    //                 AsyncSnapshot<QuerySnapshot> snapshot) {
    //               if (snapshot.hasError) {
    //                 return const Text("erorr");
    //               }
    //               if (snapshot.connectionState == ConnectionState.waiting) {
    //                 return const Center(child: CircularProgressIndicator());
    //               }

    //               return ListView.builder(
    //                 itemCount: snapshot.data!.docs.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return InkWell(
    //                     onTap: () async {
    //                       // if (snapshot.data!.docs[index]["active"] == true) {
    //                       FirebaseFirestore.instance
    //                           .collection("section")
    //                           .doc(snapshot.data!.docs[index].id)
    //                           .update({"active": true});
    //                       final refrandom = FirebaseFirestore.instance
    //                           .collection('random')
    //                           .doc(snapshot.data!.docs[index]["idRandom"]);
    //                       await refrandom.update({
    //                         "randomSubject": Random().nextInt(100000) * 9965
    //                       });
    //                       DocumentSnapshot getrandom = await refrandom.get();
    //                       List data = [];
    //                       data.add(getrandom);
    //                       // ignore: use_build_context_synchronously
    //                       Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                             builder: (context) => AttendanceRecordPage(
    //                                 numberrandom: data[0]["randomSubject"],
    //                                 mapdata: snapshot.data!.docs[index],
    //                                 idteach: snapshot.data!.docs[index].id,
    //                                 namesubject: snapshot.data!.docs[index]
    //                                     ["namesubject"]),
    //                           ));
    //                       // }
    //                     },
    //                     child: Card(
    //                       color: const Color.fromARGB(255, 255, 255, 255),
    //                       child: ListTile(
    //                           subtitle: Padding(
    //                             padding:
    //                                 const EdgeInsets.symmetric(horizontal: 10),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Text(
    //                                     snapshot.data!.docs[index]
    //                                         ["nameteacher"],
    //                                     style: const TextStyle(
    //                                         fontSize: 15,
    //                                         fontWeight: FontWeight.bold)),
    //                                 Row(
    //                                   children: [
    //                                     Text(
    //                                       snapshot.data!.docs[index]
    //                                               ["numbersection"][0] +
    //                                           " - " +
    //                                           snapshot.data!.docs[index]
    //                                               ["numbersection"][1],
    //                                       style: const TextStyle(
    //                                           fontSize: 20,
    //                                           fontWeight: FontWeight.bold),
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           title: Center(
    //                             child: Text(
    //                               snapshot.data!.docs[index]["namesubject"],
    //                               style: const TextStyle(
    //                                   fontSize: 25,
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                           )),
    //                     ),
    //                   );
    //                 },
    //               );
    //             },
    //           ),
    //         ),
    //       );
  }

  Container cardinfo(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 30,
      height: 150,
      decoration: BoxDecoration(
          color: darkcolor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "!مرحبا بك",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("م/ ${dataTeach[0]["fullname"]}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const Gap(15),
          const Text("نسعد اليوم بوجودك معنا نتمني ان تكون في افضل حال",
              style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
