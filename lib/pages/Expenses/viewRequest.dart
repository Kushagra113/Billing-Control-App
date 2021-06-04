// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:billing_control/constants/global_constants.dart' as globals;

class ViewRequest extends StatefulWidget {
  String status, title, date, pay_to, amount;
  int id;

  ViewRequest(
      this.id, this.status, this.title, this.date, this.amount, this.pay_to);

  @override
  _ViewRequestState createState() =>
      _ViewRequestState(id, status, title, date, amount, pay_to);
}

class _ViewRequestState extends State<ViewRequest> {
  String status, title, date, amount, pay_to;
  int id;

  _ViewRequestState(
      this.id, this.status, this.title, this.date, this.amount, this.pay_to);

  // Each Row For Inputs
  Row rows(value, text) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 1, 2, 2),
              child: Text(
                value,
              )),
        ),
        Expanded(
          flex: 5,
          child: Text(text),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Request"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 23,
                ),
                rows(title, "Tite"),
                rows(status, "Status"),
                rows(pay_to, "Pay To"),
                rows(amount, "Amount"),
                rows(date, "Date"),
                // rows(, "Image")
              ],
            ),
          ),
        ));
  }
}
