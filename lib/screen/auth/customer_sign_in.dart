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
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 45.w),
                child: AspectRatio(
                  aspectRatio: 1.45,
                  child: Image.asset(
                    'assets/images/splash1.png',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.w),
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/splash3.png',
                    width: 180.w,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Customer Sign In",
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                  color: Custlogin,
                  letterSpacing: .5,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 168.h,
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    'assets/images/splash2.png',
                  ),
                ),
              ),
              // SizedBox(
              //   height: 100,
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 250),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 1,
                        top: 1,
                        left: 0,
                        child: Container(
                          // height: 200.h,
                          width: 70.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
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
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
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
                              hintText: "Phone Number",
                              hintStyle: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: kgrey,
                                    // letterSpacing: .5,er a
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              fillColor: Colors.white,
                              filled: true),
                          // filled: true,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          // inputBorder: OutlineInputBorder(),

                          onSaved: (PhoneNumber number) {
                            print('On Saved: $number');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "We need to verify you. We will send you a\n one time verification code.",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: SplashText1,
                              letterSpacing: .5,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        textAlign: TextAlign.start),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: SizedBox(
                  width: 400, // <-- Your width
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Button,

                      elevation: 3,
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
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 20.0.h),
                                          child: Text(
                                            "We have sent SMS to :\n046 XXX XX XX",
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                  color: Black,
                                                  letterSpacing: .5,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        OTPTextField(
                                          length: 5,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fieldWidth: 50,
                                          style: const TextStyle(fontSize: 17),
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
                                          padding: EdgeInsets.only(left: 100.h),
                                          child: Text(
                                            'Resend OTP',
                                            style: GoogleFonts.dmSans(
                                              textStyle: const TextStyle(
                                                  // color: SplashTex
                                                  letterSpacing: .5,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
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
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            // color: SplashTex
                            letterSpacing: .5,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 180),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: Black,
                            letterSpacing: .5,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    // Text("data")
                    TextButton(
                      onPressed: () {
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
          )
        ],
      ),
    ));
  }
}
