import 'package:flutter/material.dart';

Card cardSection(
      {required teachername,
      required section1,
      required section2,
      required subjectname}) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: ListTile(
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(teachername,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text(
                      section1 + " - " + section2,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          title: Center(
            child: Text(
              subjectname,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
