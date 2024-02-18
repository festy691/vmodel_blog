import 'package:blog/core/utils/pallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_manager/theme_manager.dart';

String fontFamily = 'helvetica';

bool isLightMode(BuildContext context) =>
    ThemeManager.of(context).brightness == Brightness.light;
Color colorSwitch(BuildContext context) =>
    isLightMode(context) ? Pallet.black : Pallet.black;

final titleStyle = TextStyle(
  color: Pallet.white,
  fontSize: 24.sp,
  fontFamily: "helveticabold",
  fontWeight: FontWeight.w700,
);

final captionStyle = GoogleFonts.poppins(
  color: Pallet.white,
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
);

