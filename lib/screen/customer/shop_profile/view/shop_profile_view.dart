import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/review/view/c_review_view.dart';
import 'package:local_supper_market/screen/customer/home/view/category.dart';

import 'package:local_supper_market/screen/customer/home/view/category1.dart';
import 'package:local_supper_market/screen/customer/home/view/coupons.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/Seasonal_products.dart';
import 'package:provider/provider.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/offer_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/recommendation_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/view_all_offer_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/view_all_seasonal_products.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopProfile extends StatefulWidget {
  final String? shopId;

  const ShopProfile({super.key, required this.shopId});

  @override
  State<ShopProfile> createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile> {
  PageController? _pageController;

  List<String> images = [
    "assets/images/customerBanner.png",
    "assets/images/customerBanner.png",
    "assets/images/customerBanner.png",
  ];

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ShopProfileController>().initState(context, widget.shopId);
    });
    _pageController = PageController(viewportFraction: 0.9, initialPage: 1);
  }

  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ShopProfileController>();
    final read = context.read<ShopProfileController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          readMain.onBackPressed(0, HomeScreenView());
          return true;
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
              padding: EdgeInsets.only(left: 20.w, top: 40.h, right: 20.w),
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
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Stack(
              children: [
                Align(
                  child: SizedBox(
                    height: 181.0.h,
                    // width: 390.0,
                    child: const Carousel(
                      images: [
                        AssetImage(
                          "assets/images/shop_image.png",
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
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    width: ScreenUtil().screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            watch.shopDetails?.shopName ?? "",
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
                            padding: EdgeInsets.symmetric(
                                vertical: 5.w, horizontal: 10.w),
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
                                  "0.0",
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
            Container(
              padding: EdgeInsets.all(12.w),
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
                        width: 8.w,
                      ),
                      
                      Container(
                        width: 200.w,
                        child: Text(
                          "${watch.shopDetails?.shopAddress}\n${watch.shopDetails?.cityName} - ${watch.shopDetails?.shopPincode}",
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Black,
                                // letterSpacing: .5,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          read.launchPhone(
                              watch.shopDetails?.shopOwnerSupportNumber ?? "",
                              context);
                        },
                        child: SvgPicture.asset(
                          'assets/images/call.svg',
                          // width: 15.w,
                          // height: 19.h,
                        ),
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
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 19.h,
                right: 19.w,
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
            SizedBox(
              height: 15.h,
            ),
                watch.offerProduct?.isNotEmpty??false? OfferProducts():Container(),
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
              child:  watch.seasonalProduct?.isNotEmpty??false? SeasonalProducts():Container(),
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
            SizedBox(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: watch.shopCategory?.length ?? 0,
                        itemBuilder: (BuildContext, index) {
                          final element = watch.shopCategory?[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 19.w : 0,
                                          // top: 15.w,
                                          right: index == 7 ? 19.w : 5.w),
                                      // margin: EdgeInsets.only(right: 10.h),
                                      decoration: BoxDecoration(
                                          color: CategoryOne,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height: 50.h,
                                      width: 70.w,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.w),
                                        child: Image.network(
                                          "${element?.categoryImagePath}",
                                          width: 68.w,
                                          height: 49.w,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 19.w : 0,
                                          // top: 15.w,
                                          right: index == 7 ? 19.w : 5.w),
                                      alignment: Alignment.center,
                                      width: 70.w,
                                      child: Text(
                                        "${element?.categoryName}",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 11.5.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                                // SizedBox(
                                //   width: 10.w,
                                // )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // SizedBox(
                    //   height: 100.h,
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.zero,
                    //     scrollDirection: Axis.horizontal,
                    //     physics: NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     itemCount: 8,
                    //     itemBuilder: (BuildContext, index) {
                    //       return GestureDetector(
                    //         onTap: () {},
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Column(
                    //               children: [
                    //                 Container(
                    //                   margin: EdgeInsets.only(
                    //                       left: index == 0 ? 19.w : 0,
                    //                       // top: 15.w,
                    //                       right: index == 7 ? 19.w : 5.w),
                    //                   // margin: EdgeInsets.only(right: 10.h),
                    //                   decoration: BoxDecoration(
                    //                       color: CategoryOne,
                    //                       borderRadius: BorderRadius.all(
                    //                           Radius.circular(10))),
                    //                   height: 50.h,
                    //                   width: 70.w,
                    //                   child: Padding(
                    //                     padding: EdgeInsets.all(8.w),
                    //                     child: Image.asset(
                    //                       'assets/images/gridone.png',
                    //                       width: 68.w,
                    //                       height: 49.w,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   margin: EdgeInsets.only(
                    //                       left: index == 0 ? 19.w : 0,
                    //                       // top: 15.w,
                    //                       right: index == 7 ? 19.w : 5.w),
                    //                   alignment: Alignment.center,
                    //                   width: 70.w,
                    //                   child: Text(
                    //                     "Cold Drink\n & Juices",
                    //                     textAlign: TextAlign.center,
                    //                     style: GoogleFonts.dmSans(
                    //                       textStyle: TextStyle(
                    //                           color: Black,
                    //                           letterSpacing: .5,
                    //                           fontSize: 11.5.sp,
                    //                           fontWeight: FontWeight.w500),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //             ),
                    //             // SizedBox(
                    //             //   width: 10.w,
                    //             // )
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 17.w),
              child: const CouponsScreen(),
            ),
            watch.recommandedProduct?.isNotEmpty??false? RecommendationProducts():Container(),
                SizedBox(
                  height: 100.w,
                ),
          ]),
        ),
      ),
    );
  }
}
