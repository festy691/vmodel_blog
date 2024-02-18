import 'package:another_flushbar/flushbar.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:flutter/material.dart';

class AppFlushBar {
  static void showSuccess({
    required BuildContext context,
    required String message,
    FlushbarPosition flushbarPosition = FlushbarPosition.TOP,
    String title = "Success!",
    int duartion = 4,
  }) {
    Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeOut,
      title: title,
      flushbarPosition: flushbarPosition,
      duration: Duration(seconds: duartion),
      isDismissible: true,
      backgroundColor: Pallet.green,
      message: message,
      // backgroundGradient: LinearGradient(colors: [
      //   Pallet.primary,
      //   Pallet.success.shade500,
      // ]),
      boxShadows: [
        BoxShadow(
          color: Pallet.green.withOpacity(0.8),
          offset: const Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    ).show(context);
  }

  static void showError({
    required BuildContext context,
    required String message,
    String title = "Error",
    FlushbarPosition flushbarPosition = FlushbarPosition.TOP,
    int duartion = 4,
  }) {
    Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeOut,
      title: title,
      flushbarPosition: flushbarPosition,
      duration: Duration(seconds: duartion),
      isDismissible: true,
      backgroundColor: Pallet.red,
      message: message,
      boxShadows: [
        BoxShadow(
          color: Pallet.red.withOpacity(0.9),
          offset: const Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    ).show(context);
  }

  static void showInfo({
    required BuildContext context,
    required String message,
    String title = "Info",
    FlushbarPosition flushbarPosition = FlushbarPosition.TOP,
    int duartion = 4,
  }) {
    Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeOut,
      title: title,
      flushbarPosition: flushbarPosition,
      duration: Duration(seconds: duartion),
      isDismissible: true,
      backgroundColor: Pallet.blue,
      message: message,
      boxShadows: [
        BoxShadow(
          color: Pallet.blue.withOpacity(0.9),
          offset: const Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    ).show(context);
  }
}

