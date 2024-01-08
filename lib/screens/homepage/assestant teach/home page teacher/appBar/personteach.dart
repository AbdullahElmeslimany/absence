import 'package:absence/constant/constant.dart';
import 'package:flutter/material.dart';

class PersionTeachData extends StatefulWidget {
  final data;
  const PersionTeachData({super.key, required this.data});

  @override
  State<PersionTeachData> createState() => _PersionTeachDataState();
}

class _PersionTeachDataState extends State<PersionTeachData> {
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
                  "بيانات المدرس",
                  style: TextStyle(
                      fontFamily: font1,
                      fontSize: 40,
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
                    prefixText: widget.data[0]["fullname"],
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
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {
                    print("================odo");
                    print(widget.data);
                    print("================odo");
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width - 40,
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
