import 'package:flutter/material.dart';

class Expenses_home extends StatefulWidget {
  @override
  _Expenses_homeState createState() => _Expenses_homeState();
}

class _Expenses_homeState extends State<Expenses_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/raise_request");
            },
            child: Text("Raise Request"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/view_request");
            },
            child: Text("View Request"),
          ),
        ],
      ),
    );
  }
}
