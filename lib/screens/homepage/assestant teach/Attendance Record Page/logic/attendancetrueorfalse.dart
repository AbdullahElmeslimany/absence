
  import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> attandanceTrueOrFalse({required condtion, required id}) async {
    if (condtion == true) {
      await FirebaseFirestore.instance
          .collection("usersStudent")
          .doc(id)
          .update({"active": false});
    } else {
      await FirebaseFirestore.instance
          .collection("usersStudent")
          .doc(id)
          .update({"active": true});
    }
  }