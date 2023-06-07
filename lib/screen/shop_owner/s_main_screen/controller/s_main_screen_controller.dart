import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';

import 'package:local_supper_market/screen/customer/cart/view/cart_screen_view.dart';
import 'package:local_supper_market/screen/customer/coupons/couponsall.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';


import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_order_status_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/views/s_payment_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';

class SMainScreenController extends ChangeNotifier {
  int currentIndex = 0;
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = ShopDashBoard();

  void initState(context,index,currentScreen){
    onBackPressed(index,currentScreen);
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
    currentScreen = ShopDashBoard();
    notifyListeners();
  }



  void onCategoryPressed(context){
   currentIndex=0;
   currentScreen=SSCategoryListView();
   notifyListeners();
  }

  void onCategoryAddPressed(){
    currentIndex=0;
    currentScreen=SSelectCategoryView();
    notifyListeners();
  }

  void onCategorySelectUpdatePressed(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>SMainScreenView()));
    currentIndex=0;
    currentScreen=SSCategoryListView();
    notifyListeners();
  }

  void onOrdersPressed() {
    currentTab = 1;
    currentScreen = SOrderStatusView();
    notifyListeners();
  }

  void onPaymentPressed() {
    currentTab = 2;
    currentScreen = SPaymentsView();
    notifyListeners();
  }

  void onOfferPressed() {
    currentTab = 3;
    currentScreen = Center(
      child: Text("Offers"),
    );
    notifyListeners();
  }

  void onAccountPressed() {
    currentTab = 4;
    currentScreen = SAccountScreenView();
    notifyListeners();
  }

  Future<void> onBackPressed(tabIndex,screenName)async{
    currentTab=tabIndex;
    currentScreen=screenName;
    notifyListeners();
  }
  void onNavigation(tabIndex,screenName,context){
    print("hello");
    print(screenName);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SMainScreenView()));
    currentTab=tabIndex;
    currentScreen=screenName;
    notifyListeners();
  }
}
