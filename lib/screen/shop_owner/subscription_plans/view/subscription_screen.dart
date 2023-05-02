import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/screen/customer/on_boarding/controller/on_boarding_controller.dart';

import 'package:local_supper_market/widget/buttons.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:provider/provider.dart';

class SubscriptionScreenView extends StatefulWidget {
  const SubscriptionScreenView({Key? key}) : super(key: key);

  @override
  _SubscriptionScreenViewState createState() => _SubscriptionScreenViewState();
}

class _SubscriptionScreenViewState extends State<SubscriptionScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0.w,
            child: Image.asset(
              "assets/images/splash1.png",
              height: 235.w,
              width: 361.w,
            ),
          ),
          Positioned(
            bottom: 0.w,
            right: 0.w,
            child: Image.asset(
              "assets/images/splash2.png",
              height: 235.w,
              width: 361.w,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 45.w,
                      ),
                      SizedBox(
                        height: 7.w,
                      ),
                      Image.asset(
                        "assets/images/splash4.png",
                        height: 112.w,
                        width: 59.w,
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LOCAL",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: SplashText),
                          ),
                          Text(
                            " SUPERMART",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: SplashText1),
                          ),
                        ],
                      ),
                      Text(
                        "Hameshase aapke sath....",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
