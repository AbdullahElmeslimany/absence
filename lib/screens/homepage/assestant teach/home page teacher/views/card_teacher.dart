import 'package:absence/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Container cardinfo(BuildContext context, {required fullname}) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 30,
      height: 150,
      decoration: BoxDecoration(
          color: darkcolor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "!مرحبا بك",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("م/ $fullname",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const Gap(15),
          const Text("نسعد اليوم بوجودك معنا نتمني ان تكون في افضل حال",
              style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
