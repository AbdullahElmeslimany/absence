import 'package:absence/constant/constant.dart';
import 'package:flutter/material.dart';

class PersonData extends StatefulWidget {
  final data;
  const PersonData({super.key, required this.data});

  @override
  State<PersonData> createState() => _PersonDataState();
}

class _PersonDataState extends State<PersonData> {
  String? name;
  String? specialty;
  String? numbersection;
  String? group;
  setPass() {
    setState(() {
      name = widget.data[0]["name"];
      specialty = widget.data[0]["specialty"];
      numbersection = widget.data[0]["specialty"];
      group = widget.data[0]["specialty"];
    });
  }

  @override
  void initState() {
    setPass();
    print(widget.data[0]["specialty"]);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                 
                  "بيانات الطالب",
                  style: TextStyle(
                    
                      fontFamily: font1,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "للتعديل قم بالضغط علي الحقل وسيتم عرض بيانات الحقل",
                  style: TextStyle(
                      fontFamily: font1,
                      color: Colors.grey[400],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    suffixText: ":  الاسم",
                    prefixText: widget.data[0]["name"],
                    prefixIcon: const Icon(Icons.person),
                    border: const OutlineInputBorder(),
                    labelText: "الاسم",
                  ),
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: widget.data[0]["specialty"],
                    suffixText: ":  التخصص",
                    prefixText: widget.data[0]["specialty"],
                    prefixIcon: const Icon(Icons.home_filled),
                  ),
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {
                      value;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "الفرقة",
                    suffixText: ":  الفرقة",
                    prefixIcon: const Icon(Icons.group),
                    prefixText: widget.data[0]["group"],
                  ),
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {
                      value;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "السكشن",
                    suffixText: ":  السكشن",
                    prefixIcon:
                        const Icon(Icons.settings_accessibility_outlined),
                    prefixText: widget.data[0]["numbersection"],
                  ),
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {
                      value;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Container(
                    width: MediaQuery.sizeOf(context).width-40,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color.fromARGB(255, 126, 202, 121),
                    ),
                    child: const Center(
                      child: Text(
                        "طلب تعديل",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
