import 'package:absence/LoginPage/regester.dart';
import 'package:absence/constant/Shared.dart';
import 'package:absence/constant/constant.dart';
import 'package:absence/screens/homepage/assestant%20teach/teachhomepage.dart';
import 'package:absence/screens/homepage/student/studenthomepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  late SharedPreferences prefs;
  savedSharedData() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    savedSharedData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset("assets/images/student2.jpg")),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "مرحبا بك",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          fontFamily: font2),
                    ),
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "الاميل",
                      ),
                      textAlign: TextAlign.end,
                      onChanged: (value) {
                        setState(() {
                          email = value;
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
                      textAlign: TextAlign.end,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
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
                        child: const Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email!, password: password!)
                                .then((value) async {
                              String uid =
                                  FirebaseAuth.instance.currentUser!.uid;
                              prefs.setString("idmail", uid);
                              prefs.setBool("repeat", true);
                              print(prefs.getString("idmail"));
                              print(uid);

                              List checkData = [];
                              await FirebaseFirestore.instance
                                  .collection("allusers")
                                  .where("idemail", isEqualTo: uid)
                                  .get()
                                  .then((value) async {
                                checkData.addAll(value.docs);
                                print(
                                    "=============================================");
                                print(checkData[0]["rank"]);
                                print(
                                    "=============================================");
                                prefshared =
                                    await SharedPreferences.getInstance();
                                prefshared.setString(
                                  "rank",
                                  checkData[0]["rank"],
                                );
                              });
                              if (checkData[0]["rank"] == "1") {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TechHomePage(idmail: uid),
                                    ));
                              } else if (checkData[0]["rank"] == "0") {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StudentHomePage(idmail: uid),
                                    ));
                              }
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                              print('-=============================-=-=');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                              print('-=============================-=-=');
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
    );
  }
}
