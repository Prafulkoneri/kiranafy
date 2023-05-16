import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/shop_registration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends ChangeNotifier {
  Future<void> initState(context) async {
    Timer(Duration(seconds: 3), () async{

      SharedPreferences pref=await SharedPreferences.getInstance();
      if(pref.getString("kycStatus")!=null){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SKycVerificationView()));
      }
      else if(pref.getString("mobileNo")!=null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ShopRegistrationView()));
      }
      else if(pref.getString("sucessToken").toString()!=null){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => MainScreenView()));
      }
      else{
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnBoardingScreenView()));
      }
    });
  }
}
