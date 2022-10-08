import 'package:flutter/material.dart';

class Colors {
  static Color warningRed = Color(hexColor('#C74C4C'));
  static Color primaryGreen = Color(hexColor('#617515'));
  static Color accentGreen = Color(hexColor('#97B44B'));
  static Color darkBrown = Color(hexColor('#574240'));
  static Color beigePink = Color(hexColor('#BFA5A3'));

  static int hexColor(String color) {
    String hexStr = '0xFF' + color;
    hexStr = hexStr.replaceAll('#', '');
    int hexColor = int.parse(hexStr);
    return hexColor;
  }
}
