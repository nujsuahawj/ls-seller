// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ignore: unused_import
import 'dart:async';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ລົງທະບຽນເປີດຮ້ານ"),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://lao-shop.com/shop/apply/',
      ),
    );
  }
}
