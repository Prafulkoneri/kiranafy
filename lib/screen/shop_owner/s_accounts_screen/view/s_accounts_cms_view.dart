import 'dart:io';

import 'package:launch_review/launch_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/about_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/faq_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/privacy_policy_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/terms_and_condition_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';

class SAccountCmsPagesView extends StatefulWidget {
  const SAccountCmsPagesView({super.key});

  @override
  State<SAccountCmsPagesView> createState() => _SAccountCmsPagesViewState();
}

class _SAccountCmsPagesViewState extends State<SAccountCmsPagesView> {
  @override
  Widget build(BuildContext context) {
    final readMain = context.read<SMainScreenController>();
    // final read = context.read<ProfileController>();
    // final watch = context.watch<ProfileController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "Accounts",
          onBackBtnPressed: () {
            readMain.onNavigation(
                4,
                const SAccountScreenView(
                  refresh: false,
                ),
                context);
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          readMain.onNavigation(
              4,
              const SAccountScreenView(
                refresh: false,
              ),
              context);
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, const AboutScreenView(), context);
                  readMain.hideBottomNavigationBar();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 22.w, right: 28.w, top: 16.w),
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
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/icons/about.svg',
                        // width: 14.w,
                        // height: 13.h,
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      Text(
                        'About',
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

              ////////////////////////ShopFAQView

              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, const ShopFAQView(), context);
                  readMain.hideBottomNavigationBar();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ShopFAQView()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 22.w, right: 28.w, top: 16.w),
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
                      const SizedBox(
                        width: 5,
                      ),
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
              ///////////////////////
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(4, const PrivacyPolicyView(), context);
                  readMain.hideBottomNavigationBar();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PrivacyPolicyView()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, right: 28.w, top: 16.w),
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
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/icons/privacy.svg',
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
              GestureDetector(
                onTap: () {
                  readMain.onNavigation(
                      4, const TermsAndConditionView(), context);
                  readMain.hideBottomNavigationBar();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => TermsAndConditionView()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, right: 28.w, top: 16.w),
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
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/icons/terms.svg',
                      ),
                      SizedBox(
                        width: 18.w,
                      ),
                      Text(
                        'Terms & Conditions',
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
                  if (Platform.isAndroid) {
                    Share.share(
                        'hey! check out this new app https://play.google.com/store/apps/details?id=com.kirana_fy&hl=en&gl=US');
                  } else {
                    Share.share(
                        'hey! check out this new app https://apps.apple.com/us/app/local-supermart/id6451146831');
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(left: 22.w, right: 28.w, top: 16.w),
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
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/icons/share.svg',
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
              /////Rate Us////
              GestureDetector(
                onTap: () async {
                  LaunchReview.launch(
                      androidAppId: "com.kirana_fy&hl=en&gl=US",
                      iOSAppId: "6451146831");
                },
                child: Container(
                  margin: EdgeInsets.only(left: 22.w, right: 28.w, top: 16.w),
                  padding: EdgeInsets.only(bottom: 15.w),
                  decoration: const BoxDecoration(

                      // color: Colors.white,
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/icons/star.svg',
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
            ],
          ),
        ),
      ),
    );
  }
}
