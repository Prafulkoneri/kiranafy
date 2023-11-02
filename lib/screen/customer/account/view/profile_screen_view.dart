import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launch_review/launch_review.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/about_us/view/c_about_us_view.dart';
import 'package:local_supper_market/screen/customer/about_us/view/c_privacy_policy.dart';
import 'package:local_supper_market/screen/customer/account/controller/profile_controller.dart';
import 'package:local_supper_market/screen/customer/account/view/c_faq_view.dart';
import 'package:local_supper_market/screen/customer/c_setting/view/c_setting_view.dart';
import 'package:local_supper_market/screen/customer/delivery_address/view/my_delivery_address.dart';
import 'package:local_supper_market/screen/customer/favourites/view/favourites_view.dart';
import 'package:local_supper_market/screen/customer/help_center/view/help_center_view.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
import 'package:local_supper_market/screen/customer/my_vouchers/view/my_vouchers_view.dart';
import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
import 'package:local_supper_market/screen/customer/ref_and_earn/controller/ref_and_earn_controller.dart';
import 'package:local_supper_market/screen/customer/ref_and_earn/view/refer_and_earn_view.dart';
import 'package:local_supper_market/screen/customer/update_profile/view/update_profile_view.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:provider/provider.dart';

// import '../controller/profile_controller.dart';

class ProfileScreenView extends StatefulWidget {
  final bool? isRefreshed;
  const ProfileScreenView({super.key, required this.isRefreshed});

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileController>().initState(context, widget.isRefreshed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<ProfileController>();
    final watch = context.watch<ProfileController>();
    final readMain = context.read<MainScreenController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          isBackButtonEnabled: false,
          title: "Profile",
          onActionTap: () {},
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          readMain.onNavigation(0, HomeScreenView(refreshPage: false), context);
          return false;
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Text(
              //     watch.referAndEarnCouponDetails?.discountAmount??"null"),
              Container(
                margin: EdgeInsets.only(
                    left: 14.w, right: 14.w, top: 20.w, bottom: 0.w),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
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
                          child:
                              watch.customerData?.customerProfileImagePath == ""
                                  ? Image.asset(
                                      'assets/images/profile_image.png',
                                      fit: BoxFit.cover,
                                    )
                                  : AppNetworkImages(
                                      imageUrl: watch.customerData
                                              ?.customerProfileImagePath ??
                                          "",
                                      fit: BoxFit.cover,
                                    ),
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
                                  "${watch.customerData?.customerName}",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    if (pref.getString("status") ==
                                        "guestLoggedIn") {
                                      Utils().showLoginDialog(
                                          context, "Please Login to continue");
                                      return;
                                    }
                                    // Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateProfileView()));
                                    readMain.onNavigation(
                                        4, const UpdateProfileView(), context);
                                    // Navigator.pushAndRemoveUntil(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => MainScreenView(
                                    //           index: 4,
                                    //           screenName: UpdateProfileView())),
                                    //   (Route<dynamic> route) => false,
                                    // );
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/edit.svg',
                                    width: 14.w,
                                    height: 14.h,
                                  ),
                                ),
                              ],
                            ),
                            watch.customerData?.customerEmail != null
                                ? SizedBox(
                                    height: 7.2.h,
                                  )
                                : Container(),
                            watch.customerData?.customerEmail != null
                                ? Row(
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
                                      watch.customerData?.customerEmail != ""
                                          ? Text(
                                              watch.customerData
                                                      ?.customerEmail ??
                                                  "",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    // decoration:
                                                    // TextDecoration.lineThrough,
                                                    color: Black,
                                                    // letterSpacing:
                                                    //     .5,
                                                    fontSize: 15.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                    // ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 11.h,
                            ),
                            watch.customerData?.customerMobileNumber != 0
                                ? Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/call.svg',
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        '${watch.customerData?.customerCountryCode} ${watch.customerData?.customerMobileNumber}',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                    // ),
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  if (pref.getString("status") == "guestLoggedIn") {
                    Utils()
                        .showLoginDialog(context, "Please Login to continue");
                    return;
                  }
                  readMain.onNavigation(4, const UpdateProfileView(), context);

                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 4, screenName: UpdateProfileView())),
                  //   (Route<dynamic> route) => false,
                  // );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 20.w),
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
                        width: 5.w,
                      ),
                      SvgPicture.asset(
                        'assets/icons/edit2.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'Edit Profile',
                      ),
                    ],
                  ),
                ),
              ),
              /////////////
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  if (pref.getString("status") == "guestLoggedIn") {
                    Utils()
                        .showLoginDialog(context, "Please Login to continue");
                    return;
                  }
                  readMain.onNavigation(4, const MyOrderView(), context);

                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 4, screenName: MyOrderView())),
                  //   (Route<dynamic> route) => false,
                  // );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 20.w),
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
                      SvgPicture.asset(
                        'assets/icons/myorders.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'My Orders',
                      ),
                    ],
                  ),
                ),
              ),
              ///////////////////////
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(
                      4, const CustomerNotificationsScreenView(), context);
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
                      SvgPicture.asset(
                        'assets/icons/notification.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'Notifications',
                      ),
                    ],
                  ),
                ),
              ),
              ///////////////////////////////////////////////////////////
              // GestureDetector(
              //   onTap: () {
              //     readMain.onNavigation(4, const MyVouchersView(), context);
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              //     padding: EdgeInsets.only(bottom: 15.w),
              //     decoration: BoxDecoration(
              //       border: Border(
              //         bottom: BorderSide(width: 1, color: grey10),
              //       ),
              //       // color: Colors.white,
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         SvgPicture.asset(
              //           'assets/icons/voucher.svg',
              //           // width: 14.w,
              //           // height: 13.h,
              //         ),
              //         SizedBox(
              //           width: 18.w,
              //         ),
              //         AccountScreen(
              //           text: 'My Vouchers',
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              ////////////////////////////////////////////////////////////
              // GestureDetector(
              //   onTap: () {
              //     readMain.onNavigation(
              //         4, ReferAndEarnView(isRefreshed: true), context);
              //     // read.getReferAndEarnDetails(context);
              //   },
              //   child: Container(
              //     margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              //     padding: EdgeInsets.only(bottom: 15.w),
              //     decoration: BoxDecoration(
              //       border: Border(
              //         bottom: BorderSide(width: 1, color: grey10),
              //       ),
              //       // color: Colors.white,
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         SvgPicture.asset(
              //           'assets/icons/refer.svg',
              //           // width: 14.w,
              //           // height: 13.h,
              //         ),
              //         SizedBox(
              //           width: 18.w,
              //         ),
              //         AccountScreen(
              //           text: 'Refer & Earn',
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
///////////////////////////////////////////////////////////////////
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  if (pref.getString("status") == "guestLoggedIn") {
                    Utils()
                        .showLoginDialog(context, "Please Login to continue");
                    return;
                  }
                  readMain.onNavigation(
                      4, const CFavouritesView(selectedIndex: 0), context);
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
                      SvgPicture.asset(
                        'assets/icons/favourites.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'Favourites',
                      ),
                    ],
                  ),
                ),
              ),

              /////////////////////

              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  if (pref.getString("status") == "guestLoggedIn") {
                    Utils()
                        .showLoginDialog(context, "Please Login to continue");
                    return;
                  }
                  readMain.onNavigation(
                      4, const MyDeliveryAddressView(isRefresh: true), context);
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
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/address.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      AccountScreen(
                        text: 'My Delivery Addresses',
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  if (pref.getString("status") == "guestLoggedIn") {
                    Utils()
                        .showLoginDialog(context, "Please Login to continue");
                    return;
                  }
                  readMain.onNavigation(4, const HelpCenterView(), context);
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
                      SvgPicture.asset(
                        'assets/icons/customersupport.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      AccountScreen(
                        text: 'Customer Support',
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, const CAboutUsView(), context);
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
                      SvgPicture.asset(
                        'assets/icons/aboutus.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'About Us',
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, const CustomerFAQView(), context);
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
                      SvgPicture.asset(
                        'assets/icons/faq.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'FAQ',
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (Platform.isAndroid) {
                    Share.share(
                        'Find your nearby Kirana Store here and shop online, download the Local Supermart app now https://play.google.com/store/apps/details?id=com.lsm.local_supper_market&hl=en&gl=US');
                  } else {
                    Share.share(
                        'Find your nearby Kirana Store here and shop online, download the Local Supermart app now https://apps.apple.com/us/app/local-supermart/id6451146831');
                  }
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
                      SvgPicture.asset(
                        'assets/icons/share.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'Share App',
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(
                      4, const CustomerPrivacyPolicy(), context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 4, screenName: CustomerPrivacyPolicy())),
                  //   (Route<dynamic> route) => false,
                  // );
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
                      SvgPicture.asset(
                        'assets/icons/policy.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'Privacy Policy',
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  LaunchReview.launch(
                      androidAppId: "com.lsm.local_supper_market&hl=en&gl=US",
                      iOSAppId: "6451146831");
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
                      SvgPicture.asset(
                        'assets/icons/rateus.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'Rate Us',
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  if (pref.getString("status") == "guestLoggedIn") {
                    Utils()
                        .showLoginDialog(context, "Please Login to continue");
                    return;
                  }
                  readMain.onNavigation(4, const CustomerSetting(), context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 4, screenName: CustomerSetting())),
                  //   (Route<dynamic> route) => false,
                  // );
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
                      SvgPicture.asset(
                        'assets/icons/setting.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'Settings',
                      ),
                    ],
                  ),
                ),
              ),
              // watch.isGuestLogin
              //     ? Container()
              //     :
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  readMain.onSignOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnBoardingScreenView()),
                  );
                  // read.customerSignOut(context);
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
                      SvgPicture.asset(
                        'assets/icons/signout.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      AccountScreen(
                        text: 'Sign Out',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 90.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
