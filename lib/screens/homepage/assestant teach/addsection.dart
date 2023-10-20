import 'package:absence/constant/constant.dart';
import 'package:absence/screens/homepage/assestant%20teach/table/tableday.dart';
import 'package:absence/screens/homepage/assestant%20teach/table/tablesubject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

class AddSection extends StatefulWidget {
  const AddSection({super.key});

  @override
  State<AddSection> createState() => _AddSectionState();
}

class _AddSectionState extends State<AddSection> {
  @override
  void initState() {
    pref = FirebaseFirestore.instance.collection('section');
    getData();

    super.initState();
  }

  String? nameteacher;
  String? time;
  String? days;
  String? namesubject;
  String? numbersubject;
  String? numbersction;
  List<String>? data;
  String? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Center(child: Text("اضافة سكشن"))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: Column(
            children: [
              Text(
                "اسم المحاضر",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: font2),
              ),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "اسم المحاضر",
                ),
                textAlign: TextAlign.end,
                onChanged: (value) {
                  setState(() {
                    nameteacher = value;
                  });
                },
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                "كود المادة",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: font2),
              ),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "كود المادة",
                ),
                textAlign: TextAlign.end,
                onChanged: (value) {
                  setState(() {
                    numbersubject = value;
                  });
                },
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                "اسم المادة",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: font2),
              ),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "اسم المادة",
                ),
                textAlign: TextAlign.end,
                onChanged: (value) {
                  setState(() {
                    namesubject = value;
                  });
                },
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                "رقم السكشن",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: font2),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "رقم السكشن",
                ),
                textAlign: TextAlign.end,
                onChanged: (value) {
                  setState(() {
                    numbersction = value;
                  });
                },
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                "الفترة",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: font2),
              ),
              TableSubject(),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "اليوم",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TableDay(),
              const SizedBox(
                height: 15,
              ),
              MaterialButton(
                child: Container(
                    height: 40,
                    width: MediaQuery.sizeOf(context).width - 20,
                    decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    child: const Center(
                        child: Text(
                      "اضافة مادة",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ))),
                onPressed: () async {
                  // setState(() {
                  //   result =
                  //       '{"id":$idtech, \n"nameteacher":$nameteacher, \n "namesubject":$namesubject, \n "numbersubject":$numbersubject, \n "dataday":$dataday, \n "datasubject":$datasubject \n }';
                  //   convertmap = jsonDecode(result!);
                  // });
                  // print(result);
                  // if (result != null) {
                  // await pref.add({"section": convertmap});

                  final addRandom =
                      FirebaseFirestore.instance.collection('random').add({
                    "idteacher": null,
                    "nameteather": nameteacher,
                    "nameSubject": namesubject,
                    "randomSubject": null
                  }).then((value) async {
                    // return print(value.id);
                    return await pref.add({
                      "id": idtech,
                      "nameteacher": nameteacher,
                      "namesubject": namesubject,
                      "numbersubject": numbersubject,
                      "numbersection": numbersction,
                      "dataday": dataday,
                      "datasubject": datasubject,
                      "active": false,
                      "idRandom": value.id
                    });
                  });
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}
