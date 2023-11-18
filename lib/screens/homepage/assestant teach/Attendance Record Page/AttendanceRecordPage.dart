import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AttendanceRecordPage extends StatefulWidget {
  final idteach;
  final String namesubject;
  final mapdata;
  final numberrandom;
  const AttendanceRecordPage(
      {super.key,
      required this.idteach,
      required this.namesubject,
      required this.mapdata,
      required this.numberrandom});

  @override
  State<AttendanceRecordPage> createState() => _AttendanceRecordPageState();
}

class _AttendanceRecordPageState extends State<AttendanceRecordPage> {
  late Stream<QuerySnapshot> userstudent;
  @override
  void initState() {
    userstudent =
        FirebaseFirestore.instance.collection("usersStudent").snapshots();

    print("===================================== encrypt");
    print(widget.mapdata["id"]);

    print("===================================== encrypt");

    print(widget.idteach);
    print("===================================== map");

    print(DateTime.now());

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
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            widget.mapdata == null
                ? Container()
                : Center(
                    child: QrImageView(
                      data: widget.numberrandom.toString(),
                      size: MediaQuery.sizeOf(context).width - 40,
                      version: QrVersions.auto,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("section")
                    .doc(widget.idteach)
                    .update({"active": false}).then(
                        (value) => Navigator.pop(context));
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
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
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

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                child: ListTile(
                                    // leading: MaterialButton(
                                    //   onPressed: () {},
                                    //   child: snapshot.data!.docs[index]
                                    //               ["type"] ==
                                    //           true
                                    //       ? const Text(
                                    //           "حضر",
                                    //           style: TextStyle(
                                    //               fontSize: 18,
                                    //               fontWeight: FontWeight.bold,
                                    //               color: Colors.greenAccent),
                                    //         )
                                    //       : const Text(
                                    //           "غائب",
                                    //           style: TextStyle(
                                    //               fontSize: 18,
                                    //               fontWeight: FontWeight.bold,
                                    //               color: Colors.red),
                                    //         ),
                                    // ),

                                    title: Text(
                                        snapshot.data!.docs[index]["name"])),
                              ),
                            );
                          },
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
    ));
  }
}
