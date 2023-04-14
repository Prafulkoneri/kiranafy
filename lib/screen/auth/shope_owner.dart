// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/intro/intro_one.dart';

// class ShopeOwner extends StatefulWidget {
//   @override
//   _ShopeOwnerState createState() => _ShopeOwnerState();
// }

// class _ShopeOwnerState extends State<ShopeOwner> {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Container(
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 stops: [0.1, 0.3, 0.7, 1],
//                 colors: [splashnone, Colors.white, Colors.white, splashnone])),
//         child: Column(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 150),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Image(
//                       image: AssetImage("assets/images/splash.png"),
//                       width: 59,
//                       height: 78,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: ' LOCAL',
//                             style: GoogleFonts.lato(
//                               textStyle: const TextStyle(
//                                   color: SplashText,
//                                   letterSpacing: .5,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           TextSpan(
//                             text: ' SUPERMART',
//                             style: GoogleFonts.lato(
//                               textStyle: const TextStyle(
//                                   color: SplashText1,
//                                   letterSpacing: .5,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       "Hameshase aapke sath....",
//                       // style: TextStyle(color: SplashText,),
//                       style: GoogleFonts.inter(
//                         textStyle: const TextStyle(
//                             color: Black,
//                             letterSpacing: .5,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Text(
//                       "Shop Sign Up",
//                       // style: TextStyle(color: SplashText,),
//                       style: GoogleFonts.inter(
//                         textStyle: const TextStyle(
//                             color: Custlogin,
//                             letterSpacing: .5,
//                             fontSize: 24,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                     // Spacer(),
//                     SizedBox(
//                       height: 52,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(15),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Shop Name',
//                           hintText: 'Enter Shop Name',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(15),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Contact Name',
//                           hintText: 'Enter Contact Name',
//                         ),
//                       ),
//                     ),

//                     Padding(
//                       padding: EdgeInsets.all(15),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Phone Number',
//                           hintText: 'Phone Number',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(15),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Email',
//                           hintText: 'Email id',
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                               "We need to verify you. We will send you a\n one time verification code.",
//                               style: GoogleFonts.inter(
//                                 textStyle: const TextStyle(
//                                     color: SplashText1,
//                                     letterSpacing: .5,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                               textAlign: TextAlign.start),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     SizedBox(
//                       width: 400, // <-- Your width
//                       height: 60,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: Button,
//                           // onPrimary: Colors.white,
//                           // shadowColor: Colors.greenAccent,
//                           elevation: 3,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14.0)),
//                           minimumSize: Size(100, 40), //////// HERE
//                         ),
//                         // style: style,
//                         onPressed: () {},
//                         child: Text(
//                           'Next',
//                           style: GoogleFonts.inter(
//                             textStyle: const TextStyle(
//                                 // color: SplashTex
//                                 letterSpacing: .5,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Already have an account?",
//                           style: GoogleFonts.inter(
//                             textStyle: const TextStyle(
//                                 color: Black,
//                                 letterSpacing: .5,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                         // Text("data")
//                         TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "Login",
//                             style: GoogleFonts.inter(
//                               textStyle: const TextStyle(
//                                   color: Custlogin,
//                                   letterSpacing: .5,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/auth/shop_registration.dart';
import 'package:local_supper_market/screen/intro/intro_one.dart';
import 'package:local_supper_market/test.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class ShopeOwner extends StatefulWidget {
  @override
  State<ShopeOwner> createState() => _ShopeOwnerState();
}

class _ShopeOwnerState extends State<ShopeOwner> {
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
                padding: const EdgeInsets.only(right: 45),
                child: AspectRatio(
                  aspectRatio: 1.45,
                  child: Image.asset(
                    'assets/images/splash1.png',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/splash3.png',
                    width: 200,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Shop Sign In",
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
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          initialValue: number,
                          textFieldController: controller,
                          // formatInput: true,
                          // fillColor: Colors.white,
                          inputBorder: InputBorder.none,
                          inputDecoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
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
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            // height: 335,
                            child: Padding(
                              padding: EdgeInsets.all(25.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    width: MediaQuery.of(context).size.width,
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
                                                BorderRadius.circular(14.0)),
                                        minimumSize:
                                            const Size(100, 40), //////// HERE
                                      ),
                                      // style: style,
                                      onPressed: () {},
                                      child: Text(
                                        'Submit',
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
                          );
                        },
                      );
                    },
                    child: Text(
                      'Login',
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
                              builder: (context) => ShopRegistration()),
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
