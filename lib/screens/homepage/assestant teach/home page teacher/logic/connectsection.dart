


 import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot<Object?>> streamSection(id) {
     Stream<QuerySnapshot> sectionsteaher = FirebaseFirestore.instance
        .collection("random")
        .where('idteacher', isEqualTo: "$id")
        .snapshots();
    return sectionsteaher;
  }