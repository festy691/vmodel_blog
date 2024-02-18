import 'package:blog/core/utils/app_theme.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_views.dart';

// ignore: must_be_immutable
class CustomButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double height;
  final double radius;
  final String? font;
  final double fontSize;
  final Color? buttonTextColor;
  Color? buttonColor;
  Color? borderColor;
  final double width;
  bool disabled;
  bool loading;

  CustomButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.font,
      this.height = 56,
      this.radius = 8,
      this.width = 50,
      this.fontSize = 16,
      this.buttonTextColor,
      this.borderColor,
      this.disabled = false,
      this.loading = false,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: IgnorePointer(
        ignoring: disabled,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            primary: disabled == true
                ? Pallet.lightGrey.withOpacity(0.1)
                : buttonColor ?? Pallet.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.w),
            ),
          ),
          child: loading ?
          const CircularProgressIndicator(color: Pallet.white,) :
          TextView(
            text: buttonText,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
                fontFamily: fontFamily,
                color: buttonTextColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomOutlinedButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double height;
  final double radius;
  final double fontSize;
  final String? font;
  final Color? buttonTextColor;
  Color? buttonColor;
  Color? borderColor;
  final double width;

  CustomOutlinedButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.font,
      this.height = 50,
      this.radius = 8,
      this.width = 50,
      this.fontSize = 16,
      this.buttonTextColor,
      this.borderColor,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
            primary: borderColor ?? Pallet.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0.w),
            ),
            side: BorderSide(color: borderColor ?? Pallet.blue)),
        child: TextView(
          text: buttonText,
          textAlign: TextAlign.center,
          textStyle: TextStyle(
              fontFamily: fontFamily,
              fontSize: ScreenUtil().setSp(fontSize),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
