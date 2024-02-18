import 'package:blog/core/utils/pallet.dart';
import 'package:blog/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget body;
  final List<Widget>? actions;
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool hasPadding;
  final bool hasAppBar;
  final Color backgroundColor;

  const BackgroundWidget({
    Key? key,
    required this.body,
    this.actions,
    this.hasPadding = false,
    this.leadingWidget,
    this.titleWidget,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.hasAppBar = true,
    this.backgroundColor = Pallet.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: hasAppBar
          ? appBar(
              context,
              actions: actions,
              leadingWidget: leadingWidget,
              titleWidget: titleWidget,
            )
          : null,
      floatingActionButton: floatingActionButton,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          color: Pallet.white,
        ),
        padding: hasPadding
            ? EdgeInsets.only(left: 20.w, right: 20.w, bottom: 16.h)
            : EdgeInsets.zero,
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
