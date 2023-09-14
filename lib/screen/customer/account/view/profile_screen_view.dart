import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
import 'package:local_supper_market/screen/customer/update_profile/view/update_profile_view.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/utils/maps/view/map_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../products/views/product_screen_view.dart';
import 'package:provider/provider.dart';

// import '../controller/profile_controller.dart';

class ProfileScreenView extends StatefulWidget {
  final bool ? isRefreshed;
  const ProfileScreenView({super.key,required this.isRefreshed});

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileController>().initState(context,widget.isRefreshed);
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
          return false;
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
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
                                  onTap: () {
                                    // Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateProfileView()));
                                    readMain.onNavigation(4,UpdateProfileView(), context);
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
                            Row(
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
                  readMain.onNavigation(4,UpdateProfileView(), context);

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
                      Text(
                        'Edit Profile',
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
              /////////////
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, MyOrderView(), context);

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
                      Text(
                        'My Orders',
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
                  readMain.onNavigation(4, CustomerNotificationsScreenView(), context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 4,
                  //           screenName: CustomerNotificationsScreenView())),
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
                        'assets/icons/notification.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      Text(
                        'Notifications',
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

              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4,CFavouritesView(), context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 4, screenName: CFavouritesView())),
                  //   (Route<dynamic> route) => true,
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
                        'assets/icons/favourites.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      Text(
                        'Favourites',
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

              /////////////////////

              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, MyDeliveryAddressView(isRefresh: true), context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 4,
                  //           screenName:
                  //               MyDeliveryAddressView(isRefresh: true))),
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
                      Text(
                        'My Delivery Addresses',
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
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, HelpCenterView(), context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 4, screenName: HelpCenterView())),
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
                        'assets/icons/customersupport.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Text(
                        'Customer Support',
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
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, CAboutUsView(), context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 4, screenName: CAboutUsView())),
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
                        'assets/icons/aboutus.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      Text(
                        'About Us',
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
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, CustomerFAQView(), context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 4, screenName: CustomerFAQView())),
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
                        'assets/icons/faq.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      Text(
                        'FAQ',
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
              GestureDetector(
                onTap: () {
                  Share.share(
                      'hey! check out this new app https://play.google.com/store/apps/details?id=com.lsm.local_supper_market&hl=en&gl=US');
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
                      Text(
                        'Share App',
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
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, CustomerPrivacyPolicy(), context);
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
                      Text(
                        'Privacy Policy',
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
              // Container(
              // margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              // padding: EdgeInsets.only(bottom: 15.w),
              // decoration: BoxDecoration(
              //   border: Border(
              //     bottom: BorderSide(width: 1, color: grey10),
              //   ),
              //   // color: Colors.white,
              // ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     SvgPicture.asset(
              //       'assets/icons/rateus.svg',
              //       // width: 14.w,
              //       // height: 13.h,
              //     ),
              //     SizedBox(
              //       width: 18.w,
              //     ),
              //     Text(
              //       'Rate Us',
              //       style: GoogleFonts.dmSans(
              //         textStyle: TextStyle(
              //             color: Black,
              //             fontSize: 14.sp,
              //             fontWeight: FontWeight.w400),
              //       ),
              //     ),
              //   ],
              // ),
              // ),
              GestureDetector(
                onTap: () async {
                  if (await canLaunch(
                      "https://play.google.com/store/apps/details?id=com.lsm.local_supper_market&hl=en-IN")) {
                    await launch(
                        "https://play.google.com/store/apps/details?id=com.lsm.local_supper_market&hl=en-IN");
                  } else {
                    throw 'Could not launch https://play.google.com/store/apps/details?id=com.lsm.local_supper_market&hl=en-IN';
                  }
                  LaunchReview.launch(
                      androidAppId: "com.lsm.local_supper_market&hl=en&gl=US",
                      iOSAppId: "585027354");
                  // StoreRedirect.redirect(
                  //   androidAppId: "com.lsm.local_supper_market&hl=en&gl=US",
                  //   iOSAppId: "585027354",
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
                        'assets/icons/rateus.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      Text(
                        'Rate Us',
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
              GestureDetector(
                onTap: () async {
                  readMain.onNavigation(4, CustomerSetting(), context);
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
              ),
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
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
