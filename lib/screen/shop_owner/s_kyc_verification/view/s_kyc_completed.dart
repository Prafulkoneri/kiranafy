
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_sign_in_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:provider/provider.dart';

class KycCompletedView extends StatefulWidget {
  const KycCompletedView({super.key});

  @override
  State<KycCompletedView> createState() => _KycCompletedViewState();
}

class _KycCompletedViewState extends State<KycCompletedView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopSignInController>();
    final watch = context.watch<ShopSignInController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
            title: "KYC Verification", isBackButtonEnabled: false),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -25.w,
                right: 0.w,
                child: Image.asset(
                  "assets/images/splash2.png",
                  height: 235.w,
                  width: 361.w,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/kycone.png",
                      height: 150.h,
                      width: 150.w,
                    ),
                    SizedBox(
                      height: 58.h,
                    ),
                    Text(
                      "Congratulations!",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: const Color(0xff20BF55),
                            // height: 1.5,

                            // letterSpacing: .05,
                            // overflow: TextOverflow.ellipsis,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                    Text(
                      "Your registration has been successfully\nCompleted",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: const Color(0xff181725),
                            // height: 1.5,

                            // letterSpacing: .05,
                            // overflow: TextOverflow.ellipsis,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Your KYC verification is under process.\nOur executive will contact you soon!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: const Color(0xff181725),
                            // height: 1.5,

                            // letterSpacing: .05,
                            // overflow: TextOverflow.ellipsis,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    PrimaryButton(
                        height: 40.w,
                        width: 164.w,
                        fontSize: 14.sp,
                        text: "Buy Subscription Plan",
                        color: SplashText,
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SSubscriptionScreenView(
                                      loggedIn: false,
                                  routeName: "kyc",
                                    )),
                            (Route<dynamic> route) => false,
                          );
                          // read.onUploadClicked(context);
                        }),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
