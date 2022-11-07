import 'package:flutter/material.dart';

Color HexColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if(hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}