import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/products/controller/product_view_controller.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreenView extends StatefulWidget {
  final String? shopId;
  final String? categoryId;
  final String? productId;
  final String? selectedUnitId;
  final String? productType;

  const ProductScreenView(
      {super.key,
      this.productType,
      this.selectedUnitId,
      this.shopId,
      this.categoryId,
      this.productId});

  @override
  _ProductScreenViewState createState() => _ProductScreenViewState();
}

class _ProductScreenViewState extends State<ProductScreenView> {

  PageController? _pageController;
  int activePage = 0;

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return currentIndex == index
          ? Container(
              margin: EdgeInsets.only(left: 85.w),
              width: 16.w,
              height: 6.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: currentIndex == index ? indicator : Grey,
              ),
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewController>().initState(
          context,
          widget.shopId,
          widget.categoryId,
          widget.productId,
          widget.selectedUnitId,
          widget.productType,
      );
    });
    _pageController = PageController(viewportFraction: 1, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ProductViewController>();
    final read = context.read<ProductViewController>();
    return Scaffold(
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : //  onWillPop: () async {
          //     Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => MainScreenView(
          //               index: 1, screenName: (refreshPage: false,))),
          //       (Route<dynamic> route) => false,
          //     );
          //     return false;
          //   },
          WillPopScope(
            onWillPop: ()async{
              return false;
            },
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.w),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.20),
                              blurRadius: 8,
                              spreadRadius: 3),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 54.w,
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
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/location2.svg',
                                            width: 28.w,
                                            height: 28.w,
                                          ),
                                          SizedBox(
                                            width: 9.w,
                                          ),
                                          Text(
                                            "${watch.shopDetails?.shopAddress} \n ${watch.shopDetails?.cityName} - ${watch.shopDetails?.shopPincode}",
                                            // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Black,
                                                  letterSpacing: .5,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400),
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
                                                      context,
                                                      watch.shopDetails?.id)
                                                  : read.updateAllShopFavList(
                                                      context,
                                                      watch.shopDetails?.id);
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
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 17.w,
                          ),
                          Divider(
                            thickness: 1.w,
                            color: Color(0xffDADADA),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          SizedBox(
                              // width: MediaQuery.of(context).size.width,
                              height: 241.w,
                              child: watch.unitImages.isNotEmpty
                                  ? PageView.builder(
                                      itemCount: watch.unitImages.length,
                                      // watch.productViewData?.productUnitDetails?.length ??
                                      //     0,
                                      physics: BouncingScrollPhysics(),
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
                                          child: Center(
                                            child: AppNetworkImages(
                                            imageUrl:  '${element}',
                                              height: 241.w,
                                              // width: 102.w,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              left: pagePosition == 0 ? 19.w : 0,
                                              // top: 15.w,
                                              right: pagePosition ==
                                                  watch.unitImages.length - 1
                                                  ? 19.w
                                                  : 10.w),
                                        );
                                      })
                                  : Container(
                                      child: AppNetworkImages(
                                        // '${element}',
                                     imageUrl:    "${watch.productDetails?.productImagePath}",
                                        // images[pagePosition],
                                        height: 241.w,
                                        // width: 102.w,
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Row(
                                  children: indicators(
                                      watch.unitImages.length, activePage)),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        watch.onShareXFileFromAssets(context);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/icons/share.svg")),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
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
                                physics: NeverScrollableScrollPhysics(),
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
                                          color: Color(0xffEAFFF1),
                                          border: Border.all(
                                              color: Color(0xff69BB86)),
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
                                                                  fontSize: 12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)
                                                              : TextStyle(
                                                                  color: Black1,
                                                                  letterSpacing:
                                                                      .5,
                                                                  fontSize: 12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)))
                                                  : Text(""),
                                              Row(
                                                children: [
                                                  element?.offerPrice != "" &&
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        )
                                                      : Text(""),
                                                  // SizedBox(
                                                  //   width: 8.w,
                                                  // ),
                                                  element?.discountPercentage !=
                                                          ""
                                                      ? Container(
                                                          width: 60.w,
                                                          height: 20.h,
                                                          decoration: BoxDecoration(
                                                              color: lightgreen,
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          5.w))),
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
                                                          style:
                                                              GoogleFonts.dmSans(
                                                            textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              fontSize: 12.sp,
                                                              color: Color(
                                                                  0xff53B175),
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text("${element?.unit}",
                                                          style:
                                                              GoogleFonts.dmSans(
                                                            textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w400,
                                                              fontSize: 12.sp,
                                                              color: Color(
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
                                              // Container(
                                              //   decoration: BoxDecoration(
                                              //       color: Color(0xffE0E0E0),
                                              //       borderRadius:
                                              //           BorderRadius.circular(5.w)),
                                              //   height: 30.w,
                                              //   width: 30.w,
                                              //   child: Padding(
                                              //     padding:
                                              //         EdgeInsets.only(bottom: 20.w),
                                              //     child: Icon(Icons.minimize_sharp),
                                              //   ),
                                              // ),
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              // Text(
                                              //   "1",
                                              //   style: TextStyle(
                                              //       fontSize: 16.sp,
                                              //       fontWeight: FontWeight.w500,
                                              //       color: Colors.black),
                                              // ),
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xffFF844C),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.w)),
                                                height: 30.w,
                                                width: 30.w,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
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
                              color: Color(0xffE2E2E2).withOpacity(0.7),
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
                            Text("Similar Products",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: Black1),
                                )),
                            SizedBox(
                              height: 17.w,
                            ),
                            Container(
                              height: 205.w,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: watch.productViewData
                                          ?.similarProducts?.length ??
                                      0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext, index) {
                                    final element = watch
                                        .productViewData?.similarProducts?[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainScreenView(
                                                    index: 1,
                                                    screenName: ProductScreenView(
                                                        categoryId: element
                                                            ?.categoryId
                                                            .toString(),
                                                        // categoryId: watch.categoryId,
                                                        productId: element?.id
                                                            .toString(),
                                                        shopId: widget.shopId,
                                                        productType:
                                                            element?.productType),
                                                  )),
                                          (Route<dynamic> route) => false,
                                        );
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
                                                  BorderRadius.circular(20.w),
                                            ),
                                            width: 156.w,
                                            padding: EdgeInsets.only(
                                                left: 19.w,
                                                top: 5.w,
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
                                                            width: 60.w,
                                                            height: 20.h,
                                                          ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    element?.productImagePath ==
                                                            ""
                                                        ? Container(
                                                            height: 89.w,
                                                            width: 89.w,
                                                            child: Image.asset(
                                                              "assets/images/profile_image.png",
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 89.w,
                                                            width: 89.w,
                                                            child: AppNetworkImages(
                                                            imageUrl:   "${element?.productImagePath}",
                                                              fit: BoxFit.cover,
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
                                                        style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                            color: Black1,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            // letterSpacing: .5,
                                                            fontSize: 16.sp,

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
                                                  children: [
                                                    Text(
                                                      "${element?.weight}${element?.unit}",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Black1,
                                                            // letterSpacing: .5,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600),
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
                                                        element?.mrpPrice != ""
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
                                                                            fontSize: 12
                                                                                .sp,
                                                                            fontWeight:
                                                                                FontWeight.w400)))
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
                                    );
                                  }),
                            ),
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
