import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final Color? textColor;
  final VoidCallback? onTap;
  final Widget? leading;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;


  const PrimaryButton(
      {Key? key,
      this.leading,
      this.width,
      this.height,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      required this.text,
      required this.color,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? 45.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(7.w),
          ),
          child: leading == null
              ? Center(
                  child: Text(
                  "${text}",
                  style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontWeight: fontWeight ?? FontWeight.w700,
                      fontSize: fontSize ?? 14.sp),
                ))
              : leading),
    );
  }
}
