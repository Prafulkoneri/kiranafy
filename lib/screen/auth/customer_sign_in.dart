import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/Home/home_screen.dart';
import 'package:local_supper_market/screen/auth/customer_sign_up.dart';
import 'package:local_supper_market/screen/auth/shop_registration.dart';
import 'package:local_supper_market/screen/intro/intro_one.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class CustomerSignIn extends StatefulWidget {
  @override
  State<CustomerSignIn> createState() => _CustomerSignInState();
}

class _CustomerSignInState extends State<CustomerSignIn> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    String initialCountry = 'IN';
    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                // alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 29.w),
                    child: AspectRatio(
                      aspectRatio: 1.45,
                      child: Image.asset(
                        'assets/images/splash1.png',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 140.w, left: 98.w, right: 98.w),
                    child: Image.asset(
                      'assets/images/splash3.png',
                      width: 195.w,
                      height: 160.h,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 54.w, bottom: 130.w),
                child: Text(
                  "Customer Sign In",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Custlogin,
                        letterSpacing: .5,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Stack(
                // alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 30.w,
                    ),
                    child: Image.asset(
                      'assets/images/splash2.png',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 23.w),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 1,
                          top: 1,
                          // left: 2,
                          child: Container(
                            // height: 10.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: InternationalPhoneNumberInput(
                            // selectorConfig: const SelectorConfig(
                            //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            //     setSelectorButtonAsPrefixIcon: true,
                            //     leadingPadding: 20,
                            //     useEmoji: true,
                            //   ),
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                                // setSelectorButtonAsPrefixIcon: true,
                                setSelectorButtonAsPrefixIcon: false),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: TextStyle(color: kgrey),
                            initialValue: number,
                            textFieldController: controller,
                            // formatInput: true,
                            // fillColor: Colors.white,

                            // inputBorder: InputBorder.none,
                            inputDecoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(5.0),
//<-- SEE HERE
                                ),
                                border: InputBorder.none,
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(10.0),

                                // ),

                                // borderRadius: BorderRadius.circular(5),

                                hintText: "Phone Number",
                                hintStyle: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: kgrey,
                                      // letterSpacing: .5,er a
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                fillColor: Colors.white,
                                filled: true),
                            // filled: true,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: OutlineInputBorder(
                              // borderSide: BorderSide.,
                              borderRadius: BorderRadius.circular(20),
                            ),

                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60.w, left: 33.w),
                    child: Text(
                        "We need to verify you. We will send you a\n one time verification code.",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: SplashText1,
                              // letterSpacing: .5,/
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        textAlign: TextAlign.start),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 130.w, left: 24.w, right: 23.w),
                    child: SizedBox(
                      width: 330.w, // <-- Your width
                      height: 45.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Button,

                          // elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0)),
                          minimumSize: const Size(100, 40), //////// HERE
                        ),
                        // style: style,
                        onPressed: () {
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
                                              padding:
                                                  EdgeInsets.only(top: 20.0.h),
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
                                              style:
                                                  const TextStyle(fontSize: 17),
                                              textFieldAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              fieldStyle: FieldStyle.underline,
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
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeScreen()),
                                                  );
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
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 100.h),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 205),
                    child: Row(
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
                            "Sign Up",
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
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
