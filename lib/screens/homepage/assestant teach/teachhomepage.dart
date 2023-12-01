import 'dart:math';

import 'package:absence/screens/homepage/assestant%20teach/Attendance%20Record%20Page/AttendanceRecordPage.dart';

import 'package:absence/screens/homepage/assestant%20teach/appBar/drawerPage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TechHomePage extends StatefulWidget {
  final idmail;
  const TechHomePage({super.key, required this.idmail});

  @override
  State<TechHomePage> createState() => _TechHomePageState();
}

class _TechHomePageState extends State<TechHomePage> {
  List dataTeach = [];
  bool loading = true;

  getDataTeach() async {
    QuerySnapshot prefdata = await FirebaseFirestore.instance
        .collection("usersTeach")
        .where("idemail", isEqualTo: widget.idmail)
        .get();
    setState(() {
      dataTeach.addAll(prefdata.docs);
      loading = false;
      print("========");
    });
  }

  @override
  void initState() {
    getDataTeach();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> sectionsteaher = FirebaseFirestore.instance
        .collection("section")
        .where('id', isEqualTo: "${widget.idmail}")
        .snapshots();
    return loading == true
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            endDrawer: DrawerPage(
                data: dataTeach,
                idTeach: widget.idmail,
                fullnameTeach: dataTeach[0]["fullname"]),
            appBar: AppBar(
                backgroundColor: Colors.grey[200],
                title: Center(child: Text("مرحبا م.${dataTeach[0]["name"]}"))),
            body: Container(
              color: Colors.grey[300],
              child: StreamBuilder(
                stream: sectionsteaher,
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
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          // if (snapshot.data!.docs[index]["active"] == true) {
                          FirebaseFirestore.instance
                              .collection("section")
                              .doc(snapshot.data!.docs[index].id)
                              .update({"active": true});
                          final refrandom = FirebaseFirestore.instance
                              .collection('random')
                              .doc(snapshot.data!.docs[index]["idRandom"]);
                          await refrandom.update({
                            "randomSubject": Random().nextInt(100000) * 9965
                          });
                          DocumentSnapshot getrandom = await refrandom.get();
                          List data = [];
                          data.add(getrandom);

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AttendanceRecordPage(
                                    numberrandom: data[0]["randomSubject"],
                                    mapdata: snapshot.data!.docs[index],
                                    idteach: snapshot.data!.docs[index].id,
                                    namesubject: snapshot.data!.docs[index]
                                        ["namesubject"]),
                              ));
                          // }
                        },
                        child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: ListTile(
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        snapshot.data!.docs[index]
                                            ["nameteacher"],
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]
                                                  ["numbersection"][0] +
                                              " - " +
                                              snapshot.data!.docs[index]
                                                  ["numbersection"][1],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              title: Center(
                                child: Text(
                                  snapshot.data!.docs[index]["namesubject"],
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
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
