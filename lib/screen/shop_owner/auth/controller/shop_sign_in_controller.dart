import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/auth/view/shop_registration_view.dart';

class ShopSignInController extends ChangeNotifier{
  TextEditingController mobController =TextEditingController();
  void onOtpSubmitPressed(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>MainScreenView()));
  }

  void onNewShopPressed(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>ShopRegistrationView()));
  }

}