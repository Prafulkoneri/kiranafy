

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/view/s_coupons_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_order_status_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/views/s_payment_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/widget/persistent_bottom_navigation/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:win32/win32.dart';


class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarScreenState createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int currentIndex=0;
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      ShopDashBoardView(refresh: true),
    SOrderStatusView(
    selectedIndex: 0,
    isFromOrderView: false,
    ),
      SPaymentsView(
        isNavFromAccounts: false,
      ),
      ShopCouponsView(
        isRefresh: true,
        isNavFromDashBoard: true,
      ),
      SAccountScreenView(refresh:true),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    final watch=Provider.of<SMainScreenController>(context,listen: false);
    final read=Provider.of<SMainScreenController>(context,listen: false);
    return [
      PersistentBottomNavBarItem(
        // onPressed: (index){
        //   // setState(() {
        //   //   currentIndex=0;
        //   //   _buildScreens[]
        //   // });
        // },
        icon:_controller.index== 0
            ? Container(
          padding: EdgeInsets.only(left: 2.w,right: 2.w),
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(
                height: 14.w,
              ),
              Container(
                height: 20.w,
                width: 21.w,
                child: SvgPicture.asset(
                  "assets/icons/home_selected.svg",
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              Text(
                "Dashboard",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.sp,
                    color: CouponsText),
              )
            ],
          ),
        )
            : Container(
          padding: EdgeInsets.only(left: 2.w,right: 2.w),
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(
                height: 14.w,
              ),
              Container(
                height: 20.w,
                width: 21.w,
                child: SvgPicture.asset(
                  "assets/icons/home.svg",
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              Text(
                "Dashboard",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.sp,
                    color: Black1),
              )
            ],
          ),
        ),

        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed: (index){
          setState(() {
            currentIndex=1;
          });
        },
        icon: currentIndex==1?SvgPicture.asset(
          "assets/icons/orders_selected.svg",
          height: 20.w,
          width: 20.w,
        ):SvgPicture.asset(
          "assets/icons/orders_selected.svg",
          height: 20.w,
          width: 20.w,
          color: Colors.black,
        ),
        title: "Orders",
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final read=context.read<SMainScreenController>();
    final watch=context.watch<SMainScreenController>();
    return PersistentTabView(
      onItemSelected: (index){
      read.onBottomNavChanged(index);
       },
      navBarStyle: NavBarStyle.style15,
navBarHeight: 81.w,
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: [
        PersistentBottomNavBarItem(
          // onPressed: (index){
          //   // setState(() {
          //   //   currentIndex=0;
          //   //   _buildScreens[]
          //   // });
          // },
          icon:watch.currentIndex== 0
              ? Container(
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 14.w,
                ),
                Container(
                  height: 20.w,
                  width: 21.w,
                  child: SvgPicture.asset(
                    "assets/icons/home_selected.svg",
                  ),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  "Dashboard",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: CouponsText),
                )
              ],
            ),
          )
              : Container(
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 14.w,
                ),
                Container(
                  height: 20.w,
                  width: 21.w,
                  child: SvgPicture.asset(
                    "assets/icons/home.svg",
                  ),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  "Dashboard",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: Black1),
                )
              ],
            ),
          ),

          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: currentIndex==1?Container(
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 14.w,
                ),
                Container(
                  height: 20.w,
                  width: 21.w,
                  child: SvgPicture.asset(
                    "assets/icons/orders_selected.svg",
                    height: 20.w,
                    width: 20.w,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  "Orders",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: CouponsText),
                )
              ],
            ),
          )
              : Container(
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 14.w,
                ),
                Container(
                  height: 20.w,
                  width: 21.w,
                  child: SvgPicture.asset(
                      "assets/icons/orders.svg"),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  "Orders",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: Black1),
                )
              ],
            ),
          ),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(

          icon: watch.currentIndex==2?Container(
        padding: EdgeInsets.only(left: 2.w,right: 2.w),
    color: Colors.transparent,
    child: Column(
    children: [
      SizedBox(
        height: 14.w,
      ),
    Container(
    height: 20.w,
    width: 21.w,
    child: SvgPicture.asset(
    "assets/icons/payment_selected.svg",
    ),
    ),
    SizedBox(
    height: 5.w,
    ),
    Text(
    "Payment",
    style: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 11.sp,
    color: CouponsText),
    )
    ],
    ),
    )
        : Container(
    padding: EdgeInsets.only(left: 2.w,right: 2.w),
    color: Colors.transparent,
    child: Column(
    children: [
      SizedBox(
        height: 14.w,
      ),
    Container(
    height: 20.w,
    width: 21.w,
    child: SvgPicture.asset(
    "assets/icons/payments.svg",
    ),
    ),
    SizedBox(
    height: 5.w,
    ),
    Text(
    "Payment",
    style: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 11.sp,
    color: Black1),
    )
    ],
    ),
    ),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: watch.currentTab == 3
              ? Container(
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 14.w,
                ),
                Container(
                  height: 20.w,
                  width: 21.w,
                  child: SvgPicture.asset(
                    "assets/icons/offers_selected.svg",
                  ),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  "Offers",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: CouponsText),
                )
              ],
            ),
          )
              : Container(
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 14.w,
                ),
                Container(
                  height: 20.w,
                  width: 21.w,
                  child: SvgPicture.asset(
                      "assets/icons/offers.svg"),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  "Offers",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 11.sp),
                )
              ],
            ),
          ),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon:  watch.currentTab == 4
              ? Container(
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 14.w,
                ),
                Container(
                  height: 20.w,
                  width: 21.w,
                  child: SvgPicture.asset(
                    "assets/icons/account_selected.svg",
                    color: CouponsText,
                  ),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  "Account",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: CouponsText),
                )
              ],
            ),
          )
              : Container(
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 14.w,
                ),
                Container(
                  height: 20.w,
                  width: 21.w,
                  child: SvgPicture.asset(
                      "assets/icons/account.svg"),
                ),
                SizedBox(
                  height: 5.w,
                ),
                Text(
                  "Account",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 11.sp),
                )
              ],
            ),
          ),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
      confineInSafeArea: false,
      backgroundColor: Colors.transparent, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
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
    );
  }





}
