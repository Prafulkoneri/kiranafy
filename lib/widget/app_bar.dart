import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryAppBar extends StatelessWidget {
  final String? title;
  final Widget? action;
  final bool? isBackButtonEnabled;
  final EdgeInsets? titlePadding;
  void Function()? onActionTap;
  final void Function()? onBackBtnPressed;
  PrimaryAppBar(
      {Key? key,
      this.isBackButtonEnabled,
      required this.title,
      this.onBackBtnPressed,
      this.action,
      this.titlePadding,
      this.onActionTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarHeight: 65.w,
      // backgroundColor: kappbar,
      leading: isBackButtonEnabled ?? true
          ? Container(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: onBackBtnPressed,
              ),
            )
          : Container(),
      title: Container(
        padding: titlePadding,
        child: Text(
          maxLines: 2,
          title ?? "",
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
                color: Black,
                // letterSpacing: .5,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
          bottom: Radius.circular(40),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(40)),
          gradient: LinearGradient(
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
              colors: <Color>[
                kstatusbar.withOpacity(0.55),
                kstatusbar.withOpacity(0.98),
              ]),
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: onActionTap,
          child: Container(
            color: Colors.transparent,
            height: 100.w,
            width: 100.w,
            // width: 50.w,
            // height: 65.w,
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: action,
                )),
          ),
        )
      ],
    );
  }
}
