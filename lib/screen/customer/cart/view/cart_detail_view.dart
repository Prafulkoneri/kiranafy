import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/cart/controller/cart_detail_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:provider/provider.dart';

class CartDetailView extends StatefulWidget {
  final String? shopId;
  final String? cartId;
  const CartDetailView({super.key, this.cartId, this.shopId});

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
          .initState(context, widget.cartId, widget.shopId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CartDetailController>();
    final read = context.read<CartDetailController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            title: "Cart Details",
            action: SvgPicture.asset("assets/images/delete.svg"),
            onActionTap: () {
              read.deleteCartDetails(context, widget.cartId);
            },
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 17.w, top: 20.w),
                child: Text(
                  "${watch.shopDetailData?.shopName}",
                  // "New Balaji Trading Company",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black1,
                        letterSpacing: .5,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
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
                            "${watch.shopDetailData?.shopAddress}\n${watch.shopDetailData?.cityName} - ${watch.shopDetailData?.shopPincode}",
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
                                watch.shopDetailData?.shopOwnerSupportNumber ??
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
                                    context, watch.shopDetailData?.id)
                                : read.updateAllShopFavList(
                                    context, watch.shopDetailData?.id);
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
              // Divider(thickness: 1, color: grey2),
              Container(
                // height: 360.h,
                // width: 352.w,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: watch.cartDetailData?.cartItemList?.length ?? 0,
                    itemBuilder: (BuildContext, index) {
                      final element =
                          watch.cartDetailData?.cartItemList?[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductScreenView()));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 18.w,
                                  top: index == 0 ? 14.w : 24.w,
                                  right: 17.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.07),
                                      width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 5,
                                        offset: Offset(-.0, 5.0),
                                        spreadRadius: 0),
                                  ],
                                ),
                                // height: 95.h,
                                // width: 355.w,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: Image.asset(
                                        'assets/images/sprite.png',
                                        width: 39.w,
                                        height: 92.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Container(
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                          //                   <--- right side
                                          color: Color(0xffE0E0E0),
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
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 5.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${element?.productImagePath}",
                                                  // "Ariel Washing Powder",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Black1,
                                                        // letterSpacing: .5,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0.91.w,
                                                      horizontal: 7.84.w),
                                                  // width: 60.w,
                                                  // height: 20.h,
                                                  decoration: BoxDecoration(
                                                      color: lightgreen
                                                          .withOpacity(0.6),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.w))),
                                                  child: Center(
                                                    child: Text("50% off",
                                                        // textAlign: TextAlign.center,
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              // letterSpacing:
                                                              //     .5,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.w,
                                          ),
                                          Text("${element?.weight}",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Grey,
                                                    // letterSpacing: .5,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          SizedBox(
                                            height: 9.48.w,
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 5.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //       top: 12.w),
                                                //   child:
                                                Row(
                                                  // crossAxisAlignment:
                                                  //     CrossAxisAlignment.start,
                                                  // mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '\u{20B9}${25.00}',
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Black,
                                                            // letterSpacing:
                                                            //     .5,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(
                                                      '\u{20B9}${25.00}',
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            // decoration:
                                                            // TextDecoration.lineThrough,
                                                            color: Black,
                                                            // letterSpacing:
                                                            //     .5,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                  // ),
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/minus.svg',
                                                      // width: 30.w,
                                                      // height: 30.h,
                                                    ),
                                                    SizedBox(
                                                      width: 12.w,
                                                    ),
                                                    Text(
                                                      "1",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            // decoration:
                                                            // TextDecoration.lineThrough,
                                                            color: Black,
                                                            // letterSpacing:
                                                            //     .5,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12.w,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/images/add.svg',
                                                      // width: 30.w,
                                                      // height: 30.h,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                // decoration: BoxDecoration(
                                //   // color: Colors.blueAccent,
                                //   border: Border.all(width: 1, color: grey1),
                                // ),
                                // decoration: BoxDecoration(color: Black),
                              ),
                            ),
                            index == 4
                                ? SizedBox(
                                    height: 20.h,
                                  )
                                : Container()
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ))),
          // SizedBox(
          //   height: 40.h,
          // ),
          Container(
            padding:
                EdgeInsets.only(left: 20.w, bottom: 6, right: 15.w, top: 6.w),
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
                Text("4 Items",
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
                left: 20.w, top: 12.w, right: 15.w, bottom: 8.w),
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
                    Text("₹132.00",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/check1.svg',
                          height: 18.w,
                          width: 18.w,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text("saved ₹132.00",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: .5,
                                  fontSize: 16.sp,
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
                                scrollable: true,
                                title: Text("Conditions",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700),
                                    )),
                                content: Column(
                                  children: <Widget>[
                                    // Padding(
                                    //   padding: EdgeInsets.only(left: 6.w),
                                    //   child: Row(
                                    //     // crossAxisAlignment: CrossAxisAlignment.start,
                                    //     children: [
                                    //       Padding(
                                    //           padding:
                                    //               EdgeInsets.only(bottom: 35.w),
                                    //           child: Icon(
                                    //             Icons.circle_rounded,
                                    //             size: 5.w,
                                    //           )),
                                    //       SizedBox(
                                    //         width: 10,
                                    //       ),
                                    //       Flexible(
                                    //         child: Text(
                                    //           // softWrap: true,
                                    //           // maxLines: 3,//
                                    //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sit nunc, netus ac vulputate sed",
                                    //           textAlign: TextAlign.justify,
                                    //           style: GoogleFonts.dmSans(
                                    //             textStyle: TextStyle(
                                    //                 color: Black1,
                                    //                 height: 1.5,

                                    //                 // letterSpacing: .05,
                                    //                 // overflow: TextOverflow.ellipsis,
                                    //                 fontSize: 14.sp,
                                    //                 fontWeight:
                                    //                     FontWeight.w400),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 6.w, top: 5.w),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 18.w),
                                              child: Icon(
                                                Icons.circle_rounded,
                                                size: 5.w,
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              // softWrap: true,
                                              // maxLines: 3,//
                                              "Regarding product delivery please contact to shop owner.",
                                              textAlign: TextAlign.justify,
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black1,
                                                    height: 1.5,

                                                    // letterSpacing: .05,
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 6.w, top: 5.w),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 35.w),
                                              child: Icon(
                                                Icons.circle_rounded,
                                                size: 5.w,
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Text(
                                              // softWrap: true,
                                              // maxLines: 3,//

                                              "You are directly transferring payment to shop owner, any issue related to payment transfer please contact to shop owner.",
                                              textAlign: TextAlign.justify,
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black1,
                                                    height: 1.5,

                                                    // letterSpacing: .05,
                                                    // overflow: TextOverflow.ellipsis,
                                                    fontSize: 14.sp,
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
                                actions: [
                                  ElevatedButton(
                                      child: Text("Submit"),
                                      onPressed: () {
                                        // your code
                                      })
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
          )
        ]));
  }
}
