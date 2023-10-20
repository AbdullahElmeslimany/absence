import 'package:flutter/material.dart';

List datasubject = [];

class TableSubject extends StatefulWidget {
  const TableSubject({super.key});

  @override
  State<TableSubject> createState() => _TableSubjectState();
}

class _TableSubjectState extends State<TableSubject> {
  bool? isChecked1 = false,
      isChecked2 = false,
      isChecked3 = false,
      isChecked4 = false,
      isChecked5 = false,
      isChecked6 = false,
      isChecked7 = false,
      isChecked8 = false,
      isChecked9 = false,
      isChecked10 = false;
  String? time1 = "الفترة الاولي",
      time2 = "الفترة الثانية",
      time3 = "الفترة الثالثة",
      time4 = "الفترة الرابعة",
      time5 = "الفترة الخامسة",
      time6 = "الفترةالسادسة",
      time7 = "الفترة السابعة",
      time8 = "الفترة الثامنة",
      time9 = "الفترة التاسعة",
      time10 = "الفترة العاشرة";

  @override
  Widget build(BuildContext context) {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(),
        children: [
          const TableRow(children: [
            Center(
              child: Text(
                "الفترة\n الاولي",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "الفترة\n الثانية",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "الفترة \nالثالثة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "الفترة \nالرابعة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "الفترة\n الخامسة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ]),
          TableRow(children: [
            Checkbox(
              value: isChecked1,
              onChanged: (value) {
                setState(() {
                  isChecked1 = value!;
                  if (value == true) {
                    datasubject.add(time1);
                    print(datasubject);
                  } else {
                    datasubject.remove(time1);
                    print(datasubject);
                  }
                });
                if (isChecked1 == true) {
                  print(time1);
                }
              },
            ),
            Checkbox(
              value: isChecked2,
              onChanged: (value) {
                setState(() {
                  isChecked2 = value!;
                  if (value == true) {
                    datasubject.add(time2);
                    print(datasubject);
                  } else {
                    datasubject.remove(time2);
                    print(datasubject);
                  }
                });
                if (isChecked2 == true) {
                  print(time2);
                }
              },
            ),
            Checkbox(
              value: isChecked3,
              onChanged: (value) {
                setState(() {
                  isChecked3 = value!;
                  if (value == true) {
                    datasubject.add(time3);
                    print(datasubject);
                  } else {
                    datasubject.remove(time3);
                    print(datasubject);
                  }
                });
                if (isChecked3 == true) {
                  print(time3);
                }
              },
            ),
            Checkbox(
              value: isChecked4,
              onChanged: (value) {
                setState(() {
                  isChecked4 = value!;
                  if (value == true) {
                    datasubject.add(time4);
                    print(datasubject);
                  } else {
                    datasubject.remove(time4);
                    print(datasubject);
                  }
                });
                if (isChecked4 == true) {
                  print(time4);
                }
              },
            ),
            Checkbox(
              value: isChecked5,
              onChanged: (value) {
                setState(() {
                  isChecked5 = value!;
                  if (value == true) {
                    datasubject.add(time5);
                    print(datasubject);
                  } else {
                    datasubject.remove(time5);
                    print(datasubject);
                  }
                });
                if (isChecked5 == true) {
                  print(time5);
                }
              },
            ),
          ]),
          const TableRow(children: [
            Center(
              child: Text(
                "الفترة\nالسادسة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "الفترة \nالسابعة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "الفترة \nالثامنة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "الفترة\n التاسعة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                "الفترة\n العاشرة",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          TableRow(children: [
            Checkbox(
              value: isChecked6,
              onChanged: (value) {
                setState(() {
                  isChecked6 = value!;
                  if (value == true) {
                    datasubject.add(time6);
                    print(datasubject);
                  } else {
                    datasubject.remove(time6);
                    print(datasubject);
                  }
                });
                if (isChecked6 == true) {
                  print(time6);
                }
              },
            ),
            Checkbox(
              value: isChecked7,
              onChanged: (value) {
                setState(() {
                  isChecked7 = value!;
                  if (value == true) {
                    datasubject.add(time7);
                    print(datasubject);
                  } else {
                    datasubject.remove(time7);
                    print(datasubject);
                  }
                });
                if (isChecked7 == true) {
                  print(time7);
                }
              },
            ),
            Checkbox(
              value: isChecked8,
              onChanged: (value) {
                setState(() {
                  isChecked8 = value!;
                  if (value == true) {
                    datasubject.add(time8);
                    print(datasubject);
                  } else {
                    datasubject.remove(time8);
                    print(datasubject);
                  }
                });
                if (isChecked8 == true) {
                  print(time8);
                }
              },
            ),
            Checkbox(
              value: isChecked9,
              onChanged: (value) {
                setState(() {
                  isChecked9 = value!;
                  if (value == true) {
                    datasubject.add(time9);
                    print(datasubject);
                  } else {
                    datasubject.remove(time9);
                    print(datasubject);
                  }
                });
                if (isChecked9 == true) {
                  print(time9);
                }
              },
            ),
            Checkbox(
              value: isChecked10,
              onChanged: (value) {
                setState(() {
                  isChecked10 = value!;
                  if (value == true) {
                    datasubject.add(time10);
                    print(datasubject);
                  } else {
                    datasubject.remove(time10);
                    print(datasubject);
                  }
                });
                if (isChecked10 == true) {
                  print(time10);
                }
              },
            ),
          ])
        ]);
  }
}
