import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/dashboard/controller/s_dashboard_controller.dart';

import 'package:provider/provider.dart';

class ShopDashBoard extends StatefulWidget {
  const ShopDashBoard({super.key});

  @override
  State<ShopDashBoard> createState() => _ShopDashBoardState();
}

class _ShopDashBoardState extends State<ShopDashBoard> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SDashBoardController>();
    final watch = context.watch<SDashBoardController>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 19.w, top: 40.w, right: 23.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  image: const AssetImage(
                    "assets/images/logo.png",
                  ),
                  fit: BoxFit.fill,
                  width: 150.w,
                  height: 50.w,
                ),
                SvgPicture.asset("assets/icons/notification_shop.svg")
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.w),
            child: Stack(
              children: [
                Align(
                  child: SizedBox(
                    height: 181.0.h,
                    // width: 390.0,
                    child: const Carousel(
                      images: [
                        AssetImage(
                          "assets/images/property1.png",
                        ),
                        AssetImage(
                          "assets/images/property2.png",
                        ),

                        // ExactAssetImage("images/image-carousel.jpeg"),
                      ],
                      autoplay: true,
                      animationDuration: Duration(milliseconds: 1000),
                      dotBgColor: Colors.red,
                      showIndicator: false,
                      // dotSize: 6.0,
                      // dotSpacing: 15.0,
                      // dotColor: Colors.lightGreenAccent,
                      // borderRadius: true,
                    ),
                  ),
                ),
                Positioned(
                  //<-- SEE HERE
                  // right: 15.w,
                  // left: 0.w,
                  bottom: 10.w,
                  child: Container(
                    padding: EdgeInsets.only(left: 16.w),
                    width: ScreenUtil().screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Balaji Trading Company",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // letterSpacing: .5,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15.w),
                          height: 24.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/star.svg",
                                height: 14.h,
                                width: 14.w,
                              ),
                              SizedBox(
                                width: 4.3.w,
                              ),
                              Text(
                                "4.5",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              // child:
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 13.w, top: 18.w, right: 19.w, bottom: 17.w),
            // height: 70.h,
            decoration: BoxDecoration(
              border: Border(
                // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                bottom: BorderSide(width: 1, color: grey2),
              ),
            ),

            // color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/location2.svg',
                      width: 23.w,
                      height: 28.h,
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Text(
                      "Bhairav Nagar, Vishrantwadi\nPune - 411015",
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
                Container(
                  child: SvgPicture.asset(
                    "assets/icons/shop_edit.svg",
                    // width: 30.w,
                    // height: 30.w,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 19.0.w, top: 20.w, bottom: 10.w),
            child: Text(
              "Customer",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black1,
                    // letterSpacing: .5,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 14.w, right: 15.w, top: 9.w, bottom: 9.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      color: SplashText,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "120",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Total Customer Ordered",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 14.w, right: 15.w, top: 9.w, bottom: 9.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      color: SplashText,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(10)),

                  child: Column(
                    children: [
                      Text(
                        "200",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Customer Linked to Shop",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 11.93.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          /////

          Padding(
            padding: EdgeInsets.only(left: 19.0.w, top: 30.w, bottom: 10.w),
            child: Text(
              "Active Offer",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black1,
                    // letterSpacing: .5,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 45.w, right: 45.w, top: 9.w, bottom: 9.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "10",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Product Offer",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 11.7.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 14.w, right: 15.w, top: 9.w, bottom: 9.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(10)),

                  child: Column(
                    children: [
                      Text(
                        "9",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Coupons",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          ///////////////////////////////

          Padding(
            padding: EdgeInsets.only(left: 19.0.w, top: 30.w, bottom: 10.w),
            child: Text(
              "Product",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black1,
                    // letterSpacing: .5,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    read.onCategorySelect(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 45.w, right: 45.w, top: 9.w, bottom: 9.w),
                    // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                    // height: 50.h,/
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: <Color>[
                              green.withOpacity(0.55),
                              green1.withOpacity(0.98),
                            ]),
                        color: Custlogin,
                        // border: Border.all(width: 1, color: Black),
                        borderRadius: BorderRadius.circular(8)),

                    child: Column(
                      children: [
                        Text(
                          "5",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // letterSpacing: .5,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text(
                          "Category",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // letterSpacing: .5,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // read.onProductSelect(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 14.w, right: 15.w, top: 9.w, bottom: 9.w),
                    // height: 50.h,/
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter,
                            colors: <Color>[
                              green.withOpacity(0.55),
                              green1.withOpacity(0.98),
                            ]),
                        color: Custlogin,
                        // border: Border.all(width: 1, color: Black),
                        borderRadius: BorderRadius.circular(10)),

                    child: Column(
                      children: [
                        Text(
                          "285",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // letterSpacing: .5,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text(
                          "Products",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // letterSpacing: .5,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.w,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 45.w, right: 45.w, top: 9.w, bottom: 9.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: <Color>[
                            green.withOpacity(0.55),
                            green1.withOpacity(0.98),
                          ]),
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "25",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Products",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 14.w, right: 15.w, top: 9.w, bottom: 9.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: <Color>[
                            green.withOpacity(0.55),
                            green1.withOpacity(0.98),
                          ]),
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(10)),

                  child: Column(
                    children: [
                      Text(
                        "50",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Fulfil your cravings",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          /////////////////////////////////////////////////////

          Padding(
            padding: EdgeInsets.only(left: 19.0.w, top: 30.w, bottom: 10.w),
            child: Text(
              "Orders",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black1,
                    // letterSpacing: .5,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 19.w, right: 19.w, top: 11.w, bottom: 11.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //     end: Alignment.topCenter,
                      //     begin: Alignment.bottomCenter,
                      //     colors: <Color>[
                      //       green.withOpacity(0.55),
                      //       green1.withOpacity(0.98),
                      //     ]),
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "3000",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Total Orders",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 11.1.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 19.w, right: 19.w, top: 11.w, bottom: 11.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //     end: Alignment.topCenter,
                      //     begin: Alignment.bottomCenter,
                      //     colors: <Color>[
                      //       green.withOpacity(0.55),
                      //       green1.withOpacity(0.98),
                      //     ]),
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "200",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Pending",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 19.w, right: 19.w, top: 11.w, bottom: 11.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //     end: Alignment.topCenter,
                      //     begin: Alignment.bottomCenter,
                      //     colors: <Color>[
                      //       green.withOpacity(0.55),
                      //       green1.withOpacity(0.98),
                      //     ]),
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "370",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Confirmed",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 19.w, right: 19.w, top: 11.w, bottom: 11.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //     end: Alignment.topCenter,
                      //     begin: Alignment.bottomCenter,
                      //     colors: <Color>[
                      //       green.withOpacity(0.55),
                      //       green1.withOpacity(0.98),
                      //     ]),
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "3000",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "In process",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 19.w, right: 19.w, top: 11.w, bottom: 11.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //     end: Alignment.topCenter,
                      //     begin: Alignment.bottomCenter,
                      //     colors: <Color>[
                      //       green.withOpacity(0.55),
                      //       green1.withOpacity(0.98),
                      //     ]),
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "200",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Delivered",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 19.w, right: 19.w, top: 11.w, bottom: 11.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //     end: Alignment.topCenter,
                      //     begin: Alignment.bottomCenter,
                      //     colors: <Color>[
                      //       green.withOpacity(0.55),
                      //       green1.withOpacity(0.98),
                      //     ]),
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "370",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Cancelled",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          /////////////////////////////////////////////////////////////////////////////////
          Padding(
            padding: EdgeInsets.only(left: 19.0.w, top: 20.w, bottom: 10.w),
            child: Text(
              "Refund",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black1,
                    // letterSpacing: .5,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 40.w, right: 40.w, top: 9.w, bottom: 9.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      color: SplashText,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "INR 2000",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Pending Refund",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 11.53.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 49.w, right: 49.w, top: 9.w, bottom: 9.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      color: SplashText,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(10)),

                  child: Column(
                    children: [
                      Text(
                        "INR 3500",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 15.2.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Refunded",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 19.0.w, top: 20.w, bottom: 10.w),
            child: Text(
              "Business",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black1,
                    // letterSpacing: .5,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 24.w, right: 16.w, top: 19.w, bottom: 19.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: <Color>[
                            green.withOpacity(0.55),
                            green1.withOpacity(0.98),
                          ]),
                      color: SplashText,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Revenue",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "INR 3,00,500",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 19.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 24.w, right: 24.w, top: 9.w, bottom: 9.w),
                  // EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: <Color>[
                            green.withOpacity(0.55),
                            green1.withOpacity(0.98),
                          ]),
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(8)),

                  child: Column(
                    children: [
                      Text(
                        "INR 10,000",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Total Refund Amount",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: 14.w, right: 15.w, top: 9.w, bottom: 9.w),
                  // height: 50.h,/
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          colors: <Color>[
                            green.withOpacity(0.55),
                            green1.withOpacity(0.98),
                          ]),
                      color: Custlogin,
                      // border: Border.all(width: 1, color: Black),
                      borderRadius: BorderRadius.circular(10)),

                  child: Column(
                    children: [
                      Text(
                        "INR 15,000",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Total Cancelled Amount",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, top: 15.w, right: 0.w),
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                Image.asset(
                  'assets/images/dash.png',
                  // width: 450.w,
                  // height: 119.h,
                ),
                Positioned(
                  bottom: 17.w,
                  right: 17.w,
                  left: 8.w,
                  child: Image.asset(
                    'assets/images/dash1.png',
                    // width: 352.w,
                    // height: 60.h,
                  ),
                ),
                Positioned(
                  top: 15.w,
                  left: 25.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 67.w),
                        width: ScreenUtil().screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Standard Plan',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    // letterSpacing: .5,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: 73.w,
                              height: 20.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    primary:
                                        Colors.transparent.withOpacity(0.35)),
                                onPressed: () {},
                                child: Text(
                                  'Active',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        // letterSpacing: .5,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 7.w,
                      ),
                      Container(
                        width: ScreenUtil().screenWidth,
                        padding: EdgeInsets.only(right: 67.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '1 Year Validity ',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              'Exp Date - 25 Dec 2023',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            // SizedBox(
                            //   width: 85.w,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Stack(
          //   children: [
          //     Container(
          //       // height: 74.h,
          //       // width: 350.w,
          //       decoration: BoxDecoration(
          //           color: Custlogin,
          //           gradient: LinearGradient(
          //               end: Alignment.topCenter,
          //               begin: Alignment.bottomCenter,
          //               colors: <Color>[
          //                 yellow1.withOpacity(0.55),
          //                 yellow2.withOpacity(0.98),
          //               ]),

          //           // border: Border.all(width: 1, color: Black),
          //           borderRadius: BorderRadius.circular(10)),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Row(
          //             children: [
          //               Text(
          //                 'My Subscription Plan',
          //                 style: GoogleFonts.dmSans(
          //                   textStyle: TextStyle(
          //                       color: Colors.white,
          //                       // letterSpacing: .5,
          //                       fontSize: 12.sp,
          //                       fontWeight: FontWeight.w400),
          //                 ),
          //               ),
          //               SizedBox(
          //                 width: 73.w,
          //                 height: 20.h,
          //                 child: ElevatedButton(
          //                   style: ElevatedButton.styleFrom(
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(5),
          //                       ),
          //                       primary: Colors.transparent.withOpacity(0.35)),
          //                   onPressed: () {},
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     // mainAxisSize: MainAxisSize.min,
          //                     children: [
          //                       Text(
          //                         'Active',
          //                         style: GoogleFonts.dmSans(
          //                           textStyle: TextStyle(
          //                               color: Colors.white,
          //                               // letterSpacing: .5,
          //                               fontSize: 12.sp,
          //                               fontWeight: FontWeight.w400),
          //                         ),
          //                       ), // <-- Text
          //                       SizedBox(width: 5.w),
          //                       SvgPicture.asset("assets/icons/forward1.svg"),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Text(
          //                 'Standard Plan',
          //                 style: GoogleFonts.dmSans(
          //                   textStyle: TextStyle(
          //                       color: Colors.white,
          //                       // letterSpacing: .5,
          //                       fontSize: 18.sp,
          //                       fontWeight: FontWeight.w700),
          //                 ),
          //               ),
          //               Text(
          //                 'Exp Date - 25 Dec 2023',
          //                 style: GoogleFonts.dmSans(
          //                   textStyle: TextStyle(
          //                       color: Colors.white,
          //                       // letterSpacing: .5,
          //                       fontSize: 12.sp,
          //                       fontWeight: FontWeight.w400),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Positioned(
          //       top: 23.w,
          //       right: 11.w,
          //       // left: 8.w,
          //       child: Image.asset(
          //         'assets/images/subcurve.png',
          //         width: 352.w,
          //         height: 52.h,
          //       ),
          //     ),
          //   ],
          // ),

          SizedBox(
            height: 80.w,
          ),
        ]),
      ),
    );
  }
}
