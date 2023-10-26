import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/ref_and_earn/controller/ref_and_earn_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RefferAndEarnView extends StatefulWidget {
  // final bool? canWork;
  const RefferAndEarnView({
    super.key,
  });

  @override
  State<RefferAndEarnView> createState() => _RefferAndEarnViewState();
}

class _RefferAndEarnViewState extends State<RefferAndEarnView> {
  // _launchInstagram() async {
  //   const nativeUrl =
  //   // "https://play.google.com/store/apps/details?id=com.lsm.local_supper_market&hl=en&gl=US";
  //   "instagram://user?username";
  //   const webUrl = "https://www.instagram.com";
  //   if (await canLaunch(nativeUrl)) {
  //     await launch(nativeUrl);
  //   } else if (await canLaunch(webUrl)) {
  //     await launch(webUrl);
  //   } else {
  //     print("can't open Instagram");
  //   }
  // }
  // final bool TargetPlatform = false;
  // Future<void> launchUrl(String url) async {
  //   final _canLaunch = await canLaunch(url);
  //   if (kIsWeb) {
  //     if (_canLaunch) {
  //       await launch(url);
  //     } else {
  //       throw "Could not launch $url";
  //     }
  //     return;
  //   }
  //   if (Platform.isAndroid) {
  //     if (url.startsWith("https://www.facebook.com/")) {
  //       final url2 = "fb://facewebmodal/f?href=$url";
  //       final intent2 = AndroidIntent(action: "action_view", data: url2);
  //       final canWork = await intent2.canResolveActivity();
  //       if (canWork == true) return intent2.launch();
  //     }
  //     final intent = AndroidIntent(action: "action_view", data: url);
  //     return intent.launch();
  //   } else {
  //     if (_canLaunch) {
  //       await launch(url, forceSafariVC: false);
  //     } else {
  //       throw "Could not launch $url";
  //     }
  //   }
  // }
  // final url = Uri.parse("https://facebook.com/profile.php?id=your_id");
  // void _launchURL(String url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // final url = Uri.parse("https://www.instagram.com/direct/new/");
  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(url)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<RefAndEarnController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final readMain = context.read<MainScreenController>();
    final read = context.read<RefAndEarnController>();
    final watch = context.read<RefAndEarnController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            // read.onBackPressed();
            readMain.onNavigation(
                4,
                const ProfileScreenView(
                  isRefreshed: false,
                ),
                context);
          },
          title: "Refer & Earn",
        ),
      ),
      body: watch.isLoading
          ? Loader()
          : WillPopScope(
              onWillPop: () async {
                readMain.onNavigation(
                    4,
                    const ProfileScreenView(
                      isRefreshed: false,
                    ),
                    context);

                return false;
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 21.w,
                    ),
                    Container(
                      // padding: EdgeInsets.only(left: 8.w, right: 3.w),
                      child: Stack(
                        children: [
                          const Image(
                            image: AssetImage(
                              "assets/images/reffer_and_earn.png",
                            ),
                            // width: ScreenUtil().screenWidth,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            //<-- SEE HERE
                            // bottom: 10.w,
                            left: 30.w,
                            top: 20.w,
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/reffer_and_earn_2.png",
                                  ),
                                  width: 126.w, height: 104.w,
                                  // fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: 13.w,
                                ),
                                Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            'Rs. ${watch.couponDetails?.discountAmount} ',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              color: Color(0xff39C19D),
                                              fontSize: 21,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        /*defining default style is optional */
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' Voucher\n can be yours.',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.w,
                                    ),
                                    Text(
                                      // "",
                                      "Onboard your favourite kirana shops\n on Local Supermart and get discount\n voucher on shop approval!",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 49.h,
                    ),
                    Text(
                      "Refer Now! ",
                      // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Color(0xff39C19D),
                            // letterSpacing: .5,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 62.w, top: 14, bottom: 13.w, right: 61.13.w),
                      decoration: BoxDecoration(
                          color: Color(0xffE2FFF7),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xff39C19D),
                          )),
                      child: RichText(
                        text: TextSpan(
                          text: 'REFERRAL CODE ',
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                                color: Black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                          /*defining default style is optional */
                          children: <TextSpan>[
                            TextSpan(
                              text: 'AGRO557',
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                    color: Color(0xff39C19D),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 33.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24.w, right: 17.w),
                      child: Text(
                        "Onboard kirana shops with your referral code to get discount voucher of Rs. 1000 which can be applied on any shop order. You will receive the voucher code under My Vouchers section when the referred shop gets approved and listed on our platform. ",
                        // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              // letterSpacing: .5,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      "Refer shops using",
                      // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Black,
                            // letterSpacing: .5,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 19.w, right: 19.w),
                      padding: EdgeInsets.only(
                          left: 27.w, top: 25.w, bottom: 26.w, right: 26.w),
                      decoration: BoxDecoration(
                          color: Color(0xff37B4B8).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // _launchURL(
                                  //     "https://developers.facebook.com/docs/messenger-platform/plugin-reference/send-to-messenger");
                                },
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left: 3.w,
                                        right: 3.w,
                                        top: 3.w,
                                        bottom: 3.w),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Image.asset(
                                      "assets/images/facebook.png",
                                      width: 34.w,
                                      height: 34.w,
                                    )),
                              ),
                              SizedBox(
                                height: 9.w,
                              ),
                              Text(
                                "Facebook",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      // letterSpacing: .5,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 9.w,
                                      right: 9.w,
                                      top: 9.w,
                                      bottom: 9.w),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffE2E2E2)),
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Image.asset(
                                    "assets/images/instagram.png",
                                    width: 21.w,
                                    height: 21.w,
                                  )),
                              SizedBox(
                                height: 9.w,
                              ),
                              Text(
                                "Instagram",
                                // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      // letterSpacing: .5,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // _launchWhatsapp();
                                },
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left: 6.w,
                                        right: 6.w,
                                        top: 6.w,
                                        bottom: 6.w),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Image.asset(
                                      "assets/images/whatsapp.png",
                                      width: 28.w,
                                      height: 29.w,
                                    )),
                              ),
                              SizedBox(
                                height: 9.w,
                              ),
                              Text(
                                "WhatsApp",
                                // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      // letterSpacing: .5,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 7.w,
                                      right: 7.w,
                                      top: 7.w,
                                      bottom: 7.w),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Image.asset(
                                    "assets/images/sms.png",
                                    width: 27.w,
                                    height: 23.w,
                                  )),
                              SizedBox(
                                height: 9.w,
                              ),
                              Text(
                                "SMS",
                                // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      // letterSpacing: .5,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
