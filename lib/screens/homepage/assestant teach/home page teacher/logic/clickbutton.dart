import 'dart:math';
import 'package:absence/screens/homepage/assestant%20teach/AttendanceRecordPage/attendancerecordpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> buttonClickLogic(AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
    int index, BuildContext context,
    {required id, required day}) async {
  FirebaseFirestore.instance
      .collection("random")
      .doc(id)
      .update({"active": true});
  final refrandom = FirebaseFirestore.instance.collection('random').doc(id);
  // await refrandom.update({"randomSubject": Random().nextInt(100000) * 9965999});
  await refrandom.update({"daytablename": "s_${int.parse(day) + 1}"});
  DocumentSnapshot getrandom = await refrandom.get();
  List datasubject = [];
  datasubject.add(getrandom);
  Get.to(
      AttendanceRecordPage(
          numberrandom: datasubject[0]["randomSubject"],
          mapdata: datasubject,
          idrandom: snapshot.data!.docs[index].id,
          namesubject: snapshot.data!.docs[index]["nameSubject"]),
      transition: Transition.fade);
}
