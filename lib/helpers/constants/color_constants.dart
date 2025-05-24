import 'package:flutter/material.dart';
import '../extansions/color_ext.dart';

class ColorConstants {
  static ColorConstants? _instance;
  static ColorConstants get instance {
    _instance ??= ColorConstants._init();
    return _instance!;
  }

  ColorConstants._init();

  Color brown = HexColor.fromHex("#b78460");
  Color gradientStart = HexColor.fromHex("#504CA0");
  Color gradientEnd = HexColor.fromHex("#3A90CD");
  Color grey = HexColor.fromHex("#5A5C63");
  Color blue = HexColor.fromHex("#0072BA");
  Color greyNew = const Color.fromRGBO(84, 88, 95, 1);


}
