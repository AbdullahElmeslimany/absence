import 'package:absence/constant/constant.dart';
import 'package:absence/screens/homepage/assestant%20teach/table/tableday.dart';
import 'package:absence/screens/homepage/assestant%20teach/table/tablesubject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AddSection extends StatefulWidget {
  final idTeach;
  final fullnameTeach;
  const AddSection(
      {super.key, required this.idTeach, required this.fullnameTeach});

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
  // String? numbersubject;
  List<String> numbersction = [];
  List<String>? data;
  String? result;
  late String group;
  List<String> groupchoose = [
    "الفرقة الاولي",
    "الفرقة الثانية",
    "الفرقة الثالثة",
    "الفرقة الرابعة"
  ];

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
                    if (value != null) {
                      nameteacher = value;
                    } else {
                      nameteacher = widget.fullnameTeach;
                    }
                  });
                },
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                "اختر الفرقة",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: font2),
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
                  width: MediaQuery.sizeOf(context).width - 30,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2.2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "رقم السكشن",
                      ),
                      textAlign: TextAlign.end,
                      onChanged: (value) {
                        setState(() {
                          numbersction.add(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2.2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "رقم السكشن",
                      ),
                      textAlign: TextAlign.end,
                      onChanged: (value) {
                        setState(() {
                          numbersction?.add(value);
                        });
                      },
                    ),
                  ),
                ],
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
              const TableSubject(),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "اليوم",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const TableDay(),
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
              

                  final addRandom =
                      FirebaseFirestore.instance.collection('random').add({
                    "idteacher": widget.idTeach,
                    "group": group,
                    "nameteather": nameteacher != null
                        ? nameteacher
                        : widget.fullnameTeach,
                    "nameSubject": namesubject,
                    "numbersection": numbersction,
                    "randomSubject": null
                  }).then((value) async {
                    // return print(value.id);
                    return await pref.add({
                      "id": widget.idTeach,
                      "nameteacher": nameteacher != null
                          ? nameteacher
                          : widget.fullnameTeach,
                      "namesubject": namesubject,
                      "group": group,
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
