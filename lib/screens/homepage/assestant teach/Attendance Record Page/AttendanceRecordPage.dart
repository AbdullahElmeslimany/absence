import 'dart:convert';

import 'package:absence/constant/constant.dart';
import 'package:absence/constant/encryptprossing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
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
  // late final encrypt;
  @override
  void initState() {
    // setState(() {
    //   encrypt = MyEncryption.encryptAES(json.encode(widget.mapdata[0]));
    print("===================================== encrypt");
    print(widget.mapdata["id"]);
    // print(json.encode(widget.mapdata[0]));

    print("===================================== encrypt");
    // });
    print(widget.idteach);
    print("===================================== map");
    // print(widget.mapdata[0]["nameteacher"]);
    print(DateTime.now());
    // print(MyEncryption.decryptAES(encrypt));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          actions: [
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
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
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
              height: 40,
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
                      stream: users,
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
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                child: ListTile(
                                    leading: MaterialButton(
                                      onPressed: () {},
                                      child: snapshot.data!.docs[index]
                                                  ["type"] ==
                                              true
                                          ? const Text(
                                              "حضر",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.greenAccent),
                                            )
                                          : const Text(
                                              "غائب",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                    ),
                                    // subtitle:
                                    //     Text(snapshot.data!.docs[index]["age"]),
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
