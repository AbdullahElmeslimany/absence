
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Color buttonColor = const Color.fromRGBO(255, 152, 0, 1);
Color basecolor = const Color.fromRGBO(81, 78, 243, 1);
Color darkcolor = Color.fromARGB(255, 59, 105, 148);
Color talabatcolor = const Color.fromRGBO(254, 128, 132, 1);

String rank = "0";
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

  QuerySnapshot get = await pref.get();
  

  print(pref.snapshots());

  print("===================================");
;
}

late QuerySnapshot prfcon;
List<QueryDocumentSnapshot> datacon = [];
condtionGet() async {
  prfcon = await FirebaseFirestore.instance
      .collection("section")
      .where("id", isEqualTo: "2")
      .get();

  datacon.addAll(prfcon.docs);
  print(datacon);
}

Stream<QuerySnapshot> users = FirebaseFirestore.instance
    .collection("users")
    .orderBy("time", descending: false)
    .snapshots();




// String section = "6";
// String namesubject = "200";

// Stream<QuerySnapshot> sectionsteaheractive = FirebaseFirestore.instance
//     .collection("section")
//     .where('numbersection', arrayContains: section)
//     .where("numbersubject", isEqualTo: namesubject)
//     .snapshots();


// كود العشوائي

  // final refrandom =
  // FirebaseFirestore.instance.collection('random').doc("$idDosc");

