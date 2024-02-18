import 'package:blog/core/utils/app_assets.dart';
import 'package:blog/core/utils/app_theme.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/custom_button.dart';
import 'package:blog/core/widgets/image_loader.dart';
import 'package:blog/core/widgets/text_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyScreen extends StatelessWidget {
  EmptyScreen({Key? key, this.icon = AppAssets.noData, required this.title, required this.onRefresh}) : super(key: key);
  String title;
  String icon;
  Function onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        SizedBox(height: 64.h,),

        ImageLoader(
          path: icon,
          width: 1.sw * 0.5,
          height: 1.sw * 0.5,
          fit: BoxFit.fitWidth,
        ),

        TextView(text: title, textStyle: titleStyle.copyWith(fontSize: 16.sp, color: Pallet.black),),

        SizedBox(height: 64.h,),

        CustomButtonWidget(
          buttonText: 'Refresh',
          height: 56.h,
          width: 0.6.sw,
          onTap: () {
            onRefresh();
          },
        ),
      ],
    );
  }
}
