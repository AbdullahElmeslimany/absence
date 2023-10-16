import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanCompleted = false;
  String? latecode;

  void colseScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
          child: ListView(
        children: const [
          DrawerHeader(
              child: Icon(
            Icons.person,
            size: 80,
          )),
          ListTile(
            leading: Icon(Icons.co_present_outlined, size: 26),
            title: Text(
              'بيانات الطالب',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Center(child: Text("الطالب"))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Container(
                    height: 200,
                    width: 200,
                    child: MobileScanner(
                      onDetect: (barcode, args) {
                        if (!isScanCompleted) {
                          setState(() {
                            String code = barcode.rawValue ?? '----------';
                            latecode = code;
                            isScanCompleted = true;
                          });

                          print("======================================");
                          print(latecode);
                          print("--------------------------------------");

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => StudentHomePage(
                          //           code: code!, func: colseScreen),
                          //     ));
                        }
                      },
                    ))),
            latecode == null ? Container() : Text(latecode!)
          ],
        ),
      ),
    );
  }
}
