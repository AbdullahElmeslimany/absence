import 'dart:convert';
import 'package:absence/constant/constant.dart';
import 'package:absence/constant/link.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/teachhomepage.dart';
import 'package:absence/screens/homepage/student/studenthomepage.dart';
import 'package:absence/test/testpage.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loadButton = false;
  String? nationalid;
  String? password;
  late SharedPreferences prefs;
  savedSharedData() async {
    prefs = await SharedPreferences.getInstance();
  }

  permision() async {
    PermissionStatus camira = await Permission.camera.status;
    PermissionStatus location = await Permission.location.status;
    print(camira);
    print(location);
    if (camira.isDenied) {
      await Permission.camera.request();
    }
    if (location.isDenied) {
      await Permission.location.request();
    }
  }

  // positionGet() async {
  //   Position? position = await Geolocator.getLastKnownPosition();
  //   // double late = 31.01534035567858;
  //   // double lang = 31.377829242038437;
  //   // print(late - 31.015478979887387);
  //   // print(late - 31.015295674066557);
  //   // print(late - 31.016691007875927);
  //   // print(late - 31.01641791122879);
  //   // print(lang - 31.377746093558976);
  //   // print(lang - 31.37804683624477);
  //   // print(lang - 31.37902791462027);
  //   // print(lang - 31.37937827817284);

  //   // if (late > 31.015478979887387 &&
  //   //     lang > 31.377746093558976 &&
  //   //     late > 31.015295674066557 &&
  //   //     lang > 31.37804683624477 &&
  //   //     late < 31.016691007875927 &&
  //   //     lang < 31.37902791462027 &&
  //   //     late < 31.01641791122879 &&
  //   //     lang < 31.37937827817284) {
  //   //   print("انت بالداخل");
  //   // } else {
  //   //   print("انت بالخارج");
  //   // }
  //   //31.016013481797803,31.37868090382897

  //   // else {
  //   //   print("انت بالخارج");
  //   // }
  //   //////////////////////////
  //   if (position!.latitude > 31.015478979887387 &&
  //       position!.longitude > 31.377746093558976 &&
  //       position!.latitude > 31.015295674066557 &&
  //       position!.longitude > 31.37804683624477 &&
  //       position!.latitude < 31.016691007875927 &&
  //       position!.longitude < 31.37902791462027 &&
  //       position!.latitude < 31.01641791122879 &&
  //       position!.longitude < 31.37937827817284) {
  //     //31.016013481797803,31.37868090382897
  //     print("انت بالداخل");
  //   } else {
  //     print("انت بالخارج");
  //   }
  //   print(position!.latitude);
  //   print(position!.longitude);
  // }

  getdatafrommemory() async {
    SharedPreferences prefsAdd = await SharedPreferences.getInstance();
    print("data...................................");
    print("id =  ${prefsAdd.getInt("idmail")}");
    print("rank =  ${prefsAdd.getInt("rank")}");
    print("repeat =  ${prefsAdd.getBool("repeat")}");
    print("data..............................");
  }

  @override
  void initState() {
    savedSharedData();
    permision();
    determinePositiona();
    getdatafrommemory();
    // positionGet();
    super.initState();
  }

  GlobalKey<FormState> loginkey = GlobalKey<FormState>();
  TextEditingController idnatinalController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(.3, 15),
            colors: <Color>[
              Colors.white,
              // Color(0xfff39060),
              // Color(0xffffb56b),
              Colors.black54
            ],
          )),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 220,
                            height: 200,
                            child: Image.asset("assets/images/logo.png")),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "مرحبا بك",
                          style: GoogleFonts.alexandria(
                              fontSize: 30, color: darkcolor),
                        ),
                        const Gap(12),
                        Form(
                          key: loginkey,
                          child: Container(
                            height: 210,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    controller: idnatinalController,
                                    textDirection: TextDirection.ltr,
                                    autofocus: true,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "الرقم القومي",
                                    ),
                                    textAlign: TextAlign.start,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'يرجي ادخال الرقم القومي';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    textDirection: TextDirection.ltr,
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "الباسورد",
                                    ),
                                    textAlign: TextAlign.start,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'يرجي ادخال الباسورد';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: darkcolor,
                          ),
                          width: 190,
                          child: MaterialButton(
                            height: 30,
                            child: loadButton == true
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "تسجيل الدخول",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                            onPressed: () async {
                              if (loginkey.currentState!.validate()) {
                                setState(() {
                                  loadButton = true;
                                });
                                List data = [];
                                try {
                                  var responce = await http
                                      .post(Uri.parse(Link.loginlink), body: {
                                    "nattional_id": idnatinalController.text,
                                    "password": passwordController.text,
                                  });
                                  // check is connect or no
                                  if (responce.statusCode == 200 ||
                                      responce.statusCode == 201) {
                                    Map responsebody =
                                        jsonDecode(responce.body);

                                    print(responsebody);
                                    if (responsebody["status"] == "success") {
                                      data.addAll(responsebody["data"]);

                                      setState(() {
                                        loadButton = false;
                                      });
                                      print("success");
                                      SharedPreferences prefsAdd =
                                          await SharedPreferences.getInstance();
                                      prefsAdd.setInt(
                                          "idmail", data[0]["nattional_id"]);
                                      prefsAdd.setInt("rank", data[0]["rank"]);
                                      prefsAdd.setBool("repeat", true);

                                      if (responsebody["data"][0]["rank"] ==
                                          1) {
                                        print("scussess");
                                        Get.offAll(
                                            TechHomePage(
                                                idmail: data[0]
                                                    ["nattional_id"]),
                                            transition:
                                                Transition.circularReveal);
                                      } else if (responsebody["data"][0]
                                              ["rank"] ==
                                          0) {
                                        prefs.setInt(
                                            "idmail", data[0]["nattional_id"]);
                                        Get.offAll(
                                            StudentHomePage(
                                                idmail: data[0]
                                                    ["nattional_id"]),
                                            transition: Transition.fade);
                                      }
                                    } else if (responsebody["status"] ==
                                        "failure") {
                                      setState(() {
                                        loadButton = false;
                                      });
                                      Get.dialog(
                                        const Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            title: Text("خطاء"),
                                            content: Text(
                                                "الرقم القومي او الرقم السري خاطيء"),
                                          ),
                                        ),
                                      );
                                      print("failure");
                                    }
                                  } else {
                                    setState(() {
                                      loadButton = false;
                                    });
                                    Get.dialog(
                                      const Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: AlertDialog(
                                          title: Text("خطاء الاتصال بالانترنت"),
                                          content: Text(
                                              "يرجي فحص الشبكة الخاصة بك ومعاومة المحاولة"),
                                        ),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // MaterialButton(
                    //   onPressed: () {
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const RegesterPage(),
                    //         ));
                    //   },
                    //   child: Container(
                    //     width: 120,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(25),
                    //       color: const Color.fromARGB(255, 248, 86, 74),
                    //     ),
                    //     child: const Center(
                    //       child: Text(
                    //         "ليس لدي حساب",
                    //         style: TextStyle(
                    //             fontSize: 17,
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
