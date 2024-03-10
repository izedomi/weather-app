import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/contants/color.dart';
import 'package:weather_app/ui/utils/space.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final String? optionalText;
  final TextEditingController controller;
  final Function()? onChange;
  final bool? isPassword;
  final bool? isConfirmPassword;
  final bool? showSuffixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final String? errorText;
  final double? width;
  final double? height;
  final bool? isReadOnly;
  final FocusNode? focusNode;
  final bool showLabelHeader;
  final Color? labelColor;
  final double? labelSize;
  final bool isOptional;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final int? maxLines;
  final TextCapitalization? capitalization;
  final Function()? onTap;
  final bool isFilled;
  final Color filledColor;
  final Color? textColor;
  final String? Function(String?)? validator;

  const CustomTextField(
      {Key? key,
      required this.labelText,
      this.hintText,
      this.optionalText,
      this.labelColor,
      this.labelSize,
      required this.controller,
      this.validator,
      this.isPassword = false,
      this.isConfirmPassword = false,
      this.showSuffixIcon = false,
      this.suffixIcon,
      this.prefix,
      this.errorText,
      this.width,
      this.height,
      this.maxLines,
      this.isReadOnly = false,
      this.showLabelHeader = true,
      this.focusNode,
      this.isOptional = false,
      this.onChange,
      this.labelStyle,
      this.hintStyle,
      this.capitalization,
      this.onTap,
      this.isFilled = false,
      this.textColor,
      this.filledColor = Colors.transparent})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;
  double radius = 8.r;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      // height: widget.height ?? 60.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            //cursorHeight: 14.sp,
            cursorColor: AppColor.white,
            focusNode: widget.focusNode,
            maxLines: widget.maxLines ?? 1,
            style: TextStyle(
                color: widget.textColor ?? AppColor.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400),

            controller: widget.controller,
            obscureText: widget.isPassword! && !showPassword,
            obscuringCharacter: "●".toString().substring(0, 1),
            keyboardType: TextInputType.none,

            validator: widget.validator,
            textCapitalization:
                widget.capitalization ?? TextCapitalization.none,
            onChanged: (String value) {
              if (widget.onChange != null) {
                widget.onChange!();
              }
            },

            onTap: widget.onTap,
            readOnly: widget.isReadOnly!,
            decoration: InputDecoration(
              fillColor: widget.filledColor,
              filled: widget.isFilled,
              prefixIcon: widget.prefix,
              errorText: widget.errorText,
              errorStyle: TextStyle(
                  color: AppColor.red, fontSize: 0.01.sp, height: 0.2),
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  TextStyle(
                    color: widget.labelColor ?? AppColor.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
              labelText: widget.labelText,
              suffixIcon: widget.showSuffixIcon!
                  ? Container(
                      padding: EdgeInsets.only(
                        right: 16.w,
                      ),
                      child: widget.suffixIcon ?? suffixIcon(),
                    )
                  : const SizedBox.shrink(),
              labelStyle: widget.labelStyle ??
                  TextStyle(
                      color: AppColor.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.3),
              enabledBorder: OutlineInputBorder(
                // borderSide: BorderSide.none,
                borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                borderRadius: BorderRadius.circular(radius),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                borderRadius: BorderRadius.circular(radius),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                borderRadius: BorderRadius.circular(radius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                borderRadius: BorderRadius.circular(radius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffE0E0E0)),
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),
          VSpace(1.h),
          if (widget.errorText != null)
            Text(
              widget.errorText!,
              textAlign: TextAlign.left,
              style: TextStyle(color: AppColor.red, fontSize: 11.sp),
            )
        ],
      ),
    );
  }

  Widget? suffixIcon() {
    if (widget.showSuffixIcon! && widget.suffixIcon != null) {
      return widget.suffixIcon;
    }
    return null;
  }
}
