
import 'dart:math';
import 'package:absence/screens/homepage/assestant%20teach/Attendance%20Record%20Page/AttendanceRecordPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> buttonClickLogic(AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      int index, BuildContext context,
      {required id}) async {
    FirebaseFirestore.instance
        .collection("random")
        .doc(id)
        .update({"active": true});
    final refrandom = FirebaseFirestore.instance.collection('random').doc(id);
    await refrandom
        .update({"randomSubject": Random().nextInt(100000) * 9965999});
    DocumentSnapshot getrandom = await refrandom.get();
    List datasubject = [];
    datasubject.add(getrandom);
    Get.to(AttendanceRecordPage(
        numberrandom: datasubject[0]["randomSubject"],
        mapdata: datasubject,
        idrandom: snapshot.data!.docs[index].id,
        namesubject: snapshot.data!.docs[index]["nameSubject"]),transition: Transition.fade);
  }
