

import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';

class SSubscriptionController extends ChangeNotifier{
  void onMakePaymentClicked(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SMainScreenView()));
  }
}
