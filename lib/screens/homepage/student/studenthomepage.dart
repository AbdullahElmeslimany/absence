import 'package:absence/constant/constant.dart';
import 'package:absence/constant/subject.dart';
import 'package:absence/screens/homepage/student/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  List datasubject = [];
  getsubject() async {
    QuerySnapshot quiry =
        await FirebaseFirestore.instance.collection("subject").get();
    setState(() {
      datasubject.addAll(quiry.docs);
    });
  }

  List datasection = [];
  getdatachectactivesction() async {
    setState(() {});
    print("datasection====================================");

    print("datasection====================================");
  }

  @override
  void initState() {
    print(subjectClasses["firstterm"]["Informationsystems"]["second"]);
    // getdatachectactivesction();
    getsubject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
          child: ListView(
        children: const [
          DrawerHeader(
              child: Icon(
            Icons.person,
            size: 80,
          )),
          ListTile(
            leading: Icon(Icons.co_present_outlined, size: 26),
            title: Text(
              'بيانات الطالب',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Center(child: Text("الطالب"))),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: StreamBuilder(
          stream: sectionsteaheractive,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return ListView.builder(
              itemCount: subjectClasses["firstterm"]["Informationsystems"]
                      ["second"]
                  .length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print(subjectClasses["firstterm"]["Informationsystems"]
                        ["second"][index]["subject"]);
                    print(subjectClasses["firstterm"]["Informationsystems"]
                        ["second"][index]["code"]);
                    setState(() {
                      namesubject = subjectClasses["firstterm"]
                          ["Informationsystems"]["second"][index]["code"];
                    });
                    if (snapshot.data!.docs[0]["active"] == true &&
                        snapshot.data!.docs[0]["numbersubject"] ==
                            subjectClasses["firstterm"]["Informationsystems"]
                                ["second"][index]["code"]) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentAttendance(
                                subjectname: subjectClasses["firstterm"]
                                        ["Informationsystems"]["second"][index]
                                    ["subject"]),
                          ));
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 20),
                          alignment: Alignment.centerRight,
                          height: 70,
                          width: MediaQuery.sizeOf(context).width - 20,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            subjectClasses["firstterm"]["Informationsystems"]
                                ["second"][index]["subject"],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
