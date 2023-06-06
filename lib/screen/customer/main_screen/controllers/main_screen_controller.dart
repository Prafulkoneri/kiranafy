import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/customer/cart/view/cart_screen_view.dart';
import 'package:local_supper_market/screen/customer/coupons/couponsall.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';

import '../../account/view/account_view.dart';
import '../../near_shops/view/all_near_shops_view.dart';

class MainScreenController extends ChangeNotifier {
  int currentIndex = 0;
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreenView(refreshPage: true,);

  void initState(context,index,currentScreen){
    navigation(index,currentScreen);
  }

  void onBottomNavChanged(index) {
    currentIndex = index;
    notifyListeners();
  }

  // void onFabIconPressed() {
  //   currentTab = 4;
  //   currentScreen=ChatListScreenView();
  //   print(currentIndex);
  //   notifyListeners();
  // }

  void onHomeScreenPressed() {
    currentTab = 0;
    currentScreen = HomeScreenView(refreshPage: false,);
    notifyListeners();
  }

  void onShopPressed() {
    currentTab = 1;
    currentScreen = AllNearShopsView(refreshPage:false,);
    notifyListeners();
  }

  void onMyCartPressed() {
    currentTab = 2;
    currentScreen = CartScreenView();
    notifyListeners();
  }

  void onOfferPressed() {
    currentTab = 3;
    currentScreen = AllCoupons();
    notifyListeners();
  }

  void onAccountPressed() {
    currentTab = 4;
    currentScreen = ProfileScreenView();
    notifyListeners();
  }

  Future<void> navigation(tabIndex,screenName)async{
    print("${tabIndex}tabIndex");
    currentTab=tabIndex;
    currentScreen=screenName;
    notifyListeners();
  }



}
