import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/auth/shope_owner.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_in_view.dart';
import 'package:local_supper_market/screen/shop_owner/auth/view/shop_sign_in_view.dart';

class OnBoardingController extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  Future<void> initState(context) async {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (currentIndex < 3) {
        currentIndex++;
        pageController.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        currentIndex = 3;
      }
    });
  }

  void onPageChanged(index) {
    currentIndex = index;
    notifyListeners();
  }

  void onSkipPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CustomerSignInView()));
  }

  void onShopOwnerBtnPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShopSignInView()));
  }

  void onCustomerBtnPressed(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CustomerSignInView()));
  }
}