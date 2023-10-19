import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Color buttonColor = const Color.fromRGBO(255, 152, 0, 1);
String font1 = "Amiri";
String font2 = "Molhim";
Map test = {"name": "ali"};
String? idtech;
late CollectionReference pref;
late Stream<QuerySnapshot> stremdata;
Map? convertmap;
List dataget = [];
getData() async {
  pref = FirebaseFirestore.instance.collection('section');
  // stremdata = pref.snapshots();
  QuerySnapshot get = await pref.get();
  dataget.addAll(get.docs);
  print("===================================");
  print(dataget[0]["section"]);
  print("===================================");
  print(pref.snapshots());
  // dataget.addAll(stremdata);
  // convertmap = jsonDecode(dataget[0]["section"]);
  print("===================================");
  // print(convertmap!["nameteacher"]);
}

Stream<QuerySnapshot> users = FirebaseFirestore.instance
    .collection("users")
    .orderBy("time", descending: false)
    .snapshots();

Stream<QuerySnapshot> sectionsteaher =
    FirebaseFirestore.instance.collection("section").snapshots();
