import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/screen/Home/nearby_shop.dart';
import 'package:local_supper_market/screen/Home/category.dart';
import 'package:local_supper_market/screen/Home/home_screen.dart';
import 'package:local_supper_market/screen/auth/customer_sign_in.dart';
import 'package:local_supper_market/screen/auth/shop_registration.dart';
import 'package:local_supper_market/screen/auth/shope_owner.dart';
import 'package:local_supper_market/screen/coupons/couponsall.dart';
import 'package:local_supper_market/screen/near_shops/all_near_shops.dart';
import 'package:local_supper_market/screen/shop_profile/shop_profile.dart';
import 'package:local_supper_market/screen/splash/splash.dart';
import 'package:local_supper_market/test.dart';

import 'const/color.dart';
import 'screen/auth/customer_sign_up.dart';
import 'screen/auth/upload_documents.dart';
import 'screen/intro/intro_one.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              home: ShopProfile());
        });
  }
}
