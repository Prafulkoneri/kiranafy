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
import 'package:local_supper_market/screen/customer/products/controller/product_view_controller.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class CFavouritesView extends StatefulWidget {
  const CFavouritesView({super.key});

  @override
  State<CFavouritesView> createState() => _CFavouritesViewState();
}

class _CFavouritesViewState extends State<CFavouritesView> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<FavouritesController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<FavouritesController>();
    final watch = context.watch<FavouritesController>();
    final readMain = context.read<MainScreenController>();
    final readProductViewController = context.read<ProductViewController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreenView(
                        index: 4,
                        screenName: ProfileScreenView(),
                      )),
              (Route<dynamic> route) => false,
            );
          },
          title: "Favourites",
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 19.w, right: 19.w, top: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: PrimaryButton(
                                onTap: () {
                                  read.onFavouriteShopTapped();
                                },
                                child: Text(
                                  "Favourite Shop",
                                  style: TextStyle(
                                      color: watch.isFavShopPressed
                                          ? Color(0xff39C19D)
                                          : Color(0xff3A3A3A),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                color: Colors.transparent,
                                borderColor: watch.isFavShopPressed
                                    ? Color(0xff39C19D)
                                    : Colors.transparent)),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: PrimaryButton(
                                onTap: () {
                                  read.onFavouriteProductTapped();
                                },
                                child: Text(
                                  "Favourite Product",
                                  style: TextStyle(
                                      color: watch.isFavShopPressed
                                          ? Color(0xff3A3A3A)
                                          : Color(0xff39C19D),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                color: Colors.transparent,
                                borderColor: watch.isFavShopPressed
                                    ? Colors.transparent
                                    : Color(0xff39C19D))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),

                  watch.isFavShopPressed
                      ? Container(
                          child: SizedBox(
                            child: ListView.builder(
                                // scrollDirection: Axis.vertical,p
                                physics: NeverScrollableScrollPhysics(),
                                // physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: watch.favShopList?.length ?? 0,
                                itemBuilder: (BuildContext, index) {
                                  final element = watch.favShopList?[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // readMain.onNavigation(0, ShopProfileView(shopId: element?.id.toString()), context);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreenView(
                                                    index: 1,
                                                    screenName: ShopProfileView(
                                                      shopId: element?.id
                                                          .toString(),
                                                      routeName:
                                                          "favouriteView",
                                                      refreshPage: true,
                                                    ))),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 19.w,
                                              right: 12,
                                              // top: 20.w,
                                              bottom: 14.w),
                                          child: Container(
                                            height: 160.h,
                                            width: 352.w,

                                            // margin: EdgeInsets.only(
                                            //     left: index == 0 ? 19.w : 0,
                                            //     right: index == 2 ? 19.w : 5.w),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15.w),
                                                image: element
                                                            ?.shopBannerImagePath !=
                                                        ""
                                                    ? DecorationImage(
                                                        // scale: 1.0,
                                                        image: NetworkImage(
                                                            '${element?.shopBannerImagePath}'),
                                                        fit: BoxFit.fill)
                                                    : DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/nearshop2.png"),
                                                        fit: BoxFit.cover)),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "${element?.shopName}",
                                                              style: GoogleFonts.roboto(
                                                                  textStyle: TextStyle(
                                                                      color: Colors.white,
                                                                      // letterSpacing: .5,
                                                                      fontSize: 15.sp,
                                                                      fontWeight: FontWeight.w600))),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  "assets/icons/location1.svg",
                                                                  width: 12.w,
                                                                  height: 16.h),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 8
                                                                            .w),
                                                                child: Text(
                                                                    "${element?.areaName} ${element?.cityName}",
                                                                    style: GoogleFonts.roboto(
                                                                        textStyle: TextStyle(
                                                                            color: Colors.white,
                                                                            letterSpacing: .5,
                                                                            fontSize: 12.sp,
                                                                            // height: 10,
                                                                            fontWeight: FontWeight.w400))),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            height: 21.49.h,
                                                            width: 49.w,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: yellow,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/images/star.svg",
                                                                  height: 12.h,
                                                                  width: 12.w,
                                                                ),
                                                                SizedBox(
                                                                  width: 4.3.w,
                                                                ),
                                                                Text(
                                                                  // "",
                                                                  double.parse(element
                                                                              ?.ratings
                                                                              .toString() ??
                                                                          "0.0")
                                                                      .toStringAsFixed(
                                                                          1),
                                                                  style:
                                                                      GoogleFonts
                                                                          .dmSans(
                                                                    textStyle: TextStyle(
                                                                        color:
                                                                            Black,
                                                                        letterSpacing:
                                                                            .5,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            child: Container(
                                          margin: EdgeInsets.only(
                                              left: index == 0 ? 19.w : 0,
                                              right: index == 2 ? 19.w : 5.w),
                                          height: 160.h,
                                          width: 352.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13.w),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [
                                                  0.1,
                                                  0.9,
                                                ],
                                                colors: [
                                                  Colors.white.withOpacity(0),
                                                  Colors.black.withOpacity(0.0),
                                                ],
                                              )),
                                        )),
                                        Positioned(
                                          right: 22.w,
                                          top: 11.w,
                                          child: InkWell(
                                            onTap: () {
                                              watch.fav[index]
                                                  ? read.removeFavList(context,
                                                      element?.id, index)
                                                  : read.updateFavList(context,
                                                      element?.id, index);
                                            },
                                            child: watch.fav[index]
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
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(
                              left: 12.h, top: 20.w, right: 12.h, bottom: 15.w),
                          child: SizedBox(
                            // height: 156.h,
                            // width: 2.w,
                            child: Column(
                              children: [
                                GridView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        watch.adminProductList?.length ?? 0,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 20.0,
                                            mainAxisSpacing: 4.0),
                                    itemBuilder: (BuildContext, index) {
                                      final element =
                                          watch.adminProductList?[index];
                                      return GestureDetector(
                                        onTap: () {
                                          readProductViewController
                                              .updateProductId(
                                            element?.id.toString(),
                                          );
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainScreenView(
                                                      index: 1,
                                                      screenName:
                                                          ProductScreenView(
                                                        selectedUnitId: element
                                                            ?.productUnitId
                                                            .toString(),
                                                        categoryId: element
                                                            ?.categoryId
                                                            .toString(),
                                                        productId: element?.id
                                                            .toString(),
                                                        shopId: element?.shopId
                                                            .toString(),
                                                        productType: element
                                                            ?.productType
                                                            .toString(),
                                                      ),
                                                    )),
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15.w)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Center(
                                                child: AppNetworkImages(
                                                  imageUrl:
                                                      "${element?.productImagePath}",
                                                  fit: BoxFit.contain,
                                                ),
                                              )),
                                              SizedBox(
                                                height: 3.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 17.h,
                                                  // right: 15.w,
                                                ),
                                                child: Text(
                                                  "${element?.productName}",
                                                  // "Red Label",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Black1,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 17.h,
                                                  // right: 15.w,
                                                ),
                                                child: Text(
                                                  // "100g",
                                                  "${element?.weight} ${element?.unit}",
                                                  style: TextStyle(
                                                      color: Black1,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 17.h,
                                                  right: 15.w,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '\u{20B9}${element?.price}',
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Black1,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        read.removeAdminFavProduct(
                                                            context,
                                                            element?.shopId,
                                                            element?.id,
                                                            index);
                                                      },
                                                      child: SvgPicture.asset(
                                                        'assets/icons/fvrt_products.svg',
                                                      ),
                                                    ),
                                                    // SizedBox(
                                                    //   width: 15.w,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 17.h,
                                                  bottom: 10.w,
                                                ),
                                                child: Text(
                                                  "${element?.shopName}",
                                                  // "Maharaj Kirana Store",
                                                  style: TextStyle(
                                                      color: Black1,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 5.w,
                                ),
                                GridView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                    watch.customProductList?.length ?? 0,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 20.0,
                                            mainAxisSpacing: 4.0),
                                    itemBuilder: (BuildContext, index) {
                                      final element =
                                          watch.customProductList?[index];
                                      return GestureDetector(
                                        onTap: () {
                                          readProductViewController
                                              .updateProductId(
                                            element?.id.toString(),
                                          );
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainScreenView(
                                                      index: 1,
                                                      screenName:
                                                          ProductScreenView(
                                                        selectedUnitId: element
                                                            ?.productUnitId
                                                            .toString(),
                                                        categoryId: element
                                                            ?.categoryId
                                                            .toString(),
                                                        productId: element?.id
                                                            .toString(),
                                                        shopId: element?.shopId
                                                            .toString(),
                                                        productType: element
                                                            ?.productType
                                                            .toString(),
                                                      ),
                                                    )),
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15.w)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Center(
                                                child: AppNetworkImages(
                                                  imageUrl:
                                                      "${element?.productImagePath}",
                                                  fit: BoxFit.contain,
                                                ),
                                              )),
                                              SizedBox(
                                                height: 3.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 17.h,
                                                  // right: 15.w,
                                                ),
                                                child: Text(
                                                  "${element?.productName}",
                                                  // "Red Label",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Black1,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 17.h,
                                                  // right: 15.w,
                                                ),
                                                child: Text(
                                                  // "100g",
                                                  "${element?.weight} ${element?.unit}",
                                                  style: TextStyle(
                                                      color: Black1,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 17.h,
                                                  right: 15.w,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '\u{20B9}${element?.price}',
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Black1,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        read.removeCustomFavProduct(
                                                            context,
                                                            element?.shopId,
                                                            element?.id,
                                                            index);
                                                      },
                                                      child: SvgPicture.asset(
                                                        'assets/icons/fvrt_products.svg',
                                                      ),
                                                    ),
                                                    // SizedBox(
                                                    //   width: 15.w,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4.w,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 17.h,
                                                  bottom: 10.w,
                                                ),
                                                child: Text(
                                                  "${element?.shopName}",
                                                  // "Maharaj Kirana Store",
                                                  style: TextStyle(
                                                      color: Black1,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 80.w,
                                ),
                                // GridView.builder(
                                //     shrinkWrap: true,
                                //     itemCount:
                                //         watch.customProductList?.length ?? 0,
                                //     gridDelegate:
                                //         SliverGridDelegateWithFixedCrossAxisCount(
                                //             crossAxisCount: 2,
                                //             crossAxisSpacing: 4.0,
                                //             mainAxisSpacing: 4.0),
                                //     itemBuilder: (BuildContext, index) {
                                //       final element =
                                //           watch.customProductList?[index];
                                //       return Container(
                                //         decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             borderRadius:
                                //                 BorderRadius.circular(15.w)),
                                //         padding: EdgeInsets.only(
                                //             left: 17.h,
                                //             top: 13.w,
                                //             bottom: 14.w),
                                //         child: Column(
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Expanded(
                                //                 child: Center(
                                //               child: AppNetworkImages(
                                //                 imageUrl:
                                //                     "${element?.productImagePath}",
                                //                 fit: BoxFit.cover,
                                //               ),
                                //             )),
                                //             SizedBox(
                                //               height: 3.w,
                                //             ),
                                //             Text(
                                //               "${element?.productName}",
                                //               // "Red Label",
                                //               style: GoogleFonts.dmSans(
                                //                 textStyle: TextStyle(
                                //                     color: Black1,
                                //                     fontSize: 16.sp,
                                //                     fontWeight:
                                //                         FontWeight.w600),
                                //               ),
                                //             ),
                                //             SizedBox(
                                //               height: 2.w,
                                //             ),
                                //             Text(
                                //               // "100g",
                                //               "${element?.weight}",
                                //               style: TextStyle(
                                //                   color: Black1,
                                //                   fontSize: 12.sp,
                                //                   fontWeight: FontWeight.w600),
                                //             ),
                                //             SizedBox(
                                //               height: 2.w,
                                //             ),
                                //             Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment.start,
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.end,
                                //               children: [
                                //                 Expanded(
                                //                   child: Text(
                                //                     '\u{20B9}${element?.price}',
                                //                     style: GoogleFonts.dmSans(
                                //                       textStyle: TextStyle(
                                //                           color: Black1,
                                //                           fontSize: 12.sp,
                                //                           fontWeight:
                                //                               FontWeight.w600),
                                //                     ),
                                //                   ),
                                //                 ),
                                //                 GestureDetector(
                                //                   onTap: () {
                                //                     read.removeCustomFavProduct(
                                //                         context,
                                //                         element?.shopId,
                                //                         element?.id,
                                //                         index);
                                //                   },
                                //                   child: Expanded(
                                //                     child: SvgPicture.asset(
                                //                       'assets/icons/fvrt_products.svg',
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //             SizedBox(
                                //               height: 4.w,
                                //             ),
                                //             Text(
                                //               "${element?.shopName}",
                                //               // "Maharaj Kirana Store",
                                //               style: TextStyle(
                                //                   color: Black1,
                                //                   fontSize: 12.sp,
                                //                   fontWeight: FontWeight.w600),
                                //             ),
                                //           ],
                                //         ),
                                //       );
                                //     }),
                              ],
                            ),
                          ),
                        )

                  // watch.isFavShopPressed?CFavouritesShopView():CFavouritesProductView()
                ],
              ),
            ),
    );
  }
}
