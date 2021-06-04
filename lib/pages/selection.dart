// import 'dart:html';
import 'package:billing_control/pages/Expenses/expenses_homepage.dart';
import 'package:billing_control/pages/Follow%20Up/follow_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Selection extends StatefulWidget {
  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  String title = "Selection";
  int index = 0;

  // void selection() {
  //   setState(() {
  //     title = "Selection";
  //     index = 0;
  //   });
  //   Navigator.pop(context);
  // }

  void expenses() {
    setState(() {
      title = "Expenses";
      index = 1;
    });
    Navigator.pop(context);
  }

  void followup() {
    setState(() {
      title = "Follow Ups";
      index = 2;
    });
    Navigator.pop(context);
  }

  void profile() {
    setState(() {
      title = "Profile";
      index = 3;
    });
    Navigator.pop(context);
  }

  Widget container(text, Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            )),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                DrawerHeader(
                    child: Column(
                  children: [
                    container("Hi Kushagra Tibrewal", Colors.blue[900]),
                    SizedBox(
                      height: 10,
                    ),
                    container("Profile And Navigation", Colors.blueAccent),
                  ],
                )),
                // ListTile(
                //   title: Text("Selection"),
                //   onTap: selection,
                // ),
                ListTile(
                  title: Text(
                    "Expenses",
                    style: TextStyle(fontSize: 15.0),
                    // textAlign: TextAlign.cente,
                  ),
                  onTap: expenses,
                ),
                ListTile(
                  title: Text("Follow Up"),
                  onTap: followup,
                ),
                ListTile(
                  title: Text("Profile"),
                  onTap: profile,
                ),
              ],
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: <Widget>[
          // Offstage(
          //   offstage: index != 0,
          //   child: Selection(),
          // ),
          Offstage(
            offstage: index != 1,
            child: Expenses_home(),
          ),
          Offstage(
            offstage: index != 2,
            child: FollowUp(),
          ),
          Offstage(
            offstage: index != 3,
            child: Text("Profile Page"),
            // child: Profile(),
          ),
        ],
      ),
      drawer: drawer(),
    );
  }
}
