import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';

import 'package:local_supper_market/screen/shop_owner/s_dashboard/controller/s_dashboard_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'package:provider/provider.dart';

class ShopDashBoard extends StatefulWidget {
  const ShopDashBoard({super.key});

  @override
  State<ShopDashBoard> createState() => _ShopDashBoardState();
}

class _ShopDashBoardState extends State<ShopDashBoard> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SDashBoardController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SDashBoardController>();
    final watch = context.watch<SDashBoardController>();
    final watchMainScreen = context.watch<SMainScreenController>();
    final readMainScreen = context.watch<SMainScreenController>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                      children: [
                        Flexible(
                          child: Text(
                            "${watch.shopName}",
                            // "New Balaji Trading Company",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700),
                            ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${watch.address}",
                          // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Black,
                                // letterSpacing: .5,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text(
                          "${watch.pincode}",
                          // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
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
                  ],
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      read.onEditBtnClicked(context);
                    },
                    child: SvgPicture.asset(
                      "assets/icons/shop_edit.svg",
                      // width: 30.w,
                      // height: 30.w,
                    ),
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
                child: InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: SSCategoryListView(),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.sizeUp);
                  },
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
                      // crossAxisAlignment: CrossAxisAlignment.center,
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
                          textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
                  // height: 55.h,
                  // width: 170.w,
                  padding: EdgeInsets.only(
                      left: 45.w, right: 45.w, top: 9.w, bottom: 9.w),

                  decoration: BoxDecoration(
                      color: Custlogin, borderRadius: BorderRadius.circular(8)),

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
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
                    readMainScreen.onNavigation(
                        0, SSCategoryListView(), context);
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
                          "${watch.dashBoardData?.categoriesCount}",
                          // watch.dashBoardData.categoriesCount
                          // "5",
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
                          "${watch.dashBoardData?.productsCount}",
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
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
                        "Pending",
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 11.sp,
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
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "Refunded",
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
            padding: EdgeInsets.only(
                left: 19.w, top: 15.w, right: 19.w, bottom: 80.w),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Custlogin,
                          gradient: LinearGradient(
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter,
                              colors: <Color>[
                                yellow1.withOpacity(1),
                                yellow2.withOpacity(1),
                              ]),

                          // border: Border.all(width: 1, color: Black),
                          borderRadius: BorderRadius.circular(10.w)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.w,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.w),
                            child: Image.asset(
                              'assets/images/subscription4.png',
                              // width: 352.w,
                              // height: 60.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 14.w,
                        left: 15.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: ScreenUtil().screenWidth / 1.13.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "My Subscription Plan",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 12.sp),
                                  ),
                                  Container(
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 11.w,
                                                                right: 14.w,
                                                                left: 25.w),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "Advanced Plan - ₹6000",
                                                                style:
                                                                    GoogleFonts
                                                                        .dmSans(
                                                                  textStyle: TextStyle(
                                                                      color:
                                                                          Black,
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                )),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: SvgPicture
                                                                  .asset(
                                                                      "assets/icons/pop_delete.svg"),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 23.w,
                                                          right: 16.w,
                                                        ),
                                                        height: 646.h,
                                                        // width: 362.w,
                                                        child: ListView.builder(
                                                          itemCount: 20,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Column(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    // mainAxisAlignment:
                                                                    //     MainAxisAlignment.center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .circle_rounded,
                                                                        size:
                                                                            5.w,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        // softWrap: true,
                                                                        // maxLines: 3,//
                                                                        "Ready grocery item master",

                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Black1,
                                                                              height: 1.5,

                                                                              // letterSpacing: .05,
                                                                              // overflow: TextOverflow.ellipsis,
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left:
                                                                                32.w,
                                                                            right: 32.w),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              1.w,
                                                                          height:
                                                                              35.w,
                                                                          color:
                                                                              grey11,
                                                                        ),
                                                                      ),
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/correct.svg")
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 11.w, vertical: 4.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7.w),
                                          color: Color(0xff000000)
                                              .withOpacity(0.35),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.start,
                                          // mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Active',
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    // letterSpacing: .5,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ), // <-- Text
                                          ],
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
                              width: ScreenUtil().screenWidth / 1.13.w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Standard Plan",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Exp Date - 25 Dec 2023",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 22.w,
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: 16.w,
          ),
        ]),
      ),
    );
  }
}
