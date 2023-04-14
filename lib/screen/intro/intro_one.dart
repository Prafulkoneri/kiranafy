// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/intro/intro_one.dart';

// class IntroOne extends StatefulWidget {
//   @override
//   _IntroOneState createState() => _IntroOneState();
// }

// class _IntroOneState extends State<IntroOne> {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               stops: [0.1, 0.3, 0.7, 1],
//               colors: [splashnone, Colors.white, Colors.white, splashnone])),
//       child: Column(
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 150),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Image(
//                     image: AssetImage("assets/images/splash.png"),
//                     width: 59,
//                     height: 78,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: ' LOCAL',
//                           style: GoogleFonts.lato(
//                             textStyle: const TextStyle(
//                                 color: SplashText,
//                                 letterSpacing: .5,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                         TextSpan(
//                           text: ' SUPERMART',
//                           style: GoogleFonts.lato(
//                             textStyle: const TextStyle(
//                                 color: SplashText1,
//                                 letterSpacing: .5,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Hameshase aapke sath....",
//                     // style: TextStyle(color: SplashText,),
//                     style: GoogleFonts.inter(
//                       textStyle: const TextStyle(
//                           color: Black,
//                           letterSpacing: .5,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
// import 'package:local_supper_market/screen/auth/customer_login.dart';

// class IntroOne extends StatelessWidget {
//   final Color kDarkBlueColor = const Color(0xFF053149);

//   const IntroOne({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return OnBoardingSlider(
//       finishButtonText: 'Register',
//       onFinish: () {
//         Navigator.push(
//           context,
//           CupertinoPageRoute(
//             builder: (context) => CustomerLogin(),
//           ),
//         );
//       },
//       finishButtonStyle: FinishButtonStyle(
//         backgroundColor: kDarkBlueColor,
//       ),
//       skipTextButton: Text(
//         'Skip',
//         style: TextStyle(
//           fontSize: 16,
//           color: kDarkBlueColor,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       trailing: Text(
//         'Login',
//         style: TextStyle(
//           fontSize: 16,
//           color: kDarkBlueColor,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       trailingFunction: () {
//         // Navigator.push(
//         //   context,
//         //   CupertinoPageRoute(
//         //     builder: (context) => const LoginPage(),
//         //   ),
//         // );
//       },
//       controllerColor: kDarkBlueColor,
//       totalPage: 3,
//       headerBackgroundColor: Colors.white,
//       pageBackgroundColor: Colors.white,
//       background: [
//         Image.asset(
//           'assets/slide_1.png',
//           height: 400,
//         ),
//         Image.asset(
//           'assets/slide_2.png',
//           height: 400,
//         ),
//         Image.asset(
//           'assets/slide_3.png',
//           height: 400,
//         ),
//       ],
//       speed: 1.8,
//       pageBodies: [
//         Container(
//           alignment: Alignment.center,
//           width: MediaQuery.of(context).size.width,
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               const SizedBox(
//                 height: 480,
//               ),
//               Text(
//                 'On your way...',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: kDarkBlueColor,
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'to find the perfect looking Onboarding for your app?',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.black26,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           alignment: Alignment.center,
//           width: MediaQuery.of(context).size.width,
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               const SizedBox(
//                 height: 480,
//               ),
//               Text(
//                 'You’ve reached your destination.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: kDarkBlueColor,
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Sliding with animation',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.black26,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           alignment: Alignment.center,
//           width: MediaQuery.of(context).size.width,
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               const SizedBox(
//                 height: 480,
//               ),
//               Text(
//                 'Start now!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: kDarkBlueColor,
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Text(
//                 'Where everything is possible and customize your onboarding.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.black26,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/auth/customer_sign_in.dart';
import 'package:local_supper_market/screen/auth/customer_sign_up.dart';
import 'package:local_supper_market/screen/auth/shope_owner.dart';
import 'package:local_supper_market/screen/intro/intro_one.dart';

class IntroOne extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 310,
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
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 190, // <-- Your width
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Button1,
                          // onPrimary: Colors.white,
                          // shadowColor: Colors.greenAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0)),
                          minimumSize: const Size(100, 40), //////// HERE
                        ),
                        // style: style,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerSignIn()),
                          );
                        },
                        child: Text(
                          'Customer',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: Black,
                                letterSpacing: .5,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 190, // <-- Your width
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Button,
                          // onPrimary: Colors.white,
                          // shadowColor: Colors.greenAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0)),
                          minimumSize: const Size(100, 40), //////// HERE
                        ),
                        // style: style,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopeOwner()),
                          );
                        },
                        child: Text(
                          'Shop Owner',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                // color: SplashTex
                                letterSpacing: .5,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
