import 'dart:convert';

import 'package:absence/LoginPage/regester.dart';
import 'package:absence/constant/Shared.dart';
import 'package:absence/constant/constant.dart';
import 'package:absence/constant/link.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/teachhomepage.dart';
import 'package:absence/screens/homepage/student/studenthomepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:absence/test/testpage.dart';
import 'package:geolocator/geolocator.dart';
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

  positionGet() async {
    Position? position = await Geolocator.getLastKnownPosition();
    // double late = 31.01534035567858;
    // double lang = 31.377829242038437;
    // print(late - 31.015478979887387);
    // print(late - 31.015295674066557);
    // print(late - 31.016691007875927);
    // print(late - 31.01641791122879);
    // print(lang - 31.377746093558976);
    // print(lang - 31.37804683624477);
    // print(lang - 31.37902791462027);
    // print(lang - 31.37937827817284);

    // if (late > 31.015478979887387 &&
    //     lang > 31.377746093558976 &&
    //     late > 31.015295674066557 &&
    //     lang > 31.37804683624477 &&
    //     late < 31.016691007875927 &&
    //     lang < 31.37902791462027 &&
    //     late < 31.01641791122879 &&
    //     lang < 31.37937827817284) {
    //   print("انت بالداخل");
    // } else {
    //   print("انت بالخارج");
    // }
    //31.016013481797803,31.37868090382897

    // else {
    //   print("انت بالخارج");
    // }
    //////////////////////////
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
    }
    print(position!.latitude);
    print(position!.longitude);
  }

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
                          height: 20,
                        ),
                        Text(
                          "مرحبا بك",
                          style: GoogleFonts.alexandria(
                              fontSize: 30, color: darkcolor),
                          // style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 40,
                          // fontFamily: font2
                          //     ),
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  autofocus: true,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "الرقم القومي",
                                  ),
                                  textAlign: TextAlign.start,
                                  onChanged: (value) {
                                    setState(() {
                                      nationalid = value;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 17,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "الباسورد",
                                  ),
                                  textAlign: TextAlign.start,
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: buttonColor,
                          ),
                          width: 190,
                          child: MaterialButton(
                            height: 30,
                            child: loadButton == true
                                ? CircularProgressIndicator()
                                : const Text(
                                    "تسجيل الدخول",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                            onPressed: () async {
                              setState(() {
                                loadButton = true;
                              });
                              ///////////////////////////////////////////////////////////////////

                              List data = [];
                              print("////////////////////////////////////");
                              print(nationalid);
                              print(password);
                              print("////////////////////////////////////");

                              try {
                                var responce = await http
                                    .post(Uri.parse(Link.loginlink), body: {
                                  "nattional_id": nationalid,
                                  "password": password!,
                                });

                                // check is connect or no
                                if (responce.statusCode == 200 ||
                                    responce.statusCode == 201) {
                                  Map responsebody = jsonDecode(responce.body);

                                  print(responsebody);
                                  if (responsebody["status"] == "success") {
                                    // print(responsebody["data"]);
                                    data.addAll(responsebody["data"]);
                                    print(data[0]["nattional_id"]);
                                    print((responsebody["data"][0]["rank"])
                                        .toString());
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
                                    // prefs.setBool("repeat", true);
                                    print(prefs.getInt("idmail"));
                                    print(prefs.getInt("rank"));
                                    print(prefs.getBool("repeat"));
                                    if (responsebody["data"][0]["rank"] == 1) {
                                      print("scussess");

                                      print("pppppppppppppppppppppppppppppppp");
                                      int? id = prefs.getInt("idmail");
                                      print(id);
                                      print("pppppppppppppppppppppppppppppppp");
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TechHomePage(
                                                idmail: data[0]
                                                    ["nattional_id"]),
                                          ));
                                    } else if (responsebody["data"][0]
                                            ["rank"] ==
                                        0) {
                                      // prefs.setBool("repeat", true);
                                      prefs.setInt(
                                          "idmail", data[0]["nattional_id"]);
                                      print("rank = 0");
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                StudentHomePage(
                                                    idmail: data[0]
                                                        ["nattional_id"]),
                                          ));
                                    }
                                  } else if (responsebody["status"] ==
                                      "failure") {
                                    setState(() {
                                      loadButton = false;
                                    });
                                    print("failure");
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: const AlertDialog(
                                              title: Text("خطاء"),
                                              content: Text(
                                                  "الرقم القومي او الرقم السري خاطيء"),
                                            ),
                                          );
                                        });
                                  }
                                }
                              } catch (e) {
                                print(e);
                              }

                              /////////////////////////////////////////////////////////////////////
                              // try {
                              //   await FirebaseAuth.instance
                              //       .signInWithEmailAndPassword(
                              //           email: nationalid!, password: password!)
                              //       .then((value) async {
                              //     String uid =
                              //         FirebaseAuth.instance.currentUser!.uid;
                              //     prefs.setString("idmail", uid);
                              //     prefs.setBool("repeat", true);
                              //     print(prefs.getString("idmail"));
                              //     print(uid);

                              //     List checkData = [];
                              //     await FirebaseFirestore.instance
                              //         .collection("allusers")
                              //         .where("idemail", isEqualTo: uid)
                              //         .get()
                              //         .then((value) async {
                              //       checkData.addAll(value.docs);
                              //       print(
                              //           "=============================================");
                              //       print(checkData[0]["rank"]);
                              //       print(
                              //           "=============================================");
                              //       prefshared =
                              //           await SharedPreferences.getInstance();
                              //       prefshared.setString(
                              //         "rank",
                              //         checkData[0]["rank"],
                              //       );
                              //     });
                              //     if (checkData[0]["rank"] == "1") {
                              //       // ignore: use_build_context_synchronously
                              //       Navigator.pushReplacement(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) =>
                              //                 TechHomePage(idmail: uid),
                              //           ));
                              //     } else if (checkData[0]["rank"] == "0") {
                              //       // ignore: use_build_context_synchronously
                              //       Navigator.pushReplacement(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) =>
                              //                 StudentHomePage(idmail: uid),
                              //           ));
                              //     }
                              //   });
                              // } on FirebaseAuthException catch (e) {
                              //   if (e.code == 'user-not-found') {
                              //     print('No user found for that email.');
                              //     print('-=============================-=-=');
                              //   } else if (e.code == 'wrong-password') {
                              //     print('Wrong password provided for that user.');
                              //     print('-=============================-=-=');
                              //   }
                              // }
                              //////////////////////////////////////////////////////////////
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegesterPage(),
                            ));
                      },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 248, 86, 74),
                        ),
                        child: const Center(
                          child: Text(
                            "ليس لدي حساب",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
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
