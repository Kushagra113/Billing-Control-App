import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

Color getColorFromStatus(String status) {
  if (status == "green") {
    return HexColor("80ff80");
  } else if (status == "red") {
    return HexColor("ff8080");
  } else if (status == "blue") {
    return HexColor("8080ff");
  } else if (status == "yellow") {
    return HexColor("ffff80");
  }
  return HexColor("000000");
}
