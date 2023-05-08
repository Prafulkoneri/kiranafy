import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryAppBar extends StatelessWidget {
  final String? title;
  final Widget? action;
  final PreferredSizeWidget? bottom;
  void Function()? onActionTap;

  PrimaryAppBar({Key? key, required this.title, this.action, this.onActionTap,this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        // Status bar color
        statusBarColor: kstatusbar,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
      // toolbarHeight: 65,
      // backgroundColor: kappbar,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title ?? "",
        style: GoogleFonts.dmSans(
          textStyle: TextStyle(
              color: DarkBlack,
              // letterSpacing: .5,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
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
          onTap:onActionTap,

          child: Padding(
              padding: EdgeInsets.only(
                right: 20.w,
              ),
              child: action),
        ),
      ],
bottom: bottom,
    );
  }
}
