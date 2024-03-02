import 'dart:async';
import 'dart:convert';
import 'package:absence/constant/link.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/appBar/drawerPage.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/constant/const.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/cubit_radio/radio_custon_cubit_cubit.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/logic/clickbutton.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/logic/connectsection.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/logic/cubit/seclect_day_cubit.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/views/card_section.dart';
import 'package:absence/screens/homepage/assestant%20teach/home%20page%20teacher/views/card_teacher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
  String? type;
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

  void changeOption(RadioButtonOption? newValue, BuildContext context) {
    if (newValue != null) {
      context.read<RadioCustonCubit>().changeOption(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Object?>> sectionsteaher =
        streamSection(widget.idmail);
    return Scaffold(
      appBar: AppBar(),
      endDrawer: loading == true
          ? null
          : DrawerPage(
              /////////////////////////////////////////////
              ///
              ///edittttttt
              ///
              idTeach: dataTeach[0]["national_id"],
              fullnameTeach: dataTeach[0]["fullname"],
              data: dataTeach),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
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
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                      // height: 500,
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
                                    Get.dialog(
                                        dailogScreen(snapshot, index, context));
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
                  ),
                ],
              ),
            )),
    );
  }

  Dialog dailogScreen(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext contexts) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 295,
          child: BlocBuilder<SeclectDayCubit, SeclectDayState>(
            builder: (context, state) {
              return Column(
                children: [
                  const Text(
                    "اختار يوم السكشن",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 215,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemCount: 9,
                      itemBuilder: (BuildContext contexts, int index) {
                        return RadioMenuButton(
                          value: "$index",
                          groupValue: type,
                          onChanged: (value) {
                            BlocProvider.of<SeclectDayCubit>(context)
                                .changeDay(day: value);

                            type = BlocProvider.of<SeclectDayCubit>(context)
                                .selectday;
                          },
                          child: Text('${index + 1}'),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: 95,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: MaterialButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              "الغاء",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ))),
                      Container(
                          width: 95,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal[400],
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: MaterialButton(
                            onPressed: () async {
                              await buttonClickLogic(
                                  day: type,
                                  id: snapshot.data!.docs[index].id,
                                  snapshot,
                                  index,
                                  context);
                            },
                            child: const Text(
                              "بدا الغياب",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ))),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
