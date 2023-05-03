import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/auth/view/shop_registration_view.dart';
import 'package:local_supper_market/screen/shop_owner/auth/controller/shop_sign_in_controller.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:provider/provider.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
// import 'package:country_code_picker/country_code_picker.dart';

class ShopSignInView extends StatefulWidget {
  @override
  State<ShopSignInView> createState() => _ShopSignInViewState();
}

class _ShopSignInViewState extends State<ShopSignInView> {
  @override
  Widget build(BuildContext context) {
  final read=context.read<ShopSignInController>();
  final watch=context.watch<ShopSignInController>();
    return Scaffold(
        body:  Stack(
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
                      // Padding(
                      //   padding:
                      //       EdgeInsets.only(left: 28.w, right: 23.w, top: 82.h),
                      //   child: SizedBox(
                      //     height: 48.h,
                      //     width: 334.w,
                      //     child: TextField(
                      //       decoration: InputDecoration(
                      //         fillColor: Colors.white,
                      //         filled: true,
                      //         border:
                      //             OutlineInputBorder(borderSide: BorderSide.none),
                      //         // labelText: 'Name',
                      //         hintText: 'Name',
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 28.w, top: 16.w, bottom: 16.w, right: 23.w),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 1,
                                top: 1,
                                left: 0,
                                child: Container(
                                  // height: 200.h,
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              MobileNoTextFormField(
                                enableOrder: true,
                                controller: watch.mobController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(left: 25.w, top: 16.w, right: 0.w),
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
                        height: 58.w,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 27.w,
                          ),
                          Expanded(
                            child: PrimaryButton(
                              color: Color(0xff4689EC),
                              onTap: () {
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
                                                          fontWeight:
                                                          FontWeight.w700),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20.0.h),
                                                    child: Text(
                                                      "We have sent SMS to :\n046 XXX XX XX",
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
                                                  OTPTextField(
                                                    length: 5,
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    fieldWidth: 50,
                                                    style: const TextStyle(
                                                        fontSize: 17),
                                                    textFieldAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    fieldStyle:
                                                    FieldStyle.underline,
                                                    onCompleted: (pin) {
                                                      print("Completed: " + pin);
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 400, // <-- Your width
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
                                                        minimumSize: const Size(
                                                            100, 40), //////// HERE
                                                      ),
                                                      // style: style,
                                                      onPressed: () {
                                                        read.onOtpSubmitPressed(
                                                            context);
                                                      },
                                                      child: Text(
                                                        'Submit',
                                                        style: GoogleFonts.inter(
                                                          textStyle:
                                                          const TextStyle(
                                                            // color: SplashTex
                                                              letterSpacing: .5,
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
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 100.h),
                                                    child: Text(
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    );
                                  },
                                );
                              },
                              textColor: Colors.white,
                              text: "Login",
                            ),
                          ),
                          SizedBox(
                            width: 17.w,
                          ),
                          Expanded(
                            child: PrimaryButton(
                              color: Colors.transparent,
                              borderColor: Color(0xff4689EC),
                              onTap: () {
                                read.onNewShopPressed(context);
                              },
                              textColor:  Color(0xff4689EC),
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