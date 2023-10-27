import 'dart:io';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/controller/profile_controller.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class RefAndEarnView extends StatefulWidget {
  const RefAndEarnView({Key? key}) : super(key: key);

  @override
  _RefAndEarnViewState createState() => _RefAndEarnViewState();
}

class _RefAndEarnViewState extends State<RefAndEarnView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    final read = Provider.of<ProfileController>(context, listen: false);
    final watch = Provider.of<ProfileController>(context, listen: false);
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            // read.onBackPressed();
            readMain.onNavigation(
                4,
                ProfileScreenView(
                  isRefreshed: false,
                ),
                context);
          },
          title: "Refer & Earn",
        ),
      ),
      body: WillPopScope(
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
                                      'Rs. ${watch.referAndEarnCouponDetails?.discountAmount} ',
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
                margin: EdgeInsets.only(right: 14.w, left: 14.w),
                padding: EdgeInsets.only(
                    left: 10.w, top: 14.w, bottom: 13.w, right: 10.w),
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
                        text:
                            '${watch.referAndEarnCouponDetails?.customerReferralCode}',
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
                  "Onboard kirana shops with your referral code to get discount voucher of Rs. ${watch.referAndEarnCouponDetails?.discountAmount} which can be applied on any shop order. You will receive the voucher code under My Vouchers section when the referred shop gets approved and listed on our platform. ",
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
              Container(
                margin: EdgeInsets.only(
                    left: 30.w, top: 14, bottom: 13.w, right: 30.w),
                child: AnimatedButton(
                  backgroundColor: Color(0xffE2FFF7),
                  borderWidth: 1,
                  borderColor: Color.fromARGB(255, 12, 170, 128),
                  borderRadius: 12,
                  // width: 200,
                  text: 'Click to share your referral code',
                  selectedTextColor: Colors.black,
                  transitionType: TransitionType.BOTTOM_TO_TOP,
                  textStyle: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                        // letterSpacing: 5,
                        color: Color(0xff39C19D),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onPress: () {
                    if (Platform.isAndroid) {
                      Share.share(
                          'I’m inviting you to register and list your shop on Local Supermart, an online platform where customers can buy online from your kirana shop. Here’s my referral code -${watch.referAndEarnCouponDetails?.customerReferralCode}- just enter it where you select the subscription plan and get a discount on the plan amount. https://play.google.com/store/apps/details?id=com.lsm.local_supper_market&hl=en&gl=US');
                    } else {
                      Share.share(
                          'I’m inviting you to register and list your shop on Local Supermart, an online platform where customers can buy online from your kirana shop. Here’s my referral code -${watch.referAndEarnCouponDetails?.customerReferralCode}- just enter it where you select the subscription plan and get a discount on the plan amount https://apps.apple.com/us/app/local-supermart/id6451146831');
                    }
                  },
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
