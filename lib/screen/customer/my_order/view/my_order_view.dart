import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/delivery_view/view/order_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/my_order/controller/my_orders_controller.dart';
import 'package:local_supper_market/screen/customer/my_order/view/order_filtter_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

import '../../main_screen/controllers/main_screen_controller.dart';

class MyOrderView extends StatefulWidget {
  final String? shopId;
  final String? orStatus;
  const MyOrderView({super.key, this.shopId, this.orStatus});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<MyOrdersController>()
          .initState(context, widget.shopId, widget.orStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MyOrdersController>();
    final read = context.read<MyOrdersController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            readMain.onNavigation(
                4,
                ProfileScreenView(
                  isRefreshed: false,
                ),
                context);
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => MainScreenView(
            //           index: 1, screenName: ProfileScreenView(isRefreshed: false,))),
            //   (Route<dynamic> route) => false,
            // );
          },
          title: "My Orders",
          action: InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return MyOrderFiltterView();
                  });
                },
              );
            },
            child: SvgPicture.asset(
              'assets/images/filter.svg',
              width: 20.w,
              height: 18.h,
            ),
          ),
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: watch.orderList?.isNotEmpty == true
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 100.w),
                      shrinkWrap: true,
                      itemCount: watch.myOrdersData?.orderList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final element = watch.orderList?[index];
                        return GestureDetector(
                          onTap: () {
                            readMain.onNavigation(
                                4,
                                OrderDeliveryView(
                                    screenName: "myorderView",
                                    isRefresh: true,
                                    orderId: element?.id.toString()),
                                context);
                            readMain.hideBottomNavigationBar();
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => OrderDeliveryView(
//                                       screenName: "myorderView",
//                                       isRefresh: true,
//                                       orderId: element?.id.toString())),
//                             );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 19.w,
                                bottom: 0.w),
                            padding: EdgeInsets.only(
                                left: 10.w,
                                right: 15.w,
                                top: 10.w,
                                bottom: 10.w),
                            // width: 352.w,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: grey6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        " Order ID - ${element?.orderUniqueId}",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black1,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100.w,
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
                                                color: element?.orderStatus ==
                                                        "Pending"
                                                    ? Yellow
                                                    : element?.orderStatus ==
                                                            "Delivered"
                                                        ? Color(0xff39C19D)
                                                        : element?.orderStatus ==
                                                                "Confirmed"
                                                            ? Color(0xff115B7A)
                                                            : element?.orderStatus ==
                                                                    "Cancelled"
                                                                ? Colors.red
                                                                : element?.orderStatus ==
                                                                        "Dispatched"
                                                                    ? Colors
                                                                        .orange
                                                                    : element?.orderStatus ==
                                                                            "Packing"
                                                                        ? Colors
                                                                            .brown
                                                                        : element?.orderStatus == "Refund" &&
                                                                                element?.customerCancelledStatus == "YES"
                                                                            ? Colors.red
                                                                            : element?.orderStatus == "Refund" && element?.shopCancelledStatus == "YES"
                                                                                ? Colors.red
                                                                                : element?.orderStatus == "Refund"
                                                                                    ? Colors.green
                                                                                    : Colors.transparent,
                                                // width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDeliveryView(
                                                        screenName:
                                                            "myorderview",
                                                        orderId: element?.id
                                                            .toString())),
                                          );
                                        },
                                        child: Text(
                                          // element?.orderStatus == "Refund"
                                          //     ? "Delivered"
                                          //     : element?.orderStatus ?? "",
                                          element?.orderStatus == "Refund" &&
                                                  element?.customerCancelledStatus ==
                                                      "YES"
                                              ? "Cancelled"
                                              : element?.orderStatus ==
                                                          "Refund" &&
                                                      element?.shopCancelledStatus ==
                                                          "YES"
                                                  ? "Cancelled"
                                                  : element?.orderStatus ==
                                                          "Refund"
                                                      ? "Delivered"
                                                      : element?.orderStatus ??
                                                          "",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: element?.orderStatus ==
                                                        "Pending"
                                                    ? Yellow
                                                    ///////
                                                    : element?.orderStatus ==
                                                            "Delivered"
                                                        ? Color(0xff39C19D)
                                                        ///////
                                                        : element?.orderStatus ==
                                                                "Confirmed"
                                                            ? Color(0xff115B7A)
                                                            /////////
                                                            : element?.orderStatus ==
                                                                    "Cancelled"
                                                                ? Colors.red
                                                                //////////////
                                                                : element?.orderStatus ==
                                                                        "Dispatched"
                                                                    ? Colors
                                                                        .orange
                                                                    : element?.orderStatus ==
                                                                            "Packing"
                                                                        ? Colors
                                                                            .brown
                                                                        : element?.orderStatus == "Refund" &&
                                                                                element?.customerCancelledStatus == "YES"
                                                                            ? Colors.red
                                                                            : element?.orderStatus == "Refund" && element?.shopCancelledStatus == "YES"
                                                                                ? Colors.red
                                                                                : element?.orderStatus == "Refund"
                                                                                    ? Colors.green
                                                                                    : Colors.transparent,
                                                // letterSpacing: .5
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),

                                        //
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  " ${element?.createdAt}",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: lightblack,
                                        // letterSpacing: .5,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 13.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      " Total Amount",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            // letterSpacing: .5,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Text(
                                      "Total Quantity",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      " \u{20B9} ${element?.totalAmount}",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: lightblack1,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      "${element?.totalItems}",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: lightblack1,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                ////////////////////////////////////NEW////////////////////////////
                                element?.orderStatus == "Refund" &&
                                        element?.refundProductCount != ""
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            left: 11.w,
                                            right: 9.w,
                                            top: 4.w,
                                            bottom: 3.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xffFBDFDF),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            element?.orderStatus == "Refund" &&
                                                    element?.customerCancelledStatus ==
                                                        "YES"
                                                ? Text(
                                                    "Cancel Refund Request",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12.sp,
                                                        color: Black),
                                                  )
                                                : element?.orderStatus ==
                                                            "Refund" &&
                                                        element?.shopCancelledStatus ==
                                                            "YES"
                                                    ? Text(
                                                        "Cancel Refund Request",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12.sp,
                                                            color: Black),
                                                      )

                                                    /////////////////////

                                                    : element?.orderStatus ==
                                                            "Refund"
                                                        ? Text(
                                                            "${element?.refundProductCount} Products Return Request",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12.sp,
                                                                color: Black),
                                                          )
                                                        : Text(
                                                            "Cancel Refund Request",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12.sp,
                                                                color: Black),
                                                          ),
                                            Row(
                                              children: [
                                                element?.refundOrderStatus ==
                                                        "pending"
                                                    ? Text(
                                                        "Pending",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14.sp,
                                                            color: Black),
                                                      )
                                                    : element?.refundOrderStatus ==
                                                            "accept"
                                                        ? Text(
                                                            "Accepted",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.sp,
                                                                color: Black),
                                                          )
                                                        : element?.refundOrderStatus ==
                                                                "reject"
                                                            ? Text(
                                                                "Rejected",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14.sp,
                                                                    color:
                                                                        Black),
                                                              )
                                                            : Container()
                                              ],
                                            ),
                                          ],
                                        ))
                                    :
                                    // (element?.orderStatus == "Refund" ||
                                    //         element?.orderStatus == "Cancelled")
                                    //     // element?.refundProductCount != ""
                                    //     ? Container(
                                    //         padding: EdgeInsets.only(
                                    //             left: 11.w,
                                    //             right: 9.w,
                                    //             top: 4.w,
                                    //             bottom: 3.w),
                                    //         decoration: BoxDecoration(
                                    //           borderRadius:
                                    //               BorderRadius.circular(5),
                                    //           color: Color(0xffFBDFDF),
                                    //         ),
                                    //         child: Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.spaceBetween,
                                    //           children: [
                                    //             element?.orderStatus == "Refund" &&
                                    //                     element?.customerCancelledStatus ==
                                    //                         "YES"
                                    //                 ? Text(
                                    //                     "Cancel Refund Request",
                                    //                     style: TextStyle(
                                    //                         fontWeight:
                                    //                             FontWeight.w400,
                                    //                         fontSize: 12.sp,
                                    //                         color: Black),
                                    //                   )
                                    //                 : element?.orderStatus ==
                                    //                             "Refund" &&
                                    //                         element?.shopCancelledStatus ==
                                    //                             "YES"
                                    //                     ? Text(
                                    //                         "Cancel Refund Request",
                                    //                         style: TextStyle(
                                    //                             fontWeight:
                                    //                                 FontWeight.w400,
                                    //                             fontSize: 12.sp,
                                    //                             color: Black),
                                    //                       )
                                    //                     : Container(),
                                    //                     /////////////////////
                                    //
                                    //             // : element?.orderStatus ==
                                    //             //         "Refund"
                                    //             //     ? Text(
                                    //             //         "${element?.refundProductCount} products return request",
                                    //             //         style: TextStyle(
                                    //             //             fontWeight:
                                    //             //                 FontWeight
                                    //             //                     .w400,
                                    //             //             fontSize: 12.sp,
                                    //             //             color: Black),
                                    //             //       )
                                    //             //     : Text(
                                    //             //         "Cancel Refund Request",
                                    //             //         style: TextStyle(
                                    //             //             fontWeight:
                                    //             //                 FontWeight
                                    //             //                     .w400,
                                    //             //             fontSize: 12.sp,
                                    //             //             color: Black),
                                    //             //       ),
                                    //             Row(
                                    //               children: [
                                    //                 element?.refundOrderStatus ==
                                    //                         "pending"
                                    //                     ? Text(
                                    //                         "Pending",
                                    //                         style: TextStyle(
                                    //                             fontWeight:
                                    //                                 FontWeight.w500,
                                    //                             fontSize: 14.sp,
                                    //                             color: Black),
                                    //                       )
                                    //                     : element?.refundOrderStatus ==
                                    //                             "accept"
                                    //                         ? Text(
                                    //                             "Accepted",
                                    //                             style: TextStyle(
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .w500,
                                    //                                 fontSize: 14.sp,
                                    //                                 color: Black),
                                    //                           )
                                    //                         : element?.refundOrderStatus ==
                                    //                                 "reject"
                                    //                             ? Text(
                                    //                                 "Rejected",
                                    //                                 style: TextStyle(
                                    //                                     fontWeight:
                                    //                                         FontWeight
                                    //                                             .w500,
                                    //                                     fontSize:
                                    //                                         14.sp,
                                    //                                     color:
                                    //                                         Black),
                                    //                               )
                                    //                             : Container()
                                    //               ],
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       )
                                    //     :
                                    Container()
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/emptycart.png",
                            height: 151.h,
                            width: 151.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 15.w,
                                bottom: 50.w),
                            child: Text(
                              "Looks like you don't have any Orders",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))),
    );
  }
}
