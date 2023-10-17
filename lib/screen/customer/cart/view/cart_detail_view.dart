import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/cart/controller/cart_detail_controller.dart';
import 'package:local_supper_market/screen/customer/cart/view/cart_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/view/order_summary_view.dart';
import 'package:local_supper_market/screen/customer/products/controller/product_view_controller.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class CartDetailView extends StatefulWidget {
  final String? shopId;
  final String? cartId;
  final bool? isRefresh;

  const CartDetailView(
      {super.key, this.cartId, this.shopId, required this.isRefresh});

  @override
  State<CartDetailView> createState() => _CartDetailViewState();
}

class _CartDetailViewState extends State<CartDetailView> {
  @override
  void initState() {
    print(widget.shopId);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<CartDetailController>()
          .initState(context, widget.cartId, widget.shopId, widget.isRefresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CartDetailController>();
    final read = context.read<CartDetailController>();
    final readProductViewController = context.read<ProductViewController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            title: "Cart Details",
            action: SvgPicture.asset("assets/images/delete.svg"),
            onActionTap: () {
              // read.deleteCartDetails(context, widget.cartId);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Color(0xffFFFFFF),
                      // shape: ,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),

                      // scrollable: true,
                      child: Container(
                        height: 205.h,
                        // width: 400.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "Do you really want to Delete Your Cart ? ",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Color(0xff006F94),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 37.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 19.w,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      // Navigator.pop(context);
                                      // await read.deleteShopCart(
                                      //   context,
                                      // );
                                      read.deleteCartDetails(
                                          context, widget.cartId);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 24.w,
                                          right: 24.w,
                                          top: 9.w,
                                          bottom: 9.w),
                                      decoration: BoxDecoration(
                                          color: Color(0xff39C19D),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        "Yes",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              // letterSpacing: .5,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 14.w,
                                          right: 15.w,
                                          top: 9.w,
                                          bottom: 9.w),
                                      decoration: BoxDecoration(
                                          color: Color(0xffEC7074),
                                          // border: Border.all(width: 1, color: Black),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "No",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  // letterSpacing: .5,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            onBackBtnPressed: () {
              // Navigator.pop(context);
              readMain.onNavigation(2, CartScreenView(), context);
              readMain.showBottomNavigationBar();
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) =>
              //           MainScreenView(index: 2, screenName: CartScreenView())),
              //   (Route<dynamic> route) => false,
              // );
            },
          ),
        ),
        body: watch.isLoading
            ? Loader()
            : watch.shopDetailData == null
                ? Container()
                : WillPopScope(
                    onWillPop: () async {
                      readMain.onNavigation(2, CartScreenView(), context);
                      readMain.showBottomNavigationBar();
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => MainScreenView(
                      //           index: 2, screenName: CartScreenView())),
                      //   (Route<dynamic> route) => false,
                      // );
                      return false;
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          readMain.onNavigation(
                                              1,
                                              ShopProfileView(
                                                refreshPage: true,
                                                routeName: '',
                                                shopId: watch.shopDetailData?.id
                                                    .toString(),
                                              ),
                                              context);
                                          readMain.showBottomNavigationBar();
                                          // Navigator.pushAndRemoveUntil(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           MainScreenView(
                                          //               index: 1,
                                          //               screenName:
                                          //                   ShopProfileView(
                                          //                 refreshPage: true,
                                          //                 routeName: '',
                                          //                 shopId: watch
                                          //                     .shopDetailData
                                          //                     ?.id
                                          //                     .toString(),
                                          //               ))),
                                          //   (Route<dynamic> route) => false,
                                          // );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 17.w, top: 20.w),
                                              child: Text(
                                                "${watch.shopDetailData?.shopName}",
                                                // "New Balaji Trading Company",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: Black1,
                                                      letterSpacing: .5,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7.h,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(12.w),
                                              // height: 70.h,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                                                  bottom: BorderSide(
                                                      width: 1, color: grey2),
                                                ),
                                              ),

                                              // color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/images/location2.svg',
                                                        // width: 23.w,
                                                        // height: 28.h,
                                                      ),
                                                      SizedBox(
                                                        width: 8.w,
                                                      ),
                                                      Container(
                                                        width: 200.w,
                                                        child: Text(
                                                          "${watch.shopDetailData?.shopAddress}\n${watch.shopDetailData?.cityName} - ${watch.shopDetailData?.shopPincode}",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            textStyle:
                                                                TextStyle(
                                                                    color:
                                                                        Black,
                                                                    // letterSpacing: .5,
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          read.launchPhone(
                                                              watch.shopDetailData
                                                                      ?.shopOwnerSupportNumber ??
                                                                  "",
                                                              context);
                                                        },
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 13.w,
                                                                    right: 13.w,
                                                                    top: 14.w,
                                                                    bottom:
                                                                        14.w),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xff23AA49),
                                                            ),
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/icons/new_call.svg",
                                                              width: 26.w,
                                                              height: 14.h,
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        width: 13.w,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          watch.favAllShop
                                                              ? read.removeAllShopFavList(
                                                                  context,
                                                                  watch
                                                                      .shopDetailData
                                                                      ?.id)
                                                              : read.updateAllShopFavList(
                                                                  context,
                                                                  watch
                                                                      .shopDetailData
                                                                      ?.id);
                                                        },
                                                        child: watch.favAllShop
                                                            ? SvgPicture.asset(
                                                                "assets/icons/new_fvrt_selected.svg",
                                                                // width: 26.w,
                                                                // height: 14.h,
                                                              )
                                                            : SvgPicture.asset(
                                                                "assets/icons/new_fvrt_not_selected.svg",
                                                                // width: 26.w,
                                                                // height: 14.h,
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
                                      Container(
                                        // height: 360.h,
                                        // width: 352.w,
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            physics: BouncingScrollPhysics(),
                                            // physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                watch.cartItemList?.length ?? 0,
                                            // watch.cartDetailData?.cartItemList?.length ?? 0,
                                            itemBuilder: (BuildContext, index) {
                                              final element =
                                                  watch.cartItemList?[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  readProductViewController
                                                      .updateProductId(
                                                          element?.productId
                                                              .toString(),
                                                          context,
                                                          false);
                                                  print("anobot");
                                                  readProductViewController
                                                      .getCartId(
                                                          watch.orderCartId);
                                                  readMain.onNavigation(
                                                      1,
                                                      ProductScreenView(
                                                        // selectedUnitId: element?.productUnitId.toString(),
                                                        categoryId: element
                                                            ?.categoryId
                                                            .toString(),
                                                        // categoryId: watch.categoryId,
                                                        productId: element
                                                            ?.productId
                                                            .toString(),
                                                        shopId: watch
                                                            .shopDetailData?.id
                                                            .toString(),
                                                        // widget.shopId,
                                                        productType: element
                                                            ?.productType,
                                                        routeName:
                                                            "cart_details",
                                                      ),
                                                      context);
                                                  readMain
                                                      .showBottomNavigationBar();

                                                  // Navigator.pushAndRemoveUntil(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           MainScreenView(
                                                  //             index: 1,
                                                  //             screenName:
                                                  //                 ProductScreenView(
                                                  //               // selectedUnitId: element?.productUnitId.toString(),
                                                  //               categoryId: element
                                                  //                   ?.categoryId
                                                  //                   .toString(),
                                                  //               // categoryId: watch.categoryId,
                                                  //               productId: element
                                                  //                   ?.productId
                                                  //                   .toString(),
                                                  //               shopId: watch
                                                  //                   .shopDetailData
                                                  //                   ?.id
                                                  //                   .toString(),
                                                  //               // widget.shopId,
                                                  //               productType: element
                                                  //                   ?.productType,
                                                  //               routeName:
                                                  //                   "cart_details",
                                                  //             ),
                                                  //           )),
                                                  //   (Route<dynamic> route) =>
                                                  //       false,
                                                  // );
                                                },
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 18.w,
                                                          top: index == 0
                                                              ? 14.w
                                                              : 24.w,
                                                          right: 17.w),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 5.w),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.07),
                                                              width: 1),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.04),
                                                                blurRadius: 5,
                                                                offset: Offset(
                                                                    -.0, 5.0),
                                                                spreadRadius:
                                                                    0),
                                                          ],
                                                        ),
                                                        // height: 95.h,
                                                        // width: 355.w,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.w),
                                                          child: Row(
                                                            children: [
                                                              element?.productImagePath ==
                                                                      ""
                                                                  ? Container(
                                                                      width:
                                                                          80.w,
                                                                      height:
                                                                          80.h,
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/image_not_found.png",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      width:
                                                                          80.w,
                                                                      height:
                                                                          80.h,
                                                                      child:
                                                                          AppNetworkImages(
                                                                        imageUrl:
                                                                            "${element?.productImagePath}",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                              // Container(
                                                              // padding:
                                                              //     EdgeInsets.only(left: 10.w),
                                                              //   child:
                                                              //       AppNetworkImages(
                                                              //     imageUrl: element
                                                              //         ?.productImagePath,
                                                              // width: 80.w,
                                                              // height: 80.h,
                                                              //     fit: BoxFit
                                                              //         .cover,
                                                              //     // height: 92.h,
                                                              //   ),
                                                              // ),
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                              Container(
                                                                height: 70.h,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border:
                                                                            Border(
                                                                  left:
                                                                      BorderSide(
                                                                    //                   <--- right side
                                                                    color: Color(
                                                                        0xffE0E0E0),
                                                                    // width: 1.0,
                                                                  ),
                                                                )),
                                                              ),
                                                              // VerticalDivider(
                                                              //   color: lightgrey,
                                                              //   thickness: 1,
                                                              // ),
                                                              SizedBox(
                                                                width: 15.w,
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          5.w,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                          right:
                                                                              5.w),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Text(
                                                                              "${element?.productName}",
                                                                              // "Ariel Washing Powder",
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(
                                                                                    color: Black1,
                                                                                    // letterSpacing: .5,
                                                                                    fontSize: 16.sp,
                                                                                    fontWeight: FontWeight.w700),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          element?.discountPercentage != ""
                                                                              ? Container(
                                                                                  width: 60.w,
                                                                                  height: 20.h,
                                                                                  decoration: BoxDecoration(color: lightgreen, borderRadius: BorderRadius.all(Radius.circular(5.w))),
                                                                                  child: Center(
                                                                                    child: Text("${element?.discountPercentage} off",
                                                                                        // textAlign: TextAlign.center,
                                                                                        style: GoogleFonts.dmSans(
                                                                                          textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                                                        )),
                                                                                  ),
                                                                                )
                                                                              : Container(),
                                                                          // Container(
                                                                          //   padding: EdgeInsets
                                                                          //       .symmetric(
                                                                          //           vertical:
                                                                          //               0.91.w,
                                                                          //           horizontal:
                                                                          //               7.84.w),
                                                                          //   // width: 60.w,
                                                                          //   // height: 20.h,
                                                                          //   decoration: BoxDecoration(
                                                                          //       color: lightgreen
                                                                          //           .withOpacity(
                                                                          //               0.6),
                                                                          //       borderRadius:
                                                                          //           BorderRadius.all(
                                                                          //               Radius.circular(
                                                                          //                   5.w))),
                                                                          //   child: Center(
                                                                          //     child: Text("50% off",
                                                                          //         // textAlign: TextAlign.center,
                                                                          //         style: GoogleFonts
                                                                          //             .dmSans(
                                                                          //           textStyle: TextStyle(
                                                                          //               color: Colors.white,
                                                                          //               // letterSpacing:
                                                                          //               //     .5,
                                                                          //               fontSize: 12.sp,
                                                                          //               fontWeight: FontWeight.w500),
                                                                          //         )),
                                                                          //   ),
                                                                          // ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          5.w,
                                                                    ),
                                                                    Text(
                                                                        "${element?.weight}  ${element?.unit}",
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Grey,
                                                                              // letterSpacing: .5,
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w500),
                                                                        )),
                                                                    SizedBox(
                                                                      height:
                                                                          9.48.w,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                          right:
                                                                              5.w),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              element?.mrpPrice != "" ? Text('\u{20B9}${element?.mrpPrice}', style: GoogleFonts.dmSans(textStyle: element?.offerPrice != "" && element?.offerPrice != element?.mrpPrice ? TextStyle(decoration: TextDecoration.lineThrough, color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400) : TextStyle(color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400))) : Text(""),
                                                                              SizedBox(
                                                                                width: 10.w,
                                                                              ),
                                                                              element?.offerPrice != "" && element?.offerPrice != element?.mrpPrice
                                                                                  ? Text(
                                                                                      '\u{20B9}${element?.offerPrice}',
                                                                                      style: GoogleFonts.dmSans(
                                                                                        textStyle: TextStyle(
                                                                                            // decoration:
                                                                                            // TextDecoration.lineThrough,
                                                                                            color: Black,
                                                                                            letterSpacing: .5,
                                                                                            fontSize: 13.sp,
                                                                                            fontWeight: FontWeight.w500),
                                                                                      ),
                                                                                    )
                                                                                  : Container()
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  // readMain.showBottomNavigationBar();
                                                                                  if (watch.isQuanityBtnPressed) {
                                                                                    return;
                                                                                  }
                                                                                  read.subtractItemQuantity(context, element?.cartItemId.toString(), "subtract", index);
                                                                                },
                                                                                child: SvgPicture.asset(
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
                                                                                style: GoogleFonts.dmSans(
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
                                                                                  // readMain.showBottomNavigationBar();
                                                                                  print(watch.isQuanityBtnPressed);
                                                                                  if (watch.isQuanityBtnPressed) {
                                                                                    return;
                                                                                  }
                                                                                  read.addItemQuantity(context, element?.cartItemId.toString(), "add", element?.productType, index);
                                                                                },
                                                                                child: SvgPicture.asset(
                                                                                  'assets/images/add.svg',
                                                                                  // width: 30.w,
                                                                                  // height: 30.h,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.w,
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // index == 4
                                                    //     ? SizedBox(
                                                    //         height: 20.h,
                                                    //       )
                                                    //     : Container()
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                      SizedBox(
                                        height: 20.w,
                                      ),
                                    ],
                                  ))),
                          // SizedBox(
                          //   height: 40.h,
                          // ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.w, bottom: 6, right: 15.w, top: 6.w),
                            height: 30.h,
                            width: 390.w,
                            color: Button1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          // letterSpacing: .5,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700),
                                    )),
                                Text("${watch.itemCount}  Items",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          // letterSpacing: .5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.w,
                                top: 12.w,
                                right: 15.w,
                                bottom: 8.w),
                            height: 70.h,
                            width: 390.w,
                            color: SplashText,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("₹${watch.totalAmount}",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              // letterSpacing: .5,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700),
                                        )),
                                    SizedBox(
                                      height: 8.w,
                                    ),
                                    Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/check1.svg',
                                          height: 18.w,
                                          width: 18.w,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text("Saved ₹${watch.totalSavedAmount}",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  // letterSpacing: .5,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  child: PrimaryButton(
                                      color: Colors.white,
                                      height: 36.h,
                                      width: 160.w,
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 5.w),
                                                scrollable: true,
                                                title: Text("Conditions",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: Black,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )),
                                                content: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1.w,
                                                          top: 5.w,
                                                          right: 6.w),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "•",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    20.sp),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              // softWrap: true,
                                                              // maxLines: 3,//
                                                              "Regarding product delivery please contact to shop owner.",
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    color: Black1,
                                                                    height: 1.5,

                                                                    // letterSpacing: .05,
                                                                    // overflow: TextOverflow.ellipsis,
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w400),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1.w,
                                                          top: 5.w,
                                                          right: 6.w),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "•",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    20.sp),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              "You are directly transferring payment to shop owner, any issue related to payment transfer please contact to shop owner.",
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    color: Black1,
                                                                    height: 1.5,

                                                                    // letterSpacing: .05,
                                                                    // overflow: TextOverflow.ellipsis,
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
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                          child:
                                                              Text("Continue"),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            readMain.onNavigation(
                                                                2,
                                                                OrderSummaryView(
                                                                  route:
                                                                      "cartDetail",
                                                                  isRefresh:
                                                                      true,
                                                                  cartId: watch
                                                                      .orderCartId
                                                                      .toString(),
                                                                  shopId: watch
                                                                      .shopDetailData
                                                                      ?.id
                                                                      .toString(),
                                                                ),
                                                                context);
                                                            //
                                                            // readMain.hideBottomNavigationBar();

                                                            // Navigator.pop(context);
                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //       builder: (context) =>
                                                            //           OrderSummaryView(
                                                            //             route:
                                                            //                 "cartDetail",
                                                            //             isRefresh:
                                                            //                 true,
                                                            //             cartId: watch
                                                            //                 .orderCartId
                                                            //                 .toString(),
                                                            //             shopId: watch
                                                            //                 .shopDetailData
                                                            //                 ?.id
                                                            //                 .toString(),
                                                            //           )),
                                                            // );
                                                            // your code
                                                          }),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      text: 'Place Order',
                                      textColor: SplashText1,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ));
  }
}
