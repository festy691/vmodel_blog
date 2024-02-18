import 'package:blog/core/utils/constants.dart';
import 'package:blog/core/utils/page_router.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/background_widget.dart';
import 'package:blog/core/widgets/text_views.dart';
import 'package:blog/screens/home_screens/base_screen.dart';
import 'package:blog/screens/home_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _checkState() async {
    Future.delayed(const Duration(milliseconds: 3000)).then((value) =>
    PageRouter.gotoWidget(BaseScreen(), context, clearStack: true));
  }

  @override
  void initState() {
    _checkState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      hasAppBar: false,
      body: Center(child: TextView(text: appName, textStyle: GoogleFonts.poppins(fontSize: 24.sp, color: Pallet.black, fontWeight: FontWeight.w600),),),
    );
  }
}
