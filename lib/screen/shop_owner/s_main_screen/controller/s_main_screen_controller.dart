import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/notification/view/notification_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/view/s_coupons_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_order_status_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/view/shop_order_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/views/s_payment_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';

class SMainScreenController extends ChangeNotifier {
  int currentIndex = 0;
  int currentTab = 0;
  bool hideBottomNavigation = false;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const ShopDashBoardView(
    refresh: true,
  );

  void initState(context, index, currentScreen) {
    onBackPressed(index, currentScreen);
  }

  void onBottomNavChanged(index) {
    currentIndex = index;
    notifyListeners();
  }

  void onHomeScreenPressed() {
    currentTab = 0;
    currentScreen = const ShopDashBoardView(
      refresh: true,
    );
    notifyListeners();
  }

  void onCategoryPressed(context) {
    currentIndex = 0;
    currentScreen = const SSCategoryListView();
    notifyListeners();
  }

  void onCategoryAddPressed() {
    currentIndex = 0;
    currentScreen = const SSelectCategoryView();
    notifyListeners();
  }

  void onCategorySelectUpdatePressed(context) {
    currentIndex = 0;
    currentScreen = const SSCategoryListView();
    notifyListeners();
  }

  void onOrdersPressed() {
    currentTab = 1;
    currentScreen = const SOrderStatusView(
      selectedIndex: 0,
      isFromOrderView: false,
    );
    notifyListeners();
  }

  void onPaymentPressed() {
    currentTab = 2;
    currentScreen = const SPaymentsView(
      isNavFromAccounts: false,
    );
    notifyListeners();
  }

  void onOfferPressed() {
    currentTab = 3;
    currentScreen = const ShopCouponsView(
      isRefresh: true,
      isNavFromDashBoard: true,
    );
    notifyListeners();
  }

  void onAccountPressed() {
    currentTab = 4;
    currentScreen = const SAccountScreenView(
      refresh: true,
    );
    notifyListeners();
  }

  Future<void> onBackPressed(tabIndex, screenName) async {
    currentTab = tabIndex;
    currentScreen = screenName;
    notifyListeners();
  }

  void onNavigation(tabIndex, screenName, context) {
    currentTab = tabIndex;
    currentScreen = screenName;
    notifyListeners();
  }

  onCustomTypeNotification(context) {
    print("hello");
    currentScreen = const NotificationsScreenView(
      route: "dashboard",
    );
    currentIndex = 0;
    hideBottomNavigation = false;
    notifyListeners();
  }

  onOrderTypeNotification(context, id) {
    currentScreen = ShopOrderView(
      route: "notification",
      selectedIndex: 0,
      orderId: id.toString(),
      fromOrderStatus: true,
    );
    hideBottomNavigation = true;
    notifyListeners();
  }

/////////////////////////////
  // onVoucherTypeNotification(context, id) {
  //   print("hello");
  //   currentScreen = const NotificationsScreenView(
  //     route: "",
  //   );
  //   currentIndex = 0;
  //   hideBottomNavigation = false;
  // }

/////////////////////////////////
  showBottomNavigationBar() {
    hideBottomNavigation = false;
    notifyListeners();
  }

  hideBottomNavigationBar() {
    hideBottomNavigation = true;
    notifyListeners();
  }
}
