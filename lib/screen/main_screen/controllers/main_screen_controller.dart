import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/Home/category.dart';
import 'package:local_supper_market/screen/Home/home_screen.dart';
import 'package:local_supper_market/screen/Home/offers.dart';
import 'package:local_supper_market/screen/cart/cart_screen.dart';
import 'package:local_supper_market/screen/coupons/couponsall.dart';
import 'package:local_supper_market/screen/shop_profile/offer_products.dart';
import '../../near_shops/all_near_shops.dart';

class MainScreenController extends ChangeNotifier {
  int currentIndex = 0;
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

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
    currentScreen = HomeScreen();
    notifyListeners();
  }

  void onShopPressed() {
    currentTab = 1;
    currentScreen = AllNearShops();
    notifyListeners();
  }

  void onMyCartPressed() {
    currentTab = 2;
    currentScreen = CartScreen();
    notifyListeners();
  }

  void onOfferPressed() {
    currentTab = 3;
    currentScreen = AllCoupons();
    notifyListeners();
  }

  void onAccountPressed() {
    currentTab = 4;
    currentScreen = Center(
      child: Text("Accounts"),
    );
    notifyListeners();
  }
}
