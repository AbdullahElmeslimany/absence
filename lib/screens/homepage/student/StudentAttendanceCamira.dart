import 'dart:convert';

import 'package:absence/constant/constant.dart';
import 'package:absence/constant/encryptprossing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class StudentAttendance extends StatefulWidget {
  final subjectname;
  const StudentAttendance({super.key, required this.subjectname});

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanCompleted = false;
  bool active = false;
  String? latecode;
  List datagetrandom = [];
  // late DocumentSnapshot getdata;
  void colseScreen() {
    isScanCompleted = false;
  }

  List dataSection = [];
  getdatasection() async {
    QuerySnapshot qury =
        await FirebaseFirestore.instance.collection("section").get();
    setState(() {
      dataSection.addAll(qury.docs);
    });
    print(dataSection[0]["idRandom"]);
  }

  getdataforRandom() async {
    // Eroooooooooooorr
    DocumentReference refrandom = FirebaseFirestore.instance
        .collection('random')
        .doc(dataSection[0]["idRandom"]);
    DocumentSnapshot getdata = await refrandom.get();
    setState(() {
      datagetrandom.add(getdata);
    });
    print(datagetrandom[0]["randomSubject"]);
    print(datagetrandom[0]["randomSubject"].runtimeType);
  }

  @override
  void initState() {
    getdatasection();
    // getdataforRandom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Center(
              child: Text(
            "تسجيل حضور مادة",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ))),
      body:

          //  Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(top: 25.0, bottom: 30),
          //       child: Container(
          //         alignment: AlignmentDirectional.center,
          //         width: MediaQuery.sizeOf(context).width - 30,
          //         decoration: const BoxDecoration(
          //             color: Colors.amber,
          //             borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(15),
          //                 bottomLeft: Radius.circular(30),
          //                 topRight: Radius.circular(30),
          //                 bottomRight: Radius.circular(15))),
          //         child: Text(
          //           widget.subjectname,
          //           style: TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: MediaQuery.sizeOf(context).width / 11),
          //         ),
          //       ),
          //     ),
          Stack(
        children: [
          Center(
              child: Stack(
            children: [
              Center(
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  height: 300,
                  width: 300,
                  child: MobileScanner(
                    onDetect: (barcode, args) async {
                      if (!isScanCompleted) {
                        setState(() {
                          String code = barcode.rawValue ?? '----------';
                          latecode = code;
                          print("+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+==+=+");
                          print(latecode.runtimeType);

                          print("+=+=+=+=+=++=+=+=+=+=+=+=+==+=+");

                          isScanCompleted = true;
                        });
                        if (datagetrandom[0]["randomSubject"].toString() ==
                            latecode.toString()) {
                          setState(() {
                            active = true;
                          });

                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc("brdfK1HcFNbmtDo73ZAX")
                              .update({"type": true});
                          print("sucess");
                        } else {
                          print("Faild");
                        }
                      }
                    },
                  ),
                ),
              ),
              QRScannerOverlay(
                borderColor: Colors.white,
                scanAreaHeight: 300,
                scanAreaWidth: 300,
              )
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  width:  MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 81, 94, 129),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(15))),
                  child: Text(
                    widget.subjectname,
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.sizeOf(context).width / 11),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // if (latecode == null && active != true)
      //   Container()
      // else
      //   Text("تم تسجيل بنجاح")
      //   ],
      // )
    );
  }
}
