import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/customer/account/view/account_view.dart';

import 'package:local_supper_market/screen/customer/cart/view/cart_screen_view.dart';
import 'package:local_supper_market/screen/customer/coupons/couponsall.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/all_near_shops.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';


import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_order_status_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/view/s_payment_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';

class SMainScreenController extends ChangeNotifier {
  int currentIndex = 0;
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = ShopDashBoard();

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
}
