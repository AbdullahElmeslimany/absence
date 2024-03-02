import 'package:flutter/material.dart';

dayOption({required active, required day}) {
  Color colorsactive = Colors.green;
  Color colorsunactive = Colors.red;
  Color colorsnull = Colors.grey;
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: 32,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: active == 1
              ? colorsactive
              : active == 0
                  ? colorsunactive
                  : colorsnull),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    child: Icon(
                      active == 1
                          ? Icons.check_circle_outlined
                          : active == 0
                              ? Icons.do_disturb_outlined
                              : Icons.info_outlined,
                      size: 27,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  "$day",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
