import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
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
  RefreshController refreshControllerteacher =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshControllerteacher.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    refreshControllerteacher.loadComplete();
  }

  @override
  void initState() {
    userstudent =
        FirebaseFirestore.instance.collection("usersStudent").snapshots();
    print(widget.mapdata[0]["table"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          actions: const [
            Center(
                child: Text(
              " :  تسجيل حضور ",
              style: TextStyle(fontSize: 20),
            )),
          ],
          backgroundColor: Colors.blueGrey,
          title: Center(
              child: Text(
            " ${widget.namesubject}",
            style: const TextStyle(fontSize: 25),
          ))),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: QrImageView(
                  data: widget.numberrandom.toString(),
                  size: MediaQuery.sizeOf(context).width - 120,
                  version: QrVersions.auto,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Button_END_Student_Record
              buttonEndRecordStudent(context, idrandom: widget.idrandom),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
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
                            controller: refreshControllerteacher,
                            onRefresh: onRefresh,
                            onLoading: onLoading,
                            enablePullDown: true,
                            header: WaterDropHeader(waterDropColor: Colors.red),
                            child: ListView.builder(
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Card(
                                    child: ListTile(
                                        leading: MaterialButton(
                                          onPressed: () async {
                                            if (snapshot.data!.docs[index]
                                                    ["active"] ==
                                                true) {
                                              await FirebaseFirestore.instance
                                                  .collection("usersStudent")
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .update({"active": false});
                                            } else {
                                              await FirebaseFirestore.instance
                                                  .collection("usersStudent")
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .update({"active": true});
                                            }
                                          },
                                          child: snapshot.data!.docs[index]
                                                      ["active"] ==
                                                  true
                                              ? const Text(
                                                  "حضر",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.greenAccent),
                                                )
                                              : const Text(
                                                  "غائب",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                        ),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(snapshot.data!.docs[index]
                                                ["fullname"]),
                                          ],
                                        )),
                                  ),
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

  MaterialButton buttonEndRecordStudent(
    BuildContext context, {
    required idrandom,
  }) {
    return MaterialButton(
      onPressed: () {
        FirebaseFirestore.instance
            .collection("random")
            .doc(idrandom)
            .update({"active": false}).then((value) => Navigator.pop(context));
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width - 20,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20)),
        child: const Center(
            child: Text(
          "انهاء الحضور",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
