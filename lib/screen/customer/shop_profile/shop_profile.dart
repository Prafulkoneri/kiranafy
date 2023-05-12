import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/review/view/c_review_view.dart';
import 'package:local_supper_market/screen/customer/home/view/category.dart';

import 'package:local_supper_market/screen/customer/home/view/category1.dart';
import 'package:local_supper_market/screen/customer/home/view/coupons.dart';
import 'package:local_supper_market/screen/customer/shop_profile/Seasonal_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/offer_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/recommendation_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view_all_offer_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view_all_seasonal_products.dart';

class ShopProfile extends StatefulWidget {
  const ShopProfile({super.key});

  @override
  State<ShopProfile> createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile> {
  PageController? _pageController;

  List<String> images = [
    "assets/images/property1.png",
    "assets/images/property1.png",
    "assets/images/property1.png",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 1);
  }

  int activePage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(left: 19.w, top: 40.h, right: 20.w),
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
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/location1.svg',
                      width: 15.w,
                      height: 19.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Vishrantwadi, Pune",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: SplashText1,
                            // letterSpacing: .5,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.w),
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
                        Flexible(
                          child: Text(
                            "New Balaji Trading Company",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: .5,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CReviewScreenView()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 15.w),
                            height: 24.h,
                            width: 55.w,
                            decoration: BoxDecoration(
                              color: yellow,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
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
            padding: EdgeInsets.all(12.w),
            height: 70.h,
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
                      width: 8.w,
                    ),
                    Text(
                      "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Black,
                            // letterSpacing: .5,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/call.svg',
                      // width: 15.w,
                      // height: 19.h,
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    SvgPicture.asset(
                      'assets/images/fvrt.svg',
                      // width: 15.w,
                      // height: 19.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 19.h,
              right: 20.w,
              top: 15.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Offer Products",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: DarkBlack,
                        // letterSpacing: .3,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllOfferProducts()),
                    );
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: CouponsText,
                          // letterSpacing: .3,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.w),
            child: const OfferProducts(),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 19.h,
              right: 20.w,
              top: 15.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seasonal Products",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: DarkBlack,
                        // letterSpacing: .3,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllSeasonalProducts()),
                    );
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: CouponsText,
                          // letterSpacing: .3,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.w),
            child: const SeasonalProducts(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h, left: 19.h, bottom: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Shop By Category",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black,
                        letterSpacing: .5,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          ShopCategory(),
          Padding(
            padding: EdgeInsets.only(top: 17.w),
            child: const CouponsScreen(),
          ),
          const RecommendationProducts(),
        ]),
      ),
    );
  }
}
