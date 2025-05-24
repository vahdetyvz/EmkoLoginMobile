import 'package:flutter/material.dart';


LinearGradient customGradient(colors) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      colors.gradientStart,
      colors.gradientEnd,
    ],);
}