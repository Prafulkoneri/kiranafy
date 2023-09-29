import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/auth/controller/customer_sign_in_controller.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_otp_sheet.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_up_view.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:otp_text_field/otp_text_field.dart';

import 'package:provider/provider.dart';
import 'package:telephony/telephony.dart';

class CustomerSignInView extends StatefulWidget {
  const CustomerSignInView({Key? key}) : super(key: key);

  @override
  _CustomerSignInViewState createState() => _CustomerSignInViewState();
}

class _CustomerSignInViewState extends State<CustomerSignInView> {
  Telephony telephony = Telephony.instance;
  OtpFieldController otpbox = OtpFieldController();
  @override
  void initState() {
  if(Platform.isAndroid){
  telephony.listenIncomingSms(
  onNewMessage: (SmsMessage message) {
  print(message.address); // +977981******67, sender nubmer
  print(message.body); // Your OTP code is 34567
  print(message.date); // 1659690242000, timestamp

  // get the message
  String sms = message.body.toString();

  if (message.body!.contains('yourFirebaseProjectName.firebaseapp.com')) {
  // verify SMS is sent for OTP with sender number
  String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');
  // prase code from the OTP sms
  otpbox.set(otpcode.split(""));
  // split otp code to list of number
  // and populate to otb boxes
  setState(() {
  // refresh UI
  });
  } else {
  print("Normal message.");
  }
  },
  listenInBackground: false,
  );
  }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<CustomerSignInController>();
    final watch = context.watch<CustomerSignInController>();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                    height: 10.w,
                  ),
                  Text(
                    "OR",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login as",
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
                          read.guestLogin(context);
                        },
                        child: Text(
                          " Guest",
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
                    height: 16.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: Row(
                      children: [
                        Text(
                          "  We need to verify you. We will send you\n  a one time verification code.",
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
                        // if (!watch.isVerifyChecked) {
                        //   return;
                        // }

                        showModalBottomSheet(
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          context: context,
                          builder: (BuildContext context) {
                            return OtpCustomerBottomSheet();
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
                        "Don't have an account?",
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
      ),
    );
  }
}
