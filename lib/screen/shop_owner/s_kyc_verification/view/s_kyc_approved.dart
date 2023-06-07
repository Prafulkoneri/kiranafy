import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_sign_in_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:provider/provider.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
// import 'package:country_code_picker/country_code_picker.dart';

class KycApprovedView extends StatefulWidget {
  @override
  State<KycApprovedView> createState() => _KycApprovedViewState();
}

class _KycApprovedViewState extends State<KycApprovedView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopSignInController>();
    final watch = context.watch<ShopSignInController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
            title: "KYC Verification", isBackButtonEnabled: false),
      ),
      body: Stack(
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
                    "assets/images/kyc2.png",
                    height: 150.h,
                    width: 150.w,
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Text(
                    "Congratulations!",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Color(0xff20BF55),
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 47.h,
                  ),
                  Text(
                    "Your KYC verification has been\n approved, now you are authorized to\n fully explore our platform and even set\n up your own shop.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Color(0xff181725),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 47.h,
                  ),
                  PrimaryButton(
                      height: 40.w,
                      width: 164.w,
                      fontSize: 14.sp,
                      text: "Set Shop Configuration",
                      color: SplashText,
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SShopConfigurationView(initialShopConfigration: true,)),
                              (Route<dynamic> route) => false,
                        );
                      }),
                ],
              ),
            )
          ]),
    );
  }
}
