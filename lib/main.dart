import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:local_supper_market/screen/customer/account/view/controller/profile_controller.dart';
import 'package:local_supper_market/screen/customer/auth/controller/customer_sign_in_controller.dart';
import 'package:local_supper_market/screen/customer/auth/controller/customer_sign_up_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/splash/splash.dart';
import 'package:local_supper_market/screen/shop_owner/auth/controller/shop_registration_controller.dart';
import 'package:local_supper_market/screen/shop_owner/auth/controller/shop_sign_in_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/controller/s_kyc_verrification_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/controller/s_select_category_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/subscription_screen.dart';

import 'package:provider/provider.dart';

import 'screen/customer/on_boarding/controller/on_boarding_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainScreenController()),
        ChangeNotifierProvider(create: (_) => OnBoardingController()),
        ChangeNotifierProvider(create: (_) => CustomerSignInController()),
        ChangeNotifierProvider(create: (_) => CustomerSignUpController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => ShopRegistrationController()),
        ChangeNotifierProvider(create: (_) => ShopSignInController()),
        ChangeNotifierProvider(create: (_) => SKycVerificationController()),
        ChangeNotifierProvider(create: (_) => SSelectCategoryController()),
      ],
      child: const MyApp(),
    ),
  );
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
                  primarySwatch: Colors.blue, fontFamily: 'dm_sans_regular'),
              debugShowCheckedModeBanner: false,
              home: SplashScreen());
        });
  }
}
