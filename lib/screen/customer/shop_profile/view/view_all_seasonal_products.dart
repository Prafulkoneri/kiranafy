//

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/products/controller/product_view_controller.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/all_seasonal_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class AllSeasonalProducts extends StatefulWidget {
  final String? shopId;
  const AllSeasonalProducts({super.key, required this.shopId});

  @override
  State<AllSeasonalProducts> createState() => _AllSeasonalProductsState();
}

class _AllSeasonalProductsState extends State<AllSeasonalProducts> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<ShopAllSeasonalController>()
          .initState(context, widget.shopId);
    });
    setPagination();
  }

  //
  setPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context
              .read<ShopAllSeasonalController>()
              .onScrollMaxExtent(context, widget.shopId);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ShopAllSeasonalController>();
    final read = context.read<ShopAllSeasonalController>();
    final readMain = context.read<MainScreenController>();
    final readProductViewController = context.read<ProductViewController>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            onBackBtnPressed: () {
              readMain.onNavigation(
                  1,
                  ShopProfileView(
                    shopId: widget.shopId.toString(),
                    routeName: "viewAllSeasonalProduct",
                    refreshPage: true,
                  ),
                  context);
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => MainScreenView(
              //           index: 1,
              //           screenName: ShopProfileView(
              //             shopId: widget.shopId.toString(),
              //             routeName: "viewAllSeasonalProduct",
              //             refreshPage: true,
              //           ))),
              //   (Route<dynamic> route) => false,
              // );
            },
            title: "Seasonal Products",
          ),
        ),
        body: watch.isLoading
            ? Loader()
            : WillPopScope(
                onWillPop: () async {
                  readMain.onNavigation(
                      1,
                      ShopProfileView(
                        shopId: widget.shopId.toString(),
                        routeName: "viewAllSeasonalProduct",
                        refreshPage: true,
                      ),
                      context);
                  return false;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    left: 10.w,
                                    top: 20.w,
                                    right: 10.w,
                                    bottom: 100.w),
                                itemCount: watch.seasonalProduct?.length ?? 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: (1.5.w / 1.8.w),
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0),
                                itemBuilder: (BuildContext, index) {
                                  final element = watch.seasonalProduct?[index];
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: element?.weight == "" &&
                                            element?.offerPrice == "" &&
                                            element?.mrpPrice == "" &&
                                            element?.unit == "" &&
                                            element?.productUnitId == null
                                        ? Container()
                                        : GestureDetector(
                                            onTap: () {
                                              readProductViewController
                                                  .updateProductId(
                                                      element?.id.toString(),
                                                      context,
                                                      false);
                                              readMain.onNavigation(
                                                  1,
                                                  ProductScreenView(
                                                      selectedUnitId: element
                                                          ?.productUnitId
                                                          .toString(),
                                                      categoryId: element
                                                          ?.categoryId
                                                          .toString(),
                                                      // categoryId: watch.categoryId,
                                                      productId: element?.id
                                                          .toString(),
                                                      shopId: element?.shopId,
                                                      productType:
                                                          element?.productType),
                                                  context);
                                              // Navigator.pushAndRemoveUntil(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           MainScreenView(
                                              //             index: 1,
                                              //             screenName:
                                              //                 ProductScreenView(
                                              //                     selectedUnitId: element
                                              //                         ?.productUnitId
                                              //                         .toString(),
                                              //                     categoryId: element
                                              //                         ?.categoryId
                                              //                         .toString(),
                                              //                     // categoryId: watch.categoryId,
                                              //                     productId: element
                                              //                         ?.id
                                              //                         .toString(),
                                              //                     shopId: element
                                              //                         ?.shopId,
                                              //                     productType: element
                                              //                         ?.productType),
                                              //           )),
                                              //   (Route<dynamic> route) => false,
                                              // );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: 17.w,
                                                right: 12.w,
                                              ),
                                              width: 156.w,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 0.w, top: 10.w),
                                                    child: Row(
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
                                                            : Container(
                                                                width: 60.w,
                                                                height: 20.h,
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      element?.productImagePath ==
                                                              ""
                                                          ? Container(
                                                              height: 68.w,
                                                              width: 68.w,
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/image_not_found.png",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            )
                                                          : Container(
                                                              height: 68.w,
                                                              width: 68.w,
                                                              child:
                                                                  AppNetworkImages(
                                                                imageUrl:
                                                                    "${element?.productImagePath}",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5.w,
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
                                                        style:
                                                            GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              color: Black1,
                                                              // letterSpacing: .5,
                                                              fontSize: 12.sp,
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
                                                  Container(
                                                    // padding: EdgeInsets.only(right: 0.w, bottom: 0.w),
                                                    child: Row(
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
                                                        // GestureDetector(
                                                        //   onTap: () {
                                                        //     read.addToCart(
                                                        //         element?.productType,
                                                        //         element?.productUnitId,
                                                        //         element?.shopId,
                                                        //         context);
                                                        //     watch.onSeasonalSelected(
                                                        //         index);
                                                        //   },
                                                        //   child: watch.isAllSeasonalProductAdded[
                                                        //               index] ==
                                                        //           false
                                                        //       ? SvgPicture.asset(
                                                        //           'assets/images/add.svg',
                                                        //           // width: 15.w,
                                                        //           // height: 19.h,
                                                        //         )
                                                        //       : SvgPicture.asset(
                                                        //           "assets/icons/tick_green_bg.svg"),
                                                        // ),
                                                        watch.isAllSeasonalProductAdded[
                                                                    index] ==
                                                                false
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  read.addToCart(
                                                                      element
                                                                          ?.productType,
                                                                      element
                                                                          ?.productUnitId,
                                                                      element
                                                                          ?.shopId,
                                                                      index,
                                                                      context);
                                                                  // watch
                                                                  //     .onOfferSelected(
                                                                  //         index);
                                                                },
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/images/add.svg',
                                                                  // width: 15.w,
                                                                  // height: 19.h,
                                                                ))
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  read.removeFromCart(
                                                                      element
                                                                          ?.productType,
                                                                      element
                                                                          ?.productUnitId,
                                                                      element
                                                                          ?.shopId,
                                                                      index,
                                                                      context);
                                                                },
                                                                child: SvgPicture
                                                                    .asset(
                                                                        "assets/icons/tick_green_bg.svg"),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 100.w,
                        left: 0,
                        right: 0,
                        child: Visibility(
                          visible: watch.showPaginationLoader,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: SplashText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
