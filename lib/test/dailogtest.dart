import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogTest extends StatefulWidget {
  const DialogTest({super.key});

  @override
  State<DialogTest> createState() => _DialogTestState();
}

class _DialogTestState extends State<DialogTest> {
  @override
  Widget build(BuildContext context) {
    String? type;
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Get.dialog(Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 295,
                  child: Column(
                    children: [
                      const Text(
                        "اختار يوم السكشن",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 215,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemCount: 9,
                          itemBuilder: (BuildContext context, int index) {
                            return
                             RadioMenuButton(
                              
                              value: "$index",
                              groupValue: type,
                              onChanged: (value) {
                                setState(() {
                                  type = value!;
                                  print(value);
                                });
                              },
                              child: Text('${index + 1}'),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width: 95,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                  child: MaterialButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  "الغاء",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ))),
                          Container(
                              width: 95,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.teal[400],
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                  child: MaterialButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  "بدا الغياب",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
          },
          child: Text("show"),
        ),
      ),
    );
  }
}
