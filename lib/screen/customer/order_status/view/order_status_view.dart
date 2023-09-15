import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/screen/customer/delivery_view/view/order_view.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';

import 'package:local_supper_market/screen/customer/order_status/controller/track_order_status_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/const/color.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

class OrderStatusView extends StatefulWidget {
  final String? orderId;
  final String? screenName;
  OrderStatusView({super.key, this.orderId, required this.screenName});

  @override
  State<OrderStatusView> createState() => _OrderStatusViewState();
}

class _OrderStatusViewState extends State<OrderStatusView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<TrackOrderStatusController>()
          .initState(context, widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Random random = new Random();
    final watch = context.watch<TrackOrderStatusController>();
    final read = context.read<TrackOrderStatusController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          // onBackBtnPressed: () {
          //   // Navigator.pop(context);

          //   // Navigator.push(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //         builder: (context) => OrderStatusView(
          //   //               orderId: widget.orderId,
          //   //             )));
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => OrderDeliveryView(
          //               screenName: "myorderview",
          //               orderId: widget.orderId,
          //               isRefresh: true,
          //             )),
          //   );
          // },
          // isBackButtonEnabled: false,
          onBackBtnPressed: () {
            widget.screenName == "orderSummary"
                ? readMain.onNavigation(
                    0,
                    HomeScreenView(
                      refreshPage: true,
                    ),
                    context)

                // Navigator.pushAndRemoveUntil(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => MainScreenView(
                //                   index: 0,
                //                   screenName: HomeScreenView(
                //                     refreshPage: true,
                //                   ),
                //                 )),
                //         (Route<dynamic> route) => false,
                //       )
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderDeliveryView(
                              screenName: "myorderview",
                              orderId: widget.orderId,
                              isRefresh: true,
                            )),
                  );
          },
          title: "Order Status",
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : WillPopScope(
              onWillPop: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderDeliveryView(
                            screenName: "myorderview",
                            orderId: widget.orderId,
                            isRefresh: true,
                          )),
                );
                return true;
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreenView(
                                  index: 1,
                                  screenName: ShopProfileView(
                                    refreshPage: true,
                                    routeName: '',
                                    shopId: watch.shopDetails?.id.toString(),
                                  ))),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
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
                                            // "",
                                            "${watch.shopDetails?.shopAddress}\n${watch.shopDetails?.cityName} - ${watch.shopDetails?.shopPincode}",
                                            // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Black,
                                                  letterSpacing: .5,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                  Row(
                                    children: [
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     read.launchPhone(
                                      //         watch.shopDetails
                                      //                 ?.shopOwnerSupportNumber ??
                                      //             "",
                                      //         context);
                                      //   },
                                      //   child: SvgPicture.asset(
                                      //     'assets/images/call.svg',
                                      //     // width: 15.w,
                                      //     // height: 19.h,
                                      //   ),
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          // read.launchPhone(
                                          //     watch.shopDetails
                                          //             ?.shopOwnerSupportNumber ??
                                          //         "",
                                          //     context);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 13.w,
                                                right: 13.w,
                                                top: 14.w,
                                                bottom: 14.w),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff23AA49),
                                            ),
                                            child: SvgPicture.asset(
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
                                          decoration: const BoxDecoration(
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
                    ),
                    Divider(thickness: 1, color: grey2),
                    SizedBox(
                      height: 20.h,
                    ),
                    watch.trackOrderDetails?.deliveryType != "self_pickup"
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 20.w,
                                ),
                                child: Text(
                                  "Delivery Address",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        // letterSpacing: .5,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: 19.w, right: 19.w),
                                // height: 156.h,
                                width: double.infinity,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    // side: BorderSide(color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: 20.w,
                                        left: 20.w,
                                        right: 15.w,
                                        top: 20.w),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/person.svg',
                                                  width: 11.w,
                                                  height: 15.h,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(
                                                  // "",
                                                  "${watch.deliveryAddressDetails?.customerName}",
                                                  // 'Rachel Green',
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Black,
                                                        letterSpacing: .5,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   width: 11.w,
                                                // ),
                                              ],
                                            ),
                                            SizedBox(
                                              // height: 21.h,/
                                              // width: 71.w,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0),
                                                  // backgroundColor: ,
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                        color: lighrgreen,
                                                        // width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  "${watch.deliveryAddressDetails?.deliveryAddressType}",
                                                  // "${element.deliveryAddressType}",
                                                  // "Home",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: SplashText1,
                                                        // letterSpacing: .5,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),

                                                //
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/phone.svg',
                                              width: 14.w,
                                              height: 15.h,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              "${watch.deliveryAddressDetails?.mobileNo}",
                                              // '${element.mobileNo}',
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black,
                                                    letterSpacing: .5,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.w,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/location.svg',
                                              color: SplashText1,
                                              width: 17.w,
                                              height: 17.h,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${watch.deliveryAddressDetails?.address1}\n${watch.deliveryAddressDetails?.address2}",
                                                maxLines: 3,
                                                // "${element.address1} \n${element.address2} ",
                                                // "Nand Nivas Building floor 3 B-3,Lane No.13 Bhatrau Nivas Vishrantwadi Pune -411015.",
                                                // textAlign: TextAlign.start,
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      // height: 1.5,
                                                      color: black,
                                                      // letterSpacing: .05,
                                                      // overflow: TextOverflow.ellipsis,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Container(
                      padding:
                          EdgeInsets.only(left: 19.w, top: 20.w, bottom: 30.w),
                      child: Text(
                        // maxLines: 3,
                        "Order Status",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black1,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 11.w),
                          height: 21.w,
                          width: 21.w,
                          decoration: BoxDecoration(
                              color: Color(0xff39C19D), shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Text(
                          "Order Placed",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Black1,
                              fontSize: 14.sp),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 21.w),
                          height: 78.w,
                          width: 1.w,
                          color: Color(0xffC4C4C4),
                        ),
                        SizedBox(
                          width: 28.5.w,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "We have received your order.",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "${watch.trackOrderDetails?.orderPlacedDateAndTime}",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 11.w),
                          height: 21.w,
                          width: 21.w,
                          decoration: BoxDecoration(
                              color: watch.trackOrderDetails?.orderStatus !=
                                      "order_placed"
                                  ? Color(0xff39C19D)
                                  : Color(0xffC4C4C4),
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Text(
                          "Order Confirmation",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Black1,
                              fontSize: 14.sp),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 21.w),
                          height: 75.w,
                          width: 1.w,
                          color: Color(0xffC4C4C4),
                        ),
                        SizedBox(
                          width: 28.5.w,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "Your order is confirmed.",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "${watch.trackOrderDetails?.orderConfirmedDateAndTime}",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 11.w),
                          height: 21.w,
                          width: 21.w,
                          decoration: BoxDecoration(
                              color: watch.trackOrderDetails?.orderStatus ==
                                          "order_placed" ||
                                      watch.trackOrderDetails?.orderStatus ==
                                          "order_confirmed"
                                  ? Color(0xffC4C4C4)
                                  : Color(0xff39C19D),
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Text(
                          "Order Packaging",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Black1,
                              fontSize: 14.sp),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 21.w),
                          height: 78.w,
                          width: 1.w,
                          color: Color(0xffC4C4C4),
                        ),
                        SizedBox(
                          width: 28.5.w,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "Your order is been packed",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "${watch.trackOrderDetails?.orderPackingDateAndTime}",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 11.w),
                          height: 21.w,
                          width: 21.w,
                          decoration: BoxDecoration(
                              color: watch.trackOrderDetails?.orderStatus ==
                                      "order_dispatched"
                                  ? Color(0xff39C19D)
                                  : watch.trackOrderDetails?.orderStatus ==
                                          "order_delivered"
                                      ? Color(0xff39C19D)
                                      : Color(0xffC4C4C4),
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Text(
                          "Dispatched",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Black1,
                              fontSize: 14.sp),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 21.w),
                          height: 78.w,
                          width: 1.w,
                          color: Color(0xffC4C4C4),
                        ),
                        SizedBox(
                          width: 28.5.w,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "Your order has been dispatched.",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "${watch.trackOrderDetails?.orderDispatchedDateAndTime}",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 11.w),
                          height: 21.w,
                          width: 21.w,
                          decoration: BoxDecoration(
                              color: watch.trackOrderDetails?.orderStatus ==
                                      "order_delivered"
                                  ? Color(0xff39C19D)
                                  : Color(0xffC4C4C4),
                              shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                        Text(
                          "Delivered",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Black1,
                              fontSize: 14.sp),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 48.5.w,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "We have delivered your package successfully.",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 6.w,
                            ),
                            Text(
                              "${watch.trackOrderDetails?.orderDeliveredDateAndTime}",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                      ],
                    ),
                    SizedBox(height: 80.h)
                  ],
                ),
              ),
            ),
    );
  }
}
