import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/s_account_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';


import 'package:provider/provider.dart';



class SAccountScreenView extends StatefulWidget {
  const SAccountScreenView({super.key});

  @override
  State<SAccountScreenView> createState() => _SAccountScreenViewState();
}

class _SAccountScreenViewState extends State<SAccountScreenView> {
  @override
  Widget build(BuildContext context) {
 final read=context.read<SAccountScreenController>();
 final watch=context.watch<SAccountScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Profile",
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: 14.w, right: 14.w, top: 20.w, bottom: 24.w),
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
                                "Rachel Green",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black1,
                                      // letterSpacing: .5,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  read.onEditBtnClicked(context);
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/edit.svg',
                                  width: 14.w,
                                  height: 14.h,
                                ),
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
                              SvgPicture.asset(
                                'assets/icons/email.svg',
                                width: 17.w,
                                height: 13.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'designtest@gmail.com',
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
                          Row(
                            // crossAxisAlignment:
                            //     CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/call.svg',
                                // width: 14.w,
                                // height: 13.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                '+91 55555 55555',
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                            // ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
   read.onShopConfigurationClicked(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 27.w, right: 28.w),
                padding: EdgeInsets.only(bottom: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: grey10),
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
                      'assets/icons/profile.svg',
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
            ////////////////////////
            GestureDetector(
              onTap: () {

              },
              child: Container(
                margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
                padding: EdgeInsets.only(bottom: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: grey10),
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
                      'assets/icons/myorders.svg',
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
            ),
            ///////////////////////
            GestureDetector(
              onTap: () {

              },
              child: Container(
                margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
                padding: EdgeInsets.only(bottom: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: grey10),
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
            ),
            ////////////////////
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: grey10),
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
                    'assets/icons/favourites.svg',
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

              },
              child: Container(
                margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
                padding: EdgeInsets.only(bottom: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: grey10),
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
                      'assets/icons/address.svg',
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
                  bottom: BorderSide(width: 1, color: grey10),
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
                    'assets/icons/customersupport.svg',
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
                  bottom: BorderSide(width: 1, color: grey10),
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
                    'assets/icons/aboutus.svg',
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
                  bottom: BorderSide(width: 1, color: grey10),
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
                    'assets/icons/share.svg',
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
                  bottom: BorderSide(width: 1, color: grey10),
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
                    'assets/icons/policy.svg',
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
                  bottom: BorderSide(width: 1, color: grey10),
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
                    'assets/icons/rateus.svg',
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
                  bottom: BorderSide(width: 1, color: grey10),
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
                    'assets/icons/setting.svg',
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
                  bottom: BorderSide(width: 1, color: grey10),
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
                    'assets/icons/signout.svg',
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
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: grey10),
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
                    'assets/icons/setting.svg',
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
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: grey10),
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
                    'assets/icons/signout.svg',
                    // width: 14.w,
                    // height: 13.h,
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
            SizedBox(
              height: 106.w,
            ),
          ],
        ),
      ),
    );
  }
}
