// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/customer/delivery_view/controller/customer_order_view_controller.dart';
// import 'package:local_supper_market/screen/customer/delivery_view/view/cancel_order_view_bottom_sheet.dart';
// import 'package:local_supper_market/screen/customer/delivery_view/view/order_product_list_view.dart';
// import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
// import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
// import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
// import 'package:local_supper_market/screen/customer/order_status/view/order_status_view.dart';
// import 'package:local_supper_market/screen/customer/return/view/return_view.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
// import 'package:local_supper_market/utils/Utils.dart';
// import 'package:local_supper_market/widget/app_bar.dart';
// import 'package:local_supper_market/widget/buttons.dart';
// import 'package:local_supper_market/widget/loader.dart';
// import 'package:local_supper_market/widget/rating.dart';
// import 'package:local_supper_market/widget/textfield.dart';
// import 'package:provider/provider.dart';

// class OrderDeliveryView extends StatefulWidget {
//   final String? orderId;
//   final bool? isRefresh;
//   final String? screenName;

//   const OrderDeliveryView({
//     super.key,
//     this.orderId,
//     this.isRefresh,
//     required this.screenName,
//   });

//   @override
//   State<OrderDeliveryView> createState() => _OrderDeliveryViewState();
// }

// class _OrderDeliveryViewState extends State<OrderDeliveryView> {
//   @override
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       context.read<CustomerOrderViewController>().initState(
//             context,
//             widget.orderId.toString(),
//           );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final watch = context.watch<CustomerOrderViewController>();
//     final read = context.read<CustomerOrderViewController>();
//     final readMain = context.read<MainScreenController>();
//     return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60.w),
//           child: PrimaryAppBar(
//             // onBackBtnPressed: () {
//             //   Navigator.pushAndRemoveUntil(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (context) =>
//             //             MainScreenView(index: 4, screenName: MyOrderView())),
//             //     (Route<dynamic> route) => false,
//             //   );

//             //   // Navigator.pushAndRemoveUntil(
//             //   //   context,
//             //   //   MaterialPageRoute(builder: (context) => MyOrderView()),
//             //   //   (Route<dynamic> route) => false,
//             //   // );
//             //   // Navigator.pop(context);
//             // },
//             onBackBtnPressed: () {
//               widget.screenName == "notification"
//                   ? readMain.onNavigation(
//                       4,
//                       CustomerNotificationsScreenView(
//                         isRefresh: false,
//                       ),
//                       context)
//                   : readMain.onNavigation(4, MyOrderView(), context);
//               readMain.showBottomNavigationBar();
//             },
//             title: "Order",
//           ),
//         ),
//         body: watch.isLoading
//             ? Loader()
//             : WillPopScope(
//                 onWillPop: () async {
//                   widget.screenName == "notification"
//                       ? readMain.onNavigation(
//                           4,
//                           CustomerNotificationsScreenView(
//                             isRefresh: false,
//                           ),
//                           context)
//                       : readMain.onNavigation(4, MyOrderView(), context);
//                   readMain.showBottomNavigationBar();
//                   return false;
//                 },
//                 child:
//                     // RefreshIndicator(

//                     // child:
//                     SingleChildScrollView(
//                         physics: BouncingScrollPhysics(),
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   readMain.onNavigation(
//                                       1,
//                                       ShopProfileView(
//                                         refreshPage: true,
//                                         routeName: '',
//                                         shopId:
//                                             watch.shopDetails?.id.toString(),
//                                       ),
//                                       context);
//                                   readMain.showBottomNavigationBar();
//                                   // Navigator.pushAndRemoveUntil(
//                                   //   context,
//                                   //   MaterialPageRoute(
//                                   //       builder: (context) => MainScreenView(
//                                   //           index: 1,
//                                   //           screenName: ShopProfileView(
//                                   //             refreshPage: true,
//                                   //             routeName: '',
//                                   //             shopId: watch.shopDetails?.id.toString(),
//                                   //           ))),
//                                   //       (Route<dynamic> route) => false,
//                                   // );
//                                 },
//                                 child: Container(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 15.w),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                         height: 20.w,
//                                       ),
//                                       Text("${watch.shopDetails?.shopName}",
//                                           style: GoogleFonts.roboto(
//                                             textStyle: TextStyle(
//                                                 fontSize: 18.sp,
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Black1),
//                                           )),
//                                       SizedBox(
//                                         height: 10.w,
//                                       ),
//                                       Container(
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Expanded(
//                                                 child: Container(
//                                               child: Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   SvgPicture.asset(
//                                                     'assets/images/location2.svg',
//                                                     width: 28.w,
//                                                     height: 28.w,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 9.w,
//                                                   ),
//                                                   Flexible(
//                                                     child: Text(
//                                                       // "",
//                                                       "${watch.shopDetails?.shopAddress}\n${watch.shopDetails?.cityName} - ${watch.shopDetails?.shopPincode}",
//                                                       // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
//                                                       style: GoogleFonts.dmSans(
//                                                         textStyle: TextStyle(
//                                                             color: Black,
//                                                             letterSpacing: .5,
//                                                             fontSize: 13.sp,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             )),
//                                             // Row(
//                                             //   children: [
//                                             //     InkWell(
//                                             //       onTap: () {
//                                             //         read.launchPhone(
//                                             //             watch.shopDetails
//                                             //                     ?.shopOwnerSupportNumber ??
//                                             //                 "",
//                                             //             context);
//                                             //       },
//                                             //       child: Container(
//                                             //           padding: EdgeInsets.only(
//                                             //               left: 11.w,
//                                             //               right: 11.w,
//                                             //               top: 13.w,
//                                             //               bottom: 13.w),
//                                             //           decoration: BoxDecoration(
//                                             //             shape: BoxShape.circle,
//                                             //             color: Color(0xff23AA49),
//                                             //           ),
//                                             //           child: SvgPicture.asset(
//                                             //             "assets/icons/new_call.svg",
//                                             //             width: 26.w,
//                                             //             height: 14.h,
//                                             //           )),
//                                             //     ),
//                                             //     SizedBox(
//                                             //       width: 13.w,
//                                             //     ),
//                                             //     InkWell(
//                                             //       onTap: () {
//                                             //         watch.favAllShop
//                                             //             ? read.removeAllShopFavList(
//                                             //                 context,
//                                             //                 watch.shopDetails?.id)
//                                             //             : read.updateAllShopFavList(
//                                             //                 context,
//                                             //                 watch.shopDetails?.id);
//                                             //       },
//                                             //       child: Container(
//                                             //         padding: EdgeInsets.only(
//                                             //             left: 13.w,
//                                             //             right: 13.w,
//                                             //             top: 14.w,
//                                             //             bottom: 14.w),
//                                             //         decoration: const BoxDecoration(
//                                             //           shape: BoxShape.circle,
//                                             //           color: Color(0xff4689EC),
//                                             //         ),
//                                             //         child: watch.favAllShop
//                                             //             ? SvgPicture.asset(
//                                             //                 "assets/icons/fav_selected.svg",
//                                             //                 width: 26.w,
//                                             //                 height: 14.h,
//                                             //               )
//                                             //             : SvgPicture.asset(
//                                             //                 "assets/images/favorite.svg",
//                                             //                 width: 26.w,
//                                             //                 height: 14.h,
//                                             //               ),
//                                             //       ),
//                                             //     )
//                                             //   ],
//                                             // ),
//                                             Row(
//                                               children: [
//                                                 InkWell(
//                                                   onTap: () {
//                                                     read.launchPhone(
//                                                         watch.shopDetails
//                                                                 ?.shopOwnerSupportNumber ??
//                                                             "",
//                                                         context);
//                                                   },
//                                                   child: Container(
//                                                       padding: EdgeInsets.only(
//                                                           left: 13.w,
//                                                           right: 13.w,
//                                                           top: 14.w,
//                                                           bottom: 14.w),
//                                                       decoration: BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color:
//                                                             Color(0xff23AA49),
//                                                       ),
//                                                       child: SvgPicture.asset(
//                                                         "assets/icons/new_call.svg",
//                                                         width: 26.w,
//                                                         height: 14.h,
//                                                       )),
//                                                 ),
//                                                 SizedBox(
//                                                   width: 13.w,
//                                                 ),
//                                                 // InkWell(
//                                                 //   onTap: () {
//                                                 //     watch.favAllShop
//                                                 //         ? read.removeAllShopFavList(
//                                                 //             context,
//                                                 //             watch.shopDetails?.id)
//                                                 //         : read.updateAllShopFavList(
//                                                 //             context,
//                                                 //             watch.shopDetails?.id);
//                                                 //   },
//                                                 //   child: Container(
//                                                 //     padding: EdgeInsets.only(
//                                                 //         left: 13.w,
//                                                 //         right: 13.w,
//                                                 //         top: 14.w,
//                                                 //         bottom: 14.w),
//                                                 //     decoration: BoxDecoration(
//                                                 //       shape: BoxShape.circle,
//                                                 //       color: Color(0xff4689EC),
//                                                 //     ),
//                                                 //     child: watch.favAllShop
//                                                 //         ? SvgPicture.asset(
//                                                 //             "assets/icons/fav_selected.svg",
//                                                 //             width: 26.w,
//                                                 //             height: 14.h,
//                                                 //           )
//                                                 //         : SvgPicture.asset(
//                                                 //             "assets/images/favorite.svg",
//                                                 //             width: 26.w,
//                                                 //             height: 14.h,
//                                                 //           ),
//                                                 //   ),
//                                                 // )
//                                                 InkWell(
//                                                   onTap: () {
//                                                     watch.favAllShop
//                                                         ? read
//                                                             .removeAllShopFavList(
//                                                                 context,
//                                                                 watch
//                                                                     .shopDetails
//                                                                     ?.id)
//                                                         : read
//                                                             .updateAllShopFavList(
//                                                                 context,
//                                                                 watch
//                                                                     .shopDetails
//                                                                     ?.id);
//                                                   },
//                                                   child: Container(
//                                                     padding: EdgeInsets.only(
//                                                         left: 13.w,
//                                                         right: 13.w,
//                                                         top: 14.w,
//                                                         bottom: 14.w),
//                                                     decoration:
//                                                         const BoxDecoration(
//                                                       shape: BoxShape.circle,
//                                                       color: Color(0xff4689EC),
//                                                       // color: Color(0xffFBDFDF),
//                                                     ),
//                                                     child: watch.favAllShop
//                                                         ? SvgPicture.asset(
//                                                             "assets/icons/fav_selected.svg",
//                                                             width: 26.w,
//                                                             height: 14.h,
//                                                           )
//                                                         : SvgPicture.asset(
//                                                             "assets/images/favorite.svg",
//                                                             width: 26.w,
//                                                             height: 14.h,
//                                                           ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 17.h,
//                               ),
//                               Divider(thickness: 1, color: grey2),
//                               SizedBox(
//                                 height: 10.h,
//                               ),
//                               Container(
//                                 padding:
//                                     EdgeInsets.only(left: 19.w, right: 17.w),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Order ID: ${watch.orderDetails?.orderUniqueId}",
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: TextStyle(
//                                             color: Black,
//                                             letterSpacing: .5,
//                                             fontSize: 16.sp,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                     ),
//                                     // watch.orderDetails.
//                                     SizedBox(
//                                       width: 100.w,
//                                       child: ElevatedButton(
//                                         style: ButtonStyle(
//                                           elevation:
//                                               MaterialStateProperty.all(0),
//                                           // backgroundColor: ,
//                                           backgroundColor:
//                                               MaterialStateProperty.all(
//                                                   Colors.white),
//                                           shape: MaterialStateProperty.all(
//                                             RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               side: BorderSide(
//                                                 color: watch.orderDetails
//                                                             ?.orderStatus ==
//                                                         "Pending"
//                                                     ? Yellow
//                                                     : watch.orderDetails
//                                                                 ?.orderStatus ==
//                                                             "Delivered"
//                                                         ? Color(0xff39C19D)
//                                                         : watch.orderDetails
//                                                                     ?.orderStatus ==
//                                                                 "Confirmed"
//                                                             ? Color(0xff115B7A)
//                                                             : watch.orderDetails
//                                                                         ?.orderStatus ==
//                                                                     "Cancelled"
//                                                                 ? Colors.red
//                                                                 : watch.orderDetails
//                                                                             ?.orderStatus ==
//                                                                         "Dispatched"
//                                                                     ? Colors
//                                                                         .orange
//                                                                     : watch.orderDetails?.orderStatus ==
//                                                                             "Packing"
//                                                                         ? Colors
//                                                                             .brown
//                                                                         : watch.orderDetails?.orderStatus == "Order Refund" &&
//                                                                                 watch.orderDetails?.customerCancelledStatus == "YES"
//                                                                             ? Colors.red
//                                                                             : watch.orderDetails?.orderStatus == "Order Refund" && watch.orderDetails?.shopCancelledStatus == "YES"
//                                                                                 ? Colors.red
//                                                                                 : watch.orderDetails?.orderStatus == "Order Refund"
//                                                                                     ? Colors.green
//                                                                                     : Colors.transparent,
//                                                 // width: 1,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         onPressed: () {
//                                           // Navigator.push(
//                                           //   context,
//                                           //   MaterialPageRoute(
//                                           //       builder: (context) => OrderPendingView(
//                                           //           orderId: element?.id.toString())),
//                                           // );
//                                         },
//                                         child: Text(
//                                           watch.orderDetails?.orderStatus ==
//                                                       "Order Refund" &&
//                                                   watch.orderDetails
//                                                           ?.customerCancelledStatus ==
//                                                       "YES"
//                                               ? "Cancelled"

//                                               : watch.orderDetails
//                                                               ?.orderStatus ==
//                                                           "Order Refund" &&
//                                                       watch.orderDetails
//                                                               ?.shopCancelledStatus ==
//                                                           "YES"
//                                                   ? "Cancelled"
//                                                   : watch.orderDetails
//                                                               ?.orderStatus ==
//                                                           "Order Refund"
//                                                       ? "Delivered"
//                                                       : watch.orderDetails
//                                                               ?.orderStatus ??
//                                                           "",
//                                           ///////////////
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: watch.orderDetails
//                                                             ?.orderStatus ==
//                                                         "Pending"
//                                                     ? Yellow
//                                                     ///////
//                                                     : watch.orderDetails
//                                                                 ?.orderStatus ==
//                                                             "Delivered"
//                                                         ? Color(0xff39C19D)
//                                                         ///////
//                                                         : watch.orderDetails
//                                                                     ?.orderStatus ==
//                                                                 "Confirmed"
//                                                             ? Color(0xff115B7A)
//                                                             /////////
//                                                             : watch.orderDetails
//                                                                         ?.orderStatus ==
//                                                                     "Cancelled"
//                                                                 ? Colors.red
//                                                                 //////////////
//                                                                 : watch.orderDetails
//                                                                             ?.orderStatus ==
//                                                                         "Dispatched"
//                                                                     ? Colors
//                                                                         .orange
//                                                                     : watch.orderDetails?.orderStatus ==
//                                                                             "Packing"
//                                                                         ? Colors
//                                                                             .brown
//                                                                         : watch.orderDetails?.orderStatus == "Order Refund" &&
//                                                                                 watch.orderDetails?.customerCancelledStatus == "YES"
//                                                                             ? Colors.red
//                                                                             : watch.orderDetails?.orderStatus == "Order Refund" && watch.orderDetails?.shopCancelledStatus == "YES"
//                                                                                 ? Colors.red
//                                                                                 : watch.orderDetails?.orderStatus == "Order Refund"
//                                                                                     ? Colors.green
//                                                                                     : Colors.transparent,
//                                                 // letterSpacing: .5
//                                                 fontSize: 12.sp,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         ),

//                                         //
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.only(
//                                   left: 19.w,
//                                 ),
//                                 child: Text(
//                                   "${watch.orderDetails?.createdAt}",
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         color: Black,
//                                         // letterSpacing: .5,
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                               ),
//                               /////////////////////////////////////////////
//                               watch.orderDetails?.orderStatus == "Dispatched" ||
//                                       watch.orderDetails?.orderStatus ==
//                                           "Delivered"
//                                   ? Container(
//                                       margin: EdgeInsets.only(
//                                           left: 20.w,
//                                           right: 19.w,
//                                           top: 17.w,
//                                           bottom: 19.w),
//                                       padding: EdgeInsets.only(
//                                           left: 13.w,
//                                           right: 16.w,
//                                           top: 14.w,
//                                           bottom: 15.w),
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Color(0xff39C19D),
//                                           ),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10))),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "Delivery Code",
//                                             style: GoogleFonts.dmSans(
//                                               textStyle: TextStyle(
//                                                   color: Black,
//                                                   // letterSpacing: .5,
//                                                   fontSize: 17.sp,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                           ),
//                                           Text(
//                                             "${watch.orderDetails?.deliveryCode}",
//                                             style: GoogleFonts.dmSans(
//                                               textStyle: TextStyle(
//                                                   color: Color(0xff39C19D),
//                                                   // letterSpacing: .5,
//                                                   fontSize: 22.sp,
//                                                   fontWeight: FontWeight.w700),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   : Container(
//                                       height: 20.h,
//                                     ),
//                               ///////////////////////////////////////
//                               watch.orderDetails?.deliveryType != "self_pickup"
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.only(
//                                             left: 20.w,
//                                           ),
//                                           child: Text(
//                                             "Delivery Address",
//                                             style: GoogleFonts.dmSans(
//                                               textStyle: TextStyle(
//                                                   color: Black,
//                                                   // letterSpacing: .5,
//                                                   fontSize: 16.sp,
//                                                   fontWeight: FontWeight.w700),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 10.h,
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(
//                                               left: 19.w, right: 19.w),
//                                           // height: 156.h,
//                                           width: double.infinity,
//                                           child: Card(
//                                             shape: RoundedRectangleBorder(
//                                               // side: BorderSide(color: Colors.white70, width: 1),
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                             child: Container(
//                                               padding: EdgeInsets.only(
//                                                   bottom: 20.w,
//                                                   left: 20.w,
//                                                   right: 15.w,
//                                                   top: 20.w),
//                                               child: Column(
//                                                 children: [
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           SvgPicture.asset(
//                                                             'assets/images/person.svg',
//                                                             width: 11.w,
//                                                             height: 15.h,
//                                                           ),
//                                                           SizedBox(
//                                                             width: 10.w,
//                                                           ),
//                                                           Text(
//                                                             // "",
//                                                             "${watch.deliveryAddressDetails?.customerName}",
//                                                             // 'Rachel Green',
//                                                             style: GoogleFonts
//                                                                 .dmSans(
//                                                               textStyle: TextStyle(
//                                                                   color: Black,
//                                                                   letterSpacing:
//                                                                       .5,
//                                                                   fontSize:
//                                                                       16.sp,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700),
//                                                             ),
//                                                           ),
//                                                           // SizedBox(
//                                                           //   width: 11.w,
//                                                           // ),
//                                                         ],
//                                                       ),
//                                                       SizedBox(
//                                                         // height: 21.h,/
//                                                         // width: 71.w,
//                                                         child: ElevatedButton(
//                                                           style: ButtonStyle(
//                                                             elevation:
//                                                                 MaterialStateProperty
//                                                                     .all(0),
//                                                             // backgroundColor: ,
//                                                             backgroundColor:
//                                                                 MaterialStateProperty
//                                                                     .all(Colors
//                                                                         .white),
//                                                             shape:
//                                                                 MaterialStateProperty
//                                                                     .all(
//                                                               RoundedRectangleBorder(
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             10),
//                                                                 side:
//                                                                     BorderSide(
//                                                                   color:
//                                                                       lighrgreen,
//                                                                   // width: 1,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           onPressed: () {},
//                                                           child: Text(
//                                                             "${watch.deliveryAddressDetails?.deliveryAddressType}"
//                                                                 .capitalize(),
//                                                             // "${element.deliveryAddressType}",
//                                                             // "Home",
//                                                             style: GoogleFonts
//                                                                 .dmSans(
//                                                               textStyle:
//                                                                   TextStyle(
//                                                                       color:
//                                                                           SplashText1,
//                                                                       // letterSpacing: .5,
//                                                                       fontSize:
//                                                                           12.sp,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w700),
//                                                             ),
//                                                           ),

//                                                           //
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       SvgPicture.asset(
//                                                         'assets/images/phone.svg',
//                                                         width: 14.w,
//                                                         height: 15.h,
//                                                       ),
//                                                       SizedBox(
//                                                         width: 10.w,
//                                                       ),
//                                                       Text(
//                                                         "${watch.deliveryAddressDetails?.mobileNo}",
//                                                         // '${element.mobileNo}',
//                                                         style:
//                                                             GoogleFonts.dmSans(
//                                                           textStyle: TextStyle(
//                                                               color: Black,
//                                                               letterSpacing: .5,
//                                                               fontSize: 13.sp,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   SizedBox(
//                                                     height: 10.w,
//                                                   ),
//                                                   Row(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       SvgPicture.asset(
//                                                         'assets/images/location.svg',
//                                                         color: SplashText1,
//                                                         width: 17.w,
//                                                         height: 17.h,
//                                                       ),
//                                                       SizedBox(
//                                                         width: 10.w,
//                                                       ),
//                                                       Expanded(
//                                                         child: Text(
//                                                           "${watch.deliveryAddressDetails?.address1} ${watch.deliveryAddressDetails?.address2}",
//                                                           maxLines: 3,
//                                                           // "${element.address1} \n${element.address2} ",
//                                                           // textAlign: TextAlign.start,
//                                                           style: GoogleFonts
//                                                               .dmSans(
//                                                             textStyle:
//                                                                 TextStyle(
//                                                                     // height: 1.5,
//                                                                     color:
//                                                                         black,
//                                                                     fontSize:
//                                                                         14.sp,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400),
//                                                           ),
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   : Container(
//                                       padding: EdgeInsets.only(
//                                           left: 19.w, right: 19.w),
//                                       child: Row(
//                                         children: [
//                                           Flexible(
//                                             child: RichText(
//                                               text: TextSpan(
//                                                   text: "Note: ",
//                                                   style: TextStyle(
//                                                       color: Black,
//                                                       fontSize: 12.sp,
//                                                       // height: 1.3.w,
//                                                       fontWeight:
//                                                           FontWeight.w700),
//                                                   children: [
//                                                     TextSpan(
//                                                       children: [],
//                                                       text:
//                                                           'Dear customer, as you have chosen the self-pickup option, please collect your ordered products from the shop.',
//                                                       recognizer:
//                                                           TapGestureRecognizer()
//                                                             ..onTap = () {},
//                                                       style: TextStyle(
//                                                           color: Colors.blue,
//                                                           // letterSpacing: .5,
//                                                           height: 1.5.w,
//                                                           fontSize: 12.sp,
//                                                           fontWeight:
//                                                               FontWeight.w400),
//                                                     ),
//                                                   ]),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                               watch.orderDetails?.orderStatus == "Delivered"
//                                   // ||
//                                   //         watch.orderDetails?.orderStatus ==
//                                   //             "Order Refund"
//                                   ? SizedBox(
//                                       height: 10.h,
//                                     )
//                                   : Container(),
//                               watch.orderDetails?.orderStatus == "Order Refund"
//                                   // ||
//                                   //         watch.orderDetails?.orderStatus ==
//                                   //             "Order Refund"
//                                   ? SizedBox(
//                                       height: 10.h,
//                                     )
//                                   : Container(),
//                               /////////////////////////////////////
//                             watch.orderDetails
//                                   ?.orderStatus ==
//                                   "Order Refund" &&
//                                   watch.orderDetails
//                                       ?.shopCancelledStatus ==
//                                       "YES"?Container():
//                             watch.orderDetails
//                                 ?.orderStatus ==
//                                 "Order Refund" &&
//                                 watch.orderDetails
//                                     ?.customerCancelledStatus ==
//                                     "YES" ?Container():
//                             watch.orderDetails?.orderStatus == "Order Refund"?
//                                    GestureDetector(
//                                       onTap: () {
//                                         read.orderInvoice(
//                                           context,
//                                         );
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.only(
//                                             left: 20.w,
//                                             right: 20.w,
//                                             top: 9.w,
//                                             bottom: 9.w),
//                                         width: ScreenUtil().screenWidth,
//                                         margin: EdgeInsets.only(
//                                           left: 12.w,
//                                           right: 11.w,
//                                           // top: 9.w,
//                                           // bottom: 9.w
//                                         ),
//                                         // height: 50.h,
//                                         decoration: BoxDecoration(
//                                             color: Color(0xff115B7A),
//                                             // border: Border.all(width: 1, color: Black),
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: Text(
//                                           "Invoice",
//                                           textAlign: TextAlign.center,
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Colors.white,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 18.sp,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Container(),
//                               ////////////////New//////////////////////
//                               watch.orderDetails?.orderStatus == "Delivered"
//                                   // ||
//                                   //         watch.orderDetails?.orderStatus ==
//                                   //             "Order Refund"
//                                   ? Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         SizedBox(
//                                           width: 19.w,
//                                         ),
//                                         Expanded(
//                                           child: InkWell(
//                                             onTap: () {
//                                               read.CustomerReorder(
//                                                   context,
//                                                   watch.orderDetails?.id
//                                                       .toString());
//                                             },
//                                             child: Container(
//                                               padding: EdgeInsets.only(
//                                                   left: 12.w,
//                                                   right: 12.w,
//                                                   top: 9.w,
//                                                   bottom: 9.w),
//                                               decoration: BoxDecoration(
//                                                   color: SplashText,
//                                                   borderRadius:
//                                                       BorderRadius.circular(8)),
//                                               child: Text(
//                                                 "Reorder",
//                                                 textAlign: TextAlign.center,
//                                                 style: GoogleFonts.dmSans(
//                                                   textStyle: TextStyle(
//                                                       color: Colors.white,
//                                                       // letterSpacing: .5,
//                                                       fontSize: 18.sp,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 10.w,
//                                         ),
//                                         Expanded(
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               read.orderInvoice(
//                                                 context,
//                                               );
//                                             },
//                                             child: Container(
//                                               padding: EdgeInsets.only(
//                                                   left: 12.w,
//                                                   right: 12.w,
//                                                   top: 9.w,
//                                                   bottom: 9.w),
//                                               // height: 50.h,/
//                                               decoration: BoxDecoration(
//                                                   color: Color(0xff115B7A),
//                                                   // border: Border.all(width: 1, color: Black),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10)),

//                                               child: Text(
//                                                 "Invoice",
//                                                 textAlign: TextAlign.center,
//                                                 style: GoogleFonts.dmSans(
//                                                   textStyle: TextStyle(
//                                                       color: Colors.white,
//                                                       // letterSpacing: .5,
//                                                       fontSize: 18.sp,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 10.w,
//                                         ),
//                                       ],
//                                     )
//                                   : Container(
//                                       height: 20.h,
//                                     ),
//                               watch.orderDetails?.orderStatus == "Dispatched" ||
//                                       watch.orderDetails?.orderStatus ==
//                                           "Delivered"
//                                   ? SizedBox(
//                                       height: 20.h,
//                                     )
//                                   : Container(),
//                               Container(
//                                 padding: EdgeInsets.only(
//                                   left: 19.w,
//                                 ),
//                                 child: Text(
//                                   // maxLines: 3,
//                                   "Expected Delivery Date & Slot",
//                                   // textAlign: TextAlign.start,
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         // height: 1.5,
//                                         color: black,
//                                         // letterSpacing: .05,
//                                         // overflow: TextOverflow.ellipsis,
//                                         fontSize: 15.sp,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 6.h,
//                               ),
//                               Container(
//                                 padding: EdgeInsets.only(left: 19.w),
//                                 child: Text(
//                                   // maxLines: 3,
//                                   "${watch.orderDetails?.deliveryDate}",
//                                   // textAlign: TextAlign.start,
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         // height: 1.5,
//                                         color: SplashText,
//                                         // letterSpacing: .05,
//                                         // overflow: TextOverflow.ellipsis,
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding:
//                                     EdgeInsets.only(left: 19.w, right: 19.w),
//                                 child: Row(
//                                   // crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       watch.orderDetails?.deliverySlot ==
//                                               "shop_owner_slot_9_to_12"
//                                           ? "9:00 AM - 12:00 PM"
//                                           : watch.orderDetails?.deliverySlot ==
//                                                   "shop_owner_slot_12_to_3"
//                                               ? "12:00 PM - 3:00 PM"
//                                               : watch.orderDetails
//                                                           ?.deliverySlot ==
//                                                       "shop_owner_slot_3_to_6"
//                                                   ? "3:00 PM - 6:00 PM"
//                                                   : watch.orderDetails
//                                                               ?.deliverySlot ==
//                                                           "shop_owner_slot_6_to_9"
//                                                       ? "6:00 PM - 9:00 PM"
//                                                       : "",
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: TextStyle(
//                                             color: Black,
//                                             fontSize: 14.sp,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       // height: 30.h,
//                                       width: 100.w,
//                                       child: ElevatedButton(
//                                         style: ButtonStyle(
//                                           elevation:
//                                               MaterialStateProperty.all(0),
//                                           // backgroundColor: ,
//                                           backgroundColor:
//                                               MaterialStateProperty.all(
//                                                   SplashText.withOpacity(0.3)),
//                                           shape: MaterialStateProperty.all(
//                                             RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               side: BorderSide(
//                                                 color: SplashText,
//                                                 // width: 1,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         onPressed: () {
//                                           readMain.onNavigation(
//                                               4,
//                                               OrderStatusView(
//                                                 orderId: watch.orderId,
//                                                 screenName: "orderView",
//                                               ),
//                                               context);
//                                           readMain.showBottomNavigationBar();
//                                           // Navigator.pushAndRemoveUntil(
//                                           //   context,
//                                           //   MaterialPageRoute(
//                                           //       builder: (context) =>
//                                           //           MainScreenView(
//                                           //               index: 4,
//                                           //               screenName: OrderStatusView(
//                                           //                 orderId: watch.orderId,
//                                           //                 screenName: "orderView",
//                                           //               ))),
//                                           //   (Route<dynamic> route) => false,
//                                           // );
//                                           // Navigator.push(
//                                           //     context,
//                                           //     MaterialPageRoute(
//                                           //         builder: (context) => OrderStatusView(
//                                           //               orderId: watch.orderId,
//                                           //             )));
//                                         },
//                                         child: Text(
//                                           "Track Order",
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Black,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 12.sp,
//                                                 fontWeight: FontWeight.w600),
//                                           ),
//                                         ),

//                                         //
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               //////////////
//                               Container(
//                                 padding: EdgeInsets.only(
//                                     left: 19.w, top: 10.w, right: 19.w),
//                                 child: Column(
//                                   // mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Product Details",
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: TextStyle(
//                                             color: Black1,
//                                             // letterSpacing: .5,
//                                             fontSize: 16.sp,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                     ),
//                                     Divider(
//                                       // height: 100,
//                                       color: grey2,
//                                       thickness: 1,
//                                       indent: 0,
//                                       endIndent: 0,
//                                     ),
//                                     OrderProductsListView(),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Sub Total",
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Black1,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                         ),
//                                         Text(
//                                           "\u{20B9} ${watch.orderDetails?.subTotalAmount}",
//                                           //  ${watch.orderFinalTotals?.subTotal}",
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: grey5,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10.w,
//                                     ),
//                                     Divider(
//                                       // height: 100,
//                                       color: grey2,
//                                       thickness: 1,
//                                       indent: 0,
//                                       endIndent: 0,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         RichText(
//                                           text: TextSpan(children: [
//                                             TextSpan(
//                                               text: 'Discount',
//                                               style: GoogleFonts.dmSans(
//                                                 textStyle: TextStyle(
//                                                     color: Black1,
//                                                     // letterSpacing: .5,
//                                                     fontSize: 14.sp,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                             ),
//                                             watch.couponDetails?.couponCode !=
//                                                         "" &&
//                                                     watch.couponDetails
//                                                             ?.couponCode !=
//                                                         null
//                                                 ? TextSpan(
//                                                     text:
//                                                         '  (${watch.couponDetails?.couponCode}) ',
//                                                     style: GoogleFonts.dmSans(
//                                                       textStyle: TextStyle(
//                                                           color: SplashText,
//                                                           // letterSpacing: .5,
//                                                           fontSize: 14.sp,
//                                                           fontWeight:
//                                                               FontWeight.w400),
//                                                     ),
//                                                   )
//                                                 : TextSpan(
//                                                     text: "",
//                                                   ),
//                                           ]),
//                                         ),
//                                         watch.couponDetails?.couponDiscount !=
//                                                 null
//                                             ? Text(
//                                                 // "",
//                                                 // "- Rs . ${watch.orderDetails?.totalDiscount}",
//                                                 " - \u{20B9}  ${watch.couponDetails?.couponDiscount}",
//                                                 style: GoogleFonts.dmSans(
//                                                   textStyle: TextStyle(
//                                                       color: grey5,
//                                                       // letterSpacing: .5,
//                                                       fontSize: 14.sp,
//                                                       fontWeight:
//                                                           FontWeight.w700),
//                                                 ),
//                                               )
//                                             : Text(
//                                                 "- \u{20B9} 0",
//                                                 style: GoogleFonts.dmSans(
//                                                   textStyle: TextStyle(
//                                                       color: grey5,
//                                                       // letterSpacing: .5,
//                                                       fontSize: 14.sp,
//                                                       fontWeight:
//                                                           FontWeight.w700),
//                                                 ),
//                                               ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10.w,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Delivery Charges",
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Black1,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                         ),
//                                         Text(
//                                           watch.orderDetails?.deliveryCharges ==
//                                                   ""
//                                               ? "\u{20B9}0"
//                                               : "\u{20B9}${watch.orderDetails?.deliveryCharges}",
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: grey5,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10.w,
//                                     ),
//                                     Divider(
//                                       // height: 100,
//                                       color: grey2,
//                                       thickness: 1,
//                                       indent: 0,
//                                       endIndent: 0,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           "Total Amount",
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Black1,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 16.sp,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         ),
//                                         Text(
//                                           "\u{20B9} ${watch.orderDetails?.totalAmount} ",
//                                           // ${watch.orderFinalTotals?.total}",
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Black1,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 16.sp,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10.w,
//                                     ),
//                                     Divider(
//                                       // height: 100,
//                                       color: grey2,
//                                       thickness: 1,
//                                       indent: 0,
//                                       endIndent: 0,
//                                     ),
//                                     SizedBox(
//                                       height: 10.w,
//                                     ),
//                                     Container(
//                                       child: Text(
//                                         "You will save \u{20B9} ${watch.orderDetails?.totalDiscount}",
//                                         //  ",
//                                         style: GoogleFonts.dmSans(
//                                           textStyle: TextStyle(
//                                               color: SplashText,
//                                               // letterSpacing: .5,
//                                               fontSize: 18.sp,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               //////////////////
//                               SizedBox(
//                                 height: 10.h,
//                               ),
//                               Container(
//                                 padding: EdgeInsets.only(
//                                   left: 19.w,
//                                 ),
//                                 child: Text(
//                                   "Mode of Payment",
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         color: Black,
//                                         // letterSpacing: .5,
//                                         fontSize: 20.sp,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10.h,
//                               ),
//                               Container(
//                                 padding: EdgeInsets.only(
//                                   left: 19.w,
//                                 ),
//                                 child: Text(
//                                   "${watch.orderDetails?.paymentMode}",
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         color: SplashText,
//                                         // letterSpacing: .5,
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5.h,
//                               ),

//                               watch.orderDetails?.transactionId != ""
//                                   ? SizedBox(
//                                       height: 15.h,
//                                     )
//                                   : Container(),
//                               watch.orderDetails?.transactionId != ""
//                                   ? Container(
//                                       padding: EdgeInsets.only(
//                                         left: 19.w,
//                                       ),
//                                       child: Text(
//                                         "Transaction ID : ${watch.orderDetails?.transactionId}",
//                                         style: GoogleFonts.dmSans(
//                                           textStyle: TextStyle(
//                                               color: Black,
//                                               // letterSpacing: .5,
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                     )
//                                   : Container(),
//                               SizedBox(
//                                 height: 26.h,
//                               ),
//                               /////Product Return Request start////
//                               watch.orderDetails?.orderStatus == "Delivered" &&
//                                       watch.orderData?.orderRefundStatus ==
//                                           false &&
//                                       watch.orderDetails?.returnButtonStatus ==
//                                           "active"
//                                   ?
//                                   // watch
//                                   Container(
//                                       padding: EdgeInsets.only(
//                                           left: 19.w, right: 19.w),
//                                       margin: EdgeInsets.only(bottom: 10.w),
//                                       child: SizedBox(
//                                         // padding: EdgeInsets.only(
//                                         //     left: 91.w, right: 91.w, top: 10.w, bottom: 10.w),
//                                         width: 354.w,
//                                         // <-- Your width
//                                         height: 38.h,
//                                         child: PrimaryButton(
//                                           color: Color(0xffD1D1D1),
//                                           onTap: () {
//                                             readMain.onNavigation(
//                                                 0,
//                                                 CustomerProductReturnView(
//                                                     orderId: watch.orderId
//                                                         .toString()),
//                                                 context);
//                                             // Navigator.push(
//                                             //   context,
//                                             //   MaterialPageRoute(
//                                             //       builder: (context) =>
//                                             //           CustomerProductReturnView(
//                                             //               orderId: watch.orderId
//                                             //                   .toString())),
//                                             // );
//                                           },

//                                           // style: style,

//                                           child: Text(
//                                             'Product Return Request',
//                                             style: GoogleFonts.inter(
//                                               textStyle: TextStyle(
//                                                   color: Colors.white,
//                                                   // letterSpacing: .5,
//                                                   fontSize: 18.sp,
//                                                   fontWeight: FontWeight.w700),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Container(),
//                               watch.orderDetails?.orderStatus == "Delivered" &&
//                                       (watch.orderData
//                                                   ?.orderRefundProductCount ==
//                                               "0" ||
//                                           watch.orderDetails
//                                                   ?.shopDeliveredCustomerPaymentStatus ==
//                                               "received") &&
//                                       watch.orderDetails?.returnButtonStatus ==
//                                           "active"
//                                   ? Container(
//                                       padding: EdgeInsets.only(
//                                           left: 19.w, right: 19.w),
//                                       margin: EdgeInsets.only(bottom: 10.w),
//                                       child: SizedBox(
//                                         // padding: EdgeInsets.only(
//                                         //     left: 91.w, right: 91.w, top: 10.w, bottom: 10.w),
//                                         width: 354.w,
//                                         // <-- Your width
//                                         height: 38.h,
//                                         child: PrimaryButton(
//                                           color: Color(0xffD1D1D1),
//                                           onTap: () {
//                                             readMain.onNavigation(
//                                                 0,
//                                                 CustomerProductReturnView(
//                                                     orderId: watch.orderId
//                                                         .toString()),
//                                                 context);
//                                             // Navigator.push(
//                                             //   context,
//                                             //   MaterialPageRoute(
//                                             //       builder: (context) =>
//                                             //           CustomerProductReturnView(
//                                             //               orderId: watch.orderId
//                                             //                   .toString())),
//                                             // );
//                                           },

//                                           // style: style,

//                                           child: Text(
//                                             'Product Return Request',
//                                             style: GoogleFonts.inter(
//                                               textStyle: TextStyle(
//                                                   color: Colors.white,
//                                                   // letterSpacing: .5,
//                                                   fontSize: 18.sp,
//                                                   fontWeight: FontWeight.w700),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Container(),

//                               /////Product Return Request////
//                               watch.orderDetails?.orderStatus == "Pending"
//                                   ? Container(
//                                       padding: EdgeInsets.only(
//                                           left: 19.w, right: 19.w),
//                                       margin: EdgeInsets.only(bottom: 20.w),
//                                       child: PrimaryButton(
//                                         color: Color(0xffD1D1D1),
//                                         onTap: () {
//                                           showModalBottomSheet(
//                                             backgroundColor: Colors.white,
//                                             isScrollControlled: true,
//                                             shape: const RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.only(
//                                                     topLeft:
//                                                         Radius.circular(30),
//                                                     topRight:
//                                                         Radius.circular(30))),
//                                             context: context,
//                                             builder: (context) {
//                                               return CancelOrderReasonView();
//                                             },
//                                           );
//                                         },
//                                         child: Text(
//                                           'Cancel Order',
//                                           style: GoogleFonts.inter(
//                                             textStyle: TextStyle(
//                                                 color: Colors.white,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 18.sp,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Container(),

//                               // SizedBox(
//                               //   height: 50.h,
//                               // ),
//                               watch.orderDetails?.orderStatus == "Delivered"
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         watch.reviewList?.isEmpty == true
//                                             ? Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Container(
//                                                     padding: EdgeInsets.only(
//                                                         left: 19.w),
//                                                     child: Text(
//                                                       'Your Ratings',
//                                                       style: GoogleFonts.inter(
//                                                         textStyle: TextStyle(
//                                                             // color: SplashTex
//                                                             // letterSpacing: .5,
//                                                             fontSize: 16.sp,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     height: 10.h,
//                                                   ),
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                         left: 19.w),
//                                                     child: StarRating(
//                                                         rating:
//                                                             watch.ratingValue ??
//                                                                 0,
//                                                         onRatingChanged:
//                                                             (rating) {
//                                                           read.onRatingSelect(
//                                                               rating);
//                                                           print(rating);
//                                                         }),
//                                                   ),
//                                                   //                                                             Container(
//                                                   //                               padding: EdgeInsets.only(left: 19.w),
//                                                   //                               child: Row(
//                                                   //                                 children: [
//                                                   //                                   GestureDetector(
//                                                   //                                       onTap: () {
//                                                   //                                         read.onRatingSelect(1);
//                                                   //                                       },
//                                                   //                                       child: SvgPicture.asset(
//                                                   //                                         "assets/icons/order_rating.svg",
//                                                   //                                         color: watch.ratingValue == null
//                                                   //                                             ? Color(0xffDBDBDB)
//                                                   //                                             : Colors.yellow,
//                                                   //                                       )),
//                                                   //                                   SizedBox(
//                                                   //                                     width: 9.77.w,
//                                                   //                                   ),
//                                                   //                                   GestureDetector(
//                                                   //                                       onTap: () {
//                                                   //                                         read.onRatingSelect(2);
//                                                   //                                       },
//                                                   //                                       child: SvgPicture.asset(
//                                                   //                                         "assets/icons/order_rating.svg",
//                                                   //                                         color: watch.ratingValue == 2 &&
//                                                   //                                                 watch.ratingValue == 3 &&
//                                                   //                                                 watch.ratingValue == 4 &&
//                                                   //                                                 watch.ratingValue == 5
//                                                   //                                             ? Colors.yellow
//                                                   //                                             : Color(0xffDBDBDB),
//                                                   //                                       )),
//                                                   //                                   SizedBox(
//                                                   //                                     width: 9.77.w,
//                                                   //                                   ),
//                                                   //                                   GestureDetector(
//                                                   //                                       onTap: () {
//                                                   //                                         read.onRatingSelect(3);
//                                                   //                                       },
//                                                   //                                       child: SvgPicture.asset(
//                                                   //                                           "assets/icons/order_rating.svg", color:
//                                                   //                                           watch.ratingValue == 3 &&
//                                                   //                                           watch.ratingValue == 4 &&
//                                                   //                                           watch.ratingValue == 5
//                                                   //                                           ? Colors.yellow
//                                                   //                                           : Color(0xffDBDBDB),)),
//                                                   //                                   SizedBox(
//                                                   //                                     width: 9.77.w,
//                                                   //                                   ),
//                                                   //                                   GestureDetector(
//                                                   //                                       onTap: () {
//                                                   //                                         read.onRatingSelect(4);
//                                                   //                                       },
//                                                   //                                       child: SvgPicture.asset(
//                                                   //                                           "assets/icons/order_rating.svg", color:
//                                                   // watch.ratingValue == 4 &&
//                                                   // watch.ratingValue == 5
//                                                   // ? Colors.yellow
//                                                   //     : Color(0xffDBDBDB),)),
//                                                   //                                   SizedBox(
//                                                   //                                     width: 9.77.w,
//                                                   //                                   ),
//                                                   //                                   GestureDetector(
//                                                   //                                       onTap: () {
//                                                   //                                         read.onRatingSelect(5);
//                                                   //                                       },
//                                                   //                                       child: SvgPicture.asset(
//                                                   //                                           "assets/icons/order_rating.svg", color:
//                                                   //                                           watch.ratingValue == 5
//                                                   //                                           ? Colors.yellow
//                                                   //                                           : Color(0xffDBDBDB),))
//                                                   //                                 ],
//                                                   //                               ),
//                                                   //                             ),
//                                                   SizedBox(
//                                                     height: 10.h,
//                                                   ),
//                                                   Container(
//                                                     padding: EdgeInsets.only(
//                                                         left: 19.w),
//                                                     child: Text(
//                                                       'Your Feedback',
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                         textStyle: TextStyle(
//                                                             // color: SplashTex
//                                                             // letterSpacing: .5,
//                                                             fontSize: 16.sp,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     height: 10.h,
//                                                   ),
//                                                   Container(
//                                                     padding: EdgeInsets.only(
//                                                         left: 19.w,
//                                                         right: 19.w),
//                                                     child:
//                                                         PrimarySTextFormField(
//                                                       controller: watch
//                                                           .reviewController,
//                                                       height: 108.w,
//                                                       maxLines: 5,
//                                                       hintText: "",
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     height: 19.w,
//                                                   ),
//                                                   Container(
//                                                     padding: EdgeInsets.only(
//                                                         left: 19.w,
//                                                         right: 19.w),
//                                                     child: SizedBox(
//                                                       width: 343
//                                                           .w, // <-- Your width
//                                                       height: 45.h,
//                                                       child: ElevatedButton(
//                                                         style: ElevatedButton
//                                                             .styleFrom(
//                                                           primary:
//                                                               Color(0xff39C19D),
//                                                           // onPrimary: Colors.white,
//                                                           // shadowColor: Colors.greenAccent,
//                                                           elevation: 3,
//                                                           shape: RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           14.0)),
//                                                           minimumSize: const Size(
//                                                               100,
//                                                               40), //////// HERE
//                                                         ),
//                                                         // style: style,
//                                                         onPressed: () {
//                                                           read.shopSubmitreview(
//                                                               context);
//                                                         },
//                                                         child: Text(
//                                                           'Submit',
//                                                           style: GoogleFonts
//                                                               .dmSans(
//                                                             textStyle:
//                                                                 TextStyle(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     // letterSpacing: .5,
//                                                                     fontSize:
//                                                                         20.sp,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w700),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             : Container(),
//                                         SizedBox(
//                                           height: 19.h,
//                                         ),
//                                         ListView.builder(
//                                             physics:
//                                                 NeverScrollableScrollPhysics(),
//                                             shrinkWrap: true,
//                                             itemCount:
//                                                 watch.reviewList?.length ?? 0,
//                                             itemBuilder: (context, index) {
//                                               final element =
//                                                   watch.reviewList?[index];
//                                               return Container(
//                                                 padding: EdgeInsets.only(
//                                                     left: 19.w,
//                                                     bottom: 11.w,
//                                                     right: 13.w,
//                                                     top: 10.w),
//                                                 margin: EdgeInsets.only(
//                                                   left: 19.w,
//                                                   bottom: 11.w,
//                                                   right: 19.w,
//                                                 ),
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                     color: grey6,
//                                                     width: 1,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(12),
//                                                 ),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         element?.customerProfileImagePath ==
//                                                                 ""
//                                                             ? Container(
//                                                                 width: 50.0,
//                                                                 height: 50.0,
//                                                                 decoration:
//                                                                     BoxDecoration(
//                                                                   shape: BoxShape
//                                                                       .circle,
//                                                                   image:
//                                                                       DecorationImage(
//                                                                     fit: BoxFit
//                                                                         .cover,
//                                                                     image: AssetImage(
//                                                                         'assets/images/nearshop2.png'),
//                                                                   ),
//                                                                 ),
//                                                               )
//                                                             : Container(
//                                                                 width: 50.0,
//                                                                 height: 50.0,
//                                                                 decoration:
//                                                                     BoxDecoration(
//                                                                   shape: BoxShape
//                                                                       .circle,
//                                                                   image: DecorationImage(
//                                                                       fit: BoxFit
//                                                                           .cover,
//                                                                       image: CachedNetworkImageProvider(
//                                                                           element?.customerProfileImagePath ??
//                                                                               "")),
//                                                                 ),
//                                                               ),
//                                                         Expanded(
//                                                           child: Column(
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                             children: [
//                                                               Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .spaceBetween,
//                                                                 children: [
//                                                                   Container(
//                                                                     margin: EdgeInsets
//                                                                         .only(
//                                                                             left:
//                                                                                 10),
//                                                                     child: Text(
//                                                                       "${element?.customerName}",
//                                                                       style: GoogleFonts
//                                                                           .dmSans(
//                                                                         textStyle: TextStyle(
//                                                                             color:
//                                                                                 Black,
//                                                                             fontSize:
//                                                                                 14.sp,
//                                                                             fontWeight: FontWeight.w400),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Text(
//                                                                     "${element?.createdAt}",
//                                                                     style: GoogleFonts
//                                                                         .dmSans(
//                                                                       textStyle: TextStyle(
//                                                                           color:
//                                                                               Black,
//                                                                           fontSize: 14
//                                                                               .sp,
//                                                                           fontWeight:
//                                                                               FontWeight.w400),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(
//                                                                 height: 8.h,
//                                                               ),
//                                                               Container(
//                                                                   padding: EdgeInsets
//                                                                       .only(
//                                                                           left: 10
//                                                                               .w),
//                                                                   child: element
//                                                                               ?.ratings ==
//                                                                           5
//                                                                       ? Row(
//                                                                           children: [
//                                                                             SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                             SizedBox(
//                                                                               width: 6.w,
//                                                                             ),
//                                                                             SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                             SizedBox(
//                                                                               width: 6.w,
//                                                                             ),
//                                                                             SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                             SizedBox(
//                                                                               width: 6.w,
//                                                                             ),
//                                                                             SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                             SizedBox(
//                                                                               width: 6.w,
//                                                                             ),
//                                                                             SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                           ],
//                                                                         )
//                                                                       : element?.ratings ==
//                                                                               4
//                                                                           ? Row(
//                                                                               children: [
//                                                                                 SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                                 SizedBox(
//                                                                                   width: 6.w,
//                                                                                 ),
//                                                                                 SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                                 SizedBox(
//                                                                                   width: 6.w,
//                                                                                 ),
//                                                                                 SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                                 SizedBox(
//                                                                                   width: 6.w,
//                                                                                 ),
//                                                                                 SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                               ],
//                                                                             )
//                                                                           : element?.ratings == 3
//                                                                               ? Row(
//                                                                                   children: [
//                                                                                     SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                                     SizedBox(
//                                                                                       width: 6.w,
//                                                                                     ),
//                                                                                     SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                                     SizedBox(
//                                                                                       width: 6.w,
//                                                                                     ),
//                                                                                     SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                                   ],
//                                                                                 )
//                                                                               : element?.ratings == 2
//                                                                                   ? Row(
//                                                                                       children: [
//                                                                                         SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                                         SizedBox(
//                                                                                           width: 6.w,
//                                                                                         ),
//                                                                                         SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                                       ],
//                                                                                     )
//                                                                                   : element?.ratings == 1
//                                                                                       ? Row(
//                                                                                           children: [
//                                                                                             SvgPicture.asset("assets/icons/yellow_stars.svg"),
//                                                                                           ],
//                                                                                         )
//                                                                                       : Container()),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     Divider(
//                                                       color: gradient,
//                                                       thickness: 1,
//                                                     ),
//                                                     Text(
//                                                       "${element?.review}",
//                                                       // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet.',
//                                                       style: GoogleFonts.dmSans(
//                                                         textStyle: TextStyle(
//                                                             color: Black,
//                                                             fontSize: 14.sp,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               );
//                                             }),
//                                       ],
//                                     )
//                                   : Container(),
//                               watch.orderDetails?.orderStatus == "Order Refund"
//                                   ? Container(
//                                       margin: EdgeInsets.only(bottom: 5.w),
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 17.w),
//                                       color: watch.orderDetails
//                                                   ?.refundOrderStatus ==
//                                               "reject"
//                                           ? Color(0xffFFE8E8)
//                                           : Color(0xffEFFDFF),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             height: 15.w,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Refund Request sent",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w700,
//                                                     color: Colors.black,
//                                                     fontSize: 18.sp),
//                                               ),
//                                               Container(
//                                                 height: 22.w,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5.w),
//                                                     border: Border.all(
//                                                         // color: Color(0xff115B7A)
//                                                         color: watch.orderDetails
//                                                                     ?.refundPaymentStatus ==
//                                                                 "received"
//                                                             ? Colors.green
//                                                             : watch.orderDetails
//                                                                         ?.refundOrderStatus ==
//                                                                     "reject"
//                                                                 ? Colors.red
//                                                                 : Color(
//                                                                     0xff115B7A))),
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 12.w),
//                                                 child: Center(
//                                                     child: Text(
//                                                   watch.orderDetails
//                                                               ?.refundOrderStatus ==
//                                                           "pending"
//                                                       ? "Payment Pending"
//                                                       : watch.orderDetails
//                                                                   ?.refundOrderStatus ==
//                                                               "reject"
//                                                           ? "Return Rejected"
//                                                           : watch.orderDetails
//                                                                           ?.refundOrderStatus ==
//                                                                       "accept" &&
//                                                                   watch.orderDetails
//                                                                           ?.refundPaymentStatus ==
//                                                                       "not_received"
//                                                               ? "Shop Refunded"
//                                                               : "Payment Received",
//                                                   style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color: watch.orderDetails
//                                                                   ?.refundPaymentStatus ==
//                                                               "received"
//                                                           ? Colors.green
//                                                           : watch.orderDetails
//                                                                       ?.refundOrderStatus ==
//                                                                   "reject"
//                                                               ? Colors.red
//                                                               : Color(
//                                                                   0xff115B7A)),
//                                                 )),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 13.w,
//                                           ),
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     "${watch.orderDetails?.refundProductCount} Products",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         fontSize: 18.sp),
//                                                   ),
//                                                   Text( "\u{20B9} ${watch.orderDetails?.customerRefundAmount}",style: TextStyle(
//                                                       fontWeight:
//                                                       FontWeight.w700,
//                                                       fontSize: 18.sp),),
//                                                   SizedBox(
//                                                     height: 19.w,
//                                                   ),
//                                                   watch.orderDetails
//                                                               ?.refundOrderStatus ==
//                                                           "reject"
//                                                       ? Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(
//                                                                 "Shop Owner Reject Reason",
//                                                                 style: TextStyle(
//                                                                     fontSize:
//                                                                         14.sp,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w700)),
//                                                             SizedBox(
//                                                               height: 2.w,
//                                                             ),
//                                                             Text(
//                                                               "${watch.orderDetails?.shopOwnerRefundRejectReason}",
//                                                               style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontSize: 14.sp,
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         )
//                                                       : Text(
//                                                           watch.orderDetails
//                                                                       ?.refundOrderStatus ==
//                                                                   "pending"
//                                                               ? "\u{20B9} ${watch.orderDetails?.customerRefundAmount}"
//                                                               : watch.orderDetails
//                                                                           ?.refundOrderStatus ==
//                                                                       "accept"
//                                                                   ? "\u{20B9} ${watch.orderDetails?.shopOwnerRefundPayableAmount}"
//                                                                   : "",
//                                                           style: TextStyle(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700,
//                                                               fontSize: 18.sp),
//                                                         ),
//                                                 ],
//                                               ),
//                                               watch.orderDetails
//                                                               ?.refundOrderStatus ==
//                                                           "accept" &&
//                                                       watch.orderDetails
//                                                               ?.refundPaymentStatus ==
//                                                           "received"
//                                                   ? Column(
//                                                       children: [
//                                                         Text(watch.orderDetails
//                                                                 ?.refundDatetime ??
//                                                             ""),
//                                                         SizedBox(
//                                                           height: 8.w,
//                                                         ),
//                                                         watch.orderDetails
//                                                                     ?.shopOwnerRefundTransactionId !=
//                                                                 ""
//                                                             ? Text(
//                                                                 "Transaction ID : ${watch.orderDetails?.shopOwnerRefundTransactionId}",
//                                                                 style: TextStyle(
//                                                                     fontSize:
//                                                                         14.sp,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     color:
//                                                                         Black1),
//                                                               )
//                                                             : Container()
//                                                       ],
//                                                     )
//                                                   : Container(),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 15.w,
//                                           ),

//                                           Text("Reason",
//                                               style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w700)),
//                                           SizedBox(
//                                             height: 5.w,
//                                           ),
//                                           // Text(
//                                           //   "${watch.orderDetails?.reason}",
//                                           //   style: TextStyle(
//                                           //     fontWeight: FontWeight.w400,
//                                           //     fontSize: 14.sp,
//                                           //   ),
//                                           // ),
//                                           watch.orderDetails
//                                                           ?.customerCancelledReason !=
//                                                       "" ||
//                                                   watch.orderDetails
//                                                           ?.shopOwnerCancelledReason !=
//                                                       ""
//                                               ? Text(
//                                                   watch.orderDetails
//                                                               ?.customerCancelledReason ==
//                                                           ""
//                                                       ? watch.orderDetails
//                                                               ?.shopOwnerCancelledReason
//                                                               .toString() ??
//                                                           ""
//                                                       : watch.orderDetails
//                                                               ?.customerCancelledReason
//                                                               .toString() ??
//                                                           "",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       fontSize: 16.sp),
//                                                 )
//                                               : Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(
//                                                       "${watch.orderDetails?.reason}",
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w400,
//                                                         fontSize: 14.sp,
//                                                       ),
//                                                     ),
//                                                     Text(
//                                                       "${watch.orderDetails?.customerRefundReason}",
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w400,
//                                                         fontSize: 14.sp,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                           SizedBox(
//                                             height: 10.w,
//                                           ),
//                                           watch.orderDetails
//                                                           ?.refundPaymentStatus ==
//                                                       "not_received" &&
//                                                   watch.orderDetails
//                                                           ?.refundOrderStatus ==
//                                                       "accept"
//                                               ? Row(
//                                                   children: [
//                                                     Expanded(
//                                                         child: PrimaryButton(
//                                                       color: Color(0xff39C19D),
//                                                       onTap: () {
//                                                         read.updateRefundStatus(
//                                                             "received",
//                                                             context);
//                                                       },
//                                                       text: "Yes Received",
//                                                     )),
//                                                     SizedBox(width: 12.w),
//                                                     Expanded(
//                                                         child: PrimaryButton(
//                                                       color: Color(0xffFF6258),
//                                                       onTap: () {
//                                                         read.updateRefundStatus(
//                                                             "not_received",
//                                                             context);
//                                                       },
//                                                       text: "Not Received",
//                                                     )),
//                                                   ],
//                                                 )
//                                               : Container(),
//                                           watch.orderDetails
//                                                           ?.refundPaymentStatus ==
//                                                       "not_received" &&
//                                                   watch.orderDetails
//                                                           ?.refundOrderStatus ==
//                                                       "accept"
//                                               ? SizedBox(
//                                                   height: 31.w,
//                                                 )
//                                               : Container(),
//                                           Text(
//                                             "Note",
//                                             style: TextStyle(
//                                                 fontSize: 16.sp,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                           SizedBox(
//                                             height: 5.w,
//                                           ),
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(width: 3.w),
//                                               Container(
//                                                 margin:
//                                                     EdgeInsets.only(top: 5.w),
//                                                 height: 4.w,
//                                                 width: 4.w,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.black,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 7.w,
//                                               ),
//                                               Flexible(
//                                                   child: Text(
//                                                 "Please collect your refund amount from the shop owner",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 14.sp),
//                                               )),
//                                             ],
//                                           ),
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(width: 3.w),
//                                               Container(
//                                                 margin:
//                                                     EdgeInsets.only(top: 6.w),
//                                                 height: 4.w,
//                                                 width: 4.w,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.black,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 7.w,
//                                               ),
//                                               Flexible(
//                                                   child: Text(
//                                                 "On receipt of refund amount, please provide acknowledgement.",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 14.sp),
//                                               )),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 35.w,
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   : Container(),

//                               watch.orderDetails?.orderStatus == "Cancelled"
//                                   // &&
//                                   //  watch.orderDetails?.customerCancelledReason!=""
//                                   //   watch.orderDetails?.shopOwnerCancelledReason != ""
//                                   ? Container(
//                                       padding: EdgeInsets.only(
//                                           left: 15.w, top: 11.w, bottom: 45.w),
//                                       // height: ScreenUtil().screenHeight,
//                                       width: ScreenUtil().screenWidth,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xffFFE8E8)),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Order Cancelled",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 18.sp),
//                                           ),
//                                           SizedBox(
//                                             height: 15.w,
//                                           ),
//                                           Text(
//                                             "Reason",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 16.sp),
//                                           ),
//                                           SizedBox(
//                                             height: 5.w,
//                                           ),
//                                           Text(
//                                             watch.orderDetails
//                                                         ?.customerCancelledReason ==
//                                                     ""
//                                                 ? watch.orderDetails
//                                                         ?.shopOwnerCancelledReason
//                                                         .toString() ??
//                                                     ""
//                                                 : watch.orderDetails
//                                                         ?.customerCancelledReason
//                                                         .toString() ??
//                                                     "",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 16.sp),
//                                           ),
//                                         ],
//                                       )

//                                       // Text(watch.orderDetails
//                                       //         ?.shopOwnerCancelledReason
//                                       //         .toString() ??
//                                       //     "0"),
//                                       )
//                                   : Container(),
//                               watch.orderDetails?.shopDeliveredRefundStatus ==
//                                           "YES" &&
//                                       watch.orderData?.orderRefundStatus == true
//                                   ? Container(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 17.w),
//                                       color: watch.orderDetails
//                                                       ?.shopDeliveredRefundStatus ==
//                                                   "YES" &&
//                                               watch.orderDetails
//                                                       ?.shopDeliveredCustomerPaymentStatus ==
//                                                   "received"
//                                           ? Color(0xffEFFDFF)
//                                           : watch.orderDetails
//                                                       ?.refundOrderStatus ==
//                                                   "reject"
//                                               ? Color(0xffFFE8E8)
//                                               : Color(0xffEFFDFF),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                             height: 15.w,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "Refund Amount",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w700,
//                                                     color: Colors.black,
//                                                     fontSize: 18.sp),
//                                               ),
//                                               Container(
//                                                 height: 22.w,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5.w),
//                                                     border: Border.all(
//                                                         // color: Color(0xff115B7A)
//                                                         color: watch.orderDetails
//                                                                     ?.shopDeliveredCustomerPaymentStatus ==
//                                                                 "received"
//                                                             ? Colors.green
//                                                             : Color(
//                                                                 0xff115B7A))),
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 12.w),
//                                                 child: Center(
//                                                     child: Text(
//                                                   watch.orderDetails
//                                                                   ?.shopDeliveredRefundStatus ==
//                                                               "YES" &&
//                                                           watch.orderDetails
//                                                                   ?.shopDeliveredCustomerPaymentStatus ==
//                                                               "not_received"
//                                                       ? "Shop Refunded"
//                                                       : watch.orderDetails
//                                                                       ?.shopDeliveredRefundStatus ==
//                                                                   "YES" &&
//                                                               watch.orderDetails
//                                                                       ?.shopDeliveredCustomerPaymentStatus ==
//                                                                   "received"
//                                                           ? "Payment Received"
//                                                           : "Payment Not Recieved",
//                                                   style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color: watch.orderDetails
//                                                                   ?.shopDeliveredCustomerPaymentStatus ==
//                                                               "received"
//                                                           ? Colors.green
//                                                           : Color(0xff115B7A)),
//                                                 )),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 13.w,
//                                           ),
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     "${watch.orderData?.orderRefundProductCount} Products",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         fontSize: 18.sp),
//                                                   ),
//                                                   SizedBox(
//                                                     height: 19.w,
//                                                   ),
//                                                   Text(
//                                                     "INR ${watch.orderDetails?.shopDeliveredPayableAmount ?? "0"}",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         fontSize: 18.sp),
//                                                   ),
//                                                 ],
//                                               ),
//                                               watch.orderDetails
//                                                               ?.shopDeliveredRefundStatus ==
//                                                           "YES" &&
//                                                       watch.orderDetails
//                                                               ?.shopDeliveredCustomerPaymentStatus ==
//                                                           "received"
//                                                   ? Column(
//                                                       children: [
//                                                         Text(watch.orderDetails
//                                                                 ?.refundDatetime ??
//                                                             ""),
//                                                         SizedBox(
//                                                           height: 8.w,
//                                                         ),
//                                                         Text(
//                                                           "Transaction ID : ${watch.orderDetails?.shopDeliveredTransactionId}",
//                                                           style: TextStyle(
//                                                               fontSize: 14.sp,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               color: Black1),
//                                                         )
//                                                       ],
//                                                     )
//                                                   : Container(),
//                                             ],
//                                           ),
//                                           watch.orderDetails
//                                                           ?.shopDeliveredRefundStatus ==
//                                                       "YES" &&
//                                                   watch.orderDetails
//                                                           ?.shopDeliveredCustomerPaymentStatus !=
//                                                       "received"
//                                               ? SizedBox(
//                                                   height: 31.w,
//                                                 )
//                                               : Container(),
//                                           watch.orderDetails
//                                                           ?.shopDeliveredRefundStatus ==
//                                                       "YES" &&
//                                                   watch.orderDetails
//                                                           ?.shopDeliveredCustomerPaymentStatus !=
//                                                       "received"
//                                               ? Row(
//                                                   children: [
//                                                     Expanded(
//                                                         child: PrimaryButton(
//                                                       color: Color(0xff39C19D),
//                                                       onTap: () {
//                                                         read.updateDeliveredRefundStatus(
//                                                             "received",
//                                                             context);
//                                                       },
//                                                       text: "Yes Received",
//                                                     )),
//                                                     SizedBox(width: 12.w),
//                                                     Expanded(
//                                                         child: PrimaryButton(
//                                                       color: Color(0xffFF6258),
//                                                       onTap: () {
//                                                         read.updateDeliveredRefundStatus(
//                                                             "not_received",
//                                                             context);
//                                                       },
//                                                       text: "Not Received",
//                                                     )),
//                                                   ],
//                                                 )
//                                               : Container(),
//                                           SizedBox(
//                                             height: 31.w,
//                                           ),
//                                           Text(
//                                             "Note",
//                                             style: TextStyle(
//                                                 fontSize: 16.sp,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                           SizedBox(
//                                             height: 5.w,
//                                           ),
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(width: 3.w),
//                                               Container(
//                                                 margin:
//                                                     EdgeInsets.only(top: 5.w),
//                                                 height: 4.w,
//                                                 width: 4.w,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.black,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 7.w,
//                                               ),
//                                               Flexible(
//                                                   child: Text(
//                                                 "Please collect your refund amount from the shop owner",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 14.sp),
//                                               )),
//                                             ],
//                                           ),
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(width: 3.w),
//                                               Container(
//                                                 margin:
//                                                     EdgeInsets.only(top: 6.w),
//                                                 height: 4.w,
//                                                 width: 4.w,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.black,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 7.w,
//                                               ),
//                                               Flexible(
//                                                   child: Text(
//                                                 "On receipt of refund amount, please provide acknowledgement.",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 14.sp),
//                                               )),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 35.w,
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   : watch.orderDetails
//                                                   ?.shopDeliveredRefundStatus ==
//                                               "NO" &&
//                                           watch.orderData
//                                                   ?.orderRefundProductCount !=
//                                               "0" &&
//                                           watch.orderData?.orderRefundStatus ==
//                                               true
//                                       ? Container(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 17.w),
//                                           color: watch.orderDetails
//                                                       ?.refundOrderStatus ==
//                                                   "reject"
//                                               ? Color(0xffFFE8E8)
//                                               : Color(0xffEFFDFF),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(
//                                                 height: 15.w,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Refund Amount",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w700,
//                                                         color: Colors.black,
//                                                         fontSize: 18.sp),
//                                                   ),
//                                                   Container(
//                                                     height: 22.w,
//                                                     decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(5.w),
//                                                         border: Border.all(
//                                                             // color: Color(0xff115B7A)
//                                                             color: watch.orderDetails
//                                                                         ?.shopDeliveredCustomerPaymentStatus ==
//                                                                     "received"
//                                                                 ? Colors.green
//                                                                 : Color(
//                                                                     0xff115B7A))),
//                                                     padding:
//                                                         EdgeInsets.symmetric(
//                                                             horizontal: 12.w),
//                                                     child: Center(
//                                                         child: Text(
//                                                       watch.orderDetails
//                                                                       ?.shopDeliveredRefundStatus ==
//                                                                   "YES" &&
//                                                               watch.orderDetails
//                                                                       ?.shopDeliveredCustomerPaymentStatus ==
//                                                                   "not_received"
//                                                           ? "Shop Refunded"
//                                                           : watch.orderDetails
//                                                                           ?.shopDeliveredRefundStatus ==
//                                                                       "YES" &&
//                                                                   watch.orderDetails
//                                                                           ?.shopDeliveredCustomerPaymentStatus ==
//                                                                       "received"
//                                                               ? "Payment Received"
//                                                               : "Payment Not Recieved",
//                                                       style: TextStyle(
//                                                           fontSize: 12.sp,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           color: watch.orderDetails
//                                                                       ?.shopDeliveredCustomerPaymentStatus ==
//                                                                   "received"
//                                                               ? Colors.green
//                                                               : Color(
//                                                                   0xff115B7A)),
//                                                     )),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 13.w,
//                                               ),
//                                               Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         "${watch.orderData?.orderRefundProductCount} Products",
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.w700,
//                                                             fontSize: 18.sp),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 19.w,
//                                                       ),
//                                                       Text(
//                                                         "INR ${watch.orderData?.orderRefundAmount ?? "0"}",
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.w700,
//                                                             fontSize: 18.sp),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   watch.orderDetails
//                                                                   ?.shopDeliveredRefundStatus ==
//                                                               "YES" &&
//                                                           watch.orderDetails
//                                                                   ?.shopDeliveredCustomerPaymentStatus ==
//                                                               "received"
//                                                       ? Column(
//                                                           children: [
//                                                             Text(watch
//                                                                     .orderDetails
//                                                                     ?.refundDatetime ??
//                                                                 ""),
//                                                             SizedBox(
//                                                               height: 8.w,
//                                                             ),
//                                                             Text(
//                                                               "Transaction ID : ${watch.orderDetails?.shopDeliveredTransactionId}",
//                                                               style: TextStyle(
//                                                                   fontSize:
//                                                                       14.sp,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   color:
//                                                                       Black1),
//                                                             )
//                                                           ],
//                                                         )
//                                                       : Container(),
//                                                 ],
//                                               ),
//                                               watch.orderDetails
//                                                           ?.shopDeliveredRefundStatus ==
//                                                       "YES"
//                                                   ? SizedBox(
//                                                       height: 31.w,
//                                                     )
//                                                   : Container(),
//                                               watch.orderDetails
//                                                               ?.shopDeliveredRefundStatus ==
//                                                           "YES" &&
//                                                       watch.orderDetails
//                                                               ?.shopDeliveredCustomerPaymentStatus !=
//                                                           "received"
//                                                   ? Row(
//                                                       children: [
//                                                         Expanded(
//                                                             child:
//                                                                 PrimaryButton(
//                                                           color:
//                                                               Color(0xff39C19D),
//                                                           onTap: () {
//                                                             read.updateDeliveredRefundStatus(
//                                                                 "received",
//                                                                 context);
//                                                           },
//                                                           text: "Yes Received",
//                                                         )),
//                                                         SizedBox(width: 12.w),
//                                                         Expanded(
//                                                             child:
//                                                                 PrimaryButton(
//                                                           color:
//                                                               Color(0xffFF6258),
//                                                           onTap: () {
//                                                             read.updateDeliveredRefundStatus(
//                                                                 "not_received",
//                                                                 context);
//                                                           },
//                                                           text: "Not Received",
//                                                         )),
//                                                       ],
//                                                     )
//                                                   : Container(),
//                                               SizedBox(
//                                                 height: 31.w,
//                                               ),
//                                               Text(
//                                                 "Note",
//                                                 style: TextStyle(
//                                                     fontSize: 16.sp,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
//                                               SizedBox(
//                                                 height: 5.w,
//                                               ),
//                                               Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   SizedBox(width: 3.w),
//                                                   Container(
//                                                     margin: EdgeInsets.only(
//                                                         top: 5.w),
//                                                     height: 4.w,
//                                                     width: 4.w,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black,
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 7.w,
//                                                   ),
//                                                   Flexible(
//                                                       child: Text(
//                                                     "Please collect your refund amount from the shop owner",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w400,
//                                                         fontSize: 14.sp),
//                                                   )),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   SizedBox(width: 3.w),
//                                                   Container(
//                                                     margin: EdgeInsets.only(
//                                                         top: 6.w),
//                                                     height: 4.w,
//                                                     width: 4.w,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.black,
//                                                       shape: BoxShape.circle,
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 7.w,
//                                                   ),
//                                                   Flexible(
//                                                       child: Text(
//                                                     "On receipt of refund amount, please provide acknowledgement.",
//                                                     style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.w400,
//                                                         fontSize: 14.sp),
//                                                   )),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 35.w,
//                                               ),
//                                             ],
//                                           ),
//                                         )
//                                       : Container()
//                             ])),
//                 // onRefresh: () {
//                 //   return Future.delayed(Duration(seconds: 1), () {
//                 //     watch.customerOrderView(context, widget.orderId);
//                 //   });
//                 // }
//                 // ),
//               ));
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/delivery_view/controller/customer_order_view_controller.dart';
import 'package:local_supper_market/screen/customer/delivery_view/view/cancel_order_view_bottom_sheet.dart';
import 'package:local_supper_market/screen/customer/delivery_view/view/order_product_list_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
import 'package:local_supper_market/screen/customer/notifications/view/notification_view.dart';
import 'package:local_supper_market/screen/customer/order_status/view/order_status_view.dart';
import 'package:local_supper_market/screen/customer/return/view/return_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/rating.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class OrderDeliveryView extends StatefulWidget {
  final String? orderId;
  final bool? isRefresh;
  final String? screenName;

  const OrderDeliveryView({
    super.key,
    this.orderId,
    this.isRefresh,
    required this.screenName,
  });

  @override
  State<OrderDeliveryView> createState() => _OrderDeliveryViewState();
}

class _OrderDeliveryViewState extends State<OrderDeliveryView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerOrderViewController>().initState(
            context,
            widget.orderId.toString(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CustomerOrderViewController>();
    final read = context.read<CustomerOrderViewController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            // onBackBtnPressed: () {
            //   Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             MainScreenView(index: 4, screenName: MyOrderView())),
            //     (Route<dynamic> route) => false,
            //   );

            //   // Navigator.pushAndRemoveUntil(
            //   //   context,
            //   //   MaterialPageRoute(builder: (context) => MyOrderView()),
            //   //   (Route<dynamic> route) => false,
            //   // );
            //   // Navigator.pop(context);
            // },
            onBackBtnPressed: () {
              widget.screenName == "notification"
                  ? readMain.onNavigation(
                      4,
                      CustomerNotificationsScreenView(
                        isRefresh: false,
                      ),
                      context)
                  : readMain.onNavigation(4, MyOrderView(), context);
              readMain.showBottomNavigationBar();
            },
            title: "Order",
          ),
        ),
        body: watch.isLoading
            ? Loader()
            : WillPopScope(
                onWillPop: () async {
                  widget.screenName == "notification"
                      ? readMain.onNavigation(
                          4,
                          CustomerNotificationsScreenView(
                            isRefresh: false,
                          ),
                          context)
                      : readMain.onNavigation(4, MyOrderView(), context);
                  readMain.showBottomNavigationBar();
                  return false;
                },
                child:
                    // RefreshIndicator(

                    // child:
                    SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  readMain.onNavigation(
                                      1,
                                      ShopProfileView(
                                        refreshPage: true,
                                        routeName: '',
                                        shopId:
                                            watch.shopDetails?.id.toString(),
                                      ),
                                      context);
                                  readMain.showBottomNavigationBar();
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
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                      // "",
                                                      "${watch.shopDetails?.shopAddress}\n${watch.shopDetails?.cityName} - ${watch.shopDetails?.shopPincode}",
                                                      // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Black,
                                                            letterSpacing: .5,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
                                            //         read.launchPhone(
                                            //             watch.shopDetails
                                            //                     ?.shopOwnerSupportNumber ??
                                            //                 "",
                                            //             context);
                                            //       },
                                            //       child: Container(
                                            //           padding: EdgeInsets.only(
                                            //               left: 11.w,
                                            //               right: 11.w,
                                            //               top: 13.w,
                                            //               bottom: 13.w),
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
                                            //         watch.favAllShop
                                            //             ? read.removeAllShopFavList(
                                            //                 context,
                                            //                 watch.shopDetails?.id)
                                            //             : read.updateAllShopFavList(
                                            //                 context,
                                            //                 watch.shopDetails?.id);
                                            //       },
                                            //       child: Container(
                                            //         padding: EdgeInsets.only(
                                            //             left: 13.w,
                                            //             right: 13.w,
                                            //             top: 14.w,
                                            //             bottom: 14.w),
                                            //         decoration: const BoxDecoration(
                                            //           shape: BoxShape.circle,
                                            //           color: Color(0xff4689EC),
                                            //         ),
                                            //         child: watch.favAllShop
                                            //             ? SvgPicture.asset(
                                            //                 "assets/icons/fav_selected.svg",
                                            //                 width: 26.w,
                                            //                 height: 14.h,
                                            //               )
                                            //             : SvgPicture.asset(
                                            //                 "assets/images/favorite.svg",
                                            //                 width: 26.w,
                                            //                 height: 14.h,
                                            //               ),
                                            //       ),
                                            //     )
                                            //   ],
                                            // ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    read.launchPhone(
                                                        watch.shopDetails
                                                                ?.shopOwnerSupportNumber ??
                                                            "",
                                                        context);
                                                  },
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 13.w,
                                                          right: 13.w,
                                                          top: 14.w,
                                                          bottom: 14.w),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xff23AA49),
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
                                                // InkWell(
                                                //   onTap: () {
                                                //     watch.favAllShop
                                                //         ? read.removeAllShopFavList(
                                                //             context,
                                                //             watch.shopDetails?.id)
                                                //         : read.updateAllShopFavList(
                                                //             context,
                                                //             watch.shopDetails?.id);
                                                //   },
                                                //   child: Container(
                                                //     padding: EdgeInsets.only(
                                                //         left: 13.w,
                                                //         right: 13.w,
                                                //         top: 14.w,
                                                //         bottom: 14.w),
                                                //     decoration: BoxDecoration(
                                                //       shape: BoxShape.circle,
                                                //       color: Color(0xff4689EC),
                                                //     ),
                                                //     child: watch.favAllShop
                                                //         ? SvgPicture.asset(
                                                //             "assets/icons/fav_selected.svg",
                                                //             width: 26.w,
                                                //             height: 14.h,
                                                //           )
                                                //         : SvgPicture.asset(
                                                //             "assets/images/favorite.svg",
                                                //             width: 26.w,
                                                //             height: 14.h,
                                                //           ),
                                                //   ),
                                                // )
                                                InkWell(
                                                  onTap: () {
                                                    watch.favAllShop
                                                        ? read
                                                            .removeAllShopFavList(
                                                                context,
                                                                watch
                                                                    .shopDetails
                                                                    ?.id)
                                                        : read
                                                            .updateAllShopFavList(
                                                                context,
                                                                watch
                                                                    .shopDetails
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
                              ),
                              SizedBox(
                                height: 17.h,
                              ),
                              Divider(thickness: 1, color: grey2),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: 19.w, right: 17.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order ID: ${watch.orderDetails?.orderUniqueId}",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            letterSpacing: .5,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    // watch.orderDetails.
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
                                                color: watch.orderDetails
                                                            ?.orderStatus ==
                                                        "Pending"
                                                    ? Yellow
                                                    : watch.orderDetails
                                                                ?.orderStatus ==
                                                            "Delivered"
                                                        ? Color(0xff39C19D)
                                                        : watch.orderDetails
                                                                    ?.orderStatus ==
                                                                "Confirmed"
                                                            ? Color(0xff115B7A)
                                                            : watch.orderDetails
                                                                        ?.orderStatus ==
                                                                    "Cancelled"
                                                                ? Colors.red
                                                                : watch.orderDetails
                                                                            ?.orderStatus ==
                                                                        "Dispatched"
                                                                    ? Colors
                                                                        .orange
                                                                    : watch.orderDetails?.orderStatus ==
                                                                            "Packing"
                                                                        ? Colors
                                                                            .brown
                                                                        : watch.orderDetails?.orderStatus == "Order Refund" &&
                                                                                watch.orderDetails?.customerCancelledStatus == "YES"
                                                                            ? Colors.red
                                                                            : watch.orderDetails?.orderStatus == "Order Refund" && watch.orderDetails?.shopCancelledStatus == "YES"
                                                                                ? Colors.red
                                                                                : watch.orderDetails?.orderStatus == "Order Refund"
                                                                                    ? Colors.green
                                                                                    : Colors.transparent,
                                                // width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) => OrderPendingView(
                                          //           orderId: element?.id.toString())),
                                          // );
                                        },
                                        child: Text(
                                          watch.orderDetails?.orderStatus ==
                                                      "Order Refund" &&
                                                  watch.orderDetails
                                                          ?.customerCancelledStatus ==
                                                      "YES"
                                              ? "Cancelled"
                                              : watch.orderDetails
                                                              ?.orderStatus ==
                                                          "Order Refund" &&
                                                      watch.orderDetails
                                                              ?.shopCancelledStatus ==
                                                          "YES"
                                                  ? "Cancelled"
                                                  : watch.orderDetails
                                                              ?.orderStatus ==
                                                          "Order Refund"
                                                      ? "Delivered"
                                                      : watch.orderDetails
                                                              ?.orderStatus ??
                                                          "",
                                          ///////////////
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: watch.orderDetails
                                                            ?.orderStatus ==
                                                        "Pending"
                                                    ? Yellow
                                                    ///////
                                                    : watch.orderDetails
                                                                ?.orderStatus ==
                                                            "Delivered"
                                                        ? Color(0xff39C19D)
                                                        ///////
                                                        : watch.orderDetails
                                                                    ?.orderStatus ==
                                                                "Confirmed"
                                                            ? Color(0xff115B7A)
                                                            /////////
                                                            : watch.orderDetails
                                                                        ?.orderStatus ==
                                                                    "Cancelled"
                                                                ? Colors.red
                                                                //////////////
                                                                : watch.orderDetails
                                                                            ?.orderStatus ==
                                                                        "Dispatched"
                                                                    ? Colors
                                                                        .orange
                                                                    : watch.orderDetails?.orderStatus ==
                                                                            "Packing"
                                                                        ? Colors
                                                                            .brown
                                                                        : watch.orderDetails?.orderStatus == "Order Refund" &&
                                                                                watch.orderDetails?.customerCancelledStatus == "YES"
                                                                            ? Colors.red
                                                                            : watch.orderDetails?.orderStatus == "Order Refund" && watch.orderDetails?.shopCancelledStatus == "YES"
                                                                                ? Colors.red
                                                                                : watch.orderDetails?.orderStatus == "Order Refund"
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
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 19.w,
                                ),
                                child: Text(
                                  "${watch.orderDetails?.createdAt}",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              /////////////////////////////////////////////
                              watch.orderDetails?.orderStatus == "Dispatched" ||
                                      watch.orderDetails?.orderStatus ==
                                          "Delivered"
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          left: 20.w,
                                          right: 19.w,
                                          top: 17.w,
                                          bottom: 19.w),
                                      padding: EdgeInsets.only(
                                          left: 13.w,
                                          right: 16.w,
                                          top: 14.w,
                                          bottom: 15.w),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xff39C19D),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Delivery Code",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Black,
                                                  // letterSpacing: .5,
                                                  fontSize: 17.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Text(
                                            "${watch.orderDetails?.deliveryCode}",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Color(0xff39C19D),
                                                  // letterSpacing: .5,
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 20.h,
                                    ),
                              ///////////////////////////////////////
                              watch.orderDetails?.deliveryType != "self_pickup"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          margin: EdgeInsets.only(
                                              left: 19.w, right: 19.w),
                                          // height: 156.h,
                                          width: double.infinity,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              // side: BorderSide(color: Colors.white70, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle: TextStyle(
                                                                  color: Black,
                                                                  letterSpacing:
                                                                      .5,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
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
                                                                  color:
                                                                      lighrgreen,
                                                                  // width: 1,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          onPressed: () {},
                                                          child: Text(
                                                            "${watch.deliveryAddressDetails?.deliveryAddressType}"
                                                                .capitalize(),
                                                            // "${element.deliveryAddressType}",
                                                            // "Home",
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle:
                                                                  TextStyle(
                                                                      color:
                                                                          SplashText1,
                                                                      // letterSpacing: .5,
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
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
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Black,
                                                              letterSpacing: .5,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.w,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                          "${watch.deliveryAddressDetails?.address1} ${watch.deliveryAddressDetails?.address2}",
                                                          maxLines: 3,
                                                          // "${element.address1} \n${element.address2} ",
                                                          // textAlign: TextAlign.start,
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            textStyle:
                                                                TextStyle(
                                                                    // height: 1.5,
                                                                    color:
                                                                        black,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
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
                                  : Container(
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
                                                          'Dear customer, as you have chosen the self-pickup option, please collect your ordered products from the shop.',
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {},
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          // letterSpacing: .5,
                                                          height: 1.5.w,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              watch.orderDetails?.orderStatus == "Delivered"
                                  // ||
                                  //         watch.orderDetails?.orderStatus ==
                                  //             "Order Refund"
                                  ? SizedBox(
                                      height: 10.h,
                                    )
                                  : Container(),
                              watch.orderDetails?.orderStatus == "Order Refund"
                                  // ||
                                  //         watch.orderDetails?.orderStatus ==
                                  //             "Order Refund"
                                  ? SizedBox(
                                      height: 10.h,
                                    )
                                  : Container(),
                              /////////////////////////////////////
                              watch.orderDetails?.orderStatus ==
                                          "Order Refund" &&
                                      watch.orderDetails?.shopCancelledStatus ==
                                          "YES"
                                  ? Container()
                                  : watch.orderDetails?.orderStatus ==
                                              "Order Refund" &&
                                          watch.orderDetails
                                                  ?.customerCancelledStatus ==
                                              "YES"
                                      ? Container()
                                      : watch.orderDetails?.orderStatus ==
                                              "Order Refund"
                                          ? GestureDetector(
                                              onTap: () {
                                                read.orderInvoice(
                                                  context,
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 20.w,
                                                    right: 20.w,
                                                    top: 9.w,
                                                    bottom: 9.w),
                                                width: ScreenUtil().screenWidth,
                                                margin: EdgeInsets.only(
                                                  left: 12.w,
                                                  right: 11.w,
                                                  // top: 9.w,
                                                  // bottom: 9.w
                                                ),
                                                // height: 50.h,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff115B7A),
                                                    // border: Border.all(width: 1, color: Black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  "Invoice",
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
                                              ),
                                            )
                                          : Container(),
                              ////////////////New//////////////////////
                              watch.orderDetails?.orderStatus == "Delivered"
                                  // ||
                                  //         watch.orderDetails?.orderStatus ==
                                  //             "Order Refund"
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 19.w,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              read.CustomerReorder(
                                                  context,
                                                  watch.orderDetails?.id
                                                      .toString());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 12.w,
                                                  right: 12.w,
                                                  top: 9.w,
                                                  bottom: 9.w),
                                              decoration: BoxDecoration(
                                                  color: SplashText,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Text(
                                                "Reorder",
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
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              read.orderInvoice(
                                                context,
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 12.w,
                                                  right: 12.w,
                                                  top: 9.w,
                                                  bottom: 9.w),
                                              // height: 50.h,/
                                              decoration: BoxDecoration(
                                                  color: Color(0xff115B7A),
                                                  // border: Border.all(width: 1, color: Black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),

                                              child: Text(
                                                "Invoice",
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
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                      ],
                                    )
                                  : Container(
                                      height: 20.h,
                                    ),
                              watch.orderDetails?.orderStatus == "Dispatched" ||
                                      watch.orderDetails?.orderStatus ==
                                          "Delivered"
                                  ? SizedBox(
                                      height: 20.h,
                                    )
                                  : Container(),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 19.w,
                                ),
                                child: Text(
                                  // maxLines: 3,
                                  "Expected Delivery Date & Slot",
                                  // textAlign: TextAlign.start,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        // height: 1.5,
                                        color: black,
                                        // letterSpacing: .05,
                                        // overflow: TextOverflow.ellipsis,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 19.w),
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
                              Container(
                                padding:
                                    EdgeInsets.only(left: 19.w, right: 19.w),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      watch.orderDetails?.deliverySlot ==
                                              "shop_owner_slot_9_to_12"
                                          ? "9:00 AM - 12:00 PM"
                                          : watch.orderDetails?.deliverySlot ==
                                                  "shop_owner_slot_12_to_3"
                                              ? "12:00 PM - 3:00 PM"
                                              : watch.orderDetails
                                                          ?.deliverySlot ==
                                                      "shop_owner_slot_3_to_6"
                                                  ? "3:00 PM - 6:00 PM"
                                                  : watch.orderDetails
                                                              ?.deliverySlot ==
                                                          "shop_owner_slot_6_to_9"
                                                      ? "6:00 PM - 9:00 PM"
                                                      : "",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      // height: 30.h,
                                      width: 100.w,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          // backgroundColor: ,
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  SplashText.withOpacity(0.3)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: SplashText,
                                                // width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          readMain.onNavigation(
                                              4,
                                              OrderStatusView(
                                                orderId: watch.orderId,
                                                screenName: "orderView",
                                              ),
                                              context);
                                          readMain.showBottomNavigationBar();
                                          // Navigator.pushAndRemoveUntil(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           MainScreenView(
                                          //               index: 4,
                                          //               screenName: OrderStatusView(
                                          //                 orderId: watch.orderId,
                                          //                 screenName: "orderView",
                                          //               ))),
                                          //   (Route<dynamic> route) => false,
                                          // );
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) => OrderStatusView(
                                          //               orderId: watch.orderId,
                                          //             )));
                                        },
                                        child: Text(
                                          "Track Order",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black,
                                                // letterSpacing: .5,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),

                                        //
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //////////////
                              Container(
                                padding: EdgeInsets.only(
                                    left: 19.w, top: 10.w, right: 19.w),
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
                                    OrderProductsListView(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          "\u{20B9} ${watch.orderDetails?.subTotalAmount}",
                                          //  ${watch.orderFinalTotals?.subTotal}",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            watch.couponDetails?.couponCode !=
                                                        "" &&
                                                    watch.couponDetails
                                                            ?.couponCode !=
                                                        null
                                                ? TextSpan(
                                                    text:
                                                        '  (${watch.couponDetails?.couponCode}) ',
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: SplashText,
                                                          // letterSpacing: .5,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  )
                                                : TextSpan(
                                                    text: "",
                                                  ),
                                          ]),
                                        ),
                                        watch.couponDetails?.couponDiscount !=
                                                null
                                            ? Text(
                                                // "",
                                                // "- Rs . ${watch.orderDetails?.totalDiscount}",
                                                " - \u{20B9}  ${watch.couponDetails?.couponDiscount}",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: grey5,
                                                      // letterSpacing: .5,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            : Text(
                                                "- \u{20B9} 0",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: grey5,
                                                      // letterSpacing: .5,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          watch.orderDetails?.deliveryCharges ==
                                                  ""
                                              ? "\u{20B9}0"
                                              : "\u{20B9}${watch.orderDetails?.deliveryCharges}",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          "\u{20B9} ${watch.orderDetails?.totalAmount} ",
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
                                        "You will save \u{20B9} ${watch.orderDetails?.totalDiscount}",
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
                                padding: EdgeInsets.only(
                                  left: 19.w,
                                ),
                                child: Text(
                                  "${watch.orderDetails?.paymentMode}",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: SplashText,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
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
                                height: 26.h,
                              ),
                              /////Product Return Request start////
                              watch.orderDetails?.orderStatus == "Delivered" &&
                                      watch.orderData?.orderRefundStatus ==
                                          false &&
                                      watch.orderDetails?.returnButtonStatus ==
                                          "active"
                                  ?
                                  // watch
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: 19.w, right: 19.w),
                                      margin: EdgeInsets.only(bottom: 10.w),
                                      child: SizedBox(
                                        // padding: EdgeInsets.only(
                                        //     left: 91.w, right: 91.w, top: 10.w, bottom: 10.w),
                                        width: 354.w,
                                        // <-- Your width
                                        height: 38.h,
                                        child: PrimaryButton(
                                          color: Color(0xffD1D1D1),
                                          onTap: () {
                                            readMain.onNavigation(
                                                0,
                                                CustomerProductReturnView(
                                                    orderId: watch.orderId
                                                        .toString()),
                                                context);
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           CustomerProductReturnView(
                                            //               orderId: watch.orderId
                                            //                   .toString())),
                                            // );
                                          },

                                          // style: style,

                                          child: Text(
                                            'Product Return Request',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  // letterSpacing: .5,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              watch.orderDetails?.orderStatus == "Delivered" &&
                                      (watch.orderData
                                                  ?.orderRefundProductCount ==
                                              "0" ||
                                          watch.orderDetails
                                                  ?.shopDeliveredCustomerPaymentStatus ==
                                              "received") &&
                                      watch.orderDetails?.returnButtonStatus ==
                                          "active"
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          left: 19.w, right: 19.w),
                                      margin: EdgeInsets.only(bottom: 10.w),
                                      child: SizedBox(
                                        // padding: EdgeInsets.only(
                                        //     left: 91.w, right: 91.w, top: 10.w, bottom: 10.w),
                                        width: 354.w,
                                        // <-- Your width
                                        height: 38.h,
                                        child: PrimaryButton(
                                          color: Color(0xffD1D1D1),
                                          onTap: () {
                                            readMain.onNavigation(
                                                0,
                                                CustomerProductReturnView(
                                                    orderId: watch.orderId
                                                        .toString()),
                                                context);
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           CustomerProductReturnView(
                                            //               orderId: watch.orderId
                                            //                   .toString())),
                                            // );
                                          },

                                          // style: style,

                                          child: Text(
                                            'Product Return Request',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  // letterSpacing: .5,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),

                              /////Product Return Request////
                              watch.orderDetails?.orderStatus == "Pending"
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          left: 19.w, right: 19.w),
                                      margin: EdgeInsets.only(bottom: 20.w),
                                      child: PrimaryButton(
                                        color: Color(0xffD1D1D1),
                                        onTap: () {
                                          showModalBottomSheet(
                                            backgroundColor: Colors.white,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30))),
                                            context: context,
                                            builder: (context) {
                                              return CancelOrderReasonView();
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Cancel Order',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                // letterSpacing: .5,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),

                              // SizedBox(
                              //   height: 50.h,
                              // ),
                              watch.orderDetails?.orderStatus == "Delivered"
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        watch.reviewList?.isEmpty == true
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 19.w),
                                                    child: Text(
                                                      'Your Ratings',
                                                      style: GoogleFonts.inter(
                                                        textStyle: TextStyle(
                                                            // color: SplashTex
                                                            // letterSpacing: .5,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 19.w),
                                                    child: StarRating(
                                                        rating:
                                                            watch.ratingValue ??
                                                                0,
                                                        onRatingChanged:
                                                            (rating) {
                                                          read.onRatingSelect(
                                                              rating);
                                                          print(rating);
                                                        }),
                                                  ),
                                                  //                                                             Container(
                                                  //                               padding: EdgeInsets.only(left: 19.w),
                                                  //                               child: Row(
                                                  //                                 children: [
                                                  //                                   GestureDetector(
                                                  //                                       onTap: () {
                                                  //                                         read.onRatingSelect(1);
                                                  //                                       },
                                                  //                                       child: SvgPicture.asset(
                                                  //                                         "assets/icons/order_rating.svg",
                                                  //                                         color: watch.ratingValue == null
                                                  //                                             ? Color(0xffDBDBDB)
                                                  //                                             : Colors.yellow,
                                                  //                                       )),
                                                  //                                   SizedBox(
                                                  //                                     width: 9.77.w,
                                                  //                                   ),
                                                  //                                   GestureDetector(
                                                  //                                       onTap: () {
                                                  //                                         read.onRatingSelect(2);
                                                  //                                       },
                                                  //                                       child: SvgPicture.asset(
                                                  //                                         "assets/icons/order_rating.svg",
                                                  //                                         color: watch.ratingValue == 2 &&
                                                  //                                                 watch.ratingValue == 3 &&
                                                  //                                                 watch.ratingValue == 4 &&
                                                  //                                                 watch.ratingValue == 5
                                                  //                                             ? Colors.yellow
                                                  //                                             : Color(0xffDBDBDB),
                                                  //                                       )),
                                                  //                                   SizedBox(
                                                  //                                     width: 9.77.w,
                                                  //                                   ),
                                                  //                                   GestureDetector(
                                                  //                                       onTap: () {
                                                  //                                         read.onRatingSelect(3);
                                                  //                                       },
                                                  //                                       child: SvgPicture.asset(
                                                  //                                           "assets/icons/order_rating.svg", color:
                                                  //                                           watch.ratingValue == 3 &&
                                                  //                                           watch.ratingValue == 4 &&
                                                  //                                           watch.ratingValue == 5
                                                  //                                           ? Colors.yellow
                                                  //                                           : Color(0xffDBDBDB),)),
                                                  //                                   SizedBox(
                                                  //                                     width: 9.77.w,
                                                  //                                   ),
                                                  //                                   GestureDetector(
                                                  //                                       onTap: () {
                                                  //                                         read.onRatingSelect(4);
                                                  //                                       },
                                                  //                                       child: SvgPicture.asset(
                                                  //                                           "assets/icons/order_rating.svg", color:
                                                  // watch.ratingValue == 4 &&
                                                  // watch.ratingValue == 5
                                                  // ? Colors.yellow
                                                  //     : Color(0xffDBDBDB),)),
                                                  //                                   SizedBox(
                                                  //                                     width: 9.77.w,
                                                  //                                   ),
                                                  //                                   GestureDetector(
                                                  //                                       onTap: () {
                                                  //                                         read.onRatingSelect(5);
                                                  //                                       },
                                                  //                                       child: SvgPicture.asset(
                                                  //                                           "assets/icons/order_rating.svg", color:
                                                  //                                           watch.ratingValue == 5
                                                  //                                           ? Colors.yellow
                                                  //                                           : Color(0xffDBDBDB),))
                                                  //                                 ],
                                                  //                               ),
                                                  //                             ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 19.w),
                                                    child: Text(
                                                      'Your Feedback',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle: TextStyle(
                                                            // color: SplashTex
                                                            // letterSpacing: .5,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 19.w,
                                                        right: 19.w),
                                                    child:
                                                        PrimarySTextFormField(
                                                      controller: watch
                                                          .reviewController,
                                                      height: 108.w,
                                                      maxLines: 5,
                                                      hintText: "",
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 19.w,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 19.w,
                                                        right: 19.w),
                                                    child: SizedBox(
                                                      width: 343
                                                          .w, // <-- Your width
                                                      height: 45.h,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Color(0xff39C19D),
                                                          // onPrimary: Colors.white,
                                                          // shadowColor: Colors.greenAccent,
                                                          elevation: 3,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14.0)),
                                                          minimumSize: const Size(
                                                              100,
                                                              40), //////// HERE
                                                        ),
                                                        // style: style,
                                                        onPressed: () {
                                                          read.shopSubmitreview(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Submit',
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            textStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    // letterSpacing: .5,
                                                                    fontSize:
                                                                        20.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: 19.h,
                                        ),
                                        ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                watch.reviewList?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              final element =
                                                  watch.reviewList?[index];
                                              return Container(
                                                padding: EdgeInsets.only(
                                                    left: 19.w,
                                                    bottom: 11.w,
                                                    right: 13.w,
                                                    top: 10.w),
                                                margin: EdgeInsets.only(
                                                  left: 19.w,
                                                  bottom: 11.w,
                                                  right: 19.w,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: grey6,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        element?.customerProfileImagePath ==
                                                                ""
                                                            ? Container(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: AssetImage(
                                                                        'assets/images/nearshop2.png'),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: CachedNetworkImageProvider(
                                                                          element?.customerProfileImagePath ??
                                                                              "")),
                                                                ),
                                                              ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                10),
                                                                    child: Text(
                                                                      "${element?.customerName}",
                                                                      style: GoogleFonts
                                                                          .dmSans(
                                                                        textStyle: TextStyle(
                                                                            color:
                                                                                Black,
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "${element?.createdAt}",
                                                                    style: GoogleFonts
                                                                        .dmSans(
                                                                      textStyle: TextStyle(
                                                                          color:
                                                                              Black,
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8.h,
                                                              ),
                                                              Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left: 10
                                                                              .w),
                                                                  child: element
                                                                              ?.ratings ==
                                                                          5
                                                                      ? Row(
                                                                          children: [
                                                                            SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                            SizedBox(
                                                                              width: 6.w,
                                                                            ),
                                                                            SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                            SizedBox(
                                                                              width: 6.w,
                                                                            ),
                                                                            SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                            SizedBox(
                                                                              width: 6.w,
                                                                            ),
                                                                            SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                            SizedBox(
                                                                              width: 6.w,
                                                                            ),
                                                                            SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                          ],
                                                                        )
                                                                      : element?.ratings ==
                                                                              4
                                                                          ? Row(
                                                                              children: [
                                                                                SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                                SizedBox(
                                                                                  width: 6.w,
                                                                                ),
                                                                                SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                                SizedBox(
                                                                                  width: 6.w,
                                                                                ),
                                                                                SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                                SizedBox(
                                                                                  width: 6.w,
                                                                                ),
                                                                                SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                              ],
                                                                            )
                                                                          : element?.ratings == 3
                                                                              ? Row(
                                                                                  children: [
                                                                                    SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                                    SizedBox(
                                                                                      width: 6.w,
                                                                                    ),
                                                                                    SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                                    SizedBox(
                                                                                      width: 6.w,
                                                                                    ),
                                                                                    SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                                  ],
                                                                                )
                                                                              : element?.ratings == 2
                                                                                  ? Row(
                                                                                      children: [
                                                                                        SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                                        SizedBox(
                                                                                          width: 6.w,
                                                                                        ),
                                                                                        SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                                      ],
                                                                                    )
                                                                                  : element?.ratings == 1
                                                                                      ? Row(
                                                                                          children: [
                                                                                            SvgPicture.asset("assets/icons/yellow_stars.svg"),
                                                                                          ],
                                                                                        )
                                                                                      : Container()),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      color: gradient,
                                                      thickness: 1,
                                                    ),
                                                    Text(
                                                      "${element?.review}",
                                                      // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet.',
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Black,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ],
                                    )
                                  : Container(),
                              watch.orderDetails?.orderStatus == "Order Refund"
                                  ? Container(
                                      margin: EdgeInsets.only(bottom: 5.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 17.w),
                                      color: watch.orderDetails
                                                  ?.refundOrderStatus ==
                                              "reject"
                                          ? Color(0xffFFE8E8)
                                          : Color(0xffEFFDFF),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15.w,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Refund Request sent",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                    fontSize: 18.sp),
                                              ),
                                              Container(
                                                height: 22.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.w),
                                                    border: Border.all(
                                                        // color: Color(0xff115B7A)
                                                        color: watch.orderDetails
                                                                    ?.refundPaymentStatus ==
                                                                "received"
                                                            ? Colors.green
                                                            : watch.orderDetails
                                                                        ?.refundOrderStatus ==
                                                                    "reject"
                                                                ? Colors.red
                                                                : Color(
                                                                    0xff115B7A))),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w),
                                                child: Center(
                                                    child: Text(
                                                  watch.orderDetails
                                                              ?.refundOrderStatus ==
                                                          "pending"
                                                      ? "Payment Pending"
                                                      : watch.orderDetails
                                                                  ?.refundOrderStatus ==
                                                              "reject"
                                                          ? "Return Rejected"
                                                          : watch.orderDetails
                                                                          ?.refundOrderStatus ==
                                                                      "accept" &&
                                                                  watch.orderDetails
                                                                          ?.refundPaymentStatus ==
                                                                      "not_received"
                                                              ? "Shop Refunded"
                                                              : "Payment Received",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: watch.orderDetails
                                                                  ?.refundPaymentStatus ==
                                                              "received"
                                                          ? Colors.green
                                                          : watch.orderDetails
                                                                      ?.refundOrderStatus ==
                                                                  "reject"
                                                              ? Colors.red
                                                              : Color(
                                                                  0xff115B7A)),
                                                )),
                                              ),
                                            ],
                                          ),
                                          
                                          // Text(
                                          //   "\u{20B9} ${watch.orderDetails?.shopOwnerRefundPaymentType}",
                                          //   style: TextStyle(
                                          //       // fontWeight: FontWeight.w700,

                                          //       fontSize: 1.sp),
                                          // ),
                                          SizedBox(
                                            height: 13.w,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${watch.orderDetails?.refundProductCount} Products",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18.sp),
                                                  ),
                                                  Text(
                                                    "\u{20B9} ${watch.orderDetails?.customerRefundAmount}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontSize: 18.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 19.w,
                                                  ),
                                                  // Text(
                                                  //   "Payment Given By",
                                                  //   style: TextStyle(
                                                  //       fontWeight:
                                                  //           FontWeight.w700,
                                                  //       // decoration:
                                                  //       //     TextDecoration
                                                  //       //         .lineThrough,
                                                  //       fontSize: 18.sp),
                                                  // ),
                                                  // Text(
                                                  //   "${watch.orderDetails?.shopOwnerRefundPaymentType}",
                                                  //   style: TextStyle(
                                                  //       // fontWeight:
                                                  //       //     FontWeight.w700,
                                                  //       // decoration:
                                                  //       //     TextDecoration
                                                  //       //         .lineThrough,
                                                  //       fontSize: 18.sp),
                                                  // ),
                                                  watch.orderDetails
                                                              ?.refundOrderStatus ==
                                                          "reject"
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "Shop Owner Reject Reason",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700)),
                                                            SizedBox(
                                                              height: 2.w,
                                                            ),
                                                            Text(
                                                              "${watch.orderDetails?.shopOwnerRefundRejectReason}",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Text(
                                                          watch.orderDetails
                                                                      ?.refundOrderStatus ==
                                                                  "pending"
                                                              ? "\u{20B9} ${watch.orderDetails?.customerRefundAmount}"
                                                              : watch.orderDetails
                                                                          ?.refundOrderStatus ==
                                                                      "accept"
                                                                  ? "\u{20B9} ${watch.orderDetails?.shopOwnerRefundPayableAmount}"
                                                                  : "",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 18.sp),
                                                        ),
                                                ],
                                              ),
                                              watch.orderDetails
                                                              ?.refundOrderStatus ==
                                                          "accept" &&
                                                      watch.orderDetails
                                                              ?.refundPaymentStatus ==
                                                          "received"
                                                  ? Column(
                                                      children: [
                                                        Text(watch.orderDetails
                                                                ?.refundDatetime ??
                                                            ""),
                                                        SizedBox(
                                                          height: 8.w,
                                                        ),
                                                        watch.orderDetails
                                                                    ?.shopOwnerRefundTransactionId !=
                                                                ""
                                                            ? Text(
                                                                "Transaction ID : ${watch.orderDetails?.shopOwnerRefundTransactionId}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        Black1),
                                                              )
                                                            : Container()
                                                      ],
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.w,
                                          ),
//////////////////////////Working////////////////////////////////
                                          Text("Reason",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700)),
                                          SizedBox(
                                            height: 5.w,
                                          ),
                                          /////////////////////////Working////////////////////////////////
                                          // Text(
                                          //   "${watch.orderDetails?.reason}",
                                          //   style: TextStyle(
                                          //     fontWeight: FontWeight.w400,
                                          //     fontSize: 14.sp,
                                          //   ),
                                          // ),
                                          watch.orderDetails
                                                          ?.customerCancelledReason !=
                                                      "" ||
                                                  watch.orderDetails
                                                          ?.shopOwnerCancelledReason !=
                                                      ""
                                              ? Text(
                                                  watch.orderDetails
                                                              ?.customerCancelledReason ==
                                                          ""
                                                      ? watch.orderDetails
                                                              ?.shopOwnerCancelledReason
                                                              .toString() ??
                                                          ""
                                                      : watch.orderDetails
                                                              ?.customerCancelledReason
                                                              .toString() ??
                                                          "",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16.sp),
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${watch.orderDetails?.reason}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${watch.orderDetails?.customerRefundReason}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 10.w,
                                          ),

                                          watch.orderDetails
                                                          ?.refundPaymentStatus ==
                                                      "not_received" &&
                                                  watch.orderDetails
                                                          ?.refundOrderStatus ==
                                                      "accept"
                                              ? Row(
                                                  children: [
                                                    Expanded(
                                                        child: PrimaryButton(
                                                      color: Color(0xff39C19D),
                                                      onTap: () {
                                                        read.updateRefundStatus(
                                                            "received",
                                                            context);
                                                      },
                                                      text: "Yes Received",
                                                    )),
                                                    SizedBox(width: 12.w),
                                                    Expanded(
                                                        child: PrimaryButton(
                                                      color: Color(0xffFF6258),
                                                      onTap: () {
                                                        read.updateRefundStatus(
                                                            "not_received",
                                                            context);
                                                      },
                                                      text: "Not Received",
                                                    )),
                                                  ],
                                                )
                                              : Container(),
                                          watch.orderDetails
                                                          ?.refundPaymentStatus ==
                                                      "not_received" &&
                                                  watch.orderDetails
                                                          ?.refundOrderStatus ==
                                                      "accept"
                                              ? SizedBox(
                                                  height: 31.w,
                                                )
                                              : Container(),
                                          Text(
                                            "Note",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5.w,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 3.w),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 5.w),
                                                height: 4.w,
                                                width: 4.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              Flexible(
                                                  child: Text(
                                                "Please collect your refund amount from the shop owner",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp),
                                              )),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 3.w),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 6.w),
                                                height: 4.w,
                                                width: 4.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              Flexible(
                                                  child: Text(
                                                "On receipt of refund amount, please provide acknowledgement.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp),
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 35.w,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),

                              watch.orderDetails?.orderStatus == "Cancelled"
                                  // &&
                                  //  watch.orderDetails?.customerCancelledReason!=""
                                  //   watch.orderDetails?.shopOwnerCancelledReason != ""
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          left: 15.w, top: 11.w, bottom: 45.w,right: 15.w),
                                      // height: ScreenUtil().screenHeight,
                                      width: ScreenUtil().screenWidth,
                                      decoration: BoxDecoration(
                                          color: Color(0xffFFE8E8)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Order Cancelled",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 18.sp),
                                              ),
                                              Text(watch.orderDetails?.orderCancelledDateAndTime??""),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.w,
                                          ),
                                          Text(
                                            "Reason",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp),
                                          ),
                                          SizedBox(
                                            height: 5.w,
                                          ),
                                          Text(
                                            watch.orderDetails
                                                        ?.customerCancelledReason ==
                                                    ""
                                                ? watch.orderDetails
                                                        ?.shopOwnerCancelledReason
                                                        .toString() ??
                                                    ""
                                                : watch.orderDetails
                                                        ?.customerCancelledReason
                                                        .toString() ??
                                                    "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp),
                                          ),
                                        ],
                                      )

                                      // Text(watch.orderDetails
                                      //         ?.shopOwnerCancelledReason
                                      //         .toString() ??
                                      //     "0"),
                                      )
                                  : Container(),
                              watch.orderDetails?.shopDeliveredRefundStatus ==
                                          "YES" &&
                                      watch.orderData?.orderRefundStatus == true
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 17.w),
                                      color: watch.orderDetails
                                                      ?.shopDeliveredRefundStatus ==
                                                  "YES" &&
                                              watch.orderDetails
                                                      ?.shopDeliveredCustomerPaymentStatus ==
                                                  "received"
                                          ? Color(0xffEFFDFF)
                                          : watch.orderDetails
                                                      ?.refundOrderStatus ==
                                                  "reject"
                                              ? Color(0xffFFE8E8)
                                              : Color(0xffEFFDFF),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15.w,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Refund Amount",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                    fontSize: 18.sp),
                                              ),
                                              Container(
                                                height: 22.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.w),
                                                    border: Border.all(
                                                        // color: Color(0xff115B7A)
                                                        color: watch.orderDetails
                                                                    ?.shopDeliveredCustomerPaymentStatus ==
                                                                "received"
                                                            ? Colors.green
                                                            : Color(
                                                                0xff115B7A))),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w),
                                                child: Center(
                                                    child: Text(
                                                  watch.orderDetails
                                                                  ?.shopDeliveredRefundStatus ==
                                                              "YES" &&
                                                          watch.orderDetails
                                                                  ?.shopDeliveredCustomerPaymentStatus ==
                                                              "not_received"
                                                      ? "Shop Refunded"
                                                      : watch.orderDetails
                                                                      ?.shopDeliveredRefundStatus ==
                                                                  "YES" &&
                                                              watch.orderDetails
                                                                      ?.shopDeliveredCustomerPaymentStatus ==
                                                                  "received"
                                                          ? "Payment Received"
                                                          : "Payment Not Recieved",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: watch.orderDetails
                                                                  ?.shopDeliveredCustomerPaymentStatus ==
                                                              "received"
                                                          ? Colors.green
                                                          : Color(0xff115B7A)),
                                                )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 13.w,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${watch.orderData?.orderRefundProductCount} Products",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 19.w,
                                                  ),
                                                  Text(
                                                    "INR ${watch.orderDetails?.shopDeliveredPayableAmount ?? "0"}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18.sp),
                                                  ),
                                                ],
                                              ),
                                              watch.orderDetails
                                                              ?.shopDeliveredRefundStatus ==
                                                          "YES" &&
                                                      watch.orderDetails
                                                              ?.shopDeliveredCustomerPaymentStatus ==
                                                          "received"
                                                  ? Column(
                                                      children: [
                                                        Text(watch.orderDetails
                                                                ?.refundDatetime ??
                                                            ""),
                                                        SizedBox(
                                                          height: 8.w,
                                                        ),
                                                        Text(
                                                          "Transaction ID : ${watch.orderDetails?.shopDeliveredTransactionId}",
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Black1),
                                                        )
                                                      ],
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          watch.orderDetails
                                                          ?.shopDeliveredRefundStatus ==
                                                      "YES" &&
                                                  watch.orderDetails
                                                          ?.shopDeliveredCustomerPaymentStatus !=
                                                      "received"
                                              ? SizedBox(
                                                  height: 31.w,
                                                )
                                              : Container(),
                                          watch.orderDetails
                                                          ?.shopDeliveredRefundStatus ==
                                                      "YES" &&
                                                  watch.orderDetails
                                                          ?.shopDeliveredCustomerPaymentStatus !=
                                                      "received"
                                              ? Row(
                                                  children: [
                                                    Expanded(
                                                        child: PrimaryButton(
                                                      color: Color(0xff39C19D),
                                                      onTap: () {
                                                        read.updateDeliveredRefundStatus(
                                                            "received",
                                                            context);
                                                      },
                                                      text: "Yes Received",
                                                    )),
                                                    SizedBox(width: 12.w),
                                                    Expanded(
                                                        child: PrimaryButton(
                                                      color: Color(0xffFF6258),
                                                      onTap: () {
                                                        read.updateDeliveredRefundStatus(
                                                            "not_received",
                                                            context);
                                                      },
                                                      text: "Not Received",
                                                    )),
                                                  ],
                                                )
                                              : Container(),
                                          SizedBox(
                                            height: 31.w,
                                          ),
                                          Text(
                                            "Note",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5.w,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 3.w),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 5.w),
                                                height: 4.w,
                                                width: 4.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              Flexible(
                                                  child: Text(
                                                "Please collect your refund amount from the shop owner",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp),
                                              )),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 3.w),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 6.w),
                                                height: 4.w,
                                                width: 4.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              Flexible(
                                                  child: Text(
                                                "On receipt of refund amount, please provide acknowledgement.",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp),
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 35.w,
                                          ),
                                        ],
                                      ),
                                    )
                                  : watch.orderDetails
                                                  ?.shopDeliveredRefundStatus ==
                                              "NO" &&
                                          watch.orderData
                                                  ?.orderRefundProductCount !=
                                              "0" &&
                                          watch.orderData?.orderRefundStatus ==
                                              true
                                      ? Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 17.w),
                                          color: watch.orderDetails
                                                      ?.refundOrderStatus ==
                                                  "reject"
                                              ? Color(0xffFFE8E8)
                                              : Color(0xffEFFDFF),
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
                                                  Text(
                                                    "Refund Amount",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                        fontSize: 18.sp),
                                                  ),
                                                  Container(
                                                    height: 22.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.w),
                                                        border: Border.all(
                                                            // color: Color(0xff115B7A)
                                                            color: watch.orderDetails
                                                                        ?.shopDeliveredCustomerPaymentStatus ==
                                                                    "received"
                                                                ? Colors.green
                                                                : Color(
                                                                    0xff115B7A))),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.w),
                                                    child: Center(
                                                        child: Text(
                                                      watch.orderDetails
                                                                      ?.shopDeliveredRefundStatus ==
                                                                  "YES" &&
                                                              watch.orderDetails
                                                                      ?.shopDeliveredCustomerPaymentStatus ==
                                                                  "not_received"
                                                          ? "Shop Refunded"
                                                          : watch.orderDetails
                                                                          ?.shopDeliveredRefundStatus ==
                                                                      "YES" &&
                                                                  watch.orderDetails
                                                                          ?.shopDeliveredCustomerPaymentStatus ==
                                                                      "received"
                                                              ? "Payment Received"
                                                              : "Payment Not Recieved",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: watch.orderDetails
                                                                      ?.shopDeliveredCustomerPaymentStatus ==
                                                                  "received"
                                                              ? Colors.green
                                                              : Color(
                                                                  0xff115B7A)),
                                                    )),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 13.w,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
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
                                                        "${watch.orderData?.orderRefundProductCount} Products",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 18.sp),
                                                      ),
                                                      SizedBox(
                                                        height: 19.w,
                                                      ),
                                                      Text(
                                                        "INR ${watch.orderData?.orderRefundAmount ?? "0"}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 18.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  watch.orderDetails
                                                                  ?.shopDeliveredRefundStatus ==
                                                              "YES" &&
                                                          watch.orderDetails
                                                                  ?.shopDeliveredCustomerPaymentStatus ==
                                                              "received"
                                                      ? Column(
                                                          children: [
                                                            Text(watch
                                                                    .orderDetails
                                                                    ?.refundDatetime ??
                                                                ""),
                                                            SizedBox(
                                                              height: 8.w,
                                                            ),
                                                            Text(
                                                              "Transaction ID : ${watch.orderDetails?.shopDeliveredTransactionId}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      Black1),
                                                            )
                                                          ],
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                              watch.orderDetails
                                                          ?.shopDeliveredRefundStatus ==
                                                      "YES"
                                                  ? SizedBox(
                                                      height: 31.w,
                                                    )
                                                  : Container(),
                                              watch.orderDetails
                                                              ?.shopDeliveredRefundStatus ==
                                                          "YES" &&
                                                      watch.orderDetails
                                                              ?.shopDeliveredCustomerPaymentStatus !=
                                                          "received"
                                                  ? Row(
                                                      children: [
                                                        Expanded(
                                                            child:
                                                                PrimaryButton(
                                                          color:
                                                              Color(0xff39C19D),
                                                          onTap: () {
                                                            read.updateDeliveredRefundStatus(
                                                                "received",
                                                                context);
                                                          },
                                                          text: "Yes Received",
                                                        )),
                                                        SizedBox(width: 12.w),
                                                        Expanded(
                                                            child:
                                                                PrimaryButton(
                                                          color:
                                                              Color(0xffFF6258),
                                                          onTap: () {
                                                            read.updateDeliveredRefundStatus(
                                                                "not_received",
                                                                context);
                                                          },
                                                          text: "Not Received",
                                                        )),
                                                      ],
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height: 31.w,
                                              ),
                                              Text(
                                                "Note",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 5.w,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 3.w),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5.w),
                                                    height: 4.w,
                                                    width: 4.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 7.w,
                                                  ),
                                                  Flexible(
                                                      child: Text(
                                                    "Please collect your refund amount from the shop owner",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.sp),
                                                  )),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 3.w),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 6.w),
                                                    height: 4.w,
                                                    width: 4.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 7.w,
                                                  ),
                                                  Flexible(
                                                      child: Text(
                                                    "On receipt of refund amount, please provide acknowledgement.",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.sp),
                                                  )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 35.w,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container()
                            ])),
                // onRefresh: () {
                //   return Future.delayed(Duration(seconds: 1), () {
                //     watch.customerOrderView(context, widget.orderId);
                //   });
                // }
                // ),
              ));
  }
}
