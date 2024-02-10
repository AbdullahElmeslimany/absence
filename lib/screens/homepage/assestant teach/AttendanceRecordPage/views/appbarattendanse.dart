import 'package:flutter/material.dart';

AppBar appBarAttendance(BuildContext context, {required nameSubject}) {
  return AppBar(
      actions: const [
        Center(
            child: Text(
          " :  تسجيل حضور ",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        )),
      ],
      backgroundColor: Colors.blueGrey,
      title: Center(
          child: Text(
        " $nameSubject",
        style: TextStyle(
            fontSize: MediaQuery.sizeOf(context).width / 21.5,
            fontWeight: FontWeight.bold),
      )));
}
