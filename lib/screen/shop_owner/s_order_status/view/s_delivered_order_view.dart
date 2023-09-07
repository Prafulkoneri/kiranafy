// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_status/controller/s_order_Status_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_order_view/view/shop_order_view.dart';
// import 'package:provider/provider.dart';

// class SDeliveredOrderView extends StatefulWidget {
//   const SDeliveredOrderView({super.key});

//   @override
//   State<SDeliveredOrderView> createState() => _SDeliveredOrderViewState();
// }

// class _SDeliveredOrderViewState extends State<SDeliveredOrderView> {
//   @override
//   Widget build(BuildContext context) {
//     final read = context.read<SOrderStatusController>();
//     final watch = context.watch<SOrderStatusController>();
//     final readMainScreen = context.read<SMainScreenController>();
//     return watch.deliveredOrdersList?.isEmpty ?? false
//         ? Container(
//             height: MediaQuery.of(context).size.height / 1.5,
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "assets/images/empty_order.png",
//                     width: 150.w,
//                     height: 150.h,
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Text(
//                     "No Record Found",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Black1,
//                           letterSpacing: .5,
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : ListView.builder(
//             padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
//             itemCount: watch.deliveredOrdersList?.length ?? 0,
//             physics: BouncingScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (BuildContext, index) {
//               final element = watch.deliveredOrdersList?[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ShopOrderView(
//                               orderId: element?.id.toString(),
//                               fromOrderStatus: true,
//                               selectedIndex: watch.selectedIndex,
//                             )),
//                   );
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(14.w),
//                   margin: EdgeInsets.only(bottom: 15.w),
//                   width: ScreenUtil().screenWidth,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.w),
//                     color: Colors.white,
//                     border: Border.all(color: Color(0xffEFEFEF)),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "${element?.customerName}",
//                             // "Ramesh Patil",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 15.sp,
//                                 color: Color(0xff3A3A3A)),
//                           ),
//                           Text(
//                             "Order ID : ${element?.orderUniqueId}",
//                             // "Order ID: LSM012334",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 15.sp,
//                                 color: Color(0xff3A3A3A)),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 7.w,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "${element?.totalItems} Products",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 12.sp,
//                                 color: Color(0xff3A3A3A)),
//                           ),
//                           Text(
//                             "\u{20B9}  ${element?.totalAmount}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14.sp,
//                                 color: Color(0xff39C19D)),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 7.w,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "${element?.createdAt}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 12.sp,
//                                 color: Color(0xffA3A3A3)),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               // Within the `FirstRoute` widget
//                             },
//                             child: Row(
//                               children: [
//                                 Text(
//                                   "Details",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14.sp,
//                                       color: Color(0xff3A3A3A)),
//                                 ),
//                                 SizedBox(
//                                   width: 7.w,
//                                 ),
//                                 SvgPicture.asset(
//                                     "assets/icons/arrow_right.svg"),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       ///////////////////////
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       element?.refundCount != 0
//                           ? Container(
//                               padding: EdgeInsets.only(
//                                   left: 11.w,
//                                   right: 9.w,
//                                   top: 4.w,
//                                   bottom: 3.w),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Color(0xffFBDFDF),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "${element?.refundCount} products return request",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 12.sp,
//                                         color: Black),
//                                   ),
//                                   Row(
//                                     children: [
//                                       element?.shopOwnerPaymentStatus ==
//                                               "payment-not-given"
//                                           ? Text(
//                                               "Pending",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w500,
//                                                   fontSize: 14.sp,
//                                                   color: Black),
//                                             )
//                                           : element?.shopOwnerPaymentStatus ==
//                                                   "payment-submit"
//                                               ? Text(
//                                                   "Acepeted",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       fontSize: 14.sp,
//                                                       color: Black),
//                                                 )
//                                               : element?.shopOwnerPaymentStatus ==
//                                                       "payment-rejected"
//                                                   ? Text(
//                                                       "Rejected",
//                                                       style: TextStyle(
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           fontSize: 14.sp,
//                                                           color: Black),
//                                                     )
//                                                   : Container()
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : Container()
//                     ],
//                   ),
//                 ),
//               );
//             });
//   }
// }
/////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/controller/s_order_Status_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/view/shop_order_view.dart';
import 'package:provider/provider.dart';

class SDeliveredOrderView extends StatefulWidget {
  const SDeliveredOrderView({super.key});

  @override
  State<SDeliveredOrderView> createState() => _SDeliveredOrderViewState();
}

class _SDeliveredOrderViewState extends State<SDeliveredOrderView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SOrderStatusController>();
    final watch = context.watch<SOrderStatusController>();
    final readMainScreen = context.read<SMainScreenController>();
    return watch.deliveredOrdersList?.isEmpty ?? false
        ? Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/empty_order.png",
                    width: 150.w,
                    height: 150.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "No Record Found",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          letterSpacing: .5,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
            itemCount: watch.deliveredOrdersList?.length ?? 0,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext, index) {
              final element = watch.deliveredOrdersList?[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShopOrderView(
                              orderId: element?.id.toString(),
                              fromOrderStatus: true,
                              selectedIndex: watch.selectedIndex,
                            )),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  margin: EdgeInsets.only(bottom: 15.w),
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: Colors.white,
                    border: Border.all(color: Color(0xffEFEFEF)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${element?.customerName}",
                            // "Ramesh Patil",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                color: Color(0xff3A3A3A)),
                          ),
                          Text(
                            "Order ID : ${element?.orderUniqueId}",
                            // "Order ID: LSM012334",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                                color: Color(0xff3A3A3A)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${element?.totalItems} Products",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Color(0xff3A3A3A)),
                          ),
                          Text(
                            "\u{20B9}  ${element?.totalAmount}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: Color(0xff39C19D)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${element?.createdAt}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Color(0xffA3A3A3)),
                          ),
                          InkWell(
                            onTap: () {
                              // Within the `FirstRoute` widget
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      color: Color(0xff3A3A3A)),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                SvgPicture.asset(
                                    "assets/icons/arrow_right.svg"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ///////////////////////
                      SizedBox(
                        height: 5.h,
                      ),
                      element?.refundCount != 0
                          ? Container(
                              padding: EdgeInsets.only(
                                  left: 11.w,
                                  right: 9.w,
                                  top: 4.w,
                                  bottom: 3.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffFBDFDF),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${element?.refundCount} Products Return Request",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: Black),
                                  ),
                                  Row(
                                    children: [
                                      element?.refundOrderStatus == "pending"
                                          ? Text(
                                              "Pending",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                  color: Black),
                                            )
                                          : element?.refundOrderStatus ==
                                                  "accept"
                                              ? Text(
                                                  "Accepted",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.sp,
                                                      color: Black),
                                                )
                                              : element?.refundOrderStatus ==
                                                      "reject"
                                                  ? Text(
                                                      "Rejected",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp,
                                                          color: Black),
                                                    )
                                                  : Container()
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              );
            });
  }
}
