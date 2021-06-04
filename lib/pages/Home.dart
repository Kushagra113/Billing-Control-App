import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String title = "HomePage";

  final List image_list = [
    "https://assets.fireside.fm/file/fireside-images/podcasts/images/b/bc7f1faf-8aad-4135-bb12-83a8af679756/cover.jpg?v=3/200x200",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2bEK18zKFmpINzPpi17tLJARajfO1hLxSxdnAxVUGZXVpI-0CunjBbbSFRuImxczoHdI&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2bEK18zKFmpINzPpi17tLJARajfO1hLxSxdnAxVUGZXVpI-0CunjBbbSFRuImxczoHdI&usqp=CAU"
  ];
  @override
  void initState() {
    setState(() {
      title = "Homepage";
    });
  }

  void _dragUpdate(int index) {
    if (index == 2) {
      Navigator.pushNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Swiper(
          loop: false,
          autoplay: false,
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            if (index != 3) {
              return GestureDetector(
                onVerticalDragUpdate: (DragEndDetails) => {_dragUpdate(index)},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
                  child: Image.network(
                    image_list[index],
                    fit: BoxFit.fill,
                  ),
                ),
              );
            }
          },
          itemCount: 4,
          pagination: SwiperPagination(
            margin: EdgeInsets.all(20.0),
          ),
          // control: null,
          itemHeight: 1000,
          // itemWidth: 500,
        ),
      ),
    );
  }
}
