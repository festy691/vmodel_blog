import 'package:blog/core/utils/app_assets.dart';
import 'package:blog/core/utils/app_theme.dart';
import 'package:blog/core/utils/page_router.dart';
import 'package:blog/core/widgets/custom_button.dart';
import 'package:blog/core/widgets/image_loader.dart';
import 'package:blog/core/widgets/text_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomSheetsWidget extends StatelessWidget {
  String title;
  String? desc;
  String? buttonText;
  VoidCallback? onTap;
  bool showCancel;
  CustomBottomSheetsWidget({required this.title, this.desc, this.buttonText, this.onTap, this.showCancel = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(32.w)),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  ImageLoader(
                    path: AppAssets.logo,
                    width: 48.w,
                    height: 48.w,
                  ),
                  SizedBox(height: 24.h),
                  TextView(
                    text: title,
                    textAlign: TextAlign.center,
                    textStyle: titleStyle.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 24.h),
                  TextView(
                    text: desc!,
                    textAlign: TextAlign.center,
                    textStyle: GoogleFonts.firaSans(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomButtonWidget(
                    buttonText: buttonText!,
                    width: 1.sw,
                    onTap: onTap!,
                  ),
                  Visibility(
                    visible: showCancel,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 24),
                        CustomOutlinedButtonWidget(
                          buttonText: 'Cancel',
                          width: 1.sw,
                          onTap: () => PageRouter.goBack(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSheetsWidget extends StatelessWidget {
  String desc;
  String? buttonText;
  VoidCallback? onTap;
  CustomSheetsWidget({required this.desc, this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(32.0.w)),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  ImageLoader(
                    path: AppAssets.logo,
                    width: 48.w,
                    height: 48.w,
                  ),
                  SizedBox(height: 24.h),
                  TextView(
                    text: desc,
                    textAlign: TextAlign.center,
                    textStyle: titleStyle.copyWith(fontSize: ScreenUtil().setSp(20)),
                  ),
                  SizedBox(height: 24.h),
                  CustomButtonWidget(
                    buttonText: buttonText!,
                    width: 1.sw,
                    onTap: onTap!,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
