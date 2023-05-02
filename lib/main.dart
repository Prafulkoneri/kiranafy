import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/screen/account/view/controller/profile_controller.dart';
import 'package:local_supper_market/screen/account/view/profile_view.dart';
import 'package:local_supper_market/screen/delivery_address/view/my_delivery_address.dart';
import 'package:local_supper_market/screen/notifications/view/notification_view.dart';
import 'package:local_supper_market/screen/on_boarding/controller/on_boarding_controller.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/splash/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainScreenController()),
        ChangeNotifierProvider(create: (_) => OnBoardingController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
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
              home: ProfileScreenView());
        });
  }
}
