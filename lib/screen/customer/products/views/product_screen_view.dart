import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/cart/view/cart_detail_view.dart';
import 'package:local_supper_market/screen/customer/category/view/category_view.dart';
import 'package:local_supper_market/screen/customer/favourites/view/favourites_view.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/products/controller/product_view_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/favourite.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductScreenView extends StatefulWidget {
  final String? shopId;
  final String? categoryId;
  final String? productId;
  final String? selectedUnitId;
  final String? productType;
  final String? routeName;

  const ProductScreenView(
      {super.key,
      required this.productType,
      this.selectedUnitId,
      this.shopId,
      this.categoryId,
      this.productId,
      required this.routeName});

  @override
  _ProductScreenViewState createState() => _ProductScreenViewState();
}

class _ProductScreenViewState extends State<ProductScreenView> {
  PageController? _pageController;
  int activePage = 0;

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return currentIndex == index
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  width: 16.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.w),
                    color: currentIndex == index ? indicator : Grey,
                  ),
                ),
              ],
            )
          : Container(
              margin: EdgeInsets.only(left: 7.w),
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(color: Grey, shape: BoxShape.circle),
            );
    });
  }

  @override
  void initState() {
    final watch = Provider.of<ProductViewController>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewController>().initState(
          context,
          widget.shopId,
          widget.categoryId,
          watch.productId,
          widget.selectedUnitId,
          widget.productType,
          widget.routeName);
    });
    _pageController = PageController(viewportFraction: 1, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ProductViewController>();
    final read = context.read<ProductViewController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            // print(widget.)
            if (widget.routeName == "cart_details") {
              readMain.onNavigation(
                  2,
                  CartDetailView(
                      isRefresh: true,
                      shopId: watch.shopDetails?.id.toString(),
                      cartId: watch.cartId),
                  context);
              readMain.hideBottomNavigationBar();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => CartDetailView(
              //             isRefresh: true,
              //             shopId: watch.shopDetails?.id.toString(),
              //             cartId: watch.cartId)));
            } else if (widget.routeName == "homeScreen") {
              readMain.onNavigation(
                  0, const HomeScreenView(refreshPage: false), context);
            } else if (widget.routeName == "homeScreenBanner") {
              readMain.onNavigation(
                  0, const HomeScreenView(refreshPage: false), context);
            } else if (widget.routeName == "favouriteProduct") {
              readMain.onNavigation(
                  4, const CFavouritesView(selectedIndex: 1), context);
            } else if (widget.routeName == "categoryView") {
              readMain.onNavigation(
                  1,
                  CategoryScreenView(
                      categoryId: widget.categoryId, shopId: widget.shopId),
                  context);
            } else {
              readMain.onNavigation(
                  1,
                  ShopProfileView(
                    refreshPage: true,
                    routeName: '',
                    shopId: watch.shopDetails?.id.toString(),
                  ),
                  context);
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => MainScreenView(
              //           index: 1,
              //           screenName: ShopProfileView(
              //             refreshPage: true,
              //             routeName: '',
              //             shopId: watch.shopDetails?.id.toString(),
              //           ))),
              //       (Route<dynamic> route) => false,
              // );
            }
          },

          title: "Product View",
          // "Cold Drinks & Juices - 2",
          // action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () {},
        ),
      ),
      body: watch.isLoading
          ? const Loader()
          : //  onWillPop: () async {
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => MainScreenView(
          //           index: 1, screenName: (refreshPage: false,))),
          //   (Route<dynamic> route) => false,
          // );
          //     return false;
          //   },
          WillPopScope(
              onWillPop: () async {
                if (widget.routeName == "cart_details") {
                  readMain.onNavigation(
                      2,
                      CartDetailView(
                          isRefresh: true,
                          shopId: watch.shopDetails?.id.toString(),
                          cartId: watch.cartId),
                      context);
                  readMain.hideBottomNavigationBar();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => CartDetailView(
                  //             isRefresh: true,
                  //             shopId: watch.shopDetails?.id.toString(),
                  //             cartId: watch.cartId)));
                } else if (widget.routeName == "homeScreen") {
                  readMain.onNavigation(
                      0, const HomeScreenView(refreshPage: false), context);
                } else if (widget.routeName == "favouriteProduct") {
                  readMain.onNavigation(
                      4, const CFavouritesView(selectedIndex: 1), context);
                } else if (widget.routeName == "categoryView") {
                  readMain.onNavigation(
                      1,
                      CategoryScreenView(
                          categoryId: widget.categoryId, shopId: widget.shopId),
                      context);
                } else {
                  readMain.onNavigation(
                      1,
                      ShopProfileView(
                        refreshPage: true,
                        routeName: '',
                        shopId: watch.shopDetails?.id.toString(),
                      ),
                      context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MainScreenView(
                  //           index: 1,
                  //           screenName: ShopProfileView(
                  //             refreshPage: true,
                  //             routeName: '',
                  //             shopId: watch.shopDetails?.id.toString(),
                  //           ))),
                  //       (Route<dynamic> route) => false,
                  // );
                }
                return false;
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.circular(30.w),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.20),
                              blurRadius: 8,
                              spreadRadius: 3),
                        ],
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(watch.shopDetails?.id.toString());
                              readMain.onNavigation(
                                  1,
                                  ShopProfileView(
                                    refreshPage: true,
                                    routeName: 'homeNearbyShop',
                                    // categoryId: watch.shopDetails?..toString(),
                                    shopId: watch.shopDetails?.id.toString(),
                                  ),
                                  context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.w,
                                  ),
                                  Text("${watch.shopDetails?.shopName}",
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Black1),
                                      )),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/location2.svg',
                                                width: 28.w,
                                                height: 28.w,
                                              ),
                                              SizedBox(
                                                width: 9.w,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${watch.shopDetails?.shopAddress}\n${watch.shopDetails?.cityName} - ${watch.shopDetails?.shopPincode}",
                                                  // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Black,
                                                        letterSpacing: .5,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                        // Row(
                                        //   children: [
                                        //     InkWell(
                                        //       onTap: () {
                                        // read.launchPhone(
                                        //     watch.shopDetails
                                        //             ?.shopOwnerSupportNumber ??
                                        //         "",
                                        //     context);
                                        //       },
                                        //       child: Container(
                                        //           padding: EdgeInsets.only(
                                        //               left: 13.w,
                                        //               right: 13.w,
                                        //               top: 14.w,
                                        //               bottom: 14.w),
                                        //           decoration: BoxDecoration(
                                        //             shape: BoxShape.circle,
                                        //             color: Color(0xff23AA49),
                                        //           ),
                                        //           child: SvgPicture.asset(
                                        //             "assets/icons/new_call.svg",
                                        //             width: 26.w,
                                        //             height: 14.h,
                                        //           )),
                                        //     ),
                                        //     SizedBox(
                                        //       width: 13.w,
                                        //     ),
                                        //     InkWell(
                                        //       onTap: () {
                                        // watch.favAllShop
                                        //     ? read.removeAllShopFavList(
                                        //         context,
                                        //         watch.shopDetails?.id)
                                        //     : read.updateAllShopFavList(
                                        //         context,
                                        //         watch.shopDetails?.id);
                                        //       },
                                        //       child: watch.favAllShop
                                        //           ? SvgPicture.asset(
                                        //               "assets/icons/new_fvrt_selected.svg",
                                        //               // width: 26.w,
                                        //               // height: 14.h,
                                        //             )
                                        //           : SvgPicture.asset(
                                        //               "assets/icons/new_fvrt_not_selected.svg",
                                        //               // width: 26.w,
                                        //               // height: 14.h,
                                        //             ),
                                        //       // ? SvgPicture.asset(
                                        //       //     "assets/icons/fav_selected.svg",
                                        //       //     width: 26.w,
                                        //       //     height: 14.h,
                                        //       //   )
                                        //       // : SvgPicture.asset(
                                        //       //     "assets/images/favorite.svg",
                                        //       //     width: 26.w,
                                        //       //     height: 14.h,
                                        //       //   ),
                                        //     )
                                        //   ],
                                        // ),
                                        FavouriteView(
                                          isFvrt: watch.favAllShop,
                                          onPhoneTap: () {
                                            read.launchPhone(
                                                watch.shopDetails
                                                        ?.shopOwnerSupportNumber ??
                                                    "",
                                                context);
                                          },
                                          onFvrtTap: () {
                                            watch.favAllShop
                                                ? read.removeAllShopFavList(
                                                    context,
                                                    watch.shopDetails?.id)
                                                : read.updateAllShopFavList(
                                                    context,
                                                    watch.shopDetails?.id);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 17.w,
                          ),
                          Divider(
                            thickness: 1.w,
                            color: const Color(0xffDADADA),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          SizedBox(
                              // width: MediaQuery.of(context).size.width,
                              height: 241.w,
                              child: watch.isUnitImagesVisible
                                  ? watch.unitImages.isEmpty
                                      ? Container(
                                          child: Image.asset(
                                            "assets/images/image_not_found.png",
                                            height: 241.w,
                                            // width: 102.w,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      : PageView.builder(
                                          itemCount: watch.unitImages.length,
                                          // watch.productViewData?.productUnitDetails?.length ??
                                          //     0,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padEnds: false,
                                          pageSnapping: true,
                                          // controller: _pageController,
                                          onPageChanged: (page) {
                                            setState(() {
                                              activePage = page;
                                            });
                                          },
                                          itemBuilder: (context, pagePosition) {
                                            final element =
                                                watch.unitImages[pagePosition];
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  left: pagePosition == 0
                                                      ? 19.w
                                                      : 0,
                                                  // top: 15.w,
                                                  right: pagePosition ==
                                                          watch.unitImages
                                                                  .length -
                                                              1
                                                      ? 19.w
                                                      : 10.w),
                                              child: Center(
                                                child: AppNetworkImages(
                                                  showShopImage: true,
                                                  imageUrl: '$element',
                                                  height: 241.w,
                                                  // width: 102.w,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            );
                                          })
                                  : Container(
                                      child: AppNetworkImages(
                                        showShopImage: true,
                                        // '${element}',
                                        imageUrl:
                                            "${watch.productDetails?.productImagePath}",
                                        // images[pagePosition],
                                        height: 241.w,
                                        // width: 102.w,
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                          SizedBox(
                            height: 10.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              SizedBox(
                                width: 0.w,
                              ),
                              Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: indicators(
                                      watch.unitImages.length, activePage)),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        read.shareProduct(watch
                                            .productDetails?.productImagePath);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/icons/share.svg")),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      tapPadding:
                                      const EdgeInsets.all(35.0);
                                      watch.isFavProduct
                                          ? read.removeFavProduct(context)
                                          : read.addToFavProduct(context);
                                    },
                                    child: watch.isFavProduct
                                        ? SvgPicture.asset(
                                            "assets/icons/fvrtproduct.svg",
                                            width: 26.w,
                                            height: 14.h,
                                          )
                                        : SvgPicture.asset(
                                            "assets/icons/remove_fav.svg",
                                            width: 26.w,
                                            height: 14.h,
                                          ),
                                  ), /////fvrtproduct
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ///////////////////

                          SizedBox(
                            height: 25.w,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25.w,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${watch.productDetails?.productName}",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp,
                                    color: Black1),
                              )),
                          SizedBox(
                            height: 9.w,
                          ),
                          Row(
                            children: [
                              Text("${watch.productDetails?.brandName}",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp,
                                        color: SplashText),
                                  )),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text("${watch.productDetails?.categoryName}",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp,
                                        color: Black),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 22.w,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: watch.productViewData
                                        ?.productUnitDetails?.length ??
                                    0,
                                itemBuilder: (BuildContext, index) {
                                  final element = watch.productViewData
                                      ?.productUnitDetails?[index];
                                  return GestureDetector(
                                    onTap: () {
                                      read.productsUnitImage(
                                          context, element?.id.toString());
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 18.w),
                                      decoration: BoxDecoration(
                                          color: watch.isUnitImagesAdded[index]
                                              ? const Color(0xffEAFFF1)
                                              : Colors.white,
                                          border: Border.all(
                                              color: watch
                                                      .isUnitImagesAdded[index]
                                                  ? const Color(0xff69BB86)
                                                  : const Color(0xffB3B3B3)),
                                          borderRadius:
                                              BorderRadius.circular(10.w)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 7.w, horizontal: 14.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              element?.mrpPrice != ""
                                                  ? Text(
                                                      '\u{20B9}${element?.mrpPrice}',
                                                      style: GoogleFonts.dmSans(
                                                          textStyle: element?.offerPrice !=
                                                                      "" &&
                                                                  element?.offerPrice !=
                                                                      element
                                                                          ?.mrpPrice
                                                              ? TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  color: Black1,
                                                                  letterSpacing:
                                                                      .5,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)
                                                              : TextStyle(
                                                                  color: Black1,
                                                                  letterSpacing:
                                                                      .5,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)))
                                                  : const Text(""),
                                              Row(
                                                children: [
                                                  element?.offerPrice != "" &&
                                                          element?.offerPrice !=
                                                              element?.mrpPrice
                                                      ? Text(
                                                          '\u{20B9}${element?.offerPrice}',
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            textStyle:
                                                                TextStyle(
                                                                    // decoration:
                                                                    // TextDecoration.lineThrough,
                                                                    color:
                                                                        Black,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                        )
                                                      : const Text(""),

                                                  element?.discountPercentage !=
                                                          ""
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5.w,
                                                                  right: 5.w),
                                                          width: 60.w,
                                                          height: 20.h,
                                                          decoration: BoxDecoration(
                                                              color: lightgreen,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.w))),
                                                          child: Center(
                                                            child: Text(
                                                                "${element?.discountPercentage} off",
                                                                // textAlign: TextAlign.center,
                                                                style:
                                                                    GoogleFonts
                                                                        .dmSans(
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          .5,
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                )),
                                                          ),
                                                        )
                                                      : Container(
                                                          // width: 60.w,
                                                          // height: 20.h,
                                                          ),
                                                  // SizedBox(
                                                  //   width: 12.w,
                                                  // ),
                                                  Row(
                                                    children: [
                                                      // SizedBox(
                                                      //   width: 12.w,
                                                      // ),
                                                      Text("${element?.weight}",
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            textStyle:
                                                                TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12.sp,
                                                              color: const Color(
                                                                  0xff53B175),
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text("${element?.unit}",
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            textStyle:
                                                                TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12.sp,
                                                              color: const Color(
                                                                  0xff53B175),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              // InkWell(
                                              //   onTap: () {
                                              //     read.showUnitImages(false);
                                              //     read.productsUnitImage(
                                              //         context,
                                              //         element?.id.toString());
                                              //     //  read.addToCart(watch.productDetails?.id,
                                              //     //  watch?.productUnitId,element?.shopId,context);
                                              //     read.addToCart(
                                              //         watch.addProductType
                                              //             .toString(),
                                              //         watch.addProductUnitId
                                              //             .toString(),
                                              //         watch.addProductShopId
                                              //             .toString(),
                                              //         context);
                                              //   },
                                              //   child: Container(
                                              //     decoration: BoxDecoration(
                                              //         color: const Color(
                                              //             0xffFF844C),
                                              //         borderRadius:
                                              //             BorderRadius.circular(
                                              //                 5.w)),
                                              //     height: 30.w,
                                              //     width: 30.w,
                                              //     child: const Center(
                                              //       child: Icon(
                                              //         Icons.add,
                                              //         color: Colors.white,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                              GestureDetector(
                                                onTap: () async {
                                                  SharedPreferences pref =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  if (pref.getString(
                                                          "status") ==
                                                      "guestLoggedIn") {
                                                    Utils().showLoginDialog(
                                                        context,
                                                        "Please Login to add product to cart");
                                                    return;
                                                  }
                                                  //  read.addToCart(watch.productDetails?.id,
                                                  //  watch?.productUnitId,element?.shopId,context);
                                                  watch.onUnitImagesSelected(
                                                      index);
                                                  read.addToCart(
                                                      element?.productType
                                                          .toString(),
                                                      element?.productUnitId
                                                          .toString(),
                                                      watch.shopDetails?.id
                                                          .toString(),
                                                      index,
                                                      context,
                                                      false);
                                                },
                                                child: watch.isUnitImagesAdded[
                                                            index] ==
                                                        false
                                                    ? SvgPicture.asset(
                                                        'assets/images/add.svg',
                                                        // width: 15.w,
                                                        // height: 19.h,
                                                      )
                                                    : Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (watch
                                                                  .isQuanityBtnPressed) {
                                                                return;
                                                              }
                                                              read.subtractItemQuantity(
                                                                  context,
                                                                  element
                                                                      ?.cartItemId
                                                                      .toString(),
                                                                  index,
                                                                  element
                                                                      ?.productType,
                                                                  element
                                                                      ?.productUnitId,
                                                                  false);
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/icons/minus.svg',
                                                              // width: 30.w,
                                                              // height: 30.h,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 12.w,
                                                          ),
                                                          Text(
                                                            "${watch.quantityList[index]}",
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle: TextStyle(
                                                                  // decoration:
                                                                  // TextDecoration.lineThrough,
                                                                  color: Black,
                                                                  // letterSpacing:
                                                                  //     .5,
                                                                  fontSize: 16.sp,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 12.w,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              print(watch
                                                                  .isQuanityBtnPressed);
                                                              // return;
                                                              if (watch
                                                                  .isQuanityBtnPressed) {
                                                                return;
                                                              }
                                                              read.addItemQuantity(
                                                                  context,
                                                                  element
                                                                      ?.cartItemId
                                                                      .toString(),
                                                                  index,
                                                                  element
                                                                      ?.productType,
                                                                  false);
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/images/add.svg',
                                                              // width: 30.w,
                                                              // height: 30.h,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 12.w,
                            ),
                            Text("About Product ",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: Black1),
                                )),
                            SizedBox(
                              height: 7.w,
                            ),
                            Divider(
                              thickness: 1.w,
                              color: const Color(0xffE2E2E2).withOpacity(0.7),
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            Text("${watch.productDetails?.productDescription}",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp,
                                      height: 1.6,
                                      color: Black1),
                                )),
                            SizedBox(
                              height: 30.w,
                            ),
                            watch.productViewData?.similarProducts
                                        ?.isNotEmpty ??
                                    false
                                ? Text("Similar Products",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                          color: Black1),
                                    ))
                                : Container(),
                            watch.productViewData?.similarProducts
                                        ?.isNotEmpty ??
                                    false
                                ? SizedBox(
                                    height: 17.w,
                                  )
                                : Container(),
                            watch.productViewData?.similarProducts
                                        ?.isNotEmpty ??
                                    false
                                ? SizedBox(
                                    height: 210.w,
                                    child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: watch.productViewData
                                                ?.similarProducts?.length ??
                                            0,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext, index) {
                                          final element = watch.productViewData
                                              ?.similarProducts?[index];
                                          return element?.weight == "" &&
                                                  element?.offerPrice == "" &&
                                                  element?.mrpPrice == "" &&
                                                  element?.unit == "" &&
                                                  element?.productUnitId == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    print(element?.id);
                                                    watch.updateProductId(
                                                        element?.id.toString(),
                                                        context,
                                                        true);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      // color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.03.w),
                                                            blurRadius: 5,
                                                            spreadRadius: 0,
                                                            offset:
                                                                const Offset(
                                                                    0, 3)),
                                                      ],
                                                    ),
                                                    child: Card(
                                                      // shape: ShapeBorder.
                                                      elevation: 0,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.w),
                                                        ),
                                                        width: 156.w,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 19.w,
                                                                top: 5.w,
                                                                right: 12.w,
                                                                bottom: 12.w),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
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
                                                                    : SizedBox(
                                                                        width:
                                                                            60.w,
                                                                        height:
                                                                            20.h,
                                                                      ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                element?.productImagePath ==
                                                                        ""
                                                                    ? SizedBox(
                                                                        height:
                                                                            89.w,
                                                                        width:
                                                                            89.w,
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/images/image_not_found.png",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      )
                                                                    : SizedBox(
                                                                        height:
                                                                            89.w,
                                                                        width:
                                                                            89.w,
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
                                                                        color:
                                                                            Black1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        // letterSpacing: .5,
                                                                        fontSize:
                                                                            16.sp,

                                                                        fontWeight:
                                                                            FontWeight.w600,
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
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "${element?.weight} ${element?.unit}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    textStyle: TextStyle(
                                                                        color: Black1,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 12.sp,
                                                                        fontWeight: FontWeight.w600),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    element?.mrpPrice !=
                                                                            ""
                                                                        ? Text(
                                                                            '\u{20B9}${element?.mrpPrice}',
                                                                            style:
                                                                                GoogleFonts.dmSans(textStyle: element?.offerPrice != "" && element?.offerPrice != element?.mrpPrice ? TextStyle(decoration: TextDecoration.lineThrough, color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400) : TextStyle(color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400)))
                                                                        : const Text(""),
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                    element?.offerPrice !=
                                                                                "" &&
                                                                            element?.offerPrice !=
                                                                                element?.mrpPrice
                                                                        ? Text(
                                                                            '\u{20B9}${element?.offerPrice}',
                                                                            style:
                                                                                GoogleFonts.dmSans(
                                                                              textStyle: TextStyle(
                                                                                  // decoration:
                                                                                  // TextDecoration.lineThrough,
                                                                                  color: Black,
                                                                                  letterSpacing: .5,
                                                                                  fontSize: 13.sp,
                                                                                  fontWeight: FontWeight.w500),
                                                                            ),
                                                                          )
                                                                        : const Text(""),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5.w,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                // GestureDetector(
                                                                //   onTap: () {
                                                                //     read.addToCart(
                                                                //         element
                                                                //             ?.productType,
                                                                //         element
                                                                //             ?.productUnitId,
                                                                //         element
                                                                //             ?.shopId,
                                                                //         context);
                                                                //     watch
                                                                //         .onSimilarProductSelected(
                                                                //             index);
                                                                //   },
                                                                //   child: watch.isSimilarProductAdded[
                                                                //               index] ==
                                                                //           false
                                                                //       ? SvgPicture
                                                                //           .asset(
                                                                //           'assets/images/add.svg',
                                                                //           // width: 15.w,
                                                                //           // height: 19.h,
                                                                //         )
                                                                //       : SvgPicture.asset(
                                                                //           "assets/icons/tick_green_bg.svg"),
                                                                // ),
                                                                watch.similarQuantityList[
                                                                            index] ==
                                                                        0
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          read.addToCart(
                                                                              element?.productType.toString(),
                                                                              // element
                                                                              //     ?.productId,
                                                                              element?.productUnitId,
                                                                              element?.shopId,
                                                                              index,
                                                                              context,
                                                                              true);
                                                                          // watch
                                                                          //     .onOfferSelected(
                                                                          //         index);
                                                                        },
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          'assets/images/add.svg',
                                                                          // width: 15.w,
                                                                          // height: 19.h,
                                                                        ))
                                                                    : Row(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              if (watch.isQuanityBtnPressed) {
                                                                                return;
                                                                              }
                                                                              print(element?.productType);

                                                                              read.subtractItemQuantity(context, element?.cartItemId.toString(), index, element?.productType, element?.productUnitId, true);
                                                                            },
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              'assets/icons/minus.svg',
                                                                              // width: 30.w,
                                                                              // height: 30.h,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                12.w,
                                                                          ),
                                                                          Text(
                                                                            "${watch.similarQuantityList[index]}",
                                                                            style:
                                                                                GoogleFonts.dmSans(
                                                                              textStyle: TextStyle(
                                                                                  // decoration:
                                                                                  // TextDecoration.lineThrough,
                                                                                  color: Black,
                                                                                  // letterSpacing:
                                                                                  //     .5,
                                                                                  fontSize: 16.sp,
                                                                                  fontWeight: FontWeight.w500),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                12.w,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              print(watch.isQuanityBtnPressed);
                                                                              // return;
                                                                              if (watch.isQuanityBtnPressed) {
                                                                                return;
                                                                              }
                                                                              print(element?.productType);
                                                                              read.addItemQuantity(context, element?.cartItemId.toString(), index, element?.productType, true);
                                                                            },
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              'assets/images/add.svg',
                                                                              // width: 30.w,
                                                                              // height: 30.h,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )

                                                                // GestureDetector(
                                                                //         onTap:
                                                                //             () {
                                                                //           read.removeFromCart(
                                                                //               element?.productType,
                                                                //               element?.productUnitId,
                                                                //               element?.shopId,
                                                                //               index,
                                                                //               context,
                                                                //               true);
                                                                //         },
                                                                //         child: SvgPicture.asset(
                                                                //         ,    "assets/icons/tick_green_bg.svg"),
                                                                //       )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                        }),
                                  )
                                : Container(),
                            SizedBox(
                              height: 100.w,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}
