import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/widget/buttons.dart';

import '../../const/color.dart';
import '../../widget/app_bar.dart';
import '../Home/product_screen.dart';
import '../order_summery/order_summery.dart';

class CartDetail extends StatelessWidget {
  const CartDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.w),
          child: PrimaryAppBar(
            title: "Cart Details",
            action: SvgPicture.asset("assets/images/delete.svg"),
            onActionTap: () {},
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w, top: 20.w),
                child: Text(
                  "New Balaji Trading Company",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black1,
                        letterSpacing: .5,
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
                    padding: EdgeInsets.only(left: 12.w, bottom: 15.w),
                    child: SvgPicture.asset(
                      'assets/images/location2.svg',
                      // width: 15.w,
                      // height: 19.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, bottom: 10.w),
                    child: Text(
                      "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            letterSpacing: .5,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 35.h, right: 11.w, bottom: 12.w),
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
              Container(
                // height: 360.h,
                // width: 352.w,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductScreen()));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 18.w, top: 8.w, right: 17.w),
                              child: Container(
                                height: 95.h,
                                width: 355.w,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        12.w,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              'assets/images/sprite.png',
                                              width: 39.w,
                                              height: 92.h,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Sprite",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Black1,
                                                            letterSpacing: .5,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 60.w,
                                                      height: 20.h,
                                                      decoration: BoxDecoration(
                                                          color: lightgreen,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.w))),
                                                      child: Center(
                                                        child: Text("50% off",
                                                            // textAlign: TextAlign.center,
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      .5,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text("1L",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: Grey,
                                                          // letterSpacing: .5,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 12.w),
                                                      child: Row(
                                                        // crossAxisAlignment:
                                                        //     CrossAxisAlignment.start,
                                                        // mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            '\u{20B9}${25.00}',
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  color: Black,
                                                                  letterSpacing:
                                                                      .5,
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            '\u{20B9}${25.00}',
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle:
                                                                  TextStyle(
                                                                      // decoration:
                                                                      // TextDecoration.lineThrough,
                                                                      color:
                                                                          Black,
                                                                      letterSpacing:
                                                                          .5,
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/icons/minus.svg',
                                                      // width: 30.w,
                                                      // height: 30.h,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/images/add.svg',
                                                      // width: 30.w,
                                                      // height: 30.h,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                // decoration: BoxDecoration(
                                //   // color: Colors.blueAccent,
                                //   border: Border.all(width: 1, color: grey1),
                                // ),
                                // decoration: BoxDecoration(color: Black),
                              ),
                            ),
                            index == 4
                                ? SizedBox(
                                    height: 20.h,
                                  )
                                : Container()
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ))),
          // SizedBox(
          //   height: 40.h,
          // ),
          Container(
            padding:
                EdgeInsets.only(left: 20.w, bottom: 6, right: 15.w, top: 6.w),
            height: 30.h,
            width: 390.w,
            color: Button1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          // letterSpacing: .5,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    )),
                Text("4 Items",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          // letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 20.w, top: 12.w, right: 15.w, bottom: 8.w),
            height: 70.h,
            width: 390.w,
            color: SplashText,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("₹132.00",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700),
                        )),
                    SizedBox(
                      height: 8.w,
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/check1.svg',
                          height: 18.w,
                          width: 18.w,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text("saved ₹132.00",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: .5,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ],
                ),
                Container(
                  child: PrimaryButton(
                      color: Colors.white,
                      height: 36.h,
                      width: 160.w,
                      onTap: () {},
                      text: 'Place Order',
                      textColor: SplashText1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ]));
  }
}
