import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/contants/color.dart';
import 'package:weather_app/ui/utils/space.dart';

class WeatherItemWidget extends StatelessWidget {
  const WeatherItemWidget(
      {super.key,
      required this.imageUrl,
      required this.label,
      required this.value,
      this.c1,
      this.c2});

  final String imageUrl;
  final String label;
  final String value;
  final Color? c1;
  final Color? c2;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.brandBlue, borderRadius: BorderRadius.circular(16)),
        width: 120.w,
        height: 80.h,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: 136,
                height: 80.h,
                decoration: BoxDecoration(
                  color: c1 != null
                      ? c1!.withOpacity(0.10)
                      : AppColor.blue.withOpacity(0.10),
                  // borderRadius:
                  //     BorderRadius.circular(16.r)
                ),
              ),
            ),
            Positioned(
              right: -20,
              top: -15,
              child: Container(
                width: 107,
                height: 107,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: c1 != null
                      ? c1!.withOpacity(0.10)
                      : AppColor.blue.withOpacity(0.10),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  imageUrl,
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                bottom: 8,
                left: 12,
                right: 12,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.white),
                      ),
                      VSpace(4.h),
                      Text(
                        label,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
