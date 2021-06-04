// import 'package:billing_control/pages/Expenses/PickImage.dart';
import 'package:billing_control/pages/Expenses/expenses_homepage.dart';
import 'package:billing_control/pages/Expenses/raise_request.dart';
import 'package:billing_control/pages/Expenses/view_requests.dart';
import 'package:billing_control/pages/Home.dart';
// import 'package:billing_control/pages/Login1.dart';
import 'package:billing_control/pages/login.dart';
import 'package:billing_control/pages/selection.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/login": (context) => Login(),
        "/selection": (context) => Selection(),
        "/Expenses": (context) => Expenses_home(),
        "/raise_request": (context) => Raiserequest(),
        "/view_request": (context) => View_request(),
      },
    );
  }
}
