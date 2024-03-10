import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/contants/color.dart';

class SelectionButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final bool isBlack;
  final IconData? icon;
  final Function()? onTap;
  const SelectionButtonWidget(
      {super.key,
      this.width,
      this.height,
      this.onTap,
      this.icon,
      this.isBlack = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!() : () => Navigator.pop(context),
      child: Container(
        width: 35.w,
        height: 35.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColor.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color: isBlack ? AppColor.black : AppColor.white, width: 1.5)),
        child: Icon(
          icon ?? Iconsax.menu_1,
          color: AppColor.brandBlue,
          size: 20.sp,
        ),
      ),
    );
  }
}
