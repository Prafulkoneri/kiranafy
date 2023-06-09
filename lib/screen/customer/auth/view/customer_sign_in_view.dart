import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:local_supper_market/screen/customer/auth/controller/customer_sign_in_controller.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_up_view.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import '../../main_screen/views/main_screen_view.dart';

// enum LoginScreen { SHOW_MOBILE_ENTER_WIDGET, SHOW_OTP_FORM_WIDGET }

class CustomerSignInView extends StatefulWidget {
  const CustomerSignInView({Key? key}) : super(key: key);

  @override
  _CustomerSignInViewState createState() => _CustomerSignInViewState();
}

class _CustomerSignInViewState extends State<CustomerSignInView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<CustomerSignInController>();
    final watch = context.watch<CustomerSignInController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
              children: [
                SizedBox(
                  height: 140.w,
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
                  "Customer Sign In",
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
                  padding: EdgeInsets.only(left: 28.w, right: 23.w),
                  child: MobileNoTextFormField(
                    onChanged: (value) {
                      read.mobileNumberCheck(context);
                    },
                    onCountryCodeChanged: (value) {
                      read.onCountryCodeSelected(value);
                    },
                    enableOrder: false,
                    controller: watch.mobileController,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.w),
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
                  height: 34.h,
                ),
                SizedBox(
                  height: 26.h,
                ),
                SizedBox(
                  width: 300.w, // <-- Your width
                  height: 45.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Button,

                      // elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      minimumSize: const Size(100, 40), //////// HERE
                    ),
                    // style: style,
                    onPressed: () async {
                      await read.onNextClick(context);
                      if (watch.mobileController.text.length < 10) {
                        return;
                      }
                      if (!watch.isLoginBtnEnabled) {
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
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0.h),
                                          child: Text(
                                            "We have sent SMS to :\n${watch.mobileController.text.substring(0, 3)} XXX XX XX",
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                  color: Black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
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
                                          onSubmit: (String verificationCode) {
                                            print(verificationCode);
                                            read.onOtpEntered(verificationCode);
                                          }, // end onSubmit
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: 400, // <-- Your width
                                          height: 60,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Button,
                                              // onPrimary: Colors.white,
                                              // shadowColor: Colors.greenAccent,
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0)),
                                              minimumSize: const Size(
                                                  100, 40), //////// HERE
                                            ),
                                            // style: style,
                                            onPressed: () {
                                              read.onOtpSubmitPressed(context);
                                            },
                                            child: Text(
                                              'Submit',
                                              style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
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
                                                textStyle: const TextStyle(
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
                    child: Text(
                      'Next',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            // color: SplashTex
                            letterSpacing: .5,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ? ",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            letterSpacing: .5,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    // Text("data")
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerSignUp()),
                        );
                      },
                      child: Text(
                        " Sign Up",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: Custlogin,
                              letterSpacing: .5,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
