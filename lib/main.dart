import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/screen/Home/nearby_shop.dart';
import 'package:local_supper_market/screen/Home/category.dart';
import 'package:local_supper_market/screen/Home/home_screen.dart';
import 'package:local_supper_market/screen/advertisementform/advertisementform.dart';
import 'package:local_supper_market/screen/auth/customer_sign_in.dart';
import 'package:local_supper_market/screen/auth/shop_registration.dart';
import 'package:local_supper_market/screen/auth/shope_owner.dart';
import 'package:local_supper_market/screen/boarding/view/boarding_screen_view.dart';
import 'package:local_supper_market/screen/cart/cart_screen.dart';
import 'package:local_supper_market/screen/cart/empty_cart.dart';
import 'package:local_supper_market/screen/category/category.dart';
import 'package:local_supper_market/screen/coupons/couponsall.dart';
import 'package:local_supper_market/screen/delivery_view/delivery_view_pending.dart';
import 'package:local_supper_market/screen/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/my_order/my_order.dart';
import 'package:local_supper_market/screen/near_shops/all_near_shops.dart';
import 'package:local_supper_market/screen/order_summery/order_delivery_virw.dart';
import 'package:local_supper_market/screen/order_summery/order_summery.dart';
import 'package:local_supper_market/screen/shop_profile/shop_profile.dart';
import 'package:local_supper_market/screen/shop_profile/view_all_offer_products.dart';
import 'package:local_supper_market/screen/splash/splash.dart';
import 'package:provider/provider.dart';
import 'const/color.dart';
import 'screen/auth/customer_sign_up.dart';
import 'screen/auth/upload_documents.dart';
import 'screen/intro/intro_one.dart';
import 'screen/order_payment/order_payment.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainScreenController()),
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
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              home: BoardingScreenView());
        });
  }
}
