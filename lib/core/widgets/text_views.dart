import 'package:blog/core/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final Function()? onTap;
  final int? maxLines;
  final double? textSize;
  final TextStyle? textStyle;
  final Color? textColor;

  TextView(
      {required this.text,
        this.textOverflow = TextOverflow.clip,
        this.textAlign = TextAlign.left,
        this.onTap,
        this.textStyle,
        this.textColor,
        this.textSize,
        this.maxLines,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: textStyle ?? TextStyle(
            fontFamily: fontFamily,
            fontSize: textSize ?? ScreenUtil().setSp(14),
            fontWeight: FontWeight.w400,
            color: textColor
        ),
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}