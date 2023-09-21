import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/controller/offer_seasonal_recommanded_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/controller/s_dashboard_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_edit_admin_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_edit_custom_product_view.dart';
import 'package:local_supper_market/utils/utils.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class ShopSeasonalRecommandedOfferProductsView extends StatefulWidget {
  final String? selectedProduct;
  final bool? isRefresh;
  const ShopSeasonalRecommandedOfferProductsView(
      {super.key, required this.selectedProduct, required this.isRefresh});

  @override
  State<ShopSeasonalRecommandedOfferProductsView> createState() =>
      _ShopSeasonalRecommandedOfferProductsViewState();
}

class _ShopSeasonalRecommandedOfferProductsViewState
    extends State<ShopSeasonalRecommandedOfferProductsView> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<ShopSeasonalRecommandedOfferProductsController>()
          .initState(context, widget.selectedProduct, widget.isRefresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch =
        context.watch<ShopSeasonalRecommandedOfferProductsController>();
    final read = context.read<ShopSeasonalRecommandedOfferProductsController>();
    final watchDashBoardScreen = context.read<SDashBoardController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
            onBackBtnPressed: () {
              widget.selectedProduct == "recommended"
                  ?
              readMainScreen.onNavigation(4, SAccountScreenView(
                refresh: false,
              ), context)
              // Navigator.pushAndRemoveUntil(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => SMainScreenView(
              //                   index: 4,
              //                   screenName: SAccountScreenView(
              //                     refresh: false,
              //                   ),
              //                 )),
              //         (Route<dynamic> route) => false,
              //       )
                  : readMainScreen.onNavigation(0, ShopDashBoardView(
                refresh: true,
              ), context);
              // Navigator.pushAndRemoveUntil(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => SMainScreenView(
              //                   index: 0,
              //                   screenName: ShopDashBoardView(
              //                     refresh: false,
              //                   ),
              //                 )),
              //         (Route<dynamic> route) => false,
              //       );
            },
            title: watch.isRecommadedPressed
                ? "Recommended Products"
                : watch.isSeasonalPressed
                    ? "Seasonal Products"
                    : "Fulfil your cravings\nProducts"),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 6.w, right: 6.w, bottom: 6.w, top: 6.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(bottom: 0.w, top: 0.w),
                        child: GestureDetector(
                            onTap: () {
                              read.onRecommendedTapped();
                            },
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              height: 45.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.w),
                                  color: Colors.transparent,
                                  border: Border.all(

                                      color: watch.isRecommadedPressed
                                          ? Color(0xff39C19D)
                                          : Colors.transparent),
                                  ),

                              child: Center(
                                child: Text(
                                  "Recommended",
                                  style: TextStyle(
                                      color: watch.isRecommadedPressed
                                          ? Color(0xff39C19D)
                                          : Black1,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              ),

                            ),

                      )),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(
                            left: 9.w, right: 9.w, bottom: 6.w, top: 6.w),
                        child: PrimaryButton(
                            onTap: () {
                              if (watchDashBoardScreen.specialBenifitlist
                                  .contains("seasonal_products")) {
                                read.onSeasonalProductTapped();
                              } else {
                                Utils.showPrimarySnackbar(context,
                                    "Subscribe to Advanced Plan to use this feature!",
                                    type: SnackType.error);
                                return;
                              }
                            },
                            child: Text(
                              "Seasonal",
                              style: TextStyle(
                                  color: watch.isSeasonalPressed
                                      ? Color(0xff39C19D)
                                      : Black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            color: Colors.transparent,
                            borderColor: watch.isSeasonalPressed
                                ? Color(0xff39C19D)
                                : Colors.transparent),
                      )),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(right: 7.w, bottom: 6.w, top: 6.w),
                        child: PrimaryButton(
                            onTap: () {
                              // read.onFullFilProductTapped();
                              if (watchDashBoardScreen.specialBenifitlist
                                  .contains("fullfill_craving_products")) {
                                read.onFullFilProductTapped();
                              } else {
                                Utils.showPrimarySnackbar(context,
                                    "Subscribe to Advanced Plan to use this feature!",
                                    type: SnackType.error);
                                return;
                              }
                            },
                            child: Text(
                              "Fulfil cravings",
                              style: TextStyle(
                                  color: watch.isFulFilPressed
                                      ? Color(0xff39C19D)
                                      : Black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            color: Colors.transparent,
                            borderColor: watch.isFulFilPressed
                                ? Color(0xff39C19D)
                                : Colors.transparent),
                      )),
                    ],
                  ),
                ),
                ////////////////////////////Products///////////////////////

                watch.isRecommadedPressed
                    ? watch.recommendedProducts?.isEmpty == true
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 120.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,/
                                children: [
                                  Image.asset(
                                    "assets/images/emptycart.png",
                                    height: 151.h,
                                    width: 151.w,
                                  ),
                                  Text(
                                    "No Products Found",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          letterSpacing: .5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 19.w, right: 19.w, top: 24.w),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: watch.allproducts
                                        ?.recommendedProducts?.length ??
                                    0,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final element = watch
                                      .allproducts?.recommendedProducts?[index];
                                  return Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.09),
                                                  blurRadius: 5,
                                                  offset: Offset(-.0, 5.0),
                                                  spreadRadius: 0),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1, color: grey1)),
                                        child: Theme(
                                          data: ThemeData().copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ListTileTheme(
                                            contentPadding: EdgeInsets.all(0),
                                            dense: true,
                                            // horizontalTitleGap: 5.0,
                                            // minLeadingWidth: 6,
                                            child: ExpansionTile(
                                              trailing: SizedBox.shrink(),

                                              title: Container(
                                                width: ScreenUtil().screenWidth,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 5.w),
                                                      child: Row(
                                                        children: [
                                                          element?.productImagePath !=
                                                                  ""
                                                              ? AppNetworkImages(
                                                                  imageUrl:
                                                                      "${element?.productImagePath}",
                                                                  height: 60.h,
                                                                  width: 60.w,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : Image(
                                                                  image:
                                                                      AssetImage(
                                                                    "assets/images/profile_image.png",
                                                                  ),
                                                                  height: 60.h,
                                                                  width: 60.w,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                          SizedBox(
                                                            width: 8.w,
                                                          ),
                                                          Container(
                                                            width: 150.w,
                                                            child: Text(
                                                              "${element?.productName}",
                                                              // "${element?.productName}",
                                                              // "${element?.productName}",
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                        Black1,
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (element
                                                                    ?.productType ==
                                                                "admin_product") {
                                                              readMainScreen.onNavigation(0, SEditAdminProductView(
                                                                  selectedIndex:
                                                                  0,
                                                                  productId: element?.id
                                                                      .toString(),
                                                                  isFromAccountScreen:
                                                                  true,
                                                                  categoryId:
                                                                  ""), context);
                                                              // Navigator
                                                              //     .pushAndRemoveUntil(
                                                              //   context,
                                                              //   MaterialPageRoute(
                                                              //       builder: (context) => SMainScreenView(
                                                              //           index:
                                                              //               0,
                                                              //           screenName: SEditAdminProductView(
                                                              //               selectedIndex:
                                                              //                   0,
                                                              //               productId: element?.id
                                                              //                   .toString(),
                                                              //               isFromAccountScreen:
                                                              //                   true,
                                                              //               categoryId:
                                                              //                   ""))),
                                                              //   (Route<dynamic>
                                                              //           route) =>
                                                              //       false,
                                                              // );
                                                            } else {
                                                              readMainScreen.onNavigation(0, SEditCustomProductView(
                                                                  selectedIndex:
                                                                  0,
                                                                  productId: element?.id
                                                                      .toString(),
                                                                  isFromAccountScreen:
                                                                  true,
                                                                  categoryId:
                                                                  ""), context);
                                                              // Navigator
                                                              //     .pushAndRemoveUntil(
                                                              //   context,
                                                              //   MaterialPageRoute(
                                                              //       builder: (context) => SMainScreenView(
                                                              //           index:
                                                              //               0,
                                                              //           screenName: SEditCustomProductView(
                                                              //               selectedIndex:
                                                              //                   0,
                                                              //               productId: element?.id
                                                              //                   .toString(),
                                                              //               isFromAccountScreen:
                                                              //                   true,
                                                              //               categoryId:
                                                              //                   ""))),
                                                              //   (Route<dynamic>
                                                              //           route) =>
                                                              //       false,
                                                              // );
                                                            }
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6),
                                                            decoration: BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color:
                                                                        grey6,
                                                                    offset:
                                                                        const Offset(
                                                                      5.0,
                                                                      5.0,
                                                                    ),
                                                                    blurRadius:
                                                                        10.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ), //BoxShadow
                                                                ],
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: SvgPicture.asset(
                                                                'assets/icons/e1.svg'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8.w,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            read.removeSRFProducts(
                                                                context,
                                                                index,
                                                                element?.id,
                                                                element
                                                                    ?.productType,
                                                                "recommended_product");
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6),
                                                            decoration: BoxDecoration(
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color:
                                                                        grey6,
                                                                    offset:
                                                                        const Offset(
                                                                      5.0,
                                                                      5.0,
                                                                    ),
                                                                    blurRadius:
                                                                        10.0,
                                                                    spreadRadius:
                                                                        2.0,
                                                                  ), //BoxShadow
                                                                ],
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: SvgPicture.asset(
                                                                'assets/icons/delete3.svg'),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 11.w,
                                                      bottom: 11.w,
                                                      right: 11.w),
                                                  child: Column(
                                                    children: [
                                                      Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  "Product Unit",
                                                                  style:
                                                                      GoogleFonts
                                                                          .dmSans(
                                                                    textStyle: TextStyle(
                                                                        color:
                                                                            Black1,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    "MRP",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: GoogleFonts
                                                                        .dmSans(
                                                                      textStyle: TextStyle(
                                                                          color:
                                                                              Black1,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 18.w,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "Offer price",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: GoogleFonts
                                                                        .dmSans(
                                                                      textStyle: TextStyle(
                                                                          color:
                                                                              Black1,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        itemCount: watch
                                                                .allproducts
                                                                ?.recommendedProducts?[
                                                                    index]
                                                                .unitDetails
                                                                ?.length ??
                                                            0,
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemBuilder:
                                                            (context, int) {
                                                          final element = watch
                                                              .recommendedProducts?[
                                                                  index]
                                                              .unitDetails?[int];

                                                          return Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 12.w,
                                                                    right: 20.w,
                                                                    top: 7.w,
                                                                    bottom:
                                                                        8.w),
                                                            decoration:
                                                                BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                    // color: Black1,
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color:
                                                                            grey6)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "${element?.weightAndUnit}",
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Black1,
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          // "",
                                                                          "${element?.mrpPrice}",
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              GoogleFonts.dmSans(
                                                                            textStyle: TextStyle(
                                                                                decoration: TextDecoration.lineThrough,
                                                                                color: Black1,
                                                                                fontSize: 14.sp,
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // SizedBox(
                                                                      //   width: 45.w,
                                                                      // ),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          // "",
                                                                          "\u{20B9}${element?.offerPrice}",
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                          style:
                                                                              GoogleFonts.dmSans(
                                                                            textStyle: TextStyle(
                                                                                color: Black1,
                                                                                fontSize: 14.sp,
                                                                                fontWeight: FontWeight.w400),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                              // child:
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18.w,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                    : watch.isSeasonalPressed
                        ? watch.seasonalProducts?.isEmpty == true
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 120.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,/
                                    children: [
                                      Image.asset(
                                        "assets/images/emptycart.png",
                                        height: 151.h,
                                        width: 151.w,
                                      ),
                                      Text(
                                        "No Products Found",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black1,
                                              letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 19.w, right: 19.w, top: 24.w),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: watch.allproducts
                                            ?.seasonalProducts?.length ??
                                        0,
                                    //  watch.selectedProductList?.length ?? 0,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final element = watch.allproducts
                                          ?.seasonalProducts?[index];
                                      return Column(
                                        children: [
                                          Container(
                                            // padding: EdgeInsets.only(
                                            //     left: 21.w, bottom: 11.w, top: 13.w, right: 21.w),

                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.09),
                                                      blurRadius: 5,
                                                      offset: Offset(-.0, 5.0),
                                                      spreadRadius: 0),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                border: Border.all(
                                                    width: 1, color: grey1)),

                                            child: Theme(
                                              data: ThemeData().copyWith(
                                                  dividerColor:
                                                      Colors.transparent),
                                              child: ListTileTheme(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                dense: true,
                                                // horizontalTitleGap: 5.0,
                                                // minLeadingWidth: 6,
                                                child: ExpansionTile(
                                                  trailing: SizedBox.shrink(),

                                                  title: Container(
                                                    width: ScreenUtil()
                                                        .screenWidth,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5.w),
                                                          child: Row(
                                                            children: [
                                                              element?.productImagePath !=
                                                                      ""
                                                                  ? AppNetworkImages(
                                                                      imageUrl:
                                                                          "${element?.productImagePath}",
                                                                      height:
                                                                          60.h,
                                                                      width:
                                                                          60.w,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image(
                                                                      image:
                                                                          AssetImage(
                                                                        "assets/images/profile_image.png",
                                                                      ),
                                                                      height:
                                                                          60.h,
                                                                      width:
                                                                          60.w,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Container(
                                                                width: 150.w,
                                                                child: Text(
                                                                  "${element?.productName}",
                                                                  // "${element?.productName}",
                                                                  // "${element?.productName}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .dmSans(
                                                                    textStyle: TextStyle(
                                                                        color:
                                                                            Black1,
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (element
                                                                        ?.productType ==
                                                                    "admin_product") {
                                                                  readMainScreen.onNavigation(0, SEditAdminProductView(
                                                                    selectedIndex: 1,
                                                                    productId: element?.id.toString(),
                                                                    categoryId: "",
                                                                    isFromAccountScreen: true,
                                                                  ), context);
                                                                  // Navigator
                                                                  //     .pushAndRemoveUntil(
                                                                  //   context,
                                                                  //   MaterialPageRoute(
                                                                  //       builder: (context) => SMainScreenView(
                                                                  //           index: 0,
                                                                  //           screenName: SEditAdminProductView(
                                                                  //             selectedIndex: 1,
                                                                  //             productId: element?.id.toString(),
                                                                  //             categoryId: "",
                                                                  //             isFromAccountScreen: true,
                                                                  //           ))),
                                                                  //   (Route<dynamic>
                                                                  //           route) =>
                                                                  //       false,
                                                                  // );
                                                                } else {
                                                                  readMainScreen.onNavigation(0, SEditCustomProductView(
                                                                    selectedIndex: 1,
                                                                    productId: element?.id.toString(),
                                                                    categoryId: "",
                                                                    isFromAccountScreen: true,
                                                                  ), context);
                                                                  // Navigator
                                                                  //     .pushAndRemoveUntil(
                                                                  //   context,
                                                                  //   MaterialPageRoute(
                                                                  //       builder: (context) => SMainScreenView(
                                                                  //           index: 0,
                                                                  //           screenName: SEditCustomProductView(
                                                                  //             selectedIndex: 1,
                                                                  //             productId: element?.id.toString(),
                                                                  //             categoryId: "",
                                                                  //             isFromAccountScreen: true,
                                                                  //           ))),
                                                                  //   (Route<dynamic>
                                                                  //           route) =>
                                                                  //       false,
                                                                  // );
                                                                }
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(6),
                                                                decoration: BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color:
                                                                            grey6,
                                                                        offset:
                                                                            const Offset(
                                                                          5.0,
                                                                          5.0,
                                                                        ),
                                                                        blurRadius:
                                                                            10.0,
                                                                        spreadRadius:
                                                                            2.0,
                                                                      ), //BoxShadow
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: SvgPicture
                                                                    .asset(
                                                                        'assets/icons/e1.svg'),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 8.w,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                read.removeSRFProducts(
                                                                    context,
                                                                    index,
                                                                    element?.id,
                                                                    element
                                                                        ?.productType,
                                                                    "seasonal_product");
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(6),
                                                                decoration: BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color:
                                                                            grey6,
                                                                        offset:
                                                                            const Offset(
                                                                          5.0,
                                                                          5.0,
                                                                        ),
                                                                        blurRadius:
                                                                            10.0,
                                                                        spreadRadius:
                                                                            2.0,
                                                                      ), //BoxShadow
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: SvgPicture
                                                                    .asset(
                                                                        'assets/icons/delete3.svg'),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 11.w,
                                                          bottom: 11.w,
                                                          right: 11.w),
                                                      child: Column(
                                                        children: [
                                                          Divider(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "Product Unit",
                                                                      style: GoogleFonts
                                                                          .dmSans(
                                                                        textStyle: TextStyle(
                                                                            color:
                                                                                Black1,
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        "MRP",
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Black1,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          18.w,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        "Offer price",
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Black1,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          ListView.builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            itemCount: watch
                                                                    .allproducts
                                                                    ?.seasonalProducts?[
                                                                        index]
                                                                    .unitDetails
                                                                    ?.length ??
                                                                0,
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemBuilder:
                                                                (context, int) {
                                                              final element = watch
                                                                  .seasonalProducts?[
                                                                      index]
                                                                  .unitDetails?[int];

                                                              return Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 12
                                                                            .w,
                                                                        right: 20
                                                                            .w,
                                                                        top:
                                                                            7.w,
                                                                        bottom:
                                                                            8.w),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        // color: Black1,
                                                                        border: Border.all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                grey6)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            "${element?.weightAndUnit}",
                                                                            style:
                                                                                GoogleFonts.dmSans(
                                                                              textStyle: TextStyle(color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              // "",
                                                                              "${element?.mrpPrice}",
                                                                              textAlign: TextAlign.end,
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(decoration: TextDecoration.lineThrough, color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // SizedBox(
                                                                          //   width: 45.w,
                                                                          // ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              // "",
                                                                              "\u{20B9}${element?.offerPrice}",
                                                                              textAlign: TextAlign.end,
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                  // child:
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 18.w,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                        : watch.fullfillYourCravingsProducts?.isEmpty == true
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 120.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,/
                                    children: [
                                      Image.asset(
                                        "assets/images/emptycart.png",
                                        height: 151.h,
                                        width: 151.w,
                                      ),
                                      Text(
                                        "No Products Found",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black1,
                                              letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 19.w, right: 19.w, top: 24.w),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: watch
                                            .allproducts
                                            ?.fullfillYourCravingsProducts
                                            ?.length ??
                                        0,
                                    //  watch.selectedProductList?.length ?? 0,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final element = watch.allproducts
                                              ?.fullfillYourCravingsProducts?[
                                          index];
                                      return Column(
                                        children: [
                                          Container(
                                            // padding: EdgeInsets.only(
                                            //     left: 21.w, bottom: 11.w, top: 13.w, right: 21.w),

                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.09),
                                                      blurRadius: 5,
                                                      offset: Offset(-.0, 5.0),
                                                      spreadRadius: 0),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                border: Border.all(
                                                    width: 1, color: grey1)),

                                            child: Theme(
                                              data: ThemeData().copyWith(
                                                  dividerColor:
                                                      Colors.transparent),
                                              child: ListTileTheme(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                dense: true,
                                                // horizontalTitleGap: 5.0,
                                                // minLeadingWidth: 6,
                                                child: ExpansionTile(
                                                  trailing: SizedBox.shrink(),

                                                  title: Container(
                                                    width: ScreenUtil()
                                                        .screenWidth,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5.w),
                                                          child: Row(
                                                            children: [
                                                              element?.productImagePath !=
                                                                      ""
                                                                  ? AppNetworkImages(
                                                                      imageUrl:
                                                                          "${element?.productImagePath}",
                                                                      height:
                                                                          60.h,
                                                                      width:
                                                                          60.w,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image(
                                                                      image:
                                                                          AssetImage(
                                                                        "assets/images/profile_image.png",
                                                                      ),
                                                                      height:
                                                                          60.h,
                                                                      width:
                                                                          60.w,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                              // AppNetworkImages(
                                                              //   imageUrl:
                                                              //       "${element?.productImagePath}",
                                                              //   height: 61.h,
                                                              //   width: 60.w,
                                                              // ),

                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Container(
                                                                width: 150.w,
                                                                child: Text(
                                                                  "${element?.productName}",
                                                                  // "${element?.productName}",
                                                                  // "${element?.productName}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .dmSans(
                                                                    textStyle: TextStyle(
                                                                        color:
                                                                            Black1,
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (element
                                                                        ?.productType ==
                                                                    "admin_product") {
                                                                  readMainScreen.onNavigation(0, SEditAdminProductView(
                                                                    selectedIndex: 2,
                                                                    productId: element?.id.toString(),
                                                                    categoryId: "",
                                                                    isFromAccountScreen: true,
                                                                  ), context);
                                                                  // Navigator
                                                                  //     .pushAndRemoveUntil(
                                                                  //   context,
                                                                  //   MaterialPageRoute(
                                                                  //       builder: (context) => SMainScreenView(
                                                                  //           index: 0,
                                                                  //           screenName: SEditAdminProductView(
                                                                  //             selectedIndex: 2,
                                                                  //             productId: element?.id.toString(),
                                                                  //             categoryId: "",
                                                                  //             isFromAccountScreen: true,
                                                                  //           ))),
                                                                  //   (Route<dynamic>
                                                                  //           route) =>
                                                                  //       false,
                                                                  // );
                                                                } else {
                                                                  readMainScreen.onNavigation(0, SEditCustomProductView(
                                                                  selectedIndex: 2,
                                                                  productId: element?.id.toString(),
                                                                categoryId: "",
                                                                isFromAccountScreen: true,
                                                                ), context);
                                                            //       Navigator
                                                            //           .pushAndRemoveUntil(
                                                            //         context,
                                                            // 0        MaterialPageRoute(
                                                            //             builder: (context) => SMainScreenView(
                                                            //                 index: 0,
                                                            //                 screenName: SEditCustomProductView(
                                                            //                   selectedIndex: 2,
                                                            //                   productId: element?.id.toString(),
                                                            //                   categoryId: "",
                                                            //                   isFromAccountScreen: true,
                                                            //                 ))),
                                                            //         (Route<dynamic>
                                                            //                 route) =>
                                                            //             false,
                                                            //       );
                                                                }
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(6),
                                                                decoration: BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color:
                                                                            grey6,
                                                                        offset:
                                                                            const Offset(
                                                                          5.0,
                                                                          5.0,
                                                                        ),
                                                                        blurRadius:
                                                                            10.0,
                                                                        spreadRadius:
                                                                            2.0,
                                                                      ), //BoxShadow
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: SvgPicture
                                                                    .asset(
                                                                        'assets/icons/e1.svg'),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 8.w,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                read.removeSRFProducts(
                                                                    context,
                                                                    index,
                                                                    element?.id,
                                                                    element
                                                                        ?.productType,
                                                                    "fullfill_your_cravings");
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(6),
                                                                decoration: BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color:
                                                                            grey6,
                                                                        offset:
                                                                            const Offset(
                                                                          5.0,
                                                                          5.0,
                                                                        ),
                                                                        blurRadius:
                                                                            10.0,
                                                                        spreadRadius:
                                                                            2.0,
                                                                      ), //BoxShadow
                                                                    ],
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: SvgPicture
                                                                    .asset(
                                                                        'assets/icons/delete3.svg'),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 11.w,
                                                          bottom: 11.w,
                                                          right: 11.w),
                                                      child: Column(
                                                        children: [
                                                          Divider(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "Product Unit",
                                                                      style: GoogleFonts
                                                                          .dmSans(
                                                                        textStyle: TextStyle(
                                                                            color:
                                                                                Black1,
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        "MRP",
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Black1,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          18.w,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        "Offer price",
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Black1,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          ListView.builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            itemCount: watch
                                                                    .allproducts
                                                                    ?.fullfillYourCravingsProducts?[
                                                                        index]
                                                                    .unitDetails
                                                                    ?.length ??
                                                                0,
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemBuilder:
                                                                (context, int) {
                                                              final element = watch
                                                                  .fullfillYourCravingsProducts?[
                                                                      index]
                                                                  .unitDetails?[int];

                                                              return Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 12
                                                                            .w,
                                                                        right: 20
                                                                            .w,
                                                                        top:
                                                                            7.w,
                                                                        bottom:
                                                                            8.w),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        // color: Black1,
                                                                        border: Border.all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                grey6)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            "${element?.weightAndUnit}",
                                                                            style:
                                                                                GoogleFonts.dmSans(
                                                                              textStyle: TextStyle(color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              // "",
                                                                              "${element?.mrpPrice}",
                                                                              textAlign: TextAlign.end,
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(decoration: TextDecoration.lineThrough, color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // SizedBox(
                                                                          //   width: 45.w,
                                                                          // ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              // "",
                                                                              "\u{20B9}${element?.offerPrice}",
                                                                              textAlign: TextAlign.end,
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                  // child:
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 18.w,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                SizedBox(
                  height: 100.h,
                ),
              ]),
            ),
    );
  }
}
