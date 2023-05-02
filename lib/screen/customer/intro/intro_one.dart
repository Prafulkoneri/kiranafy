import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/auth/shope_owner.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_in_view.dart';

class IntroOne extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
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
                padding: EdgeInsets.only(top: 20.w),
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
            height: 245.h,
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
                                builder: (context) => CustomerSignInView()),
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
