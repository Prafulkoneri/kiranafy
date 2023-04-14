import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/auth/customer_sign_up.dart';
import 'package:local_supper_market/screen/intro/intro_one.dart';

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
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => IntroOne())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Padding(
          padding: const EdgeInsets.only(right: 45, top: 10),
          child: Image(
            image: AssetImage("assets/images/splash1.png"),
          ),
        ),
        Image(
          image: AssetImage("assets/images/splash3.png"),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 45,
          ),
          child: Image(
            image: AssetImage("assets/images/splash2.png"),
          ),
        ),
      ],
    ));
  }
}
