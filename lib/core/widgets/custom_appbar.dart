import 'package:blog/core/utils/page_router.dart';
import 'package:blog/core/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar appBar(BuildContext context, {List<Widget>? actions, Widget? leadingWidget, Widget? titleWidget}){
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Pallet.white,
    title: titleWidget,
    toolbarHeight: 50.h,
    leading: leadingWidget ?? IconButton(
      color: Pallet.black,
      iconSize: 24.w,
      onPressed: () => PageRouter.goBack(context),
      icon: Icon(Icons.arrow_back, size: 24.w, color: Pallet.black,)
    ),
    actions: actions,
  );
}