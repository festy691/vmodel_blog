import 'package:blog/core/utils/app_assets.dart';
import 'package:blog/core/utils/app_theme.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/image_loader.dart';
import 'package:blog/core/widgets/text_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog {
  static void showLoading(BuildContext context, GlobalKey key,
      [String message = 'Loading...']) async {
    final dialog = Dialog(
      key: key,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SpinKitCubeGrid(
          //   color: Pallet.colorPrimary,
          //   size: 50.0,
          // ),
          ImageLoader(
            path: AppAssets.loaderLottie,
            width: ScreenUtil().setWidth(200),
            height: ScreenUtil().setHeight(200),
          ),
          SizedBox(height: 16.0),
          TextView(text: message)
        ],
      ),
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
      barrierDismissible: false,
    );
  }

  static void hideLoading(GlobalKey key) {
    try {
      if (key.currentContext != null) {
        Navigator.of(key.currentContext!, rootNavigator: true).pop();
      } else {
        Future.delayed(Duration(milliseconds: 350)).then((value) =>
            Navigator.of(key.currentContext!, rootNavigator: true).pop());
      }
    } catch (e) {}
  }

  static void hideLoadingWithContext(BuildContext context, GlobalKey key) {
    try {
      Navigator.of(context, rootNavigator: true).pop();
    } catch (e) {}
  }

  static Widget getLoading({double size = 50.0}) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SpinKitCubeGrid(color: Pallet.colorPrimary, size: size),
      );

  static void showSuccessDialog(
    BuildContext context,
    GlobalKey key, {
    required String title,
    required String message,
    void Function()? onClose,
  }) async {
    var future = Future.delayed(const Duration(seconds: 5));
    var subscription = future.asStream().listen((_) {
      if (key.currentContext != null) {
        Navigator.of(key.currentContext!, rootNavigator: true).pop();
      }
    });

    final dialog = AlertDialog(
      key: key,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrollable: true,
      content: GestureDetector(
        onTap: () {
          Navigator.of(key.currentContext!, rootNavigator: true).pop();
          subscription.cancel();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 0),
          width: double.maxFinite,
          constraints: BoxConstraints(maxWidth: 340),
          decoration: BoxDecoration(
            color: isLightMode(context) ? Pallet.white : Pallet.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Pallet.green.withOpacity(0.4),
                child: Icon(Icons.check, size: 40, color: Pallet.green),
              ),
              SizedBox(height: 22.0),
              TextView(text: title, textAlign: TextAlign.center),
              SizedBox(height: 12.0),
              TextView(text: message, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
      barrierDismissible: false,
    ).then((_) {
      if (onClose != null) {
        onClose();
      }
    });
  }

  static void showSnackBar(
    BuildContext context,
    String message, {
    void Function()? onClose,
    bool error = false,
  }) {
    final snackBar = SnackBar(
      content: TextView(
        text: message,
        textStyle: const TextStyle(color: Pallet.white, fontFamily: "sans"),
      ),
      backgroundColor: !error ? Pallet.colorPrimary : Pallet.red,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'CLOSE',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (onClose != null) {
            onClose();
          }
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
