import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';

import 'package:local_supper_market/screen/customer/favourites/controller/favourites_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/controller/offer_seasonal_recommanded_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_edit_admin_product_view.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class ShopSeasonalRecommandedOfferProductsView extends StatefulWidget {
  final String ? selectedProduct;
  const ShopSeasonalRecommandedOfferProductsView({super.key,required this.selectedProduct});

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
          .initState(context,widget.selectedProduct);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch =
        context.watch<ShopSeasonalRecommandedOfferProductsController>();
    final read = context.read<ShopSeasonalRecommandedOfferProductsController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
            onBackBtnPressed: () {
             widget.selectedProduct=="recommended"? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => SMainScreenView(
                          index: 4,
                          screenName: SAccountScreenView(refresh: false,),
                        )),
                (Route<dynamic> route) => false,
              ): Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(
                   builder: (context) => SMainScreenView(
                     index: 0,
                     screenName: ShopDashBoardView(refresh: false,),
                   )),
                   (Route<dynamic> route) => false,
             );
            },
            title: watch.isRecommadedPressed
                ? "Recommended Products"
                : watch.isSeasonalPressed
                    ? "Seasonal Products"
                    : "Fulfil your cravings"),
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
                        padding: EdgeInsets.only(
                            left: 6.w, right: 6.w, bottom: 0.w, top: 0.w),
                        child: PrimaryButton(
                            onTap: () {
                              read.onRecommendedTapped();
                            },
                            child: Text(
                              "Recommended",
                              style: TextStyle(
                                  color: watch.isRecommadedPressed
                                      ? Color(0xff39C19D)
                                      : Black1,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            color: Colors.transparent,
                            borderColor: watch.isRecommadedPressed
                                ? Color(0xff39C19D)
                                : Colors.transparent),
                      )),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(
                            left: 9.w, right: 9.w, bottom: 6.w, top: 6.w),
                        child: PrimaryButton(
                            onTap: () {
                              read.onSeasonalProductTapped();
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
                        padding: EdgeInsets.only(
                            left: 7.w, right: 7.w, bottom: 6.w, top: 6.w),
                        child: PrimaryButton(
                            onTap: () {
                              read.onFullFilProductTapped();
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
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: 19.w, right: 19.w, top: 24.w),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount:
                              watch.allproducts?.recommendedProducts?.length ??
                                  0,
                          //  watch.selectedProductList?.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final element =
                                watch.allproducts?.recommendedProducts?[index];
                            return Column(
                              children: [
                                Container(
                                  // padding: EdgeInsets.only(
                                  //     left: 21.w, bottom: 11.w, top: 13.w, right: 21.w),

                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.09),
                                            blurRadius: 5,
                                            offset: Offset(-.0, 5.0),
                                            spreadRadius: 0),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border:
                                          Border.all(width: 1, color: grey1)),

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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  AppNetworkImages(
                                                    imageUrl:
                                                        "${element?.productImagePath}",
                                                    height: 61.h,
                                                    width: 60.w,
                                                  ),
                                                  // Image(
                                                  //   image: NetworkImage(
                                                  //     // "assets/images/gridfour.png"
                                                  //     "${element?.productImagePath}",
                                                  //   ),
                                                  //   height: 61.h,
                                                  //   width: 60.w,
                                                  //   // fit: BoxFit.fill,
                                                  // ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Container(
                                                    width: 150.w,
                                                    child: Text(
                                                      "${element?.productName}",
                                                      // "${element?.productName}",
                                                      // "${element?.productName}",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Black1,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => SMainScreenView(
                                                                index: 0,
                                                                screenName: SEditAdminProductView(
                                                                    productId:
                                                                        element
                                                                            ?.id
                                                                            .toString(),
                                                                    categoryId:
                                                                        ""))),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false,
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: grey6,
                                                              offset:
                                                                  const Offset(
                                                                5.0,
                                                                5.0,
                                                              ),
                                                              blurRadius: 10.0,
                                                              spreadRadius: 2.0,
                                                            ), //BoxShadow
                                                          ],
                                                          color: Colors.white,
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
                                                          element?.productType,
                                                          "recommended_product");
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: grey6,
                                                              offset:
                                                                  const Offset(
                                                                5.0,
                                                                5.0,
                                                              ),
                                                              blurRadius: 10.0,
                                                              spreadRadius: 2.0,
                                                            ), //BoxShadow
                                                          ],
                                                          color: Colors.white,
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
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle: TextStyle(
                                                                  color: Black1,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
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
                                                                  TextAlign.end,
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                        Black1,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
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
                                                                  TextAlign.end,
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                        Black1,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
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
                                                  padding: EdgeInsets.zero,
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
                                                  itemBuilder: (context, int) {
                                                    final element = watch
                                                        .recommendedProducts?[
                                                            index]
                                                        .unitDetails?[int];

                                                    return Container(
                                                      padding: EdgeInsets.only(
                                                          left: 12.w,
                                                          right: 20.w,
                                                          top: 7.w,
                                                          bottom: 8.w),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          // color: Black1,
                                                          border: Border.all(
                                                              width: 1,
                                                              color: grey6)),
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
                                                                  style:
                                                                      GoogleFonts
                                                                          .dmSans(
                                                                    textStyle: TextStyle(
                                                                        color:
                                                                            Black1,
                                                                        fontSize: 14
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
                                                                    // "",
                                                                    "${element?.mrpPrice}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: GoogleFonts
                                                                        .dmSans(
                                                                      textStyle: TextStyle(
                                                                          decoration: TextDecoration
                                                                              .lineThrough,
                                                                          color:
                                                                              Black1,
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // SizedBox(
                                                                //   width: 45.w,
                                                                // ),
                                                                Expanded(
                                                                  child: Text(
                                                                    // "",
                                                                    "${element?.offerPrice}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: GoogleFonts
                                                                        .dmSans(
                                                                      textStyle: TextStyle(
                                                                          color:
                                                                              Black1,
                                                                          fontSize: 14
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
                      )
                    : watch.isSeasonalPressed
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: 19.w, right: 19.w, top: 24.w),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount:
                                  watch.allproducts?.seasonalProducts?.length ??
                                      0,
                              //  watch.selectedProductList?.length ?? 0,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final element =
                                    watch.allproducts?.seasonalProducts?[index];
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
                                                  Row(
                                                    children: [
                                                      AppNetworkImages(
                                                        imageUrl:
                                                            "${element?.productImagePath}",
                                                        height: 61.h,
                                                        width: 60.w,
                                                      ),
                                                      // Image(
                                                      //   image: NetworkImage(
                                                      //     // "assets/images/gridfour.png"
                                                      //     "${element?.productImagePath}",
                                                      //   ),
                                                      //   height: 61.h,
                                                      //   width: 60.w,
                                                      //   // fit: BoxFit.fill,
                                                      // ),
                                                      SizedBox(
                                                        width: 10.w,
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
                                                                color: Black1,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => SMainScreenView(
                                                                    index: 0,
                                                                    screenName: SEditAdminProductView(
                                                                        productId: element
                                                                            ?.id
                                                                            .toString(),
                                                                        categoryId:
                                                                            ""))),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false,
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: grey6,
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
                                                              color:
                                                                  Colors.white,
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
                                                              "seasonal_product");
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: grey6,
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
                                                              color:
                                                                  Colors.white,
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
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
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
                                                      padding: EdgeInsets.zero,
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 12.w,
                                                                  right: 20.w,
                                                                  top: 7.w,
                                                                  bottom: 8.w),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  // color: Black1,
                                                                  border: Border
                                                                      .all(
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
                                                                            color:
                                                                                Black1,
                                                                            fontSize:
                                                                                14.sp,
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
                                                                        style: GoogleFonts
                                                                            .dmSans(
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
                                                                        "${element?.offerPrice}",
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: GoogleFonts
                                                                            .dmSans(
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
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                left: 19.w, right: 19.w, top: 24.w),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: watch.allproducts
                                      ?.fullfillYourCravingsProducts?.length ??
                                  0,
                              //  watch.selectedProductList?.length ?? 0,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final element = watch.allproducts
                                    ?.fullfillYourCravingsProducts?[index];
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
                                                  Row(
                                                    children: [
                                                      element?.productImagePath !=
                                                              ""
                                                          ? AppNetworkImages(
                                                              imageUrl:
                                                                  "${element?.productImagePath}",
                                                              height: 61.h,
                                                              width: 60.w,
                                                              fit: BoxFit.fill,
                                                            )
                                                          : Image(
                                                              image: AssetImage(
                                                                "assets/images/profile_image.png",
                                                              ),
                                                              height: 61.h,
                                                              width: 60.w,
                                                              fit: BoxFit.fill,
                                                            ),
                                                      // AppNetworkImages(
                                                      //   imageUrl:
                                                      //       "${element?.productImagePath}",
                                                      //   height: 61.h,
                                                      //   width: 60.w,
                                                      // ),

                                                      SizedBox(
                                                        width: 10.w,
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
                                                                color: Black1,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => SMainScreenView(
                                                                    index: 0,
                                                                    screenName: SEditAdminProductView(
                                                                        productId: element
                                                                            ?.id
                                                                            .toString(),
                                                                        categoryId:
                                                                            ""))),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false,
                                                          );
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: grey6,
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
                                                              color:
                                                                  Colors.white,
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
                                                              "fullfill_your_cravings");
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: grey6,
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
                                                              color:
                                                                  Colors.white,
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
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
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
                                                      padding: EdgeInsets.zero,
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 12.w,
                                                                  right: 20.w,
                                                                  top: 7.w,
                                                                  bottom: 8.w),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  // color: Black1,
                                                                  border: Border
                                                                      .all(
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
                                                                            color:
                                                                                Black1,
                                                                            fontSize:
                                                                                14.sp,
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
                                                                        style: GoogleFonts
                                                                            .dmSans(
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
                                                                        "${element?.offerPrice}",
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style: GoogleFonts
                                                                            .dmSans(
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
                SizedBox(
                  height: 100.h,
                ),
              ]),
            ),
    );
  }
}
