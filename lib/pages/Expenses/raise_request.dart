import 'dart:io';
import 'package:billing_control/pages/Expenses/PickImage.dart';
import 'package:flutter/material.dart';
import 'package:billing_control/constants/global_constants.dart' as globals;

class Raiserequest extends StatefulWidget {
  @override
  _RaiserequestState createState() => _RaiserequestState();
}

class _RaiserequestState extends State<Raiserequest> {
  // Value For Date
  DateTime selectedDate = DateTime.now();
  File image_file;
  Map<String, String> result = {"name": "", "path": ""};
  String path = "";
  String name = "";

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(selectedDate.year + 1),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // Date Text Form Field
  Padding dateField() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Text(
                "Date",
                style: TextStyle(fontSize: 15.0),
              )),
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$selectedDate.tolocal()".split(' ')[0],
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                    onPressed: () => {
                          _selectDate(context),
                        },
                    icon: Icon(Icons.calendar_today)),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Text Form Field
  Padding inputs(hintText, TextInputType type) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextFormField(
        keyboardType: type,
        autofocus: false,
        decoration: InputDecoration(
            hintText: hintText,
            // labelStyle: TextStyle(fontSize: 30.0),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
    );
  }

  // Each Row For Inputs
  Row rows(value, hinttext, inputtype) {
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
          child: inputs(hinttext, inputtype),
        )
      ],
    );
  }

  // Image Upload Row Widget
  Widget image_upload() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Text(
                "Bill Image",
                style: TextStyle(fontSize: 15.0),
              )),
          Expanded(
            flex: 6,
            child: result != null
                ? TextButton(
                    onPressed: () async {
                      result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PickImage(result["path"], result["name"]),
                          ));
                      setState(() {});
                    },
                    child: Text(result["name"]))
                : ElevatedButton(
                    onPressed: () async => {
                      // a = await Navigator.pushNamed(context, "/pick_image"),
                      // setState(() {})
                      result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PickImage("", ""),
                          )),
                      print(result),
                      setState(() {})
                    },
                    child: Text("Choose Image For Bill"),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Raise Request"),
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
                // rows("ID", "ID", TextInputType.number),
                // rows("Date", "Date", TextInputType.datetime),
                rows("Title", "Title", TextInputType.text),
                rows("Pay to", "Pay To", TextInputType.text),
                rows("Amount", "Amount", TextInputType.number),
                dateField(),
                image_upload(),
                Center(
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: globals.globalRole == "Approver"
                        ? Text("Approve and Raise Request",
                            style: TextStyle(fontSize: 20.0))
                        : Text("Raise Request",
                            style: TextStyle(fontSize: 20.0)),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
