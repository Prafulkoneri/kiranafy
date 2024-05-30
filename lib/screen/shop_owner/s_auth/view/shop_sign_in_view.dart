import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_sign_in_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/view/otp_bottom_sheet_view.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:local_supper_market/widget/textfield.dart';
// import 'package:telephony/telephony.dart';

enum LoginScreen { SHOW_MOBILE_ENTER_WIDGET, SHOW_OTP_FORM_WIDGET } //otp

class ShopSignInView extends StatefulWidget {
  const ShopSignInView({super.key});

  @override
  State<ShopSignInView> createState() => _ShopSignInViewState();
}

class _ShopSignInViewState extends State<ShopSignInView> {
  bool isVisible = false;
  // Telephony telephony = Telephony.instance;
  OtpFieldController otpboxshop = OtpFieldController();
  @override
  void initState() {
    // if(Platform.isAndroid) {
    //   telephony.listenIncomingSms(
    //     onNewMessage: (SmsMessage message) {
    //       print(message.address); // +977981******67, sender nubmer
    //       print(message.body); // Your OTP code is 34567
    //       print(message.date); // 1659690242000, timestamp
    //
    //       // get the message
    //       String sms = message.body.toString();
    //       print("44444444444444444444");
    //       print(sms);
    //       print("44444444444444444444");
    //       if (message.body!.contains('lsm-0001.firebaseapp.com')) {
    //         // verify SMS is sent for OTP with sender number
    //         String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');
    //         // prase code from the OTP sms
    //         otpboxshop.set(otpcode.split(""));
    //         // split otp code to list of number
    //         // and populate to otb boxes
    //         setState(() {
    //           print("object");
    //           otpboxshop.set(otpcode.split(""));
    //           // refresh UI
    //         });
    //       } else {
    //         print("Normal message.");
    //       }
    //     },
    //     listenInBackground: false,
    //   );
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopSignInController>();
    final watch = context.watch<ShopSignInController>();
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0.w,
                  child: Image.asset(
                    "assets/images/splash1.png",
                    height: 235.w,
                    width: 361.w,
                  ),
                ),
                Positioned(
                  bottom: -25.w,
                  right: 0.w,
                  child: Image.asset(
                    "assets/images/splash2.png",
                    height: 235.w,
                    width: 361.w,
                  ),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 130.w,
                    ),
                    Image.asset(
                      "assets/images/kiranafy-logo-icon.png",
                      height: 112.w,
                      width: 60.w,
                    ),
                    // SizedBox(
                    //   height: 5.w,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Kirana",
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w600,
                              color: SplashText),
                        ),
                        Text(
                          "fy",
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w600,
                              color: SplashText1),
                        ),
                      ],
                    ),
                    Text(
                      "Hamesha Se Aapke Sath....",
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Shop Sign In",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Custlogin,
                            letterSpacing: .5,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 28.w, right: 23.w, top: 0.h),
                      child: MobileNoTextFormField(
                        onChanged: (value) {
                          read.checkMobNoExist(context);
                        },
                        onCountryCodeChanged: (value) {
                          read.onCountryCodeSelected(value);
                        },
                        enableOrder: true,
                        controller: watch.mobController,
                      ),
                      //
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 25.w, right: 0.w, top: 15.w),
                      child: Row(
                        children: [
                          Text(
                            "We need to verify you. We will send you\na one time verification code.",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: SplashText1,
                                  // letterSpacing: .5,/
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 44.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25.w,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15.w),
                            child: SeconderyCheckBox(
                              value: watch.isVerifyChecked,
                              onChanged: (value) {
                                read.onVerifyChecked(value);
                              },
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                                text:
                                    "By checking this box, you agree to our,\n",
                                style: TextStyle(
                                    color: Black,
                                    fontSize: 16.sp,
                                    height: 1.3.w,
                                    fontWeight: FontWeight.w400),
                                children: [
                                  TextSpan(
                                    children: const [],
                                    text: 'Terms of Service',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        read.launchTermsAndConditionURL();
                                      },
                                    style: TextStyle(
                                        color: SplashText1,
                                        // letterSpacing: .5,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: ' and',
                                    style: TextStyle(
                                        color: Black,
                                        // letterSpacing: .5,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: ' Privacy Policy',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        read.launchPrivacyPolicyURL();
                                      },
                                    style: TextStyle(
                                        color: SplashText1,
                                        // letterSpacing: .5,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 26.w,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 27.w,
                        ),

                        ///////////////Login//////////////
                        Expanded(
                          child: PrimaryButton(
                            color: const Color(0xff4689EC),
                            onTap: () async {
                              //otp vrification
                              await read.onLoginClick(context).then((value) {
                                if (!watch.isLoginBtnEnabled) {
                                  return;
                                }
                                if (!watch.isVerifyChecked) {
                                  return;
                                }

                                showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const OtpShopBottomSheetView();
                                  },
                                );
                              });
                              ////end
                            },
                            textColor: Colors.white,
                            text: "Login",
                          ),
                        ),

                        SizedBox(
                          width: 17.w,
                        ),

                        ///////////////////New Shop Start///////////////////////////
                        Expanded(
                          child: PrimaryButton(
                            color: Colors.transparent,
                            borderColor: const Color(0xff4689EC),
                            onTap: () async {
                              print(watch.isNewShopBtnEnabled);
                              await read.onNewShopPressed(context);
                              if (watch.mobController.text.length < 10) {
                                return;
                              }
                              if (!watch.isNewShopBtnEnabled) {
                                return;
                              }
                              if (!watch.isVerifyChecked) {
                                return;
                              }
                              await showModalBottomSheet(
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (BuildContext context) {
                                  return const OtpShopBottomSheetView();
                                },
                              );
                            },
                            textColor: const Color(0xff4689EC),
                            text: "New Shop",
                          ),
                        ),
                        SizedBox(
                          width: 27.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
