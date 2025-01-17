import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/screen/splash/controller/splash_controller.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
      children: [
        Padding(
          padding: EdgeInsets.only(right: 45.w),
          child: const Image(
            image: AssetImage("assets/images/splash1.png"),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40.w,
                ),
                // Image.asset(
                //   "assets/images/splash_logo.png",
                //   height: 227.36.w,
                //   width: 180.81.w,
                //   fit: BoxFit.fill,
                // ),
                Image.asset(
                  // "assets/images/kiranafy-logo-v14.png",
                  "assets/images/kiranafy-logo-new.png",
                  height: 200.36.w,
                  // width: 180.81.w,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 45.w,
          ),
          child: const Image(
            image: AssetImage("assets/images/splash2.png"),
          ),
        ),
      ],
    ));
  }
}
