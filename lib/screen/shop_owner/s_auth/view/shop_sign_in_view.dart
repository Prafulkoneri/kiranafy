import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_sign_in_controller.dart';

import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:provider/provider.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

// import 'package:country_code_picker/country_code_picker.dart';
enum LoginScreen { SHOW_MOBILE_ENTER_WIDGET, SHOW_OTP_FORM_WIDGET } //otp

class ShopSignInView extends StatefulWidget {
  @override
  State<ShopSignInView> createState() => _ShopSignInViewState();
}

// TextEditingController phoneController = TextEditingController();
// OtpFieldController otpController = OtpFieldController();
// LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;
// FirebaseAuth _auth = FirebaseAuth.instance;

// void SignOutME() async {
//   await _auth.signOut();
// }

class _ShopSignInViewState extends State<ShopSignInView> {
  // TextEditingController phoneController = TextEditingController();
  // OtpFieldController otpController = OtpFieldController();
  // LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  // String verificationID = "";

  // void SignOutME() async {
  //   await _auth.signOut();
  // }

  // void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
  //   try {
  //     final authCred = await _auth.signInWithCredential(phoneAuthCredential);

  //     if (authCred.user != null) {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => ShopDashBoard()));
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Some Error Occured. Try Again Later')));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopSignInController>();
    final watch = context.watch<ShopSignInController>();
    return Scaffold(
        body: Stack(
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
        SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150.w,
                  ),
                  Image.asset(
                    "assets/images/splash4.png",
                    height: 112.w,
                    width: 60.w,
                  ),
                  SizedBox(
                    height: 5.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LOCAL",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: SplashText),
                      ),
                      Text(
                        " SUPERMART",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: SplashText1),
                      ),
                    ],
                  ),
                  Text(
                    "Hameshase aapke sath....",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 50.h,
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
                    height: 120.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 28.w, right: 23.w, top: 0.h),
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
                    padding: EdgeInsets.only(left: 25.w, right: 0.w, top: 15.w),
                    child: Row(
                      children: [
                        Text(
                          "We need to verify you. We will send you\n a one time verification code.",
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
                          child: PrimaryCheckBox(
                            value: watch.isVerifyChecked,
                            onChanged: (value) {
                              read.onVerifyChecked(value);
                            },
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              text: "By continuing you agree to our,\n",
                              style: TextStyle(
                                  color: Black,
                                  fontSize: 16.sp,
                                  height: 1.3.w,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                  children: [],
                                  text: 'Term of Condition',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print('Login Text Clicked');
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
                                      print('Login Text Clicked');
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
                          color: Color(0xff4689EC),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (BuildContext context) {
                                  return Theme(
                                    data: Theme.of(context)
                                        .copyWith(canvasColor: Colors.white),
                                    child: Material(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16.0),
                                            topRight: Radius.circular(16.0)),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          // height: 335,
                                          child: Padding(
                                            padding: EdgeInsets.all(25.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Enter Verification Code",
                                                  style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                        color: Custlogin,
                                                        letterSpacing: .5,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 20.0.h),
                                                  child: Text(
                                                    "We have sent SMS to :\n ${watch.mobController.text.isNotEmpty?watch.mobController.text.substring(0,3):""} XXX XX XX",
                                                    style: GoogleFonts.inter(
                                                      textStyle: TextStyle(
                                                          color: Black,
                                                          letterSpacing: .5,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                OtpTextField(
                                                  //  controller: otpController,
                                                  numberOfFields: 6,
                                                  borderColor:
                                                      Color(0xFF512DA8),
                                                  //set to true to show as box or false to show as dash
                                                  showFieldAsBox: false,
                                                  //runs when a code is typed in
                                                  onCodeChanged: (String code) {
                                                    print(code);
                                                    //handle validation or checks here
                                                  },
                                                  //runs when every textfield is filled
                                                  onSubmit: (String
                                                      verificationCode) {
                                                    print(verificationCode);
                                                    read.onOtpEntered(
                                                        verificationCode);
                                                  }, // end onSubmit
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 400,
                                                  // <-- Your width
                                                  height: 60,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Button,
                                                      // onPrimary: Colors.white,
                                                      // shadowColor: Colors.greenAccent,
                                                      elevation: 3,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14.0)),
                                                      minimumSize: const Size(
                                                          100,
                                                          40), //////// HERE
                                                    ),
                                                    // style: style,
                                                    onPressed: () {
                                                      read.onCodeVerification(
                                                          context);
                                                    },
                                                    child: Text(
                                                      'Submit',
                                                      style: GoogleFonts.inter(
                                                        textStyle:
                                                            const TextStyle(
                                                                // color: SplashTex
                                                                letterSpacing:
                                                                    .5,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Resend OTP',
                                                      style: GoogleFonts.dmSans(
                                                        textStyle:
                                                            const TextStyle(
                                                                // color: SplashTex
                                                                letterSpacing:
                                                                    .5,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  );
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
                            if (!watch.isNewShopBtnEnabled) {
                              return;
                            }
                            if (!watch.isVerifyChecked) {
                              return;
                            }
                            await showModalBottomSheet(
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              context: context,
                              builder: (BuildContext context) {
                                return Theme(
                                  data: Theme.of(context)
                                      .copyWith(canvasColor: Colors.white),
                                  child: Material(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0)),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Padding(
                                          padding: EdgeInsets.all(25.h),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Enter Verification Code",
                                                style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                      color: Custlogin,
                                                      letterSpacing: .5,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0.h),
                                                child: Text(
                                                  "We have sent SMS to :\n ${watch.mobController.text.isNotEmpty?watch.mobController.text.substring(0,3):""} XXX XX XX",
                                                  style: GoogleFonts.inter(
                                                    textStyle: const TextStyle(
                                                        color: Black,
                                                        letterSpacing: .5,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                              OtpTextField(
                                                //  controller: otpController,
                                                numberOfFields: 6,
                                                borderColor: Color(0xFF512DA8),
                                                //set to true to show as box or false to show as dash
                                                showFieldAsBox: false,
                                                //runs when a code is typed in
                                                onCodeChanged: (String code) {
                                                  print(code);
                                                  //handle validation or checks here
                                                },
                                                //runs when every textfield is filled
                                                onSubmit:
                                                    (String verificationCode) {
                                                  print(verificationCode);
                                                  read.onOtpEntered(
                                                      verificationCode);
                                                }, // end onSubmit
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                width: 400,
                                                // <-- Your width
                                                height: 60,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Button,
                                                    // onPrimary: Colors.white,
                                                    // shadowColor: Colors.greenAccent,
                                                    elevation: 3,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14.0)),
                                                    minimumSize: Size(
                                                        100, 40), //////// HERE
                                                  ),
                                                  // style: style,
                                                  onPressed: () {
                                                    read.onCodeVerification(
                                                        context);
                                                  },
                                                  child: Text(
                                                    'Submit',
                                                    style: GoogleFonts.inter(
                                                      textStyle: TextStyle(
                                                          // color: SplashTex
                                                          letterSpacing: .5,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Resend OTP',
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          // color: SplashTex
                                                          letterSpacing: .5,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              },
                            );
                          },
                          textColor: Color(0xff4689EC),
                          text: "New Shop",
                        ),
                      ),
                      SizedBox(
                        width: 27.w,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ],
    ));
  }
}
