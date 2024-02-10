import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:absence/constant/link.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:vibration/vibration.dart';

class StudentAttendance extends StatefulWidget {
  final idstudent;
  final subjectname;
  final datasection;
  final idRandom;
  const StudentAttendance(
      {super.key,
      required this.subjectname,
      required this.datasection,
      required this.idRandom,
      required this.idstudent});

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

  Position? position;
  positionGet() async {
    position = await Geolocator.getLastKnownPosition();
    print(position!.latitude);
    print(position!.longitude);
  }

  @override
  void initState() {
    print("////////////////////////////////////");
    print(widget.datasection["table"]);
    print("/////////////////////////");
    getdatasection();
    positionGet();
    // print(widget.idstudent);
    // print("===========----========================-------");
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
                          print(latecode.runtimeType);
                          isScanCompleted = true;
                        });

                        if (position!.latitude > 31.015478979887387 &&
                            position!.longitude > 31.377746093558976 &&
                            position!.latitude > 31.015295674066557 &&
                            position!.longitude > 31.37804683624477 &&
                            position!.latitude < 31.016691007875927 &&
                            position!.longitude < 31.37902791462027 &&
                            position!.latitude < 31.01641791122879 &&
                            position!.longitude < 31.37937827817284) {
                          //31.016013481797803,31.37868090382897
                          print("انت بالداخل");
                        } else {
                          print("انت بالخارج");
                          success();
                          // AwesomeDialog(
                          //   context: context,
                          //   dialogType: DialogType.noHeader,
                          //   animType: AnimType.bottomSlide,
                          //   title: 'لم يتم تسجيل حضورك انت خارج الجامعة ',
                          //   // desc: 'Dialog description here.............',
                          //   btnCancelText: "الرجوع",
                          //   btnCancelOnPress: () {
                          //     Navigator.pop(context);
                          //   },
                          // ).show();
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

  success() async {
    if (datagetrandom[0]["randomSubject"].toString() == latecode.toString()) {
      ////////////////////////////////////////
      String table = widget.datasection["table"];
      String day = widget.datasection["daytablename"];
      String value = "1";
      String iduniversity = (widget.idstudent).toString();

      try {
        var responce = await http.post(Uri.parse(Link.updatelink), body: {
          "table": table,
          "day": day,
          "value": value,
          "iduniversity": iduniversity,
        });

        // check is connect or no
        if (responce.statusCode == 200 || responce.statusCode == 201) {
          Map responsebody = jsonDecode(responce.body);

          print(responsebody);
          if (responsebody["status"] == "success") {
            print(responsebody["data"]);

            print("success");
            Vibration.vibrate(duration: 350, amplitude: 128);
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.bottomSlide,
              title: 'تم تسجيل حضورك بنجاح',
              desc: '${widget.subjectname}',
              descTextStyle:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              btnOkOnPress: () {
                Navigator.pop(context);
              },
            ).show();
          } else if (responsebody["status"] == "failure") {
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
      } catch (e) {
        print(e);
      }

      //////////////////////////////////////////////
    } else {
      // Vibration.vibrate(pattern: [500, 0, 0, 200]);
    }
  }
}
