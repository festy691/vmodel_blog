import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pallet {
  Pallet._();

  // MISC
  static const Color colorPrimary = Color(0xFF0F6EFF);

  static const Color blue = Color(0xFF266DD3);
  static const Color green = Color(0xFF1A6A26);
  static const Color red = Color(0xFFE0323F);
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  static const Color grey = Color(0xFF5B667A);
  static const Color lightGrey = Color(0xFFE2E2E2);
  static const Color hintColor = Color(0xFFBAC3D2);

  static String getRandomColor() => Color.fromARGB(255, Random().nextInt(255),
          Random().nextInt(255), Random().nextInt(255))
      .value
      .toRadixString(16);
}
