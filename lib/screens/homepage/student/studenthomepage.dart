import 'package:absence/LoginPage/login.dart';
import 'package:absence/constant/Shared.dart';
import 'package:absence/constant/connsectuserStudent.dart';
import 'package:absence/constant/constant.dart';
import 'package:absence/constant/subject.dart';
import 'package:absence/screens/homepage/student/camera.dart';
import 'package:absence/screens/homepage/student/personedata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHomePage extends StatefulWidget {
  final firstname;
  final idmail;
  final group;
  final section;
  final specialty;
  const StudentHomePage(
      {super.key,
      this.firstname,
      required this.idmail,
      this.group,
      this.section,
      this.specialty});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  bool latetime = true;
  List datasubject = [];
  getsubject() async {
    QuerySnapshot quiry =
        await FirebaseFirestore.instance.collection("subject").get();
  }

  List datasection = [];
  getdatachectactivesction() async {
    setState(() {});
    print("datasection====================================");

    print("datasection====================================");
  }

  String? idusershared;
  SharedPreferences? prefget;
  getshared() async {
    prefget = await SharedPreferences.getInstance();

    idusershared = prefget!.getString("idmail");

    print(prefget!.getString("idmail"));
  }

  List studentdata = [];
  late QuerySnapshot studentuser;
  getdata() async {
    studentuser = await FirebaseFirestore.instance
        .collection("usersStudent")
        .where("idemail", isEqualTo: widget.idmail)
        .get();
    setState(() {
      studentdata.addAll(studentuser.docs);
      print("==s=s==s=ss==ss=s=s==s=s");
      latetime = false;
    });
    print(studentdata[0]["name"]);
  }

  @override
  void initState() {
    getdata();
    getshared();
    print(idusershared);
    print(studentdata);
    // print(prefshared.getString("firstname"));
    // print(pref.getString("firstname"));
    print(subjectClasses["firstterm"]["Informationsystems"]["second"]);
    // getdatachectactivesction();
    getsubject();
    print("id ++-+-+-+-+----+-+-+");
    print(idusershared);
    print("id ++-+-+----+-+----+-+-+");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return latetime == true
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            endDrawer: Drawer(
                child: ListView(
              children: [
                DrawerHeader(
                    child: Icon(
                  Icons.person,
                  size: 80,
                )),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>PersonData(data: studentdata) ,));
                  },
                  child: ListTile(
                    leading: Icon(Icons.co_present_outlined, size: 26),
                    title: Text(
                      'بيانات الطالب',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app_rounded, size: 26),
                    title: Text(
                      'تسجيل الخروج',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                ),
              ],
            )),
            appBar: AppBar(
                backgroundColor: Colors.blueGrey,
                title: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Center(
                      child: Text("مرحبا بك  ${studentdata[0]["name"]}")),
                )),
            body: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: StreamBuilder(
                stream: sectionsteaheractive,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return ListView.builder(
                    itemCount: subjectClasses["firstterm"]["Informationsystems"]
                            ["second"]
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          print(subjectClasses["firstterm"]
                                  ["Informationsystems"]["second"][index]
                              ["subject"]);
                          print(subjectClasses["firstterm"]
                              ["Informationsystems"]["second"][index]["code"]);
                          setState(() {
                            namesubject = subjectClasses["firstterm"]
                                ["Informationsystems"]["second"][index]["code"];
                          });
                          if (snapshot.data!.docs[0]["active"] == true &&
                              snapshot.data!.docs[0]["numbersubject"] ==
                                  subjectClasses["firstterm"]
                                          ["Informationsystems"]["second"]
                                      [index]["code"]) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StudentAttendance(
                                      subjectname: subjectClasses["firstterm"]
                                              ["Informationsystems"]["second"]
                                          [index]["subject"]),
                                ));
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 20),
                                alignment: Alignment.centerRight,
                                height: 70,
                                width: MediaQuery.sizeOf(context).width - 20,
                                decoration: BoxDecoration(color: Colors.white),
                                child: Text(
                                  subjectClasses["firstterm"]
                                          ["Informationsystems"]["second"]
                                      [index]["subject"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(
                              height: 7,
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
  }
}
