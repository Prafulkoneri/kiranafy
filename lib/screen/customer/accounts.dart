import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';

import 'package:provider/provider.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    // final read = context.read<ProfileController>();
    // final watch = context.watch<ProfileController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Account",
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 14.w, right: 14.w, top: 20.w),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(
                //     color: Colors.black.withOpacity(0.07), width: 1),

                // gradient: LinearGradient(
                //     end: Alignment.topCenter,
                //     begin: Alignment.bottomCenter,
                //     colors: <Color>[
                //       kappbar.withOpacity(0.5),
                //       kstatusbar.withOpacity(0.99),
                //     ]),
                gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: <Color>[
                      kappbar.withOpacity(0.55),
                      kstatusbar.withOpacity(0.98),
                    ]),
              ),
              // height: 100.h,
              // width: 363.w,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 10.w, right: 20.w, top: 10.w, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/profile1.png',
                        width: 80.w,
                        height: 80.h,
                      ),
                    ),
                    SizedBox(
                      width: 17.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "New Trading Balaji Company",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black1,
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/edit.svg',
                                width: 14.w,
                                height: 14.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 7.2.h,
                          ),
                          Row(
                            // crossAxisAlignment:
                            //     CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Rohit Singh',
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      // decoration:
                                      // TextDecoration.lineThrough,
                                      color: Black,
                                      // letterSpacing:
                                      //     .5,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                            // ),
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 14.w, right: 14.w),
              decoration: BoxDecoration(
                color: Color(0xff44B8CA),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Shop KYC Approved',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SvgPicture.asset(
                      'assets/icons/ok.svg',
                      width: 14.w,
                      height: 13.h,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: () {
                // read.onEditProfilePressed(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 27.w, right: 28.w),
                padding: EdgeInsets.only(bottom: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: underline),
                  ),
                  // color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      'assets/icons/shop.svg',
                      // width: 14.w,
                      // height: 13.h,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Text(
                      'Shop Configuration Setting',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/list.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Customers List',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            ///////////////////////
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/coupons.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Coupons & Offers',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            ////////////////////

            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Recommended & Seasonal Products',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),

            /////////////////////

            GestureDetector(
              onTap: () {
                // read.myDeliveryAddressPressed(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
                padding: EdgeInsets.only(bottom: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: underline),
                  ),
                  // color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      'assets/icons/ads.svg',
                      // width: 14.w,
                      // height: 13.h,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Text(
                      'Ads & Promotions',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/subscription.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'My Subscription',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/bank.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Bank A/C Details',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/payment.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Payments',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/support.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Reports',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/help.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Help & Support',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/notification.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Notification',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/local_supermart.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      Text(
                        'Local Supermart',
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/icons/forward_arrow.svg',
                    width: 14.w,
                    height: 14.h,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/settings.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Settings',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/sign_out.svg',
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Sign Out',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
