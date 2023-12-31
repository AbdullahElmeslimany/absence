import 'dart:async';
import 'dart:convert';
import 'package:absence/constant/link.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/appBar/drawerPage.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/constant/const.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/logic/clickbutton.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/logic/connectsection.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/views/card_section.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/views/card_teacher.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TechHomePage extends StatefulWidget {
  final idmail;
  const TechHomePage({super.key, required this.idmail});
  @override
  State<TechHomePage> createState() => _TechHomePageState();
}

class _TechHomePageState extends State<TechHomePage> {
  bool loading = true;
  getdatafromApi({required table, required idmail}) async {
    try {
      var responce = await http.post(Uri.parse(Link.getdatalink),
          body: {"table": table, "nattional_id": (idmail).toString()});
      // check is connect or no
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Map responsebody = jsonDecode(responce.body);
        print(responsebody);
        if (responsebody["status"] == "success") {
          print(responsebody["data"]);
          passdatalist(responsebody["data"]);
        } else if (responsebody["status"] == "failure") {
          print("failure");
        }
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  passdatalist(data) {
    dataTeach.addAll(data);
  }

  @override
  void initState() {
    getdatafromApi(table: table, idmail: widget.idmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Object?>> sectionsteaher =
        streamSection(widget.idmail);
    return Scaffold(
      appBar: AppBar(),
      endDrawer: const DrawerPage(
          /////////////////////////////////////////////
          ///
          ///edittttttt
          ///
          idTeach: "idTeach",
          fullnameTeach: "fullnameTeach",
          data: "data"),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SafeArea(
                  child: Center(
                child: Column(
                  children: [
                    const Gap(10),
                    cardinfo(context, fullname: dataTeach[0]["fullname"]),
                    const Gap(20),
                    const Text(
                      "السكاشن المتاحة",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Gap(5),
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: StreamBuilder(
                        stream: sectionsteaher,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text("erorr");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return SmartRefresher(
                            controller: refrshui.refreshControllerteacherhome,
                            onRefresh: refrshui.onRefresh,
                            onLoading: refrshui.onLoading,
                            enablePullDown: true,
                            header: const WaterDropHeader(
                                waterDropColor: Colors.red),
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () async {
                                    await buttonClickLogic(
                                        id: snapshot.data!.docs[index].id,
                                        snapshot,
                                        index,
                                        context);
                                  },
                                  child: cardSection(
                                      teachername: snapshot.data!.docs[index]
                                          ["nameteather"],
                                      section1: snapshot.data!.docs[index]
                                          ["numbersection"][0],
                                      section2: snapshot.data!.docs[index]
                                          ["numbersection"][1],
                                      subjectname: snapshot.data!.docs[index]
                                          ["nameSubject"]),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )),
            ),
    );
  }
}
