import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:local_supper_market/const/color.dart';

class OderStatus extends StatelessWidget {
  OderStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Random random = new Random();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          // Status bar color
          statusBarColor: kstatusbar,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        toolbarHeight: 65,
        // backgroundColor: kappbar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Order Status",
          style: GoogleFonts.dmSans(
            textStyle: const TextStyle(
                color: Black,
                // letterSpacing: .5,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: <Color>[
                  kstatusbar.withOpacity(0.55),
                  kstatusbar.withOpacity(0.98),
                ]),
          ),
        ),
      ),
      // backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, top: 20.w),
            child: Text(
              "New Balaji Trading Company",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Black1,
                    // letterSpacing: .5,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.w, bottom: 10.w),
                child: SvgPicture.asset(
                  'assets/images/location2.svg',
                  width: 23.w,
                  height: 28.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, bottom: 10.w),
                child: Text(
                  "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Black,
                        // letterSpacing: .5,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 36.h, right: 11.w, bottom: 12.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/call.svg',
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    SvgPicture.asset(
                      'assets/images/fvrt.svg',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(thickness: 1, color: grey2),
          Padding(
            padding: EdgeInsets.only(left: 19.w, top: 19.w, bottom: 10.w),
            child: Text(
              "Delivery Address",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black,
                    // letterSpacing: .5,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 10.w),
            child: Container(
              // decoration: BoxDecoration(
              //   boxShadow: [
              //     BoxShadow(
              //         color:
              //             Color.fromRGBO(255, 255, 255, 0.102).withOpacity(1),
              //         blurRadius: .0,

              //         ///soften the shadow
              //         spreadRadius: 1, //extend the shadow
              //         offset: Offset(
              //           0,
              //           // 1, // Move to right 10  horizontally
              //           2, // Move to bottom 10 Vertically
              //         )),
              //   ],
              // ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: 156.h,
                  // decoration: new BoxDecoration(
                  //   boxShadow: [
                  //     new BoxShadow(
                  //       color: Colors.white,
                  //       blurRadius: 10.0,
                  //     ),
                  //   ],
                  // ),
                  // width: double.infinity,
                  // width: 400.w,
                  // decoration: BoxDecoration(
                  //     // color: grey7,
                  //     border: Border.all(color: grey7),
                  //     borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          top: 20.w,
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,/
                          children: [
                            SvgPicture.asset(
                              'assets/images/person.svg',
                              width: 11.w,
                              height: 15.h,
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            Text(
                              'Rachel Green',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    // letterSpacing: .5,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            // SizedBox(
                            //   width: 11.w,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(left: 90.w),
                              child: SizedBox(
                                height: 21.h,
                                width: 71.w,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    // backgroundColor: ,
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: lighrgreen,
                                          // width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Home",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: SplashText1,
                                          // letterSpacing: .5,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),

                                  //
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 19.w,
                          top: 20.w,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/phone.svg',
                              width: 14.w,
                              height: 15.h,
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            Text(
                              '+91 986 095 3315',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    // letterSpacing: .5,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 19.w,
                          top: 19.w,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/images/location.svg',
                              color: SplashText1,
                              width: 17.w,
                              height: 17.h,
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            Expanded(
                              child: Text(
                                maxLines: 3,
                                "Nand Nivas Building floor 3 B-3,Lane No.13 Bhatrau Nivas Vishrantwadi Pune -411015.",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 19.w, top: 20.w, bottom: 30.w),
            child: Text(
              // maxLines: 3,
              "Order Status",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black1,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
                // shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,/
                        children: [
                          // Column(
                          //   children: [
                          //     Container(
                          //       height: 30.h,
                          //       width: 30.w,
                          //       color: black,
                          //     ),
                          //     Container(
                          //       height: 60.h,
                          //       width: 5.w,
                          //       color: black,
                          //     ),
                          //   ],
                          // ),
                          Padding(
                            padding: EdgeInsets.only(left: 80.w, bottom: 32.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Placed",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "We have received your order.",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "Sep 30 2021 20:15 AM.",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      index == 4
                          ? Container()
                          : Positioned(
                              left: 42,
                              top: 25,
                              // bottom: 20,
                              child: Container(
                                height: 100,
                                width: 1.0,
                                color: Colors.grey.shade400,
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(left: 25.0.w, bottom: 78.w
                            // right: 30.w,
                            ),
                        child: Container(
                            child: index == 0
                                ? SvgPicture.asset(
                                    'assets/images/check.svg',
                                    width: 21.w,
                                    height: 21.h,
                                  )
                                : Container(
                                    height: 21.h,
                                    width: 24.w,
                                    // color: Grey,
                                    decoration: new BoxDecoration(
                                      color: grey9,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  )
                            //
                            ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
