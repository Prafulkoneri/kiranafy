import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/view/customer_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/s_account_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/view/s_coupons_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/view/s_edit_profile_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/utils/maps/map_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class SAccountScreenView extends StatefulWidget {
  const SAccountScreenView({super.key});

  @override
  State<SAccountScreenView> createState() => _SAccountScreenViewState();
}

class _SAccountScreenViewState extends State<SAccountScreenView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SAccountScreenController>()
          .initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SAccountScreenController>();
    final watch = context.watch<SAccountScreenController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          isBackButtonEnabled: false,
          title: "Profile",
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: 10.w, top: 10.w, right: 20.w, bottom: 0.w),
              decoration: BoxDecoration(
                color: Color(0xff44B8CA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: <Color>[
                            kappbar.withOpacity(0.55),
                            kstatusbar.withOpacity(0.98),
                          ]),
                    ),
                    padding: EdgeInsets.only(
                        left: 10.w, bottom: 9, right: 20.w, top: 10.w),
                    child: Row(
                      children: [
                        Container(
                          height: 80.w,
                          width: 80.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.w),
                              border: Border.all(
                                width: 2.w,
                                color: Colors.white,
                              )),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13.w),
                            child: watch.shopImage == ""
                                ? Image.asset(
                                    'assets/images/profile_image.png',
                                    fit: BoxFit.cover,
                                  )
                                : AppNetworkImages(
                                    imageUrl: watch.shopImage,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${watch.name}",
                                      // "Rachel Green",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            // letterSpacing: .5,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SMainScreenView(
                                                  index: 0,
                                                  screenName: SEditProfileView(
                                                    fromDashBoard: false,
                                                  ),
                                                )),
                                        (Route<dynamic> route) => false,
                                      );
                                      // Navigator.push(©
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             SEditProfileView()));
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
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${watch.shopOwnerName}",
                                      // "Rachel Green",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   "${watch.email}",
                                  // style: GoogleFonts.dmSans(
                                  //   textStyle: TextStyle(
                                  //       color: Black,
                                  //       fontSize: 15.sp,
                                  //       fontWeight: FontWeight.w400),
                                  // ),
                                  // ),
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
                  Container(
                    padding: EdgeInsets.only(left: 10.w, bottom: 3, top: 3.w),
                    child: Row(
                      children: [
                        Text(
                          'Shop KYC Pending',
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        SvgPicture.asset(
                          'assets/icons/ok.svg',
                          width: 14.w,
                          height: 14.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SMainScreenView(
                          index: 0,
                          screenName: SShopConfigurationView(
                            initialShopConfigration: false,
                          ))),
                  (Route<dynamic> route) => false,
                );
                // read.onShopConfigurationClicked(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 27.w, top: 20, right: 28.w),
                padding: EdgeInsets.only(bottom: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: grey10),
                  ),
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
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    // Text(
                    //   'Shop Configuration Setting',
                    // style: GoogleFonts.dmSans(
                    //   textStyle: TextStyle(
                    //       color: Black,
                    //       fontSize: 14.sp,
                    //       fontWeight: FontWeight.w400),
                    // ),
                    // ),
                    Flexible(
                      child: Text(
                        "Shop Configuration Setting",
                        // "Rachel Green",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ////////////////////////
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SMainScreenView(
                          index: 4,
                          screenName: CustomerListView(
                            isRefresh: true,
                          ))),
                  (Route<dynamic> route) => false,
                );
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
                      'assets/icons/list.svg',
                      // width: 14.w,
                      // height: 13.h,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Flexible(
                      child: Text(
                        'Customers List',
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ///////////////////////
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SMainScreenView(
                          index: 4, screenName: ShopCouponsView())),
                  (Route<dynamic> route) => false,
                );
                // read.onShopConfigurationClicked(context);
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
                      'assets/icons/coupons.svg',
                      // width: 14.w,
                      // height: 13.h,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    // Text(
                    //   'Coupons & Offers',
                    //   style: GoogleFonts.dmSans(
                    //     textStyle: TextStyle(
                    //         color: Black,
                    //         fontSize: 14.sp,
                    //         fontWeight: FontWeight.w400),
                    //   ),
                    // ),
                    Flexible(
                      child: Text(
                        "Coupons & Offers",
                        // "Rachel Green",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
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
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Flexible(
                    child: Text(
                      "Recommended & Seasonal Products",
                      // "Rachel Green",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  // Text(
                  //   'Recommended & Seasonal Products',
                  //   style: GoogleFonts.dmSans(
                  //     textStyle: TextStyle(
                  //         color: Black,
                  //         fontSize: 14.sp,
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),
                ],
              ),
            ),
            /////////////////////
            GestureDetector(
              onTap: () {},
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
                      'assets/icons/ads.svg',
                      // width: 14.w,
                      // height: 13.h,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Flexible(
                      child: Text(
                        "Ads & Promotions",
                        // "Rachel Green",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    // Text(
                    //   'Ads & Promotions',
                    //   style: GoogleFonts.dmSans(
                    //     textStyle: TextStyle(
                    //         color: Black,
                    //         fontSize: 14.sp,
                    //         fontWeight: FontWeight.w400),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SSubscriptionScreenView(loggedIn:true,)));
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
                      'assets/icons/subscription.svg',
                      // width: 14.w,
                      // height: 13.h,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Flexible(
                      child: Text(
                        "My Subscription",
                        // "Rachel Green",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    // Text(
                    //   'My Subscription',
                    //   style: GoogleFonts.dmSans(
                    //     textStyle: TextStyle(
                    //         color: Black,
                    //         fontSize: 14.sp,
                    //         fontWeight: FontWeight.w400),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SMainScreenView(
                          index: 4,
                          screenName: MapView())),
                      (Route<dynamic> route) => false,
                );
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
                      'assets/icons/bank.svg',
                      // width: 14.w,
                      // height: 13.h,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Flexible(
                      child: Text(
                        "Bank A/C Details",
                        // "Rachel Green",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    // Text(
                    //   'Bank A/C Details',
                    //   style: GoogleFonts.dmSans(
                    //     textStyle: TextStyle(
                    //         color: Black,
                    //         fontSize: 14.sp,
                    //         fontWeight: FontWeight.w400),
                    //   ),
                    // ),
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
                    'assets/icons/payment.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Flexible(
                    child: Text(
                      "Payments",
                      // "Rachel Green",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  // Text(
                  //   'Payments',
                  //   style: GoogleFonts.dmSans(
                  //     textStyle: TextStyle(
                  //         color: Black,
                  //         fontSize: 14.sp,
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),
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
                    'assets/icons/support.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Flexible(
                    child: Text(
                      "Reports",
                      // "Rachel Green",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  // Text(
                  //   'Reports',
                  //   style: GoogleFonts.dmSans(
                  //     textStyle: TextStyle(
                  //         color: Black,
                  //         fontSize: 14.sp,
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),
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
                    'assets/icons/help.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Flexible(
                    child: Text(
                      "Help & Support",
                      // "Rachel Green",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  // Text(
                  //   'Help & Support',
                  //   style: GoogleFonts.dmSans(
                  //     textStyle: TextStyle(
                  //         color: Black,
                  //         fontSize: 14.sp,
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),
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
                    'assets/icons/notification.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Flexible(
                    child: Text(
                      'Notification',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 35.w, right: 28.w, top: 16.w),
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
                  Flexible(
                    child: Text(
                      'Settings',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                read.onLogout(context);
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
                      'assets/icons/signout.svg',
                      // width: 14.w,
                      // height: 13.h,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Flexible(
                      child: Text(
                        'Sign Out',
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
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
