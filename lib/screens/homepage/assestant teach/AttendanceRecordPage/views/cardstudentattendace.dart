import 'package:absence/screens/homepage/assestant%20teach/AttendanceRecordPage/logic/attendancetrueorfalse.dart';
import 'package:flutter/material.dart';

Card cardStudentAttendanse(
      {required condtion, required id, required fullName}) {
    return Card(
      child: ListTile(
          leading: MaterialButton(
            onPressed: () async {
              await attandanceTrueOrFalse(condtion: condtion, id: id);
            },
            child: condtion == true
                ? const Text(
                    "حضر",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent),
                  )
                : const Text(
                    "غائب",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(fullName),
            ],
          )),
    );
  }
