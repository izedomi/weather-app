import 'package:flutter/material.dart';
import 'package:weather_app/core/contants/color.dart';

class BsWrapper {
  static void bottomSheet({
    required BuildContext context,
    required Widget widget,
    isScrollControlled = true,
    bool? canDismiss,
    double? topRadius,
    Color? color,
  }) {
    showModalBottomSheet(
      backgroundColor: color ?? AppColor.brandBlack,
      isScrollControlled: true,
      isDismissible: canDismiss ?? true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius ?? 20),
          topRight: Radius.circular(topRadius ?? 20),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return widget;
      },
    );
  }
}
