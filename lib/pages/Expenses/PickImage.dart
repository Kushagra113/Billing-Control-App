import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class PickImage extends StatefulWidget {
  String path = "";
  String name = "";
  PickImage(String image_path, String image_name) {
    path = image_path;
    name = image_name;
  }
  @override
  _PickImageState createState() => _PickImageState(path, name);
}

class _PickImageState extends State<PickImage> {
  File imageFile;
  Map<String, String> path_name = new Map();

  // Constructor That gets the Image when Clicked From Previous Screen
  _PickImageState(String image_path, String image_name) {
    if (image_path != null) {
      printing(image_name);
    } else {}
  }

  //  Getting Image That was Choosed Before
  Future<void> printing(String image_name) async {
    Directory appdir = await path_provider.getApplicationDocumentsDirectory();
    String path123 = appdir.path;
    setState(() {
      imageFile = File("${path123}/${image_name}");
    });
  }

  //  Function When Android Back Button Is Pressed What Happens ? !
  Future<bool> _onBackPressed() async {
    if (imageFile != null) {
      path_name["name"] = path.basename(imageFile.path);
      path_name["path"] = imageFile.path;
      Navigator.pop(context, path_name);
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('You Sure u dont want to select Image?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.popUntil(
                  context, ModalRoute.withName('/raise_request')),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
          ],
        ),
      );
    }
    return true;
  }

  //  Open Gallery Option
  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    final appDir = await path_provider.getApplicationDocumentsDirectory();
    final fileName = path.basename(picture.path);
    final savedImage = await picture.copy(('${appDir.path}/$fileName'));
    this.setState(() {
      imageFile = savedImage;
    });
  }

  //  Photo From Camera Option
  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    final appDir = await path_provider.getApplicationDocumentsDirectory();
    final fileName = path.basename(picture.path);
    final savedImage = await picture.copy(('${appDir.path}/$fileName'));
    this.setState(() {
      imageFile = savedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Selection For Bill"),
        ),
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                WillPopScope(
                    child: Container(),
                    // Ignore: Missing_return
                    onWillPop: _onBackPressed),
                imageFile != null
                    ? Image.file(
                        imageFile,
                        width: 300,
                        height: 300,
                      )
                    : Container(
                        width: 300,
                        height: 300,
                      ),
                ElevatedButton.icon(
                    onPressed: () {
                      _openGallery(context);
                    },
                    icon: Icon(Icons.add_photo_alternate),
                    label: Text("Add Photo From Gallery")),
                ElevatedButton.icon(
                    onPressed: () {
                      _openCamera(context);
                    },
                    icon: Icon(Icons.add_a_photo),
                    label: Text("Add Photo From Camera")),
              ],
            ),
            Positioned(
              top: 520,
              left: 280,
              // bottom: ,
              child: ElevatedButton(
                  onPressed: () {
                    if (imageFile != null) {
                      path_name["name"] = path.basename(imageFile.path);
                      path_name["path"] = imageFile.path;
                      print(imageFile.path);
                      Navigator.pop(context, path_name);
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: const Text(
                              'Are U Sure U Dont want to select Image?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.popUntil(context,
                                  ModalRoute.withName('/raise_request')),
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 20.0),
                  )),
            ),
          ],
        ));
  }
}

//