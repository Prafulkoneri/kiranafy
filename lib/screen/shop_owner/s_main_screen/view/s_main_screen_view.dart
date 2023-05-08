import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';

import 'package:provider/provider.dart';

class SMainScreenView extends StatefulWidget {
  const SMainScreenView({Key? key}) : super(key: key);

  @override
  _SMainScreenViewState createState() => _SMainScreenViewState();
}

class _SMainScreenViewState extends State<SMainScreenView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final read = context.read<SMainScreenController>();
    final watch = context.watch<SMainScreenController>();
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
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
                padding: EdgeInsets.only(left: 21.w, right: 25.w, top: 16.w),
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
                          ? Column(
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
                            "Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                                color: CouponsText),
                          )
                        ],
                      )
                          : Column(
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
                            "Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                                color: Black1),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            read.onOrdersPressed();
                          },
                          child: watch.currentTab == 1
                              ? Column(
                            children: [
                              Container(
                                height: 20.w,
                                width: 21.w,
                                child: SvgPicture.asset(
                                  "assets/icons/orders_selected.svg",
                                  height: 20.w,
                                  width: 20.w,
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
                          )
                              : Column(
                            children: [
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
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            read.onPaymentPressed();
                          },
                          child: watch.currentTab == 2
                              ? Column(
                            children: [
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
                          )
                              : Column(
                            children: [
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
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        read.onOfferPressed();
                      },
                      child: watch.currentTab == 3
                          ? Column(
                        children: [
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
                      )
                          : Column(
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
                    GestureDetector(
                      onTap: () {
                        read.onAccountPressed();
                      },
                      child: watch.currentTab == 4
                          ? Column(
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
                      )
                          : Column(
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
                  ],
                ),
              ),
            ),
          )),
      body: PageStorage(
        bucket: watch.bucket,
        child: watch.currentScreen,
      ),
    );
  }
}
