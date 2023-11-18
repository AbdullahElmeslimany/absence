import 'package:absence/constant/subject.dart';
import 'package:absence/screens/homepage/student/StudentAttendanceCamira.dart';
import 'package:absence/screens/homepage/student/drawerStudent.dart';
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
  bool enable = true;
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
    // print(studentdata[0]["name"]);
  }

  late Stream<QuerySnapshot> sectionsteaheractive;
  getstream() {
    sectionsteaheractive = FirebaseFirestore.instance
        .collection("section")
        .where('numbersection', arrayContains: widget.section)
        .where("group", isEqualTo: widget.group)
        .snapshots();
    setState(() {
      enable = false;
    });
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
    getstream();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return latetime == true
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            endDrawer: DrawerStudent(studentdata: studentdata),
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
                  if (snapshot.hasError) {
                    return const Text("erorr");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            if (snapshot.data!.docs[index]["active"] == true) {
                              // print(snapshot.data!.docs[index]["idRandom"]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentAttendance(
                                          dataStudent: studentdata,
                                          subjectname: snapshot
                                              .data!.docs[index]["namesubject"],
                                          idRandom: snapshot.data!.docs[index]
                                              ["idRandom"])));
                            } else {
                              print("غير متاج");
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  height: 70,
                                  width: MediaQuery.sizeOf(context).width - 20,
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      snapshot.data!.docs[index]["active"] ==
                                              true
                                          ? const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.check_circle_outlined,
                                                  color: Color.fromARGB(
                                                      255, 2, 136, 53),
                                                  size: 30,
                                                  weight: 50,
                                                ),
                                                Text(
                                                  "متاح",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            )
                                          : const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .dnd_forwardslash_outlined,
                                                  color: Colors.grey,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "غير متاح",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            ["namesubject"],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 7,
                              )
                            ],
                          ));
                    },
                  );
                },
              ),
            ),
          );
  }
}
