import 'package:blog/core/utils/page_router.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/custom_button.dart';
import 'package:blog/core/widgets/text_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDialog {

  AppDialog._();

  defaultDialog(String title, Widget content,
      {bool isDismissible = false, Widget? confirm, Widget? cancel}) {
    return Get.defaultDialog(
      title: title,
      content: content,
      cancel: cancel ?? null,
      confirm: confirm ?? null,
      barrierDismissible: isDismissible,
      radius: 10,
    );
  }

  customisedDialog(
      Widget widget, {
        bool isDismissible = false,
      }) {
    return Get.dialog(widget, barrierDismissible: isDismissible);
  }

  static showConfirmationDialog(BuildContext context, {String title = "Info", required String message, required Function onContinue}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.w,
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(
              20.w,
            ),
            title: Row(
              children: [
                Icon(Icons.info, color: Pallet.blue, size: 24.w,),

                SizedBox(width: 14.w),

                TextView(
                  text: title,
                  textStyle: GoogleFonts.roboto(fontSize: 18.sp, color: Pallet.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            content: Container(
              //height: 132.h,
              width: 332.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(height: 0.5, color: Pallet.grey,),

                  SizedBox(height: 10.h),

                  TextView(
                    text: message,
                    textStyle: GoogleFonts.roboto(fontSize: 16.sp, color: Pallet.black.withOpacity(0.8), fontWeight: FontWeight.w400),
                  ),

                  SizedBox(height: 40.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomOutlinedButtonWidget(
                          buttonText: "Close",
                          height: 38.h,
                          width: 114.w,
                          onTap: (){
                            PageRouter.goBack(context);
                          }
                      ),

                      CustomButtonWidget(
                        buttonText: "Continue",
                          height: 38.h,
                          width: 114.w,
                        onTap: (){
                          onContinue();
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  static showSuccessDialog(BuildContext context, {String title = "Successful", required String message, required Function onContinue}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.w,
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(
              20.w,
            ),
            title: Row(
              children: [
                Icon(Icons.check_circle, color: Pallet.green, size: 24.w,),

                SizedBox(width: 14.w),

                TextView(
                  text: title,
                  textStyle: GoogleFonts.roboto(fontSize: 18.sp, color: Pallet.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            content: Container(
              //height: 132.h,
              width: 332.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(height: 0.5, color: Pallet.grey,),

                  SizedBox(height: 10.h),

                  TextView(
                    text: message,
                    textStyle: GoogleFonts.roboto(fontSize: 16.sp, color: Pallet.black.withOpacity(0.8), fontWeight: FontWeight.w400),
                  ),

                  SizedBox(height: 40.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomOutlinedButtonWidget(
                        buttonText: "Continue",
                        height: 38.h,
                        width: 114.w,
                        onTap: (){
                          onContinue();
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  static showErrorDialog(BuildContext context, {required String message, required Function onContinue}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.w,
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(
              20.w,
            ),
            title: Row(
              children: [
                Icon(Icons.cancel, color: Pallet.red, size: 24.w,),

                SizedBox(width: 14.w),

                TextView(
                  text: "Failed",
                  textStyle: GoogleFonts.roboto(fontSize: 18.sp, color: Pallet.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            content: Container(
              //height: 132.h,
              width: 332.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(height: 0.5, color: Pallet.grey,),

                  SizedBox(height: 10.h),

                  TextView(
                    text: message,
                    textStyle: GoogleFonts.roboto(fontSize: 16.sp, color: Pallet.black.withOpacity(0.8), fontWeight: FontWeight.w400),
                  ),

                  SizedBox(height: 40.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomOutlinedButtonWidget(
                        buttonText: "Continue",
                        height: 38.h,
                        width: 114.w,
                        onTap: (){
                          onContinue();
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

}