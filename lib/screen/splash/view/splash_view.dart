import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/splash/controller/splash_controller.dart';


import '../../on_boarding/view/on_boarding_screen_view.dart';
import 'package:provider/provider.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SplashController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 45.w),
          child: Image(
            image: AssetImage("assets/images/splash1.png"),
          ),
        ),
        Image.asset(
          "assets/images/splash_logo.png",
          height: 297.36.w,
          width: 228.81.w,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 45.w,
          ),
          child: Image(
            image: AssetImage("assets/images/splash2.png"),
          ),
        ),
      ],
    ));
  }
}
