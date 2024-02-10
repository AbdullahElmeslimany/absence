  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

MaterialButton buttonEndRecordStudent(
    BuildContext context, {
    required idrandom,
  }) {
    return MaterialButton(
      onPressed: () {
        FirebaseFirestore.instance
            .collection("random")
            .doc(idrandom)
            .update({"active": false}).then((value) => Navigator.pop(context));
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width - 20,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20)),
        child: const Center(
            child: Text(
          "انهاء الحضور",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }