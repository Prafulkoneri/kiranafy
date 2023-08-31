import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/order_payment/controller/order_payment_controller.dart';
import 'package:local_supper_market/screen/customer/order_payment/view/check_status_and_home_view.dart';
import 'package:local_supper_market/screen/customer/order_status/view/order_status_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
import 'package:local_supper_market/screen/customer/order_summary/view/order_summary_view.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/stack_loader.dart';
import 'package:provider/provider.dart';

class OrderPaymentView extends StatefulWidget {
  final String? shopId;
  final String? cartId;
  final String? couponId;
  final String? customerDeliveryAddressId;
  final String? customerDeliveryDate;
  final String? customerDeliverySlot;
  final String? customerDeliveryType;
  final String? finalTotalAmount;
  final String? finalTotalDiscount;
  final String? totalItems;
  final String? finalSubTotal;
  final String? finalDeliveryCharges;

  const OrderPaymentView(
      {super.key,
      this.cartId,
      this.shopId,
      this.couponId,
      this.customerDeliveryAddressId,
      this.customerDeliveryDate,
      this.customerDeliverySlot,
      this.customerDeliveryType,
      this.finalTotalAmount,
      this.finalTotalDiscount,
      this.totalItems,
      this.finalSubTotal,
      this.finalDeliveryCharges});

  @override
  State<OrderPaymentView> createState() => _OrderPaymentViewState();
}

class _OrderPaymentViewState extends State<OrderPaymentView> {
  // String radioButtonItem = '';

  // Group Value for Radio Button.
  // int id = 1;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<OrderPaymentController>().initState(
          context,
          widget.cartId,
          widget.shopId,
          widget.couponId,
          widget.customerDeliveryAddressId,
          widget.customerDeliveryDate,
          widget.customerDeliverySlot,
          widget.customerDeliveryType,
          widget.finalTotalAmount,
          widget.finalTotalDiscount,
          widget.totalItems,
          widget.finalSubTotal,
          widget.finalDeliveryCharges);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<OrderPaymentController>();
    final read = context.read<OrderPaymentController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            onBackBtnPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrderSummaryView(
                        isRefresh: false, route: "paymentView")),
              );
            },
            title: "Order Payment",
            // action: SvgPicture.asset("assets/icons/forward.svg"),
            // onActionTap: () async {
            //   // await read.validateField(context);
            // },
          ),
        ),
        body: watch.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : StackLoader(
                showLoader: watch.isStackLoading,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 20.w,
                                  top: 20.w,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${watch.shopDetailData?.shopName}",
                                      // "New Balaji Trading Company",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/location2.svg',
                                          // width: 15.w,
                                          // height: 19.h,
                                        ),
                                        SizedBox(
                                          width: 9.w,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${watch.shopDetailData?.shopAddress}\n${watch.shopDetailData?.cityName} - ${watch.shopDetailData?.shopPincode}",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Black,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(thickness: 1, color: grey2),
                              SizedBox(
                                height: 14.h,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: 19.w, right: 19.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${watch.totalItems} Items",
                                      // "4 Items",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Text(
                                      "Total Amount",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            letterSpacing: .5,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: 19.w, right: 19.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "You will save \u{20B9} ${watch.finalTotalDiscount}",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: SplashText,
                                              letterSpacing: .5,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "\u{20B9} ${watch.finalTotalAmount}",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            letterSpacing: .5,
                                            fontSize: 21.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: 19.w, right: 19.w),
                                child: Text(
                                  "Mode of Payment",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 22.h,
                              ),
                              watch.shopDetailData?.acceptedPaymentStatus ==
                                      "cod_and_online"
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          left: 19.w, right: 19.w),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              SecondaryRadioButton(
                                                  value: "cash",
                                                  groupValue: watch.groupValue,
                                                  // groupValue: watch.radioGroupValue,
                                                  onChanged: (value) {
                                                    read.onRadioButtonSelected(
                                                        value);
                                                  },
                                                  leading: ""),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                'Cash on Delivery',
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: Black,
                                                      letterSpacing: .5,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 22.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SecondaryRadioButton(
                                                  value: "upi",
                                                  groupValue: watch.groupValue,
                                                  onChanged: (value) {
                                                    read.onRadioButtonSelected(
                                                        value);
                                                  },
                                                  leading: ""),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "UPI ID  - ${watch.shopDetailData?.shopOwnerUpiId}",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Black,
                                                        letterSpacing: .5,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              PrimaryButton(
                                                width: 58.w,
                                                height: 19.h,
                                                borderColor: SplashText,
                                                color: Colors.white,
                                                onTap: () {
                                                  read.copyCodeForCoupanList(
                                                      context,
                                                      watch.shopDetailData
                                                          ?.shopOwnerUpiId);
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Copy",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: SplashText,
                                                            // letterSpacing: .5,
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ), // <-- Text
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/images/svg2.svg',
                                                      width: 12.w,
                                                      height: 12.h,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 22.h,
                                          ),
                                          Row(
                                            children: [
                                              SecondaryRadioButton(
                                                  value: "qr_code",
                                                  groupValue: watch.groupValue,
                                                  onChanged: (value) {
                                                    read.onRadioButtonSelected(
                                                        value);
                                                  },
                                                  leading: ""),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                'Payment QR Code',
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: Black,
                                                      letterSpacing: .5,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : watch.shopDetailData
                                              ?.acceptedPaymentStatus ==
                                          "cod"
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              left: 19.w, right: 19.w),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: [
                                                  SecondaryRadioButton(
                                                      value: "cash",
                                                      groupValue:
                                                          watch.groupValue,
                                                      // groupValue: watch.radioGroupValue,
                                                      onChanged: (value) {
                                                        read.onRadioButtonSelected(
                                                            value);
                                                      },
                                                      leading: ""),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    'Cash on Delivery',
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: Black,
                                                          letterSpacing: .5,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : watch.shopDetailData
                                                  ?.acceptedPaymentStatus ==
                                              "online"
                                          ? Container(
                                              padding: EdgeInsets.only(
                                                  left: 19.w, right: 19.w),
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SecondaryRadioButton(
                                                          value: "upi",
                                                          groupValue:
                                                              watch.groupValue,
                                                          onChanged: (value) {
                                                            read.onRadioButtonSelected(
                                                                value);
                                                          },
                                                          leading: ""),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          "UPI ID  - ${watch.shopDetailData?.shopOwnerUpiId}",
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            textStyle: TextStyle(
                                                                color: Black,
                                                                letterSpacing:
                                                                    .5,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      PrimaryButton(
                                                        width: 58.w,
                                                        height: 19.h,
                                                        borderColor: SplashText,
                                                        color: Colors.white,
                                                        onTap: () {
                                                          read.copyCodeForCoupanList(
                                                              context,
                                                              watch
                                                                  .shopDetailData
                                                                  ?.shopOwnerUpiId);
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Copy",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle:
                                                                    TextStyle(
                                                                        color:
                                                                            SplashText,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 11
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                              ),
                                                            ), // <-- Text
                                                            SizedBox(
                                                              width: 5.w,
                                                            ),
                                                            SvgPicture.asset(
                                                              'assets/images/svg2.svg',
                                                              width: 12.w,
                                                              height: 12.h,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 22.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SecondaryRadioButton(
                                                          value: "qr_code",
                                                          groupValue:
                                                              watch.groupValue,
                                                          onChanged: (value) {
                                                            read.onRadioButtonSelected(
                                                                value);
                                                          },
                                                          leading: ""),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        'Payment QR Code',
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Black,
                                                              letterSpacing: .5,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.only(
                                                  left: 19.w, right: 19.w),
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      SecondaryRadioButton(
                                                          value: "cash",
                                                          groupValue:
                                                              watch.groupValue,
                                                          // groupValue: watch.radioGroupValue,
                                                          onChanged: (value) {
                                                            read.onRadioButtonSelected(
                                                                value);
                                                          },
                                                          leading: ""),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        'Cash on Delivery',
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Black,
                                                              letterSpacing: .5,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 22.h,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SecondaryRadioButton(
                                                          value: "upi",
                                                          groupValue:
                                                              watch.groupValue,
                                                          onChanged: (value) {
                                                            read.onRadioButtonSelected(
                                                                value);
                                                          },
                                                          leading: ""),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          "UPI ID  - ${watch.shopDetailData?.shopOwnerUpiId}",
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            textStyle: TextStyle(
                                                                color: Black,
                                                                letterSpacing:
                                                                    .5,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      PrimaryButton(
                                                        width: 58.w,
                                                        height: 19.h,
                                                        borderColor: SplashText,
                                                        color: Colors.white,
                                                        onTap: () {
                                                          read.copyCodeForCoupanList(
                                                              context,
                                                              watch
                                                                  .shopDetailData
                                                                  ?.shopOwnerUpiId);
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Copy",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle:
                                                                    TextStyle(
                                                                        color:
                                                                            SplashText,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 11
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                              ),
                                                            ), // <-- Text
                                                            SizedBox(
                                                              width: 5.w,
                                                            ),
                                                            SvgPicture.asset(
                                                              'assets/images/svg2.svg',
                                                              width: 12.w,
                                                              height: 12.h,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 22.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SecondaryRadioButton(
                                                          value: "qr_code",
                                                          groupValue:
                                                              watch.groupValue,
                                                          onChanged: (value) {
                                                            read.onRadioButtonSelected(
                                                                value);
                                                          },
                                                          leading: ""),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        'Payment QR Code',
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Black,
                                                              letterSpacing: .5,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                              // Row(
                              SizedBox(
                                height: 31.h,
                              ),
                              watch.shopDetailData?.acceptedPaymentStatus !=
                                      "cod"
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        watch.shopDetailData
                                                    ?.shopOwnerQrCodeImage ==
                                                ""
                                            ? Image.asset(
                                                "assets/images/shop_image.png",
                                                width: 165.w,
                                                height: 150.h,
                                                fit: BoxFit.cover,
                                              )
                                            : AppNetworkImages(
                                                width: 165.w,
                                                height: 150.h,
                                                fit: BoxFit.cover,
                                                imageUrl: watch.shopDetailData
                                                        ?.shopOwnerQrCodeImage ??
                                                    "",
                                              ),
                                        // AppNetworkImages(
                                        //   imageUrl:
                                        //       "${watch.shopDetailData?.shopOwnerQrCodeImage}",
                                        //   // "assets/images/qrcode.png",
                                        //   // height: 165.h,
                                        //   width: 165.w,
                                        // ),
                                      ],
                                    )
                                  : Container(),
                              SizedBox(
                                height: 19.h,
                              ),
                              Visibility(
                                visible:
                                    watch.groupValue == "cash" ? false : true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 19.w, right: 19.w),
                                      child: Text(
                                        'Payment Transaction ID ',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 19.w, right: 19.w),
                                      // height: 48.h,
                                      // width: 352.w,
                                      child: TextField(
                                        controller:
                                            watch.transactionIdController,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          // border: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(10.0),
                                          // ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              width: 2,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: grey6), //<-- SEE HERE
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 19.w, right: 19.w),
                                      child: Text(
                                        'Copy and paste your payment successful transaction details on above input box',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: grey8,
                                              letterSpacing: .5,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 18.h,
                              ),

                              // SizedBox(
                              //   height: 20.h,
                              // )
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 51.h,
                      width: ScreenUtil().screenWidth,
                      child: PrimaryButton(
                        borderRadius: 0,
                        width: ScreenUtil().screenWidth,
                        color: SplashText,
                        onTap: () async {
                          await read.placeOrder(context);
                        },
                        child: Text(
                          "Submit Order",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // letterSpacing: .5,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
