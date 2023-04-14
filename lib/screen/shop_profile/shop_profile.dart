import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/Home/category.dart';
import 'package:local_supper_market/screen/Home/coupons.dart';
import 'package:local_supper_market/screen/shop_profile/Seasonal_products.dart';
import 'package:local_supper_market/screen/shop_profile/offer_products.dart';
import 'package:local_supper_market/screen/shop_profile/recommendation_products.dart';

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
                      // width: 15.w,
                      // height: 19.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Vishrantwadi, Pune",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: SplashText1,
                            letterSpacing: .5,
                            fontSize: 13.sp,
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
                  left: 15.w,
                  top: 160.w,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Balaji Trading Company",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35.w),
                        child: Container(
                          height: 24.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                      letterSpacing: .5,
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
              ],
              // child:
            ),
          ),
          Container(
            height: 70.h,
            decoration: BoxDecoration(
              border: Border(
                // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                bottom: BorderSide(width: 1, color: grey2),
              ),
            ),

            // color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 20.w, bottom: 20.w),
                  child: SvgPicture.asset(
                    'assets/images/location2.svg',
                    // width: 15.w,
                    // height: 19.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, top: 24.w, bottom: 15.w),
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
                  padding: EdgeInsets.only(
                      left: 36.h, right: 11.w, top: 12.w, bottom: 12.w),
                  child: Row(
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
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black,
                        letterSpacing: .3,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: CouponsText,
                        letterSpacing: .3,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500),
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
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black,
                        letterSpacing: .3,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: CouponsText,
                        letterSpacing: .3,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.w),
            child: const SeasonalProducts(),
          ),
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
          const ShopCategory(),
          const CouponsScreen(),
          const RecommendationProducts(),
        ]),
      ),
    );
  }
}
