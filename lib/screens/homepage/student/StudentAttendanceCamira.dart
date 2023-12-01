import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:vibration/vibration.dart';

class StudentAttendance extends StatefulWidget {
  final subjectname;
  final dataStudent;
  final idRandom;
  const StudentAttendance(
      {super.key,
      required this.subjectname,
      required this.dataStudent,
      required this.idRandom});

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

  getdatasection() async {
    List dataSection = [];
    QuerySnapshot qury = await FirebaseFirestore.instance
        .collection("section")
        .where("group", isEqualTo: widget.dataStudent[0]["group"])
        .where("numbersection",
            arrayContains: widget.dataStudent[0]["numbersection"])
        .get();
    setState(() {
      dataSection.addAll(qury.docs);
    });
    print("=========================================data");

    print("===++++++++++++++++++++++++++++++++++++=====data");

    DocumentSnapshot refrandom = await FirebaseFirestore.instance
        .collection('random')
        .doc(widget.idRandom)
        .get();

    setState(() {
      datagetrandom.add(refrandom);
    });
    print("=========================================data");

    print(widget.idRandom);
    print(datagetrandom[0]["randomSubject"]);
    print("===++++++++++++++++++++++++++++++++++++=====data");
  }

  @override
  void initState() {
    getdatasection();

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
      body: Stack(
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
                          Vibration.vibrate(duration: 350, amplitude: 128);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.bottomSlide,
                            title: 'تم تسجيل حضورك بنجاح',
                            desc: '${widget.subjectname}',
                            descTextStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            btnOkOnPress: () {
                              Navigator.pop(context);
                            },
                          ).show();

                          setState(() {
                            active = true;
                          });

                          await FirebaseFirestore.instance
                              .collection("usersStudent")
                              .doc(widget.idRandom)
                              .update({"active": true});
                          print("sucess");
                        } else {
                          // Vibration.vibrate(pattern: [500, 0, 0, 200]);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.bottomSlide,
                            title: 'لم  يتم تسجيل حضورك اعد المحاولة',
                            // desc: 'Dialog description here.............',
                            btnCancelText: "الرجوع",
                            btnCancelOnPress: () {
                              Navigator.pop(context);
                            },
                          ).show();
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
                padding: const EdgeInsets.only(top: 5.0),
                child: Container(
                  height: 100,
                  alignment: Alignment.center,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 5, 10, 39),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(15))),
                  child: Text(
                    widget.subjectname,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.sizeOf(context).width / 11),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
