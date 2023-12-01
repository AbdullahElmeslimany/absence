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
  String? namesubject;
  List<String> numbersction = [];
  String? result;
  List<String> groupchoose = [
    "الفرقة الاولي",
    "الفرقة الثانية",
    "الفرقة الثالثة",
    "الفرقة الرابعة"
  ];

  TextEditingController subjectnamecontroller = TextEditingController();
  TextEditingController groupcontroller = TextEditingController();
  GlobalKey<FormState> addsectionkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
              datasubject = [];
              dataday = [];
            },
          ),
          backgroundColor: Colors.blueGrey,
          title: const Center(child: Text("اضافة سكشن"))),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 172, 189, 247), Colors.white])),
        child: Form(
          key: addsectionkey,
          child: SingleChildScrollView(
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
                      controller: groupcontroller,
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
                          groupcontroller.text = value!;
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجي ادخال اسم المادة';
                      }
                      return null;
                    },
                    controller: subjectnamecontroller,
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "اسم المادة",
                    ),
                    textAlign: TextAlign.end,
                    onChanged: (value) {
                      setState(() {
                        subjectnamecontroller.text = value;
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجي ادخال رقم السكشن';
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجي ادخال باسورد';
                            }
                            return null;
                          },
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
                        if (addsectionkey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: const Text('اضافة سكشن'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text('هل تريد اضافة سكشن : '),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Text(
                                                '''
                                              اسم المحاضر : ${nameteacher != null ? nameteacher : widget.fullnameTeach}
                                              اسم المادة : ${subjectnamecontroller.text}
                                              رقم السكشن :  ${numbersction[0]} - ${numbersction[1]}
                                              الفرقة :  ${groupcontroller.text}
                                              الفترة :  ${datasubject[0]} - ${datasubject[1]}
                                              اليوم :  ${dataday[0]} 
                                              ''',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MaterialButton(
                                            child: Container(
                                                height: 40,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: const Center(
                                                    child: Text(
                                                  'الغاء',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ))),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          MaterialButton(
                                            child: Container(
                                                height: 40,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: const Center(
                                                    child: Text(
                                                  'اضافة',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ))),
                                            onPressed: () {
                                              final addRandom =
                                                  FirebaseFirestore.instance
                                                      .collection('random')
                                                      .add({
                                                "idteacher": widget.idTeach,
                                                "group": groupcontroller.text,
                                                "nameteather":
                                                    nameteacher != null
                                                        ? nameteacher
                                                        : widget.fullnameTeach,
                                                "nameSubject":
                                                    subjectnamecontroller.text,
                                                "numbersection": numbersction,
                                                "randomSubject": null
                                              }).then((value) async {
                                                // return print(value.id);
                                                return await pref.add({
                                                  "id": widget.idTeach,
                                                  "nameteacher": nameteacher !=
                                                          null
                                                      ? nameteacher
                                                      : widget.fullnameTeach,
                                                  "namesubject":
                                                      subjectnamecontroller
                                                          .text,
                                                  "group": groupcontroller.text,
                                                  "numbersection": numbersction,
                                                  "dataday": dataday,
                                                  "datasubject": datasubject,
                                                  "active": false,
                                                  "idRandom": value.id
                                                }).then((value) {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                  datasubject = [];
                                                  dataday = [];
                                                });
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ]);
                              });
                        }
                      }),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
