import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

import '../on_boarding/view/on_boarding_screen_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnBoardingScreenView())));
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
