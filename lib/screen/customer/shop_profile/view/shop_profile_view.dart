import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/category/view/category_view.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen.dart';
import 'package:local_supper_market/screen/customer/review/view/c_review_view.dart';
import 'package:local_supper_market/screen/customer/home/view/category.dart';

import 'package:local_supper_market/screen/customer/home/view/category1.dart';
import 'package:local_supper_market/screen/customer/home/view/coupons.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/Seasonal_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/view_all_recommanded_products.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/offer_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/recommendation_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/view_all_offer_products.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/view_all_seasonal_products.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopProfileView extends StatefulWidget {
  final String? shopId;
  final String? routeName;
  final String? categoryId;
  final bool? refreshPage;

  const ShopProfileView(
      {super.key,
      required this.shopId,
      required this.routeName,
      this.categoryId,
      required this.refreshPage});

  @override
  State<ShopProfileView> createState() => _ShopProfileViewState();
}

class _ShopProfileViewState extends State<ShopProfileView> {




  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<ShopProfileViewController>()
          .initState(context, widget.shopId, widget.refreshPage);
    });
  }

  // int activePage = 0;

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ShopProfileViewController>();
    final read = context.read<ShopProfileViewController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(

      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : WillPopScope(
              onWillPop: () async {
                read.onBackPressed(
                    widget.routeName, context, widget.categoryId);

                return false;
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 20.w, top: 40.h, right: 20.w),
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
                            child:  watch.bannerImageData!.isEmpty
                                ? Container(
                                height: 180.w,
                                child: Image.asset(
                                  "assets/images/shop_image.png",
                                  height: 191.w,
                                  fit: BoxFit.fill,
                                )):SizedBox(
                              height: 180.0.h,
                              child: PageView.builder(
                                  allowImplicitScrolling: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  controller: watch.pageController,
                                  onPageChanged: (index) {},
                                  itemCount: watch.bannerImageData?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final element =
                                        watch.bannerImageData?[index];
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        element?.imagesPath == ""
                                            ? Container(
                                                height: 190.w,
                                                child: Image.asset(
                                                  "assets/images/shop_image.png",
                                                  height: 191.w,
                                                  fit: BoxFit.fill,
                                                ))
                                            : Container(
                                                height: 190.w,
                                                child: AppNetworkImages(
                                                    imageUrl:
                                                        element?.imagesPath ??
                                                            "",
                                                    fit: BoxFit.cover),
                                                width: ScreenUtil().screenWidth,
                                              ),
                                      ],
                                    );
                                  }),
                              // Carousel(
                              //   images: [
                              //     AssetImage(
                              //       "assets/images/shop_image.png",
                              //     ),
                              //     // AssetImage(
                              //     //   "assets/images/property2.png",
                              //     // ),
                              //
                              //     // ExactAssetImage("images/image-carousel.jpeg"),
                              //   ],
                              //   autoplay: true,
                              //   animationDuration: Duration(milliseconds: 1000),
                              //   dotBgColor: Colors.red,
                              //   showIndicator: false,
                              //   // dotSize: 6.0,
                              //   // dotSpacing: 15.0,
                              //   // dotColor: Colors.lightGreenAccent,
                              //   // borderRadius: true,
                              // ),
                            ),
                          ),
                          Positioned(
                            //<-- SEE HERE
                            // right: 15.w,
                            // left: 0.w,
                            bottom: 20.w,
                            child: Container(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w),
                              width: ScreenUtil().screenWidth,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            builder: (context) =>
                                                CReviewScreenView()),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.w, horizontal: 10.w),
                                      decoration: BoxDecoration(
                                        color: yellow,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        watch.shopDetails
                                                ?.shopOwnerSupportNumber ??
                                            "",
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
                                InkWell(
                                  onTap: () {
                                    watch.favAllShop
                                        ? read.removeAllShopFavList(
                                            context, watch.shopDetails?.id)
                                        : read.updateAllShopFavList(
                                            context, watch.shopDetails?.id);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 13.w,
                                        right: 13.w,
                                        top: 14.w,
                                        bottom: 14.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff4689EC),
                                    ),
                                    child: watch.favAllShop
                                        ? SvgPicture.asset(
                                            "assets/icons/fav_selected.svg",
                                            width: 26.w,
                                            height: 14.h,
                                          )
                                        : SvgPicture.asset(
                                            "assets/images/favorite.svg",
                                            width: 26.w,
                                            height: 14.h,
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      watch.allOfferProducts?.isNotEmpty ?? false
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 19.h,
                                    right: 19.w,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainScreenView(
                                                      index: 0,
                                                      screenName:
                                                          AllOfferProducts(
                                                        shopId: widget.shopId,
                                                      ),
                                                    )),
                                            (Route<dynamic> route) => false,
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
                                )
                              ],
                            )
                          : Container(),

                      SizedBox(
                        height: 15.h,
                      ),

                      SizedBox(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                watch.offerProduct?.length ?? 0, (index) {
                              final element = watch.offerProduct?[index];
                              return watch.offerProduct?[index].mrpPrice !=
                                          "" &&
                                      watch.offerProduct?[index].offerPrice !=
                                          "" &&
                                      int.parse(element?.offerPrice ?? "0") <
                                          int.parse(element?.mrpPrice ?? "0")
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.pushAndRemoveUntil(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) => MainScreenView(
                                            //           index: 1,
                                            //           screenName: ProductScreenView(
                                            //             categoryId: widget.categoryId,
                                            //             productId: element?.id.toString(),
                                            //             shopId: widget.shopId,
                                            //           )
                                            //       )),
                                            //       (Route<dynamic> route) => false,
                                            // );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.03.w),
                                                    blurRadius: 5,
                                                    spreadRadius: 0,
                                                    offset: Offset(0, 3)),
                                              ],
                                            ),
                                            child: Card(
                                              // shape: ShapeBorder.
                                              elevation: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.w),
                                                ),
                                                width: 156.w,
                                                padding: EdgeInsets.only(
                                                    left: 19.w,
                                                    top: 14.w,
                                                    right: 12.w,
                                                    bottom: 12.w),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        element?.discountPercentage !=
                                                                ""
                                                            ? Container(
                                                                width: 60.w,
                                                                height: 20.h,
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        lightgreen,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(5.w))),
                                                                child: Center(
                                                                  child: Text(
                                                                      "${element?.discountPercentage} off",
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
                                                                            fontWeight: FontWeight.w500),
                                                                      )),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        element?.productImagePath ==
                                                                ""
                                                            ? Container(
                                                                height: 89.w,
                                                                width: 89.w,
                                                                child:
                                                                    Image.asset(
                                                                  "assets/images/profile_image.png",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              )
                                                            : Container(
                                                                height: 89.w,
                                                                width: 89.w,
                                                                child: Image
                                                                    .network(
                                                                  "${element?.productImagePath}",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3.w,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            "${element?.productName}",
                                                            maxLines: 1,
                                                            style: GoogleFonts
                                                                .roboto(
                                                              textStyle:
                                                                  TextStyle(
                                                                color: Black1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                // letterSpacing: .5,
                                                                fontSize: 16.sp,

                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2.w,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "${element?.weight}${element?.unit}",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            textStyle:
                                                                TextStyle(
                                                                    color:
                                                                        Black1,
                                                                    // letterSpacing: .5,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2.w,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            element?.mrpPrice !=
                                                                    ""
                                                                ? Text(
                                                                    '\u{20B9}${element?.mrpPrice}',
                                                                    style: GoogleFonts.dmSans(
                                                                        textStyle: element?.offerPrice != "" && element?.offerPrice != element?.mrpPrice
                                                                            ? TextStyle(
                                                                                decoration: TextDecoration.lineThrough,
                                                                                color: Black1,
                                                                                letterSpacing: .5,
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w400)
                                                                            : TextStyle(color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400)))
                                                                : Text(""),
                                                            SizedBox(
                                                              width: 5.w,
                                                            ),
                                                            element?.offerPrice !=
                                                                        "" &&
                                                                    element?.offerPrice !=
                                                                        element
                                                                            ?.mrpPrice
                                                                ? Text(
                                                                    '\u{20B9}${element?.offerPrice}',
                                                                    style: GoogleFonts
                                                                        .dmSans(
                                                                      textStyle: TextStyle(
                                                                          // decoration:
                                                                          // TextDecoration.lineThrough,
                                                                          color: Black,
                                                                          letterSpacing: .5,
                                                                          fontSize: 13.sp,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                  )
                                                                : Text(""),
                                                          ],
                                                        ),
                                                        SvgPicture.asset(
                                                          'assets/images/add.svg',
                                                          // width: 15.w,
                                                          // height: 19.h,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container();
                            }),
                          ),
                        ),
                      ),
                      //  Container(),

                      watch.seasonalProduct?.isNotEmpty ?? false
                          ? Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 19.h,
                                    right: 20.w,
                                    top: 15.w,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainScreenView(
                                                        index: 0,
                                                        screenName:
                                                            AllSeasonalProducts(
                                                          shopId: widget.shopId,
                                                        ))),
                                            (Route<dynamic> route) => false,
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
                              ],
                            )
                          : Container(),

                      Padding(
                        padding: EdgeInsets.only(top: 15.w),
                        child: watch.seasonalProduct?.isNotEmpty ?? false
                            ? SizedBox(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(
                                        watch.seasonalProduct?.length ?? 0,
                                        (index) {
                                      final element =
                                          watch.seasonalProduct?[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainScreenView(
                                                      index: 1,
                                                      screenName:
                                                          ProductScreenView(
                                                              categoryId: element
                                                                  ?.categoryId
                                                                  .toString(),
                                                              // categoryId: watch.categoryId,
                                                              productId: element
                                                                  ?.id
                                                                  .toString(),
                                                              shopId:
                                                                  widget.shopId,
                                                              productType: element
                                                                  ?.productType),
                                                    )),
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.03.w),
                                                      blurRadius: 5,
                                                      spreadRadius: 0,
                                                      offset: Offset(0, 3)),
                                                ],
                                              ),
                                              child: Card(
                                                elevation: 0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.w),
                                                  ),
                                                  width: 156.w,
                                                  padding: EdgeInsets.only(
                                                      left: 19.w,
                                                      top: 14.w,
                                                      right: 12.w,
                                                      bottom: 12.w),
                                                  child: Column(
                                                    children: [
                                                      element?.discountPercentage !=
                                                              ""
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  width: 60.w,
                                                                  height: 20.h,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          lightgreen,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(5.w))),
                                                                  child: Center(
                                                                    child: Text(
                                                                        "${element?.discountPercentage} off",
                                                                        // textAlign: TextAlign.center,
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Colors.white,
                                                                              letterSpacing: .5,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w500),
                                                                        )),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          element?.productImagePath ==
                                                                  ""
                                                              ? Container(
                                                                  height: 89.w,
                                                                  width: 89.w,
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/images/profile_image.png",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 89.w,
                                                                  width: 89.w,
                                                                  child: Image
                                                                      .network(
                                                                    "${element?.productImagePath}",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 3.w,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              "${element?.productName}",
                                                              maxLines: 1,
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                textStyle:
                                                                    TextStyle(
                                                                  color: Black1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  // letterSpacing: .5,
                                                                  fontSize:
                                                                      16.sp,

                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 2.w,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${element?.weight}${element?.unit}",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              textStyle:
                                                                  TextStyle(
                                                                      color:
                                                                          Black1,
                                                                      // letterSpacing: .5,
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 2.w,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              element?.mrpPrice !=
                                                                      ""
                                                                  ? Text(
                                                                      '\u{20B9}${element?.mrpPrice}',
                                                                      style: GoogleFonts.dmSans(
                                                                          textStyle: element?.offerPrice != "" && element?.offerPrice != element?.mrpPrice
                                                                              ? TextStyle(decoration: TextDecoration.lineThrough, color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400)
                                                                              : TextStyle(color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400)))
                                                                  : Text(""),
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                              element?.offerPrice !=
                                                                          "" &&
                                                                      element?.offerPrice !=
                                                                          element
                                                                              ?.mrpPrice
                                                                  ? Text(
                                                                      '\u{20B9}${element?.offerPrice}',
                                                                      style: GoogleFonts
                                                                          .dmSans(
                                                                        textStyle: TextStyle(
                                                                            // decoration:
                                                                            // TextDecoration.lineThrough,
                                                                            color: Black,
                                                                            letterSpacing: .5,
                                                                            fontSize: 13.sp,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                    )
                                                                  : Text(""),
                                                            ],
                                                          ),
                                                          SvgPicture.asset(
                                                            'assets/images/add.svg',
                                                            // width: 15.w,
                                                            // height: 19.h,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),

                                // ListView.builder(
                                //     scrollDirection: Axis.horizontal,
                                //     physics: BouncingScrollPhysics(),
                                //     shrinkWrap: true,
                                //     itemCount: 3,
                                //     itemBuilder: (BuildContext, index) {
                                //       return Row(
                                //         children: [
                                //           Container(
                                //             // decoration: BoxDecoration(
                                //             //   boxShadow: [
                                //             //     BoxShadow(
                                //             //       color: Colors.grey.shade200,
                                //             //       spreadRadius: 10,
                                //             //       blurRadius: 200,
                                //             //       offset: Offset(0, 5), // changes position of shadow
                                //             //     ),
                                //             //   ],
                                //             // ),
                                //             width: 182.w,
                                //             height: 156.h,
                                //             margin: EdgeInsets.only(
                                //                 left: index == 0 ? 19.w : 0,
                                //                 right: index == 2 ? 19.w : 5.w),
                                //             child: Card(
                                //               elevation: 1,
                                //               // color: black,
                                //               shape: RoundedRectangleBorder(
                                //                 borderRadius: BorderRadius.circular(15.0),
                                //               ),
                                //               child: Padding(
                                //                 padding: EdgeInsets.only(left: 17.w),
                                //                 child: Column(
                                //                   crossAxisAlignment: CrossAxisAlignment.start,
                                //                   children: [
                                //                     Row(
                                //                       mainAxisAlignment: MainAxisAlignment.center,
                                //                       crossAxisAlignment: CrossAxisAlignment.start,
                                //                       children: [
                                //                         Padding(
                                //                           padding: EdgeInsets.only(
                                //                               top: 14.w,
                                //                               left: 34.w,
                                //                               right: 40.w,
                                //                               bottom: 2.w),
                                //                           child: Card(
                                //                               child: Image.asset(
                                //                                   "assets/images/redlabel.png")),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                     Text(
                                //                       "Red Label",
                                //                       style: GoogleFonts.roboto(
                                //                         textStyle: TextStyle(
                                //                             color: Black1,
                                //                             // letterSpacing: .5,
                                //                             fontSize: 16.sp,
                                //                             fontWeight: FontWeight.w600),
                                //                       ),
                                //                     ),
                                //                     SizedBox(
                                //                       height: 2.h,
                                //                     ),
                                //                     Text(
                                //                       "100g",
                                //                       style: GoogleFonts.roboto(
                                //                         textStyle: TextStyle(
                                //                             color: Black1,
                                //                             // letterSpacing: .5,
                                //                             fontSize: 12.sp,
                                //                             fontWeight: FontWeight.w600),
                                //                       ),
                                //                     ),
                                //                     Row(
                                //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                       crossAxisAlignment: CrossAxisAlignment.end,
                                //                       children: [
                                //                         Text(
                                //                           '\u{20B9}${40}',
                                //                           style: GoogleFonts.roboto(
                                //                             textStyle: TextStyle(
                                //                                 color: Black1,
                                //                                 // letterSpacing: .5,
                                //                                 fontSize: 12.sp,
                                //                                 fontWeight: FontWeight.w600),
                                //                           ),
                                //                         ),
                                //                         Padding(
                                //                           padding: EdgeInsets.only(right: 12.w),
                                //                           child: SvgPicture.asset(
                                //                             'assets/images/add.svg',
                                //                             // width: 15.w,
                                //                             // height: 19.h,
                                //                           ),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //             ),
                                //           )
                                //         ],
                                //       );
                                //     }),
                              )
                            : Container(),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: 30.h, left: 19.h, bottom: 15.h),
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
                          physics: BouncingScrollPhysics(),
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
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainScreenView(
                                                      index: 0,
                                                      screenName:
                                                          CategoryScreenView(
                                                        shopId: widget.shopId,
                                                        categoryId: element?.id
                                                            .toString(),
                                                      ))),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: index == 0 ? 19.w : 0,
                                                    // top: 15.w,
                                                    right: index + 1 ==
                                                            watch.shopCategory
                                                                ?.length
                                                        ? 19.w
                                                        : 5.w),
                                                // margin: EdgeInsets.only(right: 10.h),
                                                decoration: BoxDecoration(
                                                    color: CategoryOne,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                height: 50.h,
                                                width: 70.w,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8.w),
                                                  child: AppNetworkImages(
                                                    imageUrl: "${element?.categoryImagePath}",
                                                    width: 68.w,
                                                    height: 49.w,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 3.w
                                                    // left: index == 0 ? 19.w : 0,
                                                    // // top: 15.w,
                                                    // right: index == 7
                                                    //     ? 19.w
                                                    //     : 5.w
                                                    ),
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
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                      watch.recommandedProduct?.isNotEmpty ?? false
                          ? Container(
                              width: 352.w,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Recommendations",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: DarkBlack,
                                                letterSpacing: .5,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreenView(
                                                          index: 0,
                                                          screenName:
                                                              AllRecommandedProductsView(
                                                            shopId:
                                                                widget.shopId,
                                                          ))),
                                              (Route<dynamic> route) => false,
                                            );
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) => AllRecommandedProductsView(
                                            //             shopId: widget.shopId,
                                            //           )),
                                            // );
                                          },
                                          child: Text(
                                            "See all",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: CouponsText,
                                                  letterSpacing: .5,
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Container(
                                      // width: 322.w,
                                      // height: 86.h,
                                      // color: Colors.white,

                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: watch
                                                  .recommandedProduct?.length ??
                                              0,
                                          itemBuilder: (BuildContext, index) {
                                            final element = watch
                                                .recommandedProduct?[index];
                                            var row = Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 13.w),
                                                      child: element?.mrpPrice != ""
                                                          ? Text(
                                                              '\u{20B9}${element?.mrpPrice}',
                                                              style: GoogleFonts.dmSans(
                                                                  textStyle: element?.offerPrice != "" &&
                                                                          element?.offerPrice !=
                                                                              element
                                                                                  ?.mrpPrice
                                                                      ? TextStyle(
                                                                          decoration: TextDecoration
                                                                              .lineThrough,
                                                                          color:
                                                                              Black1,
                                                                          letterSpacing:
                                                                              .5,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w400)
                                                                      : TextStyle(
                                                                          color:
                                                                              Black1,
                                                                          letterSpacing:
                                                                              .5,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.w400)))
                                                          : Text(""),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 13.w, left: 5.w),
                                                      child: element?.offerPrice !=
                                                                  "" &&
                                                              element?.offerPrice !=
                                                                  element
                                                                      ?.mrpPrice
                                                          ? Text(
                                                              '\u{20B9}${element?.offerPrice}',
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    // decoration:
                                                                    // TextDecoration.lineThrough,
                                                                    color: Black,
                                                                    letterSpacing: .5,
                                                                    fontSize: 13.sp,
                                                                    fontWeight: FontWeight.w500),
                                                              ),
                                                            )
                                                          : Text(""),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/add.svg',
                                                      // width: 30.w,
                                                      // height: 30.h,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              MainScreenView(
                                                                index: 1,
                                                                screenName:
                                                                    ProductScreenView(
                                                                        categoryId: element
                                                                            ?.categoryId
                                                                            .toString(),
                                                                        // categoryId: watch.categoryId,
                                                                        productId: element
                                                                            ?.id
                                                                            .toString(),
                                                                        shopId: widget
                                                                            .shopId,
                                                                        productType:
                                                                            element?.productType),
                                                              )),
                                                  (Route<dynamic> route) =>
                                                      false,
                                                );
                                              },
                                              child: Container(
                                                // color: Colors.white,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 9.h,
                                                          bottom: 9.h),
                                                      child:
                                                          element?.productImagePath ==
                                                                  ""
                                                              ? Image(
                                                                  image: AssetImage(
                                                                      "assets/images/offerone.png"),
                                                                  height: 68.h,
                                                                  width: 68.w,
                                                                )
                                                              : Image(
                                                                  image: NetworkImage(
                                                                      element?.productImagePath ??
                                                                          ''),
                                                                  height: 68.h,
                                                                  width: 68.w,
                                                                ),
                                                    ),
                                                    SizedBox(
                                                      height: 70.h,
                                                      child: VerticalDivider(
                                                          color: lightgrey,
                                                          thickness: 0.5,
                                                          indent: 5,
                                                          endIndent: 5),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 9.w,
                                                                top: 10.h,
                                                                right: 13.w),
                                                        child: Column(
                                                          // mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                      "${element?.productName}",
                                                                      style: GoogleFonts
                                                                          .dmSans(
                                                                        textStyle: TextStyle(
                                                                            color:
                                                                                Black,
                                                                            letterSpacing:
                                                                                .5,
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight: FontWeight.w700),
                                                                      )),
                                                                ),
                                                                element?.discountPercentage !=
                                                                        ""
                                                                    ? Container(
                                                                        width:
                                                                            60.w,
                                                                        height:
                                                                            20.h,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                lightgreen,
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(5.w))),
                                                                        child:
                                                                            Center(
                                                                          child: Text(
                                                                              "${element?.discountPercentage} off",
                                                                              // textAlign: TextAlign.center,
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                                              )),
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 6.h,
                                                            ),
                                                            Text(
                                                              "${element?.weight}${element?.unit}",
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    color: Grey,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            //
                                                            // SizedBox(
                                                            //   height: 10.h,
                                                            // ),
                                                            row,
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        index == 2 ? 5 : 10.h),
                                              ),
                                            );
                                          }
                                          // child:

                                          ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 100.w,
                      ),
                    ]),
              ),
            ),
    );
  }
}
