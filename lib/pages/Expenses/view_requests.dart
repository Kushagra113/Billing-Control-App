import 'package:billing_control/pages/Expenses/viewRequest.dart';
import 'package:flutter/material.dart';
import 'package:billing_control/services/fetch_viewrequest.dart';
import 'package:billing_control/constants/color_constant.dart';

class View_request extends StatefulWidget {
  @override
  _View_requestState createState() => _View_requestState();
}

class _View_requestState extends State<View_request> {
  List<fetch_viewrequest> test1 = [
    fetch_viewrequest(
        id: 1,
        status: "green",
        date: "2021-10-12",
        title: "Earbuds",
        pay_to: "Amazon",
        amount: "1400"),
    fetch_viewrequest(
        id: 2,
        status: "red",
        date: "2021-10-12",
        title: "Stick",
        pay_to: "Amazon",
        amount: "800"),
    fetch_viewrequest(
        id: 3,
        status: "blue",
        date: "2021-10-12",
        title: "Milk",
        pay_to: "Grocery Store",
        amount: "50"),
    fetch_viewrequest(
        id: 4,
        status: "yellow",
        date: "2021-10-12",
        title: "Phone Bill",
        pay_to: "Vodaphone",
        amount: "2000"),
    fetch_viewrequest(
        id: 5,
        status: "yellow",
        date: "2021-10-12",
        title: "Phone Bill",
        pay_to: "Vodaphone",
        amount: "2000"),
    fetch_viewrequest(
        id: 6,
        status: "yellow",
        date: "2021-10-12",
        title: "Phone Bill",
        pay_to: "Vodaphone",
        amount: "2000"),
    fetch_viewrequest(
        id: 7,
        status: "yellow",
        date: "2021-10-12",
        title: "Phone Bill",
        pay_to: "Vodaphone",
        amount: "2000"),
  ];
  static ScrollController _controller = ScrollController();
  final TextStyle fontSize = TextStyle(fontSize: 17);
  bool _isLoading = false;

  void getdata() {
    // List<fetch_viewrequest> test ;
    // Uri url = Uri.parse("https://jsonplaceholder.cypress.io/todos");
    // Response response = await get (url);
    // dynamic data = jsonDecode(response.body);
    // print(data);
    // dynamic test = Map<String, dynamic>.from(data);
    // test.forEach((k,v)=>{
    //   print(k),
    //   print(v)
    // });
    //

    Future.delayed(
        const Duration(milliseconds: 5000),
        () => {
              test1.add(fetch_viewrequest(
                  id: 1,
                  status: "green",
                  date: "2021-10-12",
                  title: "Earbuds",
                  pay_to: "Amazon",
                  amount: "1400")),
              setState(() {
                _isLoading = false;
              })
            });
    // if(_isLoading){
    //   setState(() {
    //   test1.addAll(test_add);
    //   });
    // }

    // return test;
    // print(data.runtimeType);
    // print(data);
    // return test1;
  }

  @override
  void initState() {
    // getdata();
    _controller.addListener(_onScroll);
    super.initState();
  }

  _onScroll() {
    if (this.mounted) {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        setState(() {
          _isLoading = true;
        });
        getdata();
      }
    }
  }

  Widget data(element) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewRequest(
                    element.id,
                    element.status,
                    element.title,
                    element.date,
                    element.amount,
                    element.pay_to)));
      },
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: <Widget>[
              Container(
                color: getColorFromStatus(element.status),
                padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "ID ${element.id}",
                      style: fontSize,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Title ${element.title}",
                      style: fontSize,
                    )),
                    Expanded(child: Text("Date", style: fontSize))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    Expanded(
                        child:
                            Text("Pay_to ${element.pay_to}", style: fontSize)),
                    Expanded(
                        child: Text("\u{20B9} ${element.amount}",
                            style: fontSize)),
                  ],
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Request"),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _isLoading ? test1.length + 1 : test1.length,
                itemBuilder: (context, index) {
                  if (test1.length == index)
                    return Center(child: CircularProgressIndicator());
                  return data(test1[index]);
                })
          ],
        ),
      ),
    );
  }
}
