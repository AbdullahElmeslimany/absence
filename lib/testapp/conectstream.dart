import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestStreamConnect extends StatelessWidget {
  const TestStreamConnect({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> users =
        FirebaseFirestore.instance.collection("users").snapshots();
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
        stream: users,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("erorr");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                    subtitle: Text(snapshot.data!.docs[index]["age"]),
                    title: Text(snapshot.data!.docs[index]["name"])),
              );
            },
          );
        },
      ),
    ));
  }
}
