import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Color buttonColor = const Color.fromRGBO(255, 152, 0, 1);
String font1 = "Amiri";
String font2 = "Molhim";
Map test = {"name": "ali"};
late CollectionReference pref;
List dataget = [];
getData() async {
  pref = FirebaseFirestore.instance.collection('section');
  QuerySnapshot get = await pref.get();
  dataget.addAll(get.docs);
  print("===================================");
  print(dataget[0]["section"]);
  print("===================================");
  Map convertmap = jsonDecode(dataget[0]["section"]);
  print("===================================");
  print(convertmap["nameteacher"]);
}
