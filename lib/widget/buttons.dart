import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PrimaryButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final Color? textColor;
  final VoidCallback? onTap;
  final Widget? leading;
  final double ? width;



  const PrimaryButton(
      {Key? key,
        this.leading,
        this.width,
        this.textColor,
        this.text,
        required this.color,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width:width??MediaQuery.of(context).size.width,
          height: 45.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(7),
          ),
          child: leading == null
              ? Center(
              child: Text(
                "${text}",
                style: TextStyle(
                    color: textColor??Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp),
              ))
              : leading
      ),
    );
  }
}