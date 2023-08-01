import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/bottom_navigation/controller/bottom_nav_controller.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/s_account_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/controller/shop_coupons_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/view/s_coupons_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/controller/s_dashboard_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/controller/s_order_Status_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_order_status_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/controller/payment_histaory_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/views/s_payment_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/widget/persistent_bottom_navigation/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:win32/win32.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}
PersistentTabController controller = PersistentTabController(initialIndex: 0);
class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int currentIndex = 0;


  List<Widget> _buildScreens=
     [
      ShopDashBoardView(refresh: true),
      SOrderStatusView(
        selectedIndex: 0,
        isFromOrderView: true,
      ),
      SPaymentsView(
        isNavFromAccounts: false,
      ),
      ShopCouponsView(
        isRefresh: true,
        isNavFromDashBoard: true,
      ),
      SAccountScreenView(refresh: true),
    ];




  @override
  Widget build(BuildContext context) {
    final read = context.read<SMainScreenController>();
    final readDashboard = context.read<SDashBoardController>();
    final readOrders = context.read<SOrderStatusController>();
    final readPayment = context.read<PaymentHistoryController>();
    final readOffers = context.read<SCouponsListController>();
    final readAccount = context.read<SAccountScreenController>();
    // final watch = context.watch<SMainScreenController>();
    final watch = context.watch<BottomNavigationController>();
    return Scaffold(
      extendBody: true,
      body: Container(
        child: PersistentTabView(
          onItemSelected: (index) {

            if (index==0){
              readDashboard.initState(context,true);

            }
            if(index==1){
              readOrders.initState(context,0);
            }
            if(index==2){
              readPayment.initState(context);
            }
            if(index==3){
              readOffers.initState(context,true);
            }
            if(index==4){
              readAccount.initState(context,true);
            }
          },
          navBarStyle: NavBarStyle.style15,
          navBarHeight: 81.w,
          context,
          controller:controller,
          screens: _buildScreens,
          items: [
            PersistentBottomNavBarItem(
              activeColorSecondary: CouponsText,
              inactiveColorSecondary: Colors.black,
              opacity: 0,
              iconSize: 0,
              // onPressed: (index){
              //   // setState(() {
              //   //   currentIndex=0;
              //   //   _buildScreens[]
              //   // });
              // },
              inactiveIcon:    Container(
                height: 20.w,
                width: 21.w,
                child: SvgPicture.asset(
                  "assets/icons/home.svg",
                ),
              ),
              icon: Container(
                height: 20.w,
                width: 21.w,
                child: SvgPicture.asset(
                  "assets/icons/home_selected.svg",
                ),
              ),
              title: "Dashboard",
              textStyle: TextStyle(color: Colors.black,fontSize: 11.sp),

              activeColorPrimary: CupertinoColors.activeBlue,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              activeColorSecondary: CouponsText,
              inactiveColorSecondary: Colors.black,
              title: "Orders",
              textStyle: TextStyle(color: Colors.black,fontSize: 11.sp),
              inactiveIcon:  Container(
                height: 20.w,
                width: 21.w,
                child: SvgPicture.asset("assets/icons/orders.svg"),
              ),
              icon:   Container(
                height: 20.w,
                width: 21.w,
                child: SvgPicture.asset(
                  "assets/icons/orders_selected.svg",
                  height: 20.w,
                  width: 20.w,
                ),
              ),
              activeColorPrimary: CupertinoColors.activeBlue,
              inactiveColorPrimary: CupertinoColors.systemGrey,

            ),
            PersistentBottomNavBarItem(
              activeColorSecondary: CouponsText,
              inactiveColorSecondary: Colors.black,
              title: "Payment",
              textStyle: TextStyle(color: Colors.black,fontSize: 11.sp),
              inactiveIcon:    Container(
                height: 20.w,
                width: 21.w,
                child: SvgPicture.asset(
                  "assets/icons/payments.svg",
                ),
              ),
              icon:     Container(
                height: 20.w,
                width: 21.w,
                child: SvgPicture.asset(
                  "assets/icons/payment_selected.svg",
                ),
              ),
              activeColorPrimary: CupertinoColors.activeBlue,
              inactiveColorPrimary: CupertinoColors.systemGrey,

            ),
            PersistentBottomNavBarItem(
              activeColorSecondary: CouponsText,
              inactiveColorSecondary: Colors.black,
              title: "Offers",
              textStyle: TextStyle(color: Colors.black,fontSize: 11.sp),
              inactiveIcon:  Container(
                height: 20.w,
                width: 21.w,
                child: SvgPicture.asset("assets/icons/offers.svg"),
              ),
              icon:     Container(
                height: 20.w,
                width: 21.w,
                child: SvgPicture.asset(
                  "assets/icons/offers_selected.svg",
                ),
              ),
              activeColorPrimary: CupertinoColors.activeBlue,
              inactiveColorPrimary: CupertinoColors.systemGrey,

            ),
            PersistentBottomNavBarItem(
              activeColorSecondary: CouponsText,
              inactiveColorSecondary: Colors.black,
              title: "Account",
              textStyle: TextStyle(color: Colors.black,fontSize: 11.sp),
              inactiveIcon:Row(
                children: [
                  Container(
                    height: 20.w,
                    width: 21.w,
                    child: SvgPicture.asset("assets/icons/account.svg"),
                  ),
                ],
              ),
              icon:    Row(
                children: [
                  Container(
                    height: 20.w,
                    width: 21.w,
                    child: SvgPicture.asset(
                      "assets/icons/account_selected.svg",
                      color: CouponsText,
                    ),
                  ),
                ],
              ),
              activeColorPrimary: CupertinoColors.activeBlue,
              inactiveColorPrimary: CupertinoColors.systemGrey,

            ),
          ],
          confineInSafeArea: false,
          backgroundColor: Colors.transparent,
          // Default is Colors.white.
          handleAndroidBackButtonPress: true,
          // Default is true.
          resizeToAvoidBottomInset: true,
          // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true,
          // Default is true.
          hideNavigationBarWhenKeyboardShows: true,
          // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            // borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,

          // itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          //   duration: Duration(milliseconds: 200),
          //   curve: Curves.ease,
          // ),
          // screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          //   animateTabTransition: true,
          //   curve: Curves.ease,
          //   duration: Duration(milliseconds: 200),
          // ),
          // navBarStyle: NavBarStyle.style1,
        ),
      ),
    );


  }
}
