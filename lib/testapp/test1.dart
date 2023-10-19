import 'package:absence/constant/encryptprossing.dart';
import 'package:flutter/material.dart';

class EncryptTest extends StatefulWidget {
  const EncryptTest({super.key});

  @override
  State<EncryptTest> createState() => _EncryptTestState();
}

class _EncryptTestState extends State<EncryptTest> {
  @override
  void initState() {
    MyEncryption.encryptAES("hello");
    
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
