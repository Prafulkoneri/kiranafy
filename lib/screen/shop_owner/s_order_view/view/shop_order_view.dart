import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/order_summary/order_products.dart';
import 'package:local_supper_market/screen/shop_owner/payment_refund/view/payment_refund_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_order_status_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/controller/shop_owner_order_view_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/view/cancel_reason_bottom_sheet_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/view/delivery_code_bottom_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/view/shop_order_products.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/stack_loader.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ShopOrderView extends StatefulWidget {
  final String? orderId;
  final int? selectedIndex;
  final bool? fromOrderStatus;

  const ShopOrderView({
    super.key,
    this.orderId,
    required this.selectedIndex,
    required this.fromOrderStatus,
  });

  @override
  State<ShopOrderView> createState() => _ShopOrderViewState();
}

class _ShopOrderViewState extends State<ShopOrderView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ShopOwnerOrderViewController>().initState(
            context,
            widget.orderId.toString(),
          );
    });
    print("gudiyaaaaa");
    print(widget.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopOwnerOrderViewController>();
    final watch = context.watch<ShopOwnerOrderViewController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
          
            widget.fromOrderStatus == true
                ? Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SMainScreenView(
                            index: 1,
                            screenName: SOrderStatusView(
                                selectedIndex: widget.selectedIndex))),
                    (Route<dynamic> route) => false,
                  )
                : Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SMainScreenView(
                            index: 2,
                            screenName: SPaymentRefundList(
                              isNavFromAccounts: false,
                            ))),
                    (Route<dynamic> route) => false,
                  );
          },
          title: "Order",
          onActionTap: () {},
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 19.w, right: 17.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Order ID: ${watch.orderDetails?.orderUniqueId}",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            watch.orderDetails?.orderStatus == "Pending"
                                ? SizedBox(
                                    height: 22.h,
                                    // width: 85.w,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        // backgroundColor: ,
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: Color(0xffE4C400),
                                              // width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // context.loaderOverlay.hide();
                                      },
                                      child: Text(
                                        "${watch.orderDetails?.orderStatus}",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Color(0xffE4C400),
                                              // letterSpacing: .5,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),

                                      //
                                    ),
                                  )
                                : watch.orderDetails?.orderStatus == "Confirmed"
                                    ? SizedBox(
                                        height: 22.h,
                                        // width: 90.w,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(0),
                                            // backgroundColor: ,
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                  color: Color(0xff39C19D),
                                                  // width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "${watch.orderDetails?.orderStatus}",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Color(0xff39C19D),
                                                  // letterSpacing: .5,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),

                                          //
                                        ),
                                      )
                                    : watch.orderDetails?.orderStatus ==
                                            "Packing"
                                        ? SizedBox(
                                            height: 22.h,
                                            // width: 85.w,
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
                                                      color: Color(0xff39C19D),
                                                      // width: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: Text(
                                                "${watch.orderDetails?.orderStatus}",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: Color(0xff39C19D),
                                                      // letterSpacing: .5,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),

                                              //
                                            ),
                                          )
                                        : watch.orderDetails?.orderStatus ==
                                                "Delivered"
                                            ? SizedBox(
                                                height: 22.h,
                                                // width: 85.w,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all(0),
                                                    // backgroundColor: ,
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        side: BorderSide(
                                                          color:
                                                              Color(0xff39C19D),
                                                          // width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    "${watch.orderDetails?.orderStatus}",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color:
                                                              Color(0xff39C19D),
                                                          // letterSpacing: .5,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),

                                                  //
                                                ),
                                              )
                                            : watch.orderDetails?.orderStatus ==
                                                    "Cancelled"
                                                ? SizedBox(
                                                    height: 22.h,
                                                    // width: 85.w,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        elevation:
                                                            MaterialStateProperty
                                                                .all(0),
                                                        // backgroundColor: ,
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .white),
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            side: BorderSide(
                                                              // color: Color(
                                                              //     0xff39C19D),
                                                              // width: 1,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {},
                                                      child: Text(
                                                        "${watch.orderDetails?.orderStatus}",
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Colors.red,
                                                              //  Color(
                                                              //     0xff39C19D),
                                                              // letterSpacing: .5,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      //
                                                    ),
                                                  )
                                                : watch.orderDetails
                                                            ?.orderStatus ==
                                                        "Pending"
                                                    ? SizedBox(
                                                        height: 22.h,
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            elevation:
                                                                MaterialStateProperty
                                                                    .all(0),
                                                            // backgroundColor: ,
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .white),
                                                            shape:
                                                                MaterialStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                side:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xff39C19D),
                                                                  // width: 1,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {},
                                                          child: Text(
                                                            "${watch.orderDetails?.orderStatus}",
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle:
                                                                  TextStyle(
                                                                      color: Color(
                                                                          0xff39C19D),
                                                                      // letterSpacing: .5,
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            ),
                                                          ),

                                                          //
                                                        ),
                                                      )
                                                    : watch.orderDetails
                                                                ?.orderStatus ==
                                                            "Dispatched"
                                                        ? SizedBox(
                                                            height: 22.h,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all(0),
                                                                // backgroundColor: ,
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .white),
                                                                shape:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    side:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0xff39C19D),
                                                                      // width: 1,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              onPressed: () {},
                                                              child: Text(
                                                                "${watch.orderDetails?.orderStatus}",
                                                                style:
                                                                    GoogleFonts
                                                                        .dmSans(
                                                                  textStyle: TextStyle(
                                                                      color: Color(0xff39C19D),
                                                                      // letterSpacing: .5,
                                                                      fontSize: 12.sp,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ),

                                                              //
                                                            ),
                                                          )
                                                        : watch.orderDetails
                                                                    ?.orderStatus ==
                                                                "Order Refund"
                                                            ? SizedBox(
                                                                height: 22.h,
                                                                // width: 85.w,
                                                                child:
                                                                    ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                    elevation:
                                                                        MaterialStateProperty
                                                                            .all(0),
                                                                    // backgroundColor: ,
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            Colors.white),
                                                                    shape:
                                                                        MaterialStateProperty
                                                                            .all(
                                                                      RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        side:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0xff39C19D),
                                                                          // width: 1,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    "${watch.orderDetails?.orderStatus}",
                                                                    style: GoogleFonts
                                                                        .dmSans(
                                                                      textStyle: TextStyle(
                                                                          color: Color(0xff39C19D),
                                                                          // letterSpacing: .5,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                  ),

                                                                  //
                                                                ),
                                                              )
                                                            : Container(),
                          ],
                        ),
                        Text(
                          "${watch.orderDetails?.createdAt}",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Black,
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  watch.orderDetails?.deliveryType == "delivery_to"
                      ? SizedBox(
                          height: 23.h,
                        )
                      : Container(),
                  watch.orderDetails?.deliveryType == "delivery_to"
                      ? Container(
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
                        )
                      : Container(),
                  SizedBox(
                    height: 10.h,
                  ),
                  watch.orderDetails?.deliveryType == "delivery_to"
                      ? Container(
                          margin: EdgeInsets.only(left: 19.w, right: 19.w),
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
                                                  fontWeight: FontWeight.w700),
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
                                                MaterialStateProperty.all(0),
                                            // backgroundColor: ,
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                  fontWeight: FontWeight.w700),
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
                                              fontWeight: FontWeight.w400),
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
                                          "${watch.deliveryAddressDetails?.address1}\n${watch.deliveryAddressDetails?.address2}  ",
                                          //

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
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(left: 19.w, right: 19.w),
                          child: Row(
                            children: [
                              Flexible(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Note: ",
                                      style: TextStyle(
                                          color: Black,
                                          fontSize: 12.sp,
                                          // height: 1.3.w,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                          children: [],
                                          text:
                                              'This is a Self- Pickup Order, the customer will collect the ordered products from your shop.',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                          style: TextStyle(
                                              color: Colors.blue,
                                              // letterSpacing: .5,
                                              height: 1.5.w,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                  //  Container(
                  //     child: Text(
                  //       maxLines: 2,
                  //       "This is a Self- Pickup Order, the customer will collect the ordered products from your shop.",
                  //       textAlign: TextAlign.center,
                  //       style: GoogleFonts.dmSans(
                  //         textStyle: TextStyle(
                  //             color: Colors.black,
                  //             // letterSpacing: .5,
                  //             fontSize: 18.sp,
                  //             fontWeight: FontWeight.w500),
                  //       ),
                  //     ),
                  //   ),
                  SizedBox(
                    height: 20.h,
                  ),
                  watch.orderDetails?.orderStatus == "Cancelled"
                      ? Container()
                      : watch.orderDetails?.orderStatus != "Delivered"
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    watch.orderDetails?.orderStatus == "Pending"
                                        ? Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                read.shopOrderStatus(
                                                    context,
                                                    watch.orderDetails?.id
                                                        .toString(),
                                                    "order_confirmed",
                                                    "",
                                                    "",
                                                    "");
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 20.w,
                                                    top: 9.w,
                                                    bottom: 7.w,
                                                    right: 34.w),
                                                decoration: BoxDecoration(
                                                    color: SplashText,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/confirm_shop.svg',
                                                    ),
                                                    Text(
                                                      "Confirm",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            // letterSpacing: .5,
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ) ///////////////////////////////////////////Confirmed//////////////
                                        : watch.orderDetails?.orderStatus ==
                                                "Confirmed"
                                            ? Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    read.shopOrderStatus(
                                                        context,
                                                        watch.orderDetails?.id
                                                            .toString(),
                                                        "order_packing",
                                                        "",
                                                        "",
                                                        "");
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20.w,
                                                        top: 2.w,
                                                        bottom: 2.w,
                                                        right: 18.w),
                                                    decoration: BoxDecoration(
                                                        color: SplashText,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/icons/confirm_shop.svg',
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              "In Process",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle:
                                                                    TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 18
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                              ),
                                                            ),
                                                            Text(
                                                              "Move to Packing",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle:
                                                                    TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 10
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                ////////////////////////////
                                              )
                                            : watch.orderDetails?.orderStatus ==
                                                    "Packing"
                                                ? Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        read.shopOrderStatus(
                                                            context,
                                                            watch.orderDetails
                                                                ?.id
                                                                .toString(),
                                                            "order_dispatched",
                                                            "",
                                                            "",
                                                            "");
                                                      },
                                                      child: Container(
                                                        // margin: EdgeInsets.only(
                                                        //     left: 19.w, right: 20.w),
                                                        padding:
                                                            EdgeInsets.only(
                                                          // left: 20.w,
                                                          top: 9.w,
                                                          bottom: 7.w,
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: SplashText,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/icons/confirm_shop.svg',
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Text(
                                                              "Order Ready for Dispatch",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle:
                                                                    TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 18
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : watch.orderDetails
                                                            ?.orderStatus ==
                                                        "Dispatched"
                                                    ? Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            // read.shopOrderStatus(
                                                            //     context,
                                                            //     watch.orderDetails
                                                            //         ?.id
                                                            //         .toString(),
                                                            //     "order_delivered",
                                                            //     "",
                                                            //     "");
                                                            showModalBottomSheet(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              isScrollControlled:
                                                                  true,
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              30),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              30))),
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return OrderDeliveryCodeView();
                                                              },
                                                            );
                                                          },
                                                          child: Container(
                                                            // margin: EdgeInsets.only(
                                                            //     left: 19.w, right: 20.w),
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 9.w,
                                                              bottom: 7.w,
                                                            ),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    SplashText,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/icons/confirm_shop.svg',
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                Text(
                                                                  "Order Delivered To Customer",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      GoogleFonts
                                                                          .dmSans(
                                                                    textStyle: TextStyle(
                                                                        color: Colors.white,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 18.sp,
                                                                        fontWeight: FontWeight.w500),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                    // watch.orderDetails?.orderStatus ==
                                    //     "Packing"||
                                    //     watch.orderDetails?.orderStatus ==
                                    //         "Dispatched"?Container():
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Visibility(
                                      visible: watch.orderDetails
                                                      ?.orderStatus ==
                                                  "Packing" ||
                                              watch.orderDetails?.orderStatus ==
                                                  "Dispatched" ||
                                              watch.orderDetails?.orderStatus ==
                                                  "Cancelled" ||
                                              watch.orderDetails?.orderStatus ==
                                                  "Order Refund"
                                          ? false
                                          : true,
                                      child: Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            // read.shopOrderStatus(
                                            //     context,
                                            //     watch.orderDetails?.id.toString(),
                                            //     "order_cancelled",
                                            //     "",
                                            //     "");
                                            showModalBottomSheet(
                                              backgroundColor: Colors.white,
                                              isScrollControlled: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(30),
                                                              topRight:
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                              context: context,
                                              builder: (context) {
                                                return cancelOrderFiltterView();
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 20.w,
                                                top: 9.w,
                                                bottom: 9.w,
                                                right: 34.w),
                                            decoration: BoxDecoration(
                                                color: Color(0xffEC7074),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/cancel_shop.svg',
                                                ),
                                                Text(
                                                  "Cancel",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        // letterSpacing: .5,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 9.h,
                                ),
                                watch.orderDetails?.orderStatus == "Pending"
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            left: 19.w, right: 19.w),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: RichText(
                                                text: TextSpan(
                                                    text: "Note: ",
                                                    style: TextStyle(
                                                        color: Black,
                                                        fontSize: 12.sp,
                                                        // height: 1.3.w,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    children: [
                                                      TextSpan(
                                                        children: [],
                                                        text:
                                                            'Before confirming order, please check if all products are available in stock.\nIncase if any product is unavailable, please uncheck below',
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {},
                                                        style: TextStyle(
                                                            color: Black,
                                                            // letterSpacing: .5,
                                                            height: 1.5.w,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 19.w, right: 61.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // maxLines: 3,
                                        "Expected Delivery Date :",
                                        // textAlign: TextAlign.start,
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              // height: 1.5,
                                              color: Color(0xff000000),
                                              // letterSpacing: .05,
                                              // overflow: TextOverflow.ellipsis,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Text(
                                        // maxLines: 3,
                                        "Delivery Slot ",
                                        // textAlign: TextAlign.start,
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              // height: 1.5,
                                              color: Color(0xff000000),
                                              // letterSpacing: .05,
                                              // overflow: TextOverflow.ellipsis,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 19.w, right: 18.w),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,/
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          // maxLines: 3,
                                          "${watch.orderDetails?.deliveryDate}",
                                          // textAlign: TextAlign.start,
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                // height: 1.5,
                                                color: SplashText,
                                                // letterSpacing: .05,
                                                // overflow: TextOverflow.ellipsis,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // maxLines: 3,
                                        watch.orderDetails?.deliverySlot ==
                                                "shop_owner_slot_9_to_12"
                                            ? "09:00 AM - 12:00 PM"
                                            : watch.orderDetails
                                                        ?.deliverySlot ==
                                                    "shop_owner_slot_12_to_3"
                                                ? "12:00 PM - 03:00 PM"
                                                : watch.orderDetails
                                                            ?.deliverySlot ==
                                                        "shop_owner_slot_3_to_6"
                                                    ? "03:00 PM - 06:00 PM"
                                                    : watch.orderDetails
                                                                ?.deliverySlot ==
                                                            "shop_owner_slot_6_to_9"
                                                        ? "06:00 PM - 09:00 PM"
                                                        : "",
                                        // textAlign: TextAlign.start,
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              // height: 1.5,
                                              color: SplashText,
                                              // letterSpacing: .05,
                                              // overflow: TextOverflow.ellipsis,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          /////////////
                          : Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 19.w, right: 61.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // maxLines: 3,
                                        "Delivered On :",
                                        // textAlign: TextAlign.start,
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              // height: 1.5,
                                              color: Color(0xff000000),
                                              // letterSpacing: .05,
                                              // overflow: TextOverflow.ellipsis,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Text(
                                        // maxLines: 3,
                                        "Delivery Time ",
                                        // textAlign: TextAlign.start,
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              // height: 1.5,
                                              color: Color(0xff000000),
                                              // letterSpacing: .05,
                                              // overflow: TextOverflow.ellipsis,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 19.w, right: 25.w),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,/
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          // maxLines: 3,
                                          "${watch.orderDetails?.deliveryDate}",
                                          // textAlign: TextAlign.start,
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                // height: 1.5,
                                                color: SplashText,
                                                // letterSpacing: .05,
                                                // overflow: TextOverflow.ellipsis,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // maxLines: 3,
                                        watch.orderDetails?.deliverySlot ==
                                                "shop_owner_slot_9_to_12"
                                            ? "09:00 AM - 12:00 PM"
                                            : watch.orderDetails
                                                        ?.deliverySlot ==
                                                    "shop_owner_slot_12_to_3"
                                                ? "12:00 PM - 03:00 PM"
                                                : watch.orderDetails
                                                            ?.deliverySlot ==
                                                        "shop_owner_slot_3_to_6"
                                                    ? "03:00 PM - 06:00 PM"
                                                    : watch.orderDetails
                                                                ?.deliverySlot ==
                                                            "shop_owner_slot_6_to_9"
                                                        ? "06:00 PM - 09:00 PM"
                                                        : "",
                                        // textAlign: TextAlign.start,
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              // height: 1.5,
                                              color: SplashText,
                                              // letterSpacing: .05,
                                              // overflow: TextOverflow.ellipsis,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                  //////////////
                  Container(
                    padding:
                        EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Details",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Divider(
                          // height: 100,
                          color: grey2,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),
                        ShopOrderProducts(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub Total",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              "Rs ${watch.subTotal}",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: grey5,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Divider(
                          // height: 100,
                          color: grey2,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Discount',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                watch.couponDetails?.couponCode != "" &&
                                        watch.couponDetails?.couponCode != null
                                    ? TextSpan(
                                        text:
                                            '  (${watch.couponDetails?.couponCode}) ',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: SplashText,
                                              // letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    : TextSpan(
                                        text: "",
                                      ),
                              ]),
                            ),
                            watch.couponDetails?.couponDiscount != null
                                ? Text(
                                    " - Rs. ${watch.couponDetails?.couponDiscount}",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: grey5,
                                          // letterSpacing: .5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                : Text(
                                    "- Rs. 0",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: grey5,
                                          // letterSpacing: .5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Charges",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              watch.orderDetails?.deliveryCharges == ""
                                  ? "Rs. 0"
                                  : "Rs.  ${watch.deliveryCharges}",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: grey5,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Divider(
                          // height: 100,
                          color: grey2,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    // letterSpacing: .5,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              "Rs. ${watch.totalAmount} ",
                              // ${watch.orderFinalTotals?.total}",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    // letterSpacing: .5,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Divider(
                          // height: 100,
                          color: grey2,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Container(
                          child: Text(
                            "You will save Rs. ${watch.totalDiscount}",
                            //  ",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: SplashText,
                                  // letterSpacing: .5,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //////////////////
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 19.w,
                    ),
                    child: Text(
                      "Mode of Payment",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            // letterSpacing: .5,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 19.w, right: 19.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${watch.orderDetails?.paymentMode}",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: SplashText,
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        watch.orderDetails?.orderStatus == "Delivered"
                            ? GestureDetector(
                                onTap: () {
                                  read.orderInvoice(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 20.w,
                                      right: 20.w,
                                      top: 2.w,
                                      bottom: 2.w),
                                  decoration: BoxDecoration(
                                    color: Color(0xff39C19D).withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(0xff39C19D),
                                      style: BorderStyle.solid,
                                    ),
                                  ),

                                  // color: Color(0xff39C19D).withOpacity(0.3),
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(color: Color(0xff39C19D))),
                                  child: Text(
                                    "Invoice",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Black,
                                          // letterSpacing: .5,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),

                  watch.orderDetails?.transactionId != ""
                      ? SizedBox(
                          height: 15.h,
                        )
                      : Container(),
                  watch.orderDetails?.transactionId != ""
                      ? Container(
                          padding: EdgeInsets.only(
                            left: 19.w,
                          ),
                          child: Text(
                            "Transaction ID : ${watch.orderDetails?.transactionId}",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black,
                                  // letterSpacing: .5,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 28.h,
                  ),
                  watch.orderDetails?.orderStatus == "Order Refund"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 19.w),
                                child: Text(
                                  "Customer has sent ${watch.orderDetails?.refundProductCount} products return request. Refund amount is INR ${watch.orderDetails?.customerRefundAmount}.",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffE80000)),
                                )),
                            SizedBox(
                              height: 5.h,
                            ),
                            watch.orderDetails?.shopOwnerRefundStatus ==
                                        "pending" &&
                                    watch.acceptPayment == false &&
                                    watch.rejectPayment == false
                                ? Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 15.w),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 19.w,
                                        ),
                                        Expanded(
                                            child: PrimaryButton(
                                          color: Color(0xff39C19D),
                                          onTap: () {
                                            read.onRefundAccept();
                                            // read.updateRefundStatus("received", context);
                                          },
                                          leading: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: SvgPicture.asset(
                                                      "assets/icons/confirm_shop.svg")),
                                              SizedBox(width: 10.w),
                                              Text(
                                                "Accept",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp),
                                              )
                                            ],
                                          ),
                                        )),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                            child: PrimaryButton(
                                          color: Color(0xffFF6258),
                                          onTap: () {
                                            read.onRefundReject();
                                            // read.updateRefundStatus("not_received", context);
                                          },
                                          leading: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: SvgPicture.asset(
                                                      "assets/icons/cross.svg")),
                                              SizedBox(width: 10.w),
                                              Text(
                                                "Reject",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp),
                                              )
                                            ],
                                          ),
                                        )),
                                        SizedBox(
                                          width: 19.w,
                                        ),
                                      ],
                                    ),
                                  )
                                : watch.orderDetails?.shopOwnerRefundStatus ==
                                            "pending" &&
                                        watch.acceptPayment == true
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 17.w),
                                        color: Color(0xffEFFDFF),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 15.w,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Refund Amount",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black,
                                                          fontSize: 18.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 11.w,
                                                    ),
                                                    Text(
                                                      "INR ${watch.orderDetails?.customerRefundAmount}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black,
                                                          fontSize: 18.sp),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 22.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.w),
                                                      border: Border.all(
                                                          color: Color(
                                                              0xff115B7A))),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.w),
                                                  child: Center(
                                                      child: Text(
                                                    watch.orderDetails
                                                                    ?.shopOwnerRefundStatus ==
                                                                "pending" &&
                                                            watch.orderDetails
                                                                    ?.customerRefundPaymentStatus ==
                                                                "not_received"
                                                        ? "Payment Pending"
                                                        : watch.orderDetails
                                                                        ?.shopOwnerRefundStatus ==
                                                                    "accept" &&
                                                                watch.orderDetails
                                                                        ?.customerRefundPaymentStatus ==
                                                                    "not_received"
                                                            ? "Pending from Customer"
                                                            : watch.orderDetails
                                                                            ?.shopOwnerRefundStatus ==
                                                                        "accept" &&
                                                                    watch.orderDetails
                                                                            ?.customerRefundPaymentStatus ==
                                                                        "received"
                                                                ? "Payment Recieved"
                                                                : "",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xff115B7A)),
                                                  )),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 16.w,
                                                ),
                                                Text("Refund Amount",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp)),
                                                SizedBox(
                                                  height: 10.w,
                                                ),
                                                PrimaryCTextFormField(
                                                  controller:
                                                      watch.refundPayableAmount,
                                                  hintText:
                                                      "Type Refund Amount",
                                                ),
                                                SizedBox(
                                                  height: 27.w,
                                                ),
                                                Row(
                                                  children: [
                                                    PrimaryCheckBox(
                                                      onChanged: (value) {
                                                        read.onRefundByCash(
                                                            value);
                                                      },
                                                      value:
                                                          watch.isRefundByCash,
                                                    ),
                                                    SizedBox(
                                                      width: 6.w,
                                                    ),
                                                    Text(
                                                      "Refund Payment Given by Cash",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14.sp),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 16.w,
                                                ),
                                                Row(
                                                  children: [
                                                    PrimaryCheckBox(
                                                      onChanged: (value) {
                                                        read.onRefundByUpi(
                                                            value);
                                                      },
                                                      value:
                                                          watch.isRefundByUpi,
                                                    ),
                                                    SizedBox(
                                                      width: 6.w,
                                                    ),
                                                    Text(
                                                      "Refund Payment Transferred by UPI/QR Code",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14.sp),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 16.w,
                                                ),
                                                Text("Payment Transaction ID",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp)),
                                                SizedBox(
                                                  height: 10.w,
                                                ),
                                                PrimaryCTextFormField(
                                                  controller:
                                                      watch.upiIdController,
                                                  hintText:
                                                      "Type Transaction ID",
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 27.w,
                                            ),
                                            PrimaryButton(
                                                color: Color(0xff39C19D),
                                                onTap: () {
                                                  read.shopRefundUpdate(
                                                      context);
                                                },
                                                text: "Submit Refund Details"),
                                            SizedBox(
                                              height: 15.w,
                                            ),
                                          ],
                                        ),
                                      )
                                    : watch.orderDetails
                                                    ?.shopOwnerRefundStatus ==
                                                "pending" &&
                                            watch.acceptPayment == false
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 17.w),
                                            color: Color(0xffEFFDFF),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 15.w,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Refund Amount",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18.sp),
                                                        ),
                                                        SizedBox(
                                                          height: 11.w,
                                                        ),
                                                        Text(
                                                          "INR ${watch.orderDetails?.totalAmount}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18.sp),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 22.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.w),
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xff115B7A))),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.w),
                                                      child: Center(
                                                          child: Text(
                                                        watch.orderDetails
                                                                        ?.shopOwnerRefundStatus ==
                                                                    "pending" &&
                                                                watch.orderDetails
                                                                        ?.customerRefundPaymentStatus ==
                                                                    "not_received"
                                                            ? "Payment Pending"
                                                            : watch.orderDetails
                                                                            ?.shopOwnerRefundStatus ==
                                                                        "accept" &&
                                                                    watch.orderDetails
                                                                            ?.customerRefundPaymentStatus ==
                                                                        "not_received"
                                                                ? "Pending from Customer"
                                                                : watch.orderDetails?.shopOwnerRefundStatus ==
                                                                            "accept" &&
                                                                        watch.orderDetails?.customerRefundPaymentStatus ==
                                                                            "received"
                                                                    ? "Payment Recieved"
                                                                    : "",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xff115B7A)),
                                                      )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 16.w,
                                                ),
                                                Text("Refund Reject Reason",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.sp)),
                                                SizedBox(
                                                  height: 10.w,
                                                ),
                                                PrimarySTextFormField(
                                                  height: 100.w,
                                                  maxLines: 5,
                                                  // textInputType:
                                                  //     TextInputType.number,
                                                  controller: watch
                                                      .rejectReasonController,
                                                  hintText:
                                                      "Refund Reject Reason",
                                                ),
                                                SizedBox(
                                                  height: 27.w,
                                                ),
                                                PrimaryButton(
                                                    color: Color(0xff39C19D),
                                                    onTap: () {
                                                      read.shopRefundUpdate(
                                                          context);
                                                    },
                                                    text:
                                                        "Submit Refund Details"),
                                                SizedBox(
                                                  height: 15.w,
                                                ),
                                              ],
                                            ),
                                          )
                                        : watch.orderDetails
                                                    ?.shopOwnerRefundStatus ==
                                                "accept"
                                            ? Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 17.w),
                                                color: Color(0xffEFFDFF),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 15.w,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Refund Amount",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      18.sp),
                                                            ),
                                                            SizedBox(
                                                              height: 11.w,
                                                            ),
                                                            Text(
                                                              "INR ${watch.orderDetails?.totalAmount}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      18.sp),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: 22.w,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.w),
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xff115B7A))),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12.w),
                                                          child: Center(
                                                              child: Text(
                                                            watch.orderDetails
                                                                            ?.shopOwnerRefundStatus ==
                                                                        "pending" &&
                                                                    watch.orderDetails
                                                                            ?.customerRefundPaymentStatus ==
                                                                        "not_received"
                                                                ? "Payment Pending"
                                                                : watch.orderDetails?.shopOwnerRefundStatus ==
                                                                            "accept" &&
                                                                        watch.orderDetails?.customerRefundPaymentStatus ==
                                                                            "not_received"
                                                                    ? "Pending from Customer"
                                                                    : watch.orderDetails?.shopOwnerRefundStatus ==
                                                                                "accept" &&
                                                                            watch.orderDetails?.customerRefundPaymentStatus ==
                                                                                "received"
                                                                        ? "Payment Recieved"
                                                                        : "",
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff115B7A)),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 27.w,
                                                    ),
                                                    watch.orderDetails
                                                                ?.shopOwnerRefundPaymentType !=
                                                            "cash"
                                                        ? Row(
                                                            children: [
                                                              PrimaryCheckBox(
                                                                  onChanged:
                                                                      (value) {
                                                                    // read.onRefundByUpi(value);
                                                                  },
                                                                  value: true),
                                                              SizedBox(
                                                                width: 6.w,
                                                              ),
                                                              Text(
                                                                "Refund Payment Transferred by UPI/QR Code",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        14.sp),
                                                              ),
                                                            ],
                                                          )
                                                        : Row(
                                                            children: [
                                                              PrimaryCheckBox(
                                                                  onChanged:
                                                                      (value) {},
                                                                  value: true),
                                                              SizedBox(
                                                                width: 6.w,
                                                              ),
                                                              Text(
                                                                "Refund Payment Given by Cash",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        14.sp),
                                                              ),
                                                            ],
                                                          ),
                                                    SizedBox(
                                                      height: 16.w,
                                                    ),
                                                    watch.orderDetails
                                                                ?.shopOwnerRefundTransactionId !=
                                                            ""
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  "Payment Transaction ID",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14.sp)),
                                                              SizedBox(
                                                                height: 14.w,
                                                              ),
                                                              Text(
                                                                watch.orderDetails
                                                                        ?.shopOwnerRefundTransactionId ??
                                                                    "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          )
                                                        : Container(),
                                                    SizedBox(
                                                      height: 50.w,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : watch.orderDetails
                                                        ?.shopOwnerRefundStatus ==
                                                    "reject"
                                                ? Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 17.w),
                                                    color: Color(0xffFFE8E8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 15.w,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Return Request Rejected ",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18.sp),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15.w,
                                                        ),
                                                        Text(
                                                          "Reason",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16.sp),
                                                        ),
                                                        SizedBox(
                                                          height: 6.w,
                                                        ),
                                                        Text(
                                                          watch.orderDetails
                                                                  ?.shopOwnerRejectReason ??
                                                              "Not Mentioned",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16.sp),
                                                        ),
                                                        SizedBox(height: 45.w),
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                          ],
                        )
                      : Container(
                          height: 50.w,
                        ),

                  // Container(
                  //   padding: EdgeInsets.only(left: 19.w, right: 19.w),
                  //   child: SizedBox(
                  //     // padding: EdgeInsets.only(
                  //     //     left: 91.w, right: 91.w, top: 10.w, bottom: 10.w),
                  //     width: 354.w,
                  //     // <-- Your width
                  //     height: 38.h,
                  //     child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         primary: Color(0xffD1D1D1),
                  //         // onPrimary: Colors.white,
                  //         // shadowColor: Colors.greenAccent,
                  //         elevation: 3,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(14.0)),
                  //         // minimumSize: const Size(100, 40), //////// HERE
                  //       ),
                  //       // style: style,
                  //       onPressed: () {
                  //         // read.onCodeVerification(context);
                  //       },
                  //       child: Text(
                  //         'Product Return Request',
                  //         style: GoogleFonts.inter(
                  //           textStyle: TextStyle(
                  //               // color: SplashTex
                  //               // letterSpacing: .5,
                  //               fontSize: 18.sp,
                  //               fontWeight: FontWeight.w700),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 26.h,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 19.w),
                  //   child: Text(
                  //     'Your Ratings',
                  //     style: GoogleFonts.inter(
                  //       textStyle: TextStyle(
                  //           // color: SplashTex
                  //           // letterSpacing: .5,
                  //           fontSize: 16.sp,
                  //           fontWeight: FontWeight.w400),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 19.w),
                  //   child: Row(
                  //     children: [
                  //       GestureDetector(
                  //           child:
                  //               SvgPicture.asset("assets/icons/order_rating.svg")),
                  //       SizedBox(
                  //         width: 9.77.w,
                  //       ),
                  //       GestureDetector(
                  //           child:
                  //               SvgPicture.asset("assets/icons/order_rating.svg")),
                  //       SizedBox(
                  //         width: 9.77.w,
                  //       ),
                  //       GestureDetector(
                  //           child:
                  //               SvgPicture.asset("assets/icons/order_rating.svg")),
                  //       SizedBox(
                  //         width: 9.77.w,
                  //       ),
                  //       GestureDetector(
                  //           child:
                  //               SvgPicture.asset("assets/icons/order_rating.svg")),
                  //       SizedBox(
                  //         width: 9.77.w,
                  //       ),
                  //       GestureDetector(
                  //           child:
                  //               SvgPicture.asset("assets/icons/order_rating.svg"))
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 19.w),
                  //   child: Text(
                  //     'Your Feedback',
                  //     style: GoogleFonts.poppins(
                  //       textStyle: TextStyle(
                  //           // color: SplashTex
                  //           // letterSpacing: .5,
                  //           fontSize: 16.sp,
                  //           fontWeight: FontWeight.w400),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 19.w, right: 19.w),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide:
                  //             BorderSide(width: 1, color: Color(0xffE8E8E8)),
                  //         borderRadius: BorderRadius.circular(10.0),

                  //         //<-- SEE HERE
                  //       ),

                  //       contentPadding:
                  //           EdgeInsets.symmetric(vertical: 80.w), // <-- SEE HERE

                  //       fillColor: Colors.white,
                  //       // border: OutlineInputBorder(
                  //       //   borderRadius: BorderRadius.circular(10.0),
                  //       //   borderSide: BorderSide(width: 100, color: grey6
                  //       //       // style: BorderStyle.none,
                  //       //       ),
                  //       // ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         borderSide: const BorderSide(
                  //           width: 0,
                  //           style: BorderStyle.none,
                  //         ),
                  //       ),
                  //       // enabledBorder: OutlineInputBorder(
                  //       //   borderSide:
                  //       //       BorderSide(width: 1, color: grey6), //<-- SEE HERE
                  //       //   borderRadius: BorderRadius.circular(10.0),
                  //       // ),
                  //       filled: true,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 19.w,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 19.w, right: 19.w),
                  //   child: SizedBox(
                  //     width: 343.w, // <-- Your width
                  //     height: 45.h,
                  //     child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         primary: Color(0xff39C19D),
                  //         // onPrimary: Colors.white,
                  //         // shadowColor: Colors.greenAccent,
                  //         elevation: 3,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(14.0)),
                  //         minimumSize: const Size(100, 40), //////// HERE
                  //       ),
                  //       // style: style,
                  //       onPressed: () {},
                  //       child: Text(
                  //         'Submit',
                  //         style: GoogleFonts.dmSans(
                  //           textStyle: TextStyle(
                  //               color: Colors.white,
                  //               // letterSpacing: .5,
                  //               fontSize: 20.sp,
                  //               fontWeight: FontWeight.w700),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 19.h,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.only(
                  //       left: 19.w, bottom: 11.w, right: 13.w, top: 10.w),
                  //   margin: EdgeInsets.only(
                  //     left: 19.w,
                  //     bottom: 11.w,
                  //     right: 19.w,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: grey6,
                  //       width: 1,
                  //     ),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Image.asset(
                  //             'assets/images/ReviewProfile.png',
                  //             height: 55.h,
                  //             width: 55.w,
                  //           ),
                  //           Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Text(
                  //                     'Johnson Doe',
                  //                     style: GoogleFonts.dmSans(
                  //                       textStyle: TextStyle(
                  //                           color: Black,
                  //                           fontSize: 14.sp,
                  //                           fontWeight: FontWeight.w400),
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     '12 Jan 2021',
                  //                     style: GoogleFonts.dmSans(
                  //                       textStyle: TextStyle(
                  //                           color: Black,
                  //                           fontSize: 14.sp,
                  //                           fontWeight: FontWeight.w400),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               SizedBox(
                  //                 height: 8.h,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.only(left: 10.w),
                  //                 child: Row(
                  //                   children: [
                  //                     SvgPicture.asset(
                  //                         "assets/icons/yellow_stars.svg"),
                  //                     SizedBox(
                  //                       width: 6.w,
                  //                     ),
                  //                     SvgPicture.asset(
                  //                         "assets/icons/yellow_stars.svg"),
                  //                     SizedBox(
                  //                       width: 6.w,
                  //                     ),
                  //                     SvgPicture.asset(
                  //                         "assets/icons/yellow_stars.svg"),
                  //                     SizedBox(
                  //                       width: 6.w,
                  //                     ),
                  //                     SvgPicture.asset(
                  //                         "assets/icons/yellow_stars.svg"),
                  //                     SizedBox(
                  //                       width: 6.w,
                  //                     ),
                  //                     SvgPicture.asset(
                  //                         "assets/icons/yellow_stars.svg"),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       Divider(
                  //         color: gradient,
                  //         thickness: 1,
                  //       ),
                  //       Text(
                  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet.',
                  //         style: GoogleFonts.dmSans(
                  //           textStyle: TextStyle(
                  //               color: Black,
                  //               fontSize: 14.sp,
                  //               fontWeight: FontWeight.w400),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              // Stack(
              //   children: [
              //
              //     Positioned(
              //     top: 0.w,right: 0.w,left: 0.w,bottom: 0.w,child: Visibility(
              //       visible: watch.isStackLoading,
              //       child: Container(
              //         width: 70.w,
              //         height: 70.w,
              //         child: Image.asset("assets/images/loading-gif.gif"),
              //       ),
              //     ))
              //   ],
              // ),
            ),
    );
  }
}
