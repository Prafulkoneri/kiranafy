import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/controller/profile_controller.dart';
import 'package:local_supper_market/screen/customer/cart/controller/cart_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/controller/all_shop_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MainScreenView extends StatefulWidget {
  final bool? isRefresh;
  final Widget? screenName;
  final int? index;
  const MainScreenView({Key? key, this.isRefresh, this.screenName, this.index})
      : super(key: key);

  @override
  _MainScreenViewState createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileController>().initState(context,true);
      context.read<AllShopController>().initState(context, true);
      context.read<CartListController>().initState(context);
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<MainScreenController>()
          .initState(context, widget.index, widget.screenName);
    });
  }
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final read = context.read<MainScreenController>();
    final watch = context.watch<MainScreenController>();
    final cartWatch = context.watch<CartListController>();

    return Scaffold(
      extendBody: true,
      bottomNavigationBar:!watch.hideBottomNavigation?
      Container(
          height: 81.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.w),
                topLeft: Radius.circular(30.w)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 2),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
            child: BottomAppBar(
              child: Container(
                padding: EdgeInsets.only(left: 35.w, right: 35.w, top: 16.w),
                height: 70.w,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        read.onHomeScreenPressed();
                      },
                      child: watch.currentTab == 0
                          ? Container(
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              color: Colors.transparent,
                              child: Column(
                                children: [
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
                                    "Home",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                        color: CouponsText),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              color: Colors.transparent,
                              child: Column(
                                children: [
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
                                    "Home",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                        color: Black1),
                                  )
                                ],
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        read.onShopPressed();
                      },
                      child: watch.currentTab == 1
                          ? Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Column(
                                children: [
                                  Container(
                                    height: 20.w,
                                    width: 21.w,
                                    child: SvgPicture.asset(
                                      "assets/icons/selected_shop_new.svg",
                                      height: 20.w,
                                      width: 20.w,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Text(
                                    "Shop",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                        color: CouponsText),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Column(
                                children: [
                                  Container(
                                    height: 20.w,
                                    width: 21.w,
                                    child: SvgPicture.asset(
                                        "assets/icons/shop_new.svg"),
                                  ),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Text(
                                    "Shop",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                        color: Black1),
                                  )
                                ],
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        read.onMyCartPressed();
                      },
                      child: watch.currentTab == 2
                          ? badges.Badge(
                              badgeContent: Text(
                                cartWatch.cartList?.length.toString() ?? "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              badgeStyle: badges.BadgeStyle(
                                  badgeColor: Color(0xffFE7062)),
                              position: badges.BadgePosition.topEnd(
                                  top: -10, end: -8),
                              showBadge: true,
                              child: Container(
                                color: Colors.transparent,
                                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 20.w,
                                      width: 21.w,
                                      child: SvgPicture.asset(
                                        "assets/icons/cart_selected.svg",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.w,
                                    ),
                                    Text(
                                      "Cart",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp,
                                          color: CouponsText),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Column(
                                children: [
                                  badges.Badge(
                                    badgeContent: Text(
                                      cartWatch.cartList?.length.toString() ??
                                          "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    badgeStyle: badges.BadgeStyle(
                                        badgeColor: Color(0xffFE7062)),
                                    position: badges.BadgePosition.topEnd(
                                        top: -10, end: -8),
                                    showBadge: true,
                                    child: Container(
                                      height: 20.w,
                                      width: 21.w,
                                      child: SvgPicture.asset(
                                        "assets/icons/cart.svg",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Text(
                                    "Cart",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.sp,
                                        color: Black1),
                                  )
                                ],
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        read.onOfferPressed();
                      },
                      child: watch.currentTab == 3
                          ? Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Column(
                                children: [
                                  Container(
                                    height: 20.w,
                                    width: 21.w,
                                    child: SvgPicture.asset(
                                      "assets/icons/offers.svg",
                                      color: CouponsText,
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
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Column(
                                children: [
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
                                        fontSize: 11.sp),
                                  )
                                ],
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        read.onAccountPressed();
                      },
                      child: watch.currentTab == 4
                          ? Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Column(
                                children: [
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
                              color: Colors.transparent,
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Column(
                                children: [
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
                                        fontSize: 11.sp),
                                  )
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          )):Container(),
      body:watch.currentScreen
      // Stack(
      //   children: [
      //     Navigator(
      //       key: navigatorKey,
      //       onGenerateRoute: (RouteSettings settings) {
      //         return MaterialPageRoute(
      //           builder: (BuildContext context) => watch.currentScreen,
      //         );
      //       },
      //     ),
      //   ],
      // ),

    );
  }
}
