import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_registration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ChangeNotifier {
  Future<void> initState(context) async {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      print(pref.getString("status"));
      if (pref.getString("status") == "numberRegistered") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ShopRegistrationView()));
      }
      if (pref.getString("status") == "shopRegistered") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SKycVerificationView()));
      }
      if(pref.getString("status")=="kycUploaded"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SSubscriptionScreenView(loggedIn: false)));
      }
      if(pref.getString("status")=="subscriptionCompleted"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SShopConfigurationView(initialShopConfigration:true)));
      }
      if (pref.getString("status") == "loggedIn") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SMainScreenView()));
      }
      if (pref.getString("status") == "customerLoggedIn") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreenView(
                  index: 0,
                  screenName: HomeScreenView(
                    refreshPage: true,
                  ))),
          (Route<dynamic> route) => false,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreenView()));
      }
      if (pref.getString("status") == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnBoardingScreenView()));
      }
    });
  }
}
