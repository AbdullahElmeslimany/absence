import 'package:flutter/material.dart';

List dataday = [];

class TableDay extends StatefulWidget {
  const TableDay({super.key});

  @override
  State<TableDay> createState() => _TableDayState();
}

class _TableDayState extends State<TableDay> {
  bool? isChecked1 = false,
      isChecked2 = false,
      isChecked3 = false,
      isChecked4 = false,
      isChecked5 = false,
      isChecked6 = false;

  String day1 = "السبت",
      day2 = "الاحد",
      day3 = "الاثنين",
      day4 = "الثلاثاء",
      day5 = "الاربعاء",
      day6 = "الخميس";

  @override
  Widget build(BuildContext context) {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(),
        children: [
          TableRow(children: [
            Center(
              child: Text(
                day1,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                day2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                day3,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          TableRow(children: [
            Checkbox(
              value: isChecked1,
              onChanged: (value) {
                setState(() {
                  isChecked1 = value!;
                  if (value == true) {
                    dataday.add(day1);
                    print(dataday);
                  } else {
                    dataday.remove(day1);
                    print(dataday);
                  }
                });
                if (isChecked1 == true) {
                  print(day1);
                }
              },
            ),
            Checkbox(
              value: isChecked2,
              onChanged: (value) {
                setState(() {
                  isChecked2 = value!;
                  if (value == true) {
                    dataday.add(day2);
                    print(dataday);
                  } else {
                    dataday.remove(day2);

                    print(dataday);
                  }
                });
                if (isChecked2 == true) {
                  print(day2);
                }
              },
            ),
            Checkbox(
              value: isChecked3,
              onChanged: (value) {
                setState(() {
                  isChecked3 = value!;
                  if (value == true) {
                    dataday.add(day3);
                    print(dataday);
                  } else {
                    dataday.remove(day3);
                    print(dataday);
                  }
                });
                if (isChecked3 == true) {
                  print(day3);
                }
              },
            ),
          ]),
          TableRow(children: [
            Center(
              child: Text(
                day4,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                day5,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                day6,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]),
          TableRow(children: [
            Checkbox(
              value: isChecked4,
              onChanged: (value) {
                setState(() {
                  isChecked4 = value!;
                  if (value == true) {
                    dataday.add(day4);
                    print(dataday);
                  } else {
                    dataday.remove(day4);
                    print(dataday);
                  }
                });
                if (isChecked4 == true) {
                  print(day4);
                }
              },
            ),
            Checkbox(
              value: isChecked5,
              onChanged: (value) {
                setState(() {
                  isChecked5 = value!;
                  if (value == true) {
                    dataday.add(day5);
                    print(dataday);
                  } else {
                    dataday.remove(day5);
                    print(dataday);
                  }
                });
                if (isChecked5 == true) {
                  print(day5);
                }
              },
            ),
            Checkbox(
              value: isChecked6,
              onChanged: (value) {
                setState(() {
                  isChecked6 = value!;
                  if (value == true) {
                    dataday.add(day6);
                    print(dataday);
                  } else {
                    dataday.remove(day6);
                    print(dataday);
                  }
                });
                if (isChecked6 == true) {
                  print(day6);
                }
              },
            ),
          ])
        ]);
  }
}
