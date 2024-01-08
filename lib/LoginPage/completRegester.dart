import 'package:absence/constant/Shared.dart';
import 'package:absence/constant/constant.dart';
import 'package:absence/screens/homepage/student/studenthomepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletReqester extends StatefulWidget {
  final nationalID;
  final fullname;
  final uid;
  const CompletReqester(
      {super.key,
      required this.nationalID,
      required this.fullname,
      required this.uid});

  @override
  State<CompletReqester> createState() => _CompletReqesterState();
}

class _CompletReqesterState extends State<CompletReqester> {
  late String firstname;
  late String rank = "0";
  late String numbersection;
  late String group;
  late String specialty;

  List<String> groupchoose = [
    "الفرقة الاولي",
    "الفرقة الثانية",
    "الفرقة الثالثة",
    "الفرقة الرابعة"
  ];
  List<String> specialtyChoose = [
    "علوم حاسب",
    "نظم معلومات ادارية",
    "محاسبة",
    "ادارة"
  ];

  saveshared() async {
    prefshared = await SharedPreferences.getInstance();
    prefshared.setString(
      "firstname",
      firstname,
    );
    prefshared.setString(
      "rank",
      rank,
    );
    prefshared.setString(
      "idmail",
      widget.uid,
    );
    prefshared.setString(
      "group",
      group,
    );
    prefshared.setString(
      "section",
      numbersection,
    );
    prefshared.setString(
      "specialty",
      specialty,
    );
    prefshared.setBool(
      "repeat",
      true,
    );
    print("save shared=======================================");
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
                      "اكمل البيانات الاتية",
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
                        labelText: "الاسم الاول",
                      ),
                      textAlign: TextAlign.end,
                      onChanged: (value) {
                        setState(() {
                          firstname = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    TextFormField(
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "رقم السكشن",
                      ),
                      textAlign: TextAlign.end,
                      onChanged: (value) {
                        setState(() {
                          numbersection = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    DropdownMenu(
                        label: Text(
                          "اختر التخصص",
                          style: TextStyle(
                              fontFamily: font2,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        width: MediaQuery.sizeOf(context).width / 1.5,
                        initialSelection: specialtyChoose.first,
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            specialty = value!;
                          });
                        },
                        dropdownMenuEntries: specialtyChoose
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList()),
                    const SizedBox(
                      height: 17,
                    ),
                    DropdownMenu(
                        label: Text(
                          "اختر الفرقة",
                          style: TextStyle(
                              fontFamily: font2,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        width: MediaQuery.sizeOf(context).width / 1.5,
                        initialSelection: groupchoose.first,
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            group = value!;
                          });
                        },
                        dropdownMenuEntries: groupchoose
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList()),
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
                          "اتمام التسجيل",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("usersStudent")
                              .add({
                            "idemail": widget.uid,
                            "nationalID": widget.nationalID,
                            "name": firstname,
                            "fullname": widget.fullname,
                            "numbersection": numbersection,
                            "group": group,
                            "specialty": specialty,
                            "active": false,
                            "rank": "0",
                          }).then((value) async {
                            await FirebaseFirestore.instance
                                .collection("allusers")
                                .add({
                              "idemail": widget.uid,
                              "rank": "0",
                            });
                            saveshared();
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentHomePage(
                                    idmail: widget.uid,
                                  ),
                                ));
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
