// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/customer/cart/view/cart_detail_view.dart';
// import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
// import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';

// import 'package:local_supper_market/screen/customer/order_payment/view/order_payment_view.dart';
// import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
// import 'package:local_supper_market/screen/customer/order_summary/view/address_list_sheet_view.dart';
// import 'package:local_supper_market/screen/customer/order_summary/view/coupons_list_sheet_view.dart';
// import 'package:local_supper_market/screen/customer/order_summary/view/expected_delivery_date_sheet_view.dart';
// import 'package:local_supper_market/screen/customer/products/controller/product_view_controller.dart';
// import 'package:local_supper_market/screen/customer/products/views/product_screen_view.dart';
// import 'package:local_supper_market/utils/utils.dart';
// import 'package:local_supper_market/widget/app_bar.dart';
// import 'package:local_supper_market/widget/buttons.dart';
// import 'package:local_supper_market/widget/checkbox.dart';
// import 'package:local_supper_market/widget/radio_button.dart';
// import 'package:local_supper_market/widget/stack_loader.dart';
// import 'package:provider/provider.dart';

// import '../order_products.dart';

// class OrderSummaryView extends StatefulWidget {
//   final String? shopId;
//   final String? cartId;
//   final bool? isRefresh;
//   final String? route;

//   const OrderSummaryView(
//       {super.key,
//       this.cartId,
//       this.shopId,
//       required this.isRefresh,
//       required this.route});

//   @override
//   State<OrderSummaryView> createState() => _OrderSummaryViewState();
// }

// // enum Fruit { apple, banana }

// class _OrderSummaryViewState extends State<OrderSummaryView> {
//   String radioButtonItem = '';
//   bool showAddressModalSheet = false;

//   // Group Value for Radio Button.
//   int id = 1;

//   @override
//   void initState() {
//     print(widget.shopId);
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       context.read<OrderSummaryController>().initState(
//             context,
//             widget.shopId,
//             widget.cartId,
//             widget.isRefresh,
//             widget.route,
//           );
//       if (widget.route == "editAddress") {
//         showModalBottomSheet(
//             backgroundColor: Colors.white,
//             isScrollControlled: true,
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30))),
//             context: context,
//             builder: (context) {
//               // using a scaffold helps to more easily position the FAB
//               return AddressListSheetView();
//             });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final watch = context.watch<OrderSummaryController>();
//     final read = context.read<OrderSummaryController>();
//     final readMain = context.read<MainScreenController>();
//     final readProductViewController = context.read<ProductViewController>();
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(66.w),
//         child: PrimaryAppBar(
//           title: "Order Summary",
//           onBackBtnPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => CartDetailView(
//                           isRefresh: true,
//                           shopId: watch.shopId,
//                           cartId: watch.cartId,
//                         )));
//           },
//         ),
//       ),
//       body: watch.isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : StackLoader(
//               showLoader: watch.isStackLoaderVisible,
//               child: SingleChildScrollView(
//                 physics: BouncingScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(left: 17.w, top: 20.w),
//                       child: Text(
//                         "${watch.shopDetailData?.shopName}",

//                         // "${watch.shopDetailData?.shopName}",

//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: Black1,
//                               letterSpacing: .5,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(12.w),
//                       // height: 70.h,
//                       // decoration: BoxDecoration(
//                       //   border: Border(
//                       //     // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
//                       //     bottom: BorderSide(width: 1, color: grey2),
//                       //   ),
//                       // ),

//                       // color: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               SvgPicture.asset(
//                                 'assets/images/location2.svg',
//                                 width: 23.w,
//                                 height: 28.h,
//                               ),
//                               SizedBox(
//                                 width: 8.w,
//                               ),
//                               Container(
//                                 width: 200.w,
//                                 child: Text(
//                                   // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
//                                   "${watch.shopDetailData?.shopAddress}\n${watch.shopDetailData?.cityName} - ${watch.shopDetailData?.shopPincode}",
//                                   style: GoogleFonts.roboto(
//                                     textStyle: TextStyle(
//                                         color: Black,
//                                         // letterSpacing: .5,
//                                         fontSize: 13.sp,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   read.launchPhone(
//                                       watch.shopDetailData
//                                               ?.shopOwnerSupportNumber ??
//                                           "",
//                                       context);
//                                 },
//                                 child: SvgPicture.asset(
//                                   'assets/images/call.svg',
//                                   // width: 15.w,
//                                   // height: 19.h,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 13.w,
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   watch.favAllShop
//                                       ? read.removeAllShopFavList(
//                                           context, watch.shopDetailData?.id)
//                                       : read.updateAllShopFavList(
//                                           context, watch.shopDetailData?.id);
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.only(
//                                       left: 11.w,
//                                       right: 11.w,
//                                       top: 13.w,
//                                       bottom: 13.w),
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Color(0xff4689EC),
//                                   ),
//                                   child: watch.favAllShop
//                                       ? SvgPicture.asset(
//                                           "assets/icons/fav_selected.svg",
//                                           width: 26.w,
//                                           height: 14.h,
//                                         )
//                                       : SvgPicture.asset(
//                                           "assets/images/favorite.svg",
//                                           width: 26.w,
//                                           height: 14.h,
//                                         ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Divider(
//                       // height: 100,
//                       color: grey2,
//                       thickness: 1,
//                       indent: 5,
//                       endIndent: 5,
//                     ),
//                     SizedBox(
//                       height: 10.w,
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(left: 19.w, right: 77.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Row(
//                             children: [
//                               watch.shopDeliveryTypes
//                                           ?.shopOwnerDeliveryToCustomer ==
//                                       "active"
//                                   ? SecondaryRadioButton(
//                                       value: "delivery_to",
//                                       groupValue: watch.groupValue,
//                                       // groupValue: watch.radioGroupValue,
//                                       onChanged: (value) {
//                                         read.onRadioButtonSelected(
//                                             value, context);
//                                       },
//                                       leading: "")
//                                   : InkWell(
//                                       onTap: () {
//                                         Utils.showPrimarySnackbar(context,
//                                             "Cannot Select Delivery To",
//                                             type: SnackType.error);
//                                       },
//                                       child: Container(
//                                         height: 16.w,
//                                         width: 16.w,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           border: Border.all(
//                                             color: Color(0xff03C9CC),
//                                             width: 1.w,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                               SizedBox(
//                                 width: 10.w,
//                               ),
//                               Text(
//                                 'Delivery To',
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       color: Black,
//                                       letterSpacing: .5,
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               watch.shopDeliveryTypes
//                                           ?.shopOwnerCustomerPickup ==
//                                       "active"
//                                   ? SecondaryRadioButton(
//                                       value: "self_pickup",
//                                       groupValue: watch.groupValue,
//                                       onChanged: (value) {
//                                         read.onRadioButtonSelected(
//                                             value, context);
//                                       },
//                                       leading: "")
//                                   : InkWell(
//                                       onTap: () {
//                                         Utils.showPrimarySnackbar(context,
//                                             "Cannot Select  Select Pickup",
//                                             type: SnackType.error);
//                                       },
//                                       child: Container(
//                                         height: 16.w,
//                                         width: 16.w,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           border: Border.all(
//                                             color: Color(0xff03C9CC),
//                                             width: 1.w,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                               SizedBox(
//                                 width: 10.w,
//                               ),
//                               Text(
//                                 'Self Pickup',
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       color: Black,
//                                       letterSpacing: .5,
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Visibility(
//                       visible: watch.groupValue == "self_pickup" ? false : true,
//                       child: Padding(
//                         padding:
//                             EdgeInsets.only(left: 16.w, top: 20.w, right: 19.w),
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: watch.customerAddress?.length ?? 0,
//                           itemBuilder: (context, index) {
//                             final element = watch.customerAddress![index];
//                             return GestureDetector(
//                               onTap: () {
//                                 showModalBottomSheet(
//                                     backgroundColor: Colors.white,
//                                     isScrollControlled: true,
//                                     shape: const RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(30),
//                                             topRight: Radius.circular(30))),
//                                     context: context,
//                                     builder: (context) {
//                                       // using a scaffold helps to more easily position the FAB
//                                       return AddressListSheetView();
//                                     });
//                               },
//                               child: Container(
//                                 width: double.infinity,
//                                 child: element.addressId ==
//                                         int.parse(watch.addressGroupValue)
//                                     ? Card(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                         child: Container(
//                                           padding: EdgeInsets.only(
//                                               bottom: 15.w,
//                                               left: 20.w,
//                                               right: 20.w,
//                                               top: 15.w),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       SvgPicture.asset(
//                                                         'assets/images/person.svg',
//                                                         width: 11.w,
//                                                         height: 15.h,
//                                                       ),
//                                                       SizedBox(
//                                                         width: 10.w,
//                                                       ),
//                                                       Text(
//                                                         "${element.customerName}",
//                                                         // 'Rachel Green',
//                                                         style:
//                                                             GoogleFonts.dmSans(
//                                                           textStyle: TextStyle(
//                                                               color: Black,
//                                                               letterSpacing: .5,
//                                                               fontSize: 16.sp,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w700),
//                                                         ),
//                                                       ),
//                                                       // SizedBox(
//                                                       //   width: 11.w,
//                                                       // ),
//                                                     ],
//                                                   ),
//                                                   Icon(Icons
//                                                       .keyboard_arrow_down_outlined),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 15.w,
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   SvgPicture.asset(
//                                                     'assets/images/phone.svg',
//                                                     width: 14.w,
//                                                     height: 15.h,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 10.w,
//                                                   ),
//                                                   Text(
//                                                     '${element.mobileNo}',
//                                                     style: GoogleFonts.dmSans(
//                                                       textStyle: TextStyle(
//                                                           color: Black,
//                                                           letterSpacing: .5,
//                                                           fontSize: 13.sp,
//                                                           fontWeight:
//                                                               FontWeight.w400),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 15.w,
//                                               ),
//                                               Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   SvgPicture.asset(
//                                                     'assets/images/location.svg',
//                                                     color: SplashText1,
//                                                     width: 17.w,
//                                                     height: 17.h,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 10.w,
//                                                   ),
//                                                   Expanded(
//                                                     child: Text(
//                                                       maxLines: 3,
//                                                       "${element.address1} \n${element.address2} ",
//                                                       // "Nand Nivas Building floor 3 B-3,Lane No.13 Bhatrau Nivas Vishrantwadi Pune -411015.",
//                                                       // textAlign: TextAlign.start,
//                                                       style: GoogleFonts.dmSans(
//                                                         textStyle: TextStyle(
//                                                             // height: 1.5,
//                                                             color: black,
//                                                             // letterSpacing: .05,
//                                                             // overflow: TextOverflow.ellipsis,
//                                                             fontSize: 14.sp,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w400),
//                                                       ),
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                     : Container(),
//                               ),
//                             );
//                           },
//                           // child:
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 19.w, top: 32.w),
//                       child: Text(
//                         "Delivery Date",
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               // height: 1.5,
//                               color: black,
//                               // letterSpacing: .05,
//                               // overflow: TextOverflow.ellipsis,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(
//                           left: 20.w, right: 17.w, top: 8.w, bottom: 10.w),
//                       margin: EdgeInsets.only(
//                           left: 10.w, right: 17.w, top: 8.w, bottom: 10.w),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: grey3),
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             // crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   "Date:",
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         // height: 1.5,
//                                         color: black,
//                                         letterSpacing: .05,
//                                         // overflow: TextOverflow.ellipsis,
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                   child: Text(
//                                 watch.slotGroupValue ==
//                                             "shop_owner_slot_9_to_12" ||
//                                         watch.slotGroupValue ==
//                                             "shop_owner_slot_12_to_3"
//                                     ? " Delivery Slot:"
//                                     : "Delivery Slot",
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       // height: 1.5,
//                                       color: black,
//                                       letterSpacing: .05,
//                                       // overflow: TextOverflow.ellipsis,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               )),
//                               SizedBox(width: 22.w),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10.h,
//                           ),
//                           watch.expectedDateController.text != "" ||
//                                   watch.slotGroupValue != ""
//                               ? Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           watch.expectedDateController.text,
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 // height: 1.5,
//                                                 color: black,
//                                                 // letterSpacing: .05,
//                                                 // overflow: TextOverflow.ellipsis,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 10.w,
//                                         ),
//                                         SvgPicture.asset(
//                                           'assets/images/calender.svg',
//                                           width: 12.w,
//                                           height: 14.h,
//                                         ),
//                                       ],
//                                     ),
//                                     // SizedBox(
//                                     //   width: 20.w,
//                                     // ),
//                                     Row(
//                                       // crossAxisAlignment:
//                                       //     CrossAxisAlignment.end,
//                                       // mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Text(
//                                           watch.slotGroupValue ==
//                                                   "shop_owner_slot_9_to_12"
//                                               ? "09:00 AM - 12:00 PM"
//                                               : watch.slotGroupValue ==
//                                                       "shop_owner_slot_12_to_3"
//                                                   ? "12:00 PM - 03:00 PM"
//                                                   : watch.slotGroupValue ==
//                                                           "shop_owner_slot_3_to_6"
//                                                       ? "03:00 PM - 06:00 PM"
//                                                       : watch.slotGroupValue ==
//                                                               "shop_owner_slot_6_to_9"
//                                                           ? "06:00 PM - 09:00 PM"
//                                                           : "",
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 // height: 1.5,
//                                                 color: black,
//                                                 // letterSpacing: .05,
//                                                 // overflow: TextOverflow.ellipsis,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 10.w,
//                                         ),
//                                         GestureDetector(
//                                           onTap: () {
//                                             showModalBottomSheet(
//                                                 backgroundColor: Colors.white,
//                                                 isScrollControlled: true,
//                                                 shape:
//                                                     const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.only(
//                                                                 topLeft: Radius
//                                                                     .circular(
//                                                                         30),
//                                                                 topRight: Radius
//                                                                     .circular(
//                                                                         30))),
//                                                 context: context,
//                                                 builder: (context) {
//                                                   // using a scaffold helps to more easily position the FAB
//                                                   return ExpectedDeliveryDateSheetView();
//                                                 });
//                                           },
//                                           child: SvgPicture.asset(
//                                             'assets/images/pencil.svg',
//                                             width: 12.w,
//                                             height: 14.h,
//                                           ),
//                                         ),
//                                         // SizedBox(
//                                         //   width: 5.w,
//                                         // ),
//                                       ],
//                                     ),
//                                   ],
//                                 )
//                               : Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         showModalBottomSheet(
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
//                                               // using a scaffold helps to more easily position the FAB
//                                               return ExpectedDeliveryDateSheetView();
//                                             });
//                                       },
//                                       child: SvgPicture.asset(
//                                         'assets/images/pencil.svg',
//                                         width: 12.w,
//                                         height: 14.h,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding:
//                           EdgeInsets.only(left: 19.w, top: 30.w, right: 19.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Available Coupon Code",
//                             style: GoogleFonts.dmSans(
//                               textStyle: TextStyle(
//                                   // height: 1.5,
//                                   color: black,
//                                   letterSpacing: .05,
//                                   // overflow: TextOverflow.ellipsis,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               if (watch.finalCouponList!.isEmpty) {
//                                 Utils.showPrimarySnackbar(
//                                     context, "No Coupons Found",
//                                     type: SnackType.error);
//                                 return;
//                               }
//                               showModalBottomSheet(
//                                   backgroundColor: Colors.white,
//                                   isScrollControlled: true,
//                                   shape: const RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(30),
//                                           topRight: Radius.circular(30))),
//                                   context: context,
//                                   builder: (context) {
//                                     // using a scaffold helps to more easily position the FAB
//                                     return CouponsListSheetView();
//                                   });
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 11.33.w, vertical: 7.w),
//                               decoration: BoxDecoration(
//                                   color: lightsky,
//                                   borderRadius: BorderRadius.circular(10.w),
//                                   border: Border.all(color: SplashText)),
//                               child: Center(
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       "Get Code",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 16.sp,
//                                           color: SplashText),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(left: 19.w, right: 19.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Enter Coupon Code",
//                             style: GoogleFonts.dmSans(
//                               textStyle: TextStyle(
//                                   color: Black1,
//                                   // letterSpacing: .5,
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 11.h,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width: 200.w,
//                                 height: 34.w,
//                                 child: TextField(
//                                   controller: watch.couponCodeController,
//                                   decoration: InputDecoration(
//                                     fillColor: grey4,
//                                     filled: true,
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // SizedBox(
//                               //   width: 30.w,
//                               // ),
//                               SizedBox(
//                                 height: 32.h,
//                                 width: 91.w,
//                                 child: PrimaryButton(
//                                   color: SplashText,

//                                   onTap: () {
//                                     read.removeCoupon(context);
//                                   },
//                                   child: Text(
//                                     "Remove",
//                                     style: GoogleFonts.dmSans(
//                                       textStyle: TextStyle(
//                                           color: Colors.white,
//                                           // letterSpacing: .5,
//                                           fontSize: 15.sp,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ),

//                                   //
//                                 ),
//                               )
//                             ],
//                           ),
//                           watch.discountPercentage != ""
//                               ? Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 10.w,
//                                     ),
//                                     RichText(
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                           text: 'Congratulations!! ',
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: SplashText,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 13.sp,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text:
//                                               ' ${watch.discountPercentage} Discount applied successfully.',
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: SplashText,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 13.sp,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                         ),
//                                       ]),
//                                     ),
//                                   ],
//                                 )
//                               : Container(),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30.w,
//                     ),
//                     watch.fullFillYourCravings!.isNotEmpty
//                         ? Container(
//                             // height: 203.h,
//                             width: ScreenUtil().screenWidth,
//                             color: Coupons,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding:
//                                       EdgeInsets.only(top: 16.w, left: 18.w),
//                                   child: Text(
//                                     "Fulfil your cravings",
//                                     style: GoogleFonts.dmSans(
//                                       textStyle: TextStyle(
//                                           color: SplashText,
//                                           // letterSpacing: .5,
//                                           fontSize: 16.sp,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   padding:
//                                       EdgeInsets.only(top: 15.w, bottom: 15.w),
//                                   child: SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     physics: BouncingScrollPhysics(),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: List.generate(
//                                           watch.fullFillYourCravings?.length ??
//                                               0, (index) {
//                                         final element =
//                                             watch.fullFillYourCravings?[index];
//                                         return watch
//                                                         .fullFillYourCravings?[
//                                                             index]
//                                                         .mrpPrice !=
//                                                     "" &&
//                                                 int.parse(element?.offerPrice ==
//                                                             ""
//                                                         ? "0"
//                                                         : element?.offerPrice ??
//                                                             "0") <
//                                                     int.parse(
//                                                         element?.mrpPrice ??
//                                                             "0")
//                                             ? Row(
//                                                 children: [
//                                                   SizedBox(
//                                                     width: 10.w,
//                                                   ),
//                                                   GestureDetector(
//                                                     onTap: () {
//                                                       readProductViewController
//                                                           .updateProductId(
//                                                         element?.id.toString(),
//                                                       );
//                                                       Navigator
//                                                           .pushAndRemoveUntil(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 MainScreenView(
//                                                                   index: 1,
//                                                                   screenName:
//                                                                       ProductScreenView(
//                                                                           selectedUnitId: element
//                                                                               ?.productUnitId
//                                                                               .toString(),
//                                                                           categoryId: element
//                                                                               ?.categoryId
//                                                                               .toString(),
//                                                                           // categoryId: watch.categoryId,
//                                                                           productId: element
//                                                                               ?.id
//                                                                               .toString(),
//                                                                           shopId: element
//                                                                               ?.shopId,
//                                                                           productType:
//                                                                               element?.productType),
//                                                                 )),
//                                                         (Route<dynamic>
//                                                                 route) =>
//                                                             false,
//                                                       );
//                                                     },
//                                                     child: Container(
//                                                       decoration: BoxDecoration(
//                                                           // color: Colors.white,
//                                                           // boxShadow: [
//                                                           //   BoxShadow(
//                                                           //       color: Colors.black
//                                                           //           .withOpacity(0.03.w),
//                                                           //       blurRadius: 5,
//                                                           //       spreadRadius: 0,
//                                                           //       offset: Offset(0, 3)),
//                                                           // ],
//                                                           ),
//                                                       child: Card(
//                                                         shape: RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10.w)),
//                                                         elevation: 0,
//                                                         child: Container(
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         20.w),
//                                                           ),
//                                                           width: 156.w,
//                                                           padding:
//                                                               EdgeInsets.only(
//                                                                   left: 19.w,
//                                                                   top: 14.w,
//                                                                   right: 12.w,
//                                                                   bottom: 12.w),
//                                                           child: Column(
//                                                             children: [
//                                                               Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .end,
//                                                                 children: [
//                                                                   element?.discountPercentage !=
//                                                                           ""
//                                                                       ? Container(
//                                                                           width:
//                                                                               60.w,
//                                                                           height:
//                                                                               20.h,
//                                                                           decoration: BoxDecoration(
//                                                                               color: lightgreen,
//                                                                               borderRadius: BorderRadius.all(Radius.circular(5.w))),
//                                                                           child:
//                                                                               Center(
//                                                                             child: Text("${element?.discountPercentage} off",
//                                                                                 // textAlign: TextAlign.center,
//                                                                                 style: GoogleFonts.dmSans(
//                                                                                   textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w500),
//                                                                                 )),
//                                                                           ),
//                                                                         )
//                                                                       : Container(
//                                                                           width:
//                                                                               60.w,
//                                                                           height:
//                                                                               20.h,
//                                                                         ),
//                                                                 ],
//                                                               ),
//                                                               Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .center,
//                                                                 children: [
//                                                                   element?.productImagePath ==
//                                                                           ""
//                                                                       ? Container(
//                                                                           height:
//                                                                               89.w,
//                                                                           width:
//                                                                               89.w,
//                                                                           child:
//                                                                               Image.asset(
//                                                                             "assets/images/profile_image.png",
//                                                                             fit:
//                                                                                 BoxFit.cover,
//                                                                           ),
//                                                                         )
//                                                                       : Container(
//                                                                           height:
//                                                                               89.w,
//                                                                           width:
//                                                                               89.w,
//                                                                           child:
//                                                                               Image.network(
//                                                                             "${element?.productImagePath}",
//                                                                             fit:
//                                                                                 BoxFit.cover,
//                                                                           ),
//                                                                         ),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(
//                                                                 height: 3.w,
//                                                               ),
//                                                               Row(
//                                                                 children: [
//                                                                   Flexible(
//                                                                     child: Text(
//                                                                       "${element?.productName}",
//                                                                       maxLines:
//                                                                           1,
//                                                                       style: GoogleFonts
//                                                                           .roboto(
//                                                                         textStyle:
//                                                                             TextStyle(
//                                                                           color:
//                                                                               Black1,
//                                                                           overflow:
//                                                                               TextOverflow.ellipsis,
//                                                                           // letterSpacing: .5,
//                                                                           fontSize:
//                                                                               16.sp,

//                                                                           fontWeight:
//                                                                               FontWeight.w600,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(
//                                                                 height: 2.w,
//                                                               ),
//                                                               Row(
//                                                                 children: [
//                                                                   Text(
//                                                                     "${element?.weight}${element?.unit}",
//                                                                     style: GoogleFonts
//                                                                         .roboto(
//                                                                       textStyle: TextStyle(
//                                                                           color: Black1,
//                                                                           // letterSpacing: .5,
//                                                                           fontSize: 12.sp,
//                                                                           fontWeight: FontWeight.w600),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               SizedBox(
//                                                                 height: 2.w,
//                                                               ),
//                                                               Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .spaceBetween,
//                                                                 children: [
//                                                                   Row(
//                                                                     children: [
//                                                                       element?.mrpPrice !=
//                                                                               ""
//                                                                           ? Text(
//                                                                               '\u{20B9}${element?.mrpPrice}',
//                                                                               style: GoogleFonts.dmSans(textStyle: element?.offerPrice != "" && element?.offerPrice != element?.mrpPrice ? TextStyle(decoration: TextDecoration.lineThrough, color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400) : TextStyle(color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400)))
//                                                                           : Text(""),
//                                                                       SizedBox(
//                                                                         width:
//                                                                             5.w,
//                                                                       ),
//                                                                       element?.offerPrice != "" &&
//                                                                               element?.offerPrice != element?.mrpPrice
//                                                                           ? Text(
//                                                                               '\u{20B9}${element?.offerPrice}',
//                                                                               style: GoogleFonts.dmSans(
//                                                                                 textStyle: TextStyle(
//                                                                                     // decoration:
//                                                                                     // TextDecoration.lineThrough,
//                                                                                     color: Black,
//                                                                                     letterSpacing: .5,
//                                                                                     fontSize: 13.sp,
//                                                                                     fontWeight: FontWeight.w500),
//                                                                               ),
//                                                                             )
//                                                                           : Text(""),
//                                                                     ],
//                                                                   ),
//                                                                   GestureDetector(
//                                                                     onTap:
//                                                                         () async {
//                                                                       await read.addToCart(
//                                                                           element
//                                                                               ?.productType,
//                                                                           element
//                                                                               ?.productUnitId,
//                                                                           element
//                                                                               ?.shopId,
//                                                                           context);
//                                                                       await read
//                                                                           .initState(
//                                                                         context,
//                                                                         element
//                                                                             ?.shopId,
//                                                                         watch
//                                                                             .cartId,
//                                                                         true,
//                                                                         "cartDetail",
//                                                                       );
//                                                                       watch.onFulFilCarvingsSelected(
//                                                                           index);
//                                                                     },
//                                                                     child: watch.isFulFilProductAdded[index] ==
//                                                                             false
//                                                                         ? SvgPicture
//                                                                             .asset(
//                                                                             'assets/images/add.svg',
//                                                                             // width: 15.w,
//                                                                             // height: 19.h,
//                                                                           )
//                                                                         : SvgPicture.asset(
//                                                                             "assets/icons/tick_green_bg.svg"),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             : Container();
//                                       }),
//                                     ),
//                                   ),
//                                 ),
//                                 // Padding(
//                                 //   padding: EdgeInsets.only(
//                                 //     top: 19.w,
//                                 //   ),
//                                 //   child: CarvingProducts(),
//                                 // )
//                               ],
//                             ),
//                           )
//                         : Container(),
//                     SizedBox(
//                       height: 30.h,
//                     ),
//                     Container(
//                       padding:
//                           EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
//                       child: Column(
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Product Details",
//                             style: GoogleFonts.dmSans(
//                               textStyle: TextStyle(
//                                   color: Black1,
//                                   // letterSpacing: .5,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                           Divider(
//                             // height: 100,
//                             color: grey2,
//                             thickness: 1,
//                             indent: 0,
//                             endIndent: 0,
//                           ),
//                           OrderProducts(),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Sub Total",
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       color: Black1,
//                                       // letterSpacing: .5,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                               Text(
//                                 "Rs. ${watch.subTotal}",
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       color: grey5,
//                                       // letterSpacing: .5,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10.w,
//                           ),
//                           Divider(
//                             // height: 100,
//                             color: grey2,
//                             thickness: 1,
//                             indent: 0,
//                             endIndent: 0,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               RichText(
//                                 text: TextSpan(children: [
//                                   TextSpan(
//                                     text: 'Discount',
//                                     style: GoogleFonts.dmSans(
//                                       textStyle: TextStyle(
//                                           color: Black1,
//                                           // letterSpacing: .5,
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.w400),
//                                     ),
//                                   ),
//                                   watch.couponCodeController.text != ""
//                                       ? TextSpan(
//                                           text:
//                                               ' (${watch.couponCodeController.text}) ',
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: SplashText,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                         )
//                                       : TextSpan(text: ""),
//                                 ]),
//                               ),
//                               Text(
//                                 "- Rs.  ${watch.couponDiscount}",
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       color: grey5,
//                                       // letterSpacing: .5,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10.w,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Delivery Charges",
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       color: Black1,
//                                       // letterSpacing: .5,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                               watch.deliveryCharges == ""
//                                   ? Text(
//                                       "Rs. 0",
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: TextStyle(
//                                             color: grey5,
//                                             // letterSpacing: .5,
//                                             fontSize: 14.sp,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                     )
//                                   : Text(
//                                       "Rs. ${watch.deliveryCharges}",
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: TextStyle(
//                                             color: grey5,
//                                             // letterSpacing: .5,
//                                             fontSize: 14.sp,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                     ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10.w,
//                           ),
//                           Divider(
//                             // height: 100,
//                             color: grey2,
//                             thickness: 1,
//                             indent: 0,
//                             endIndent: 0,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Total Amount",
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       color: Black1,
//                                       // letterSpacing: .5,
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                               Text(
//                                 "Rs. ${watch.total}",
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       color: Black1,
//                                       // letterSpacing: .5,
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w700),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10.w,
//                           ),
//                           Divider(
//                             // height: 100,
//                             color: grey2,
//                             thickness: 1,
//                             indent: 0,
//                             endIndent: 0,
//                           ),
//                           SizedBox(
//                             height: 10.w,
//                           ),
//                           Container(
//                             child: Text(
//                               "You will save Rs. ${watch.totalDiscount}",
//                               style: GoogleFonts.dmSans(
//                                 textStyle: TextStyle(
//                                     color: SplashText,
//                                     // letterSpacing: .5,
//                                     fontSize: 18.sp,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.w,
//                     ),
//                     SizedBox(
//                       height: 51.h,
//                       // width: 390.w,

//                       child: PrimaryButton(
//                         width: ScreenUtil().screenWidth,
//                         color: SplashText,
//                         onTap: () {
//                           read.onConfirmOrder(context);
//                         },

//                         child: Text(
//                           "Confirm",
//                           style: GoogleFonts.dmSans(
//                             textStyle: TextStyle(
//                                 color: Colors.white,
//                                 // letterSpacing: .5,
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),

//                         //
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/cart/view/cart_detail_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';

import 'package:local_supper_market/screen/customer/order_payment/view/order_payment_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
import 'package:local_supper_market/screen/customer/order_summary/view/address_list_sheet_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/view/coupons_list_sheet_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/view/expected_delivery_date_sheet_view.dart';
import 'package:local_supper_market/screen/customer/products/controller/product_view_controller.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/stack_loader.dart';
import 'package:provider/provider.dart';

import '../order_products.dart';

class OrderSummaryView extends StatefulWidget {
  final String? shopId;
  final String? cartId;
  final bool? isRefresh;
  final String? route;

  const OrderSummaryView(
      {super.key,
      this.cartId,
      this.shopId,
      required this.isRefresh,
      required this.route});

  @override
  State<OrderSummaryView> createState() => _OrderSummaryViewState();
}

// enum Fruit { apple, banana }

class _OrderSummaryViewState extends State<OrderSummaryView> {
  String radioButtonItem = '';
  bool showAddressModalSheet = false;

  // Group Value for Radio Button.
  int id = 1;

  @override
  void initState() {
    print(widget.shopId);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<OrderSummaryController>().initState(
            context,
            widget.shopId,
            widget.cartId,
            widget.isRefresh,
            widget.route,
          );
      if (widget.route == "editAddress") {
        showModalBottomSheet(
            backgroundColor: Colors.white,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            context: context,
            builder: (context) {
              // using a scaffold helps to more easily position the FAB
              return AddressListSheetView();
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<OrderSummaryController>();
    final read = context.read<OrderSummaryController>();
    final readMain = context.read<MainScreenController>();
    final readProductViewController = context.read<ProductViewController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Order Summary",
          onBackBtnPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartDetailView(
                          isRefresh: true,
                          shopId: watch.shopId,
                          cartId: watch.cartId,
                        )));
          },
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StackLoader(
              showLoader: watch.isStackLoaderVisible,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 17.w, top: 20.w),
                      child: Text(
                        "${watch.shopDetailData?.shopName}",

                        // "${watch.shopDetailData?.shopName}",

                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black1,
                              letterSpacing: .5,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      // height: 70.h,
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //     // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                      //     bottom: BorderSide(width: 1, color: grey2),
                      //   ),
                      // ),

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
                                  // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
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
                                      watch.shopDetailData
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
                                // onTap: () {
                                //   watch.favAllShop
                                //       ? read.removeAllShopFavList(
                                //           context, watch.shopDetailData?.id)
                                //       : read.updateAllShopFavList(
                                //           context, watch.shopDetailData?.id);
                                // },
                                onTap: () {
                                  watch.favAllShop
                                      ? read.removeAllShopFavList(
                                          context, watch.shopDetailData?.id)
                                      : read.updateAllShopFavList(
                                          context, watch.shopDetailData?.id);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 11.w,
                                      right: 11.w,
                                      top: 13.w,
                                      bottom: 13.w),
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
                    Divider(
                      // height: 100,
                      color: grey2,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 19.w, right: 77.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              watch.shopDeliveryTypes
                                          ?.shopOwnerDeliveryToCustomer ==
                                      "active"
                                  ? SecondaryRadioButton(
                                      value: "delivery_to",
                                      groupValue: watch.groupValue,
                                      // groupValue: watch.radioGroupValue,
                                      onChanged: (value) {
                                        read.onRadioButtonSelected(
                                            value, context);
                                      },
                                      leading: "")
                                  : InkWell(
                                      onTap: () {
                                        Utils.showPrimarySnackbar(context,
                                            "Cannot Select Delivery To",
                                            type: SnackType.error);
                                      },
                                      child: Container(
                                        height: 16.w,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0xff03C9CC),
                                            width: 1.w,
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Delivery To',
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
                          Row(
                            children: [
                              watch.shopDeliveryTypes
                                          ?.shopOwnerCustomerPickup ==
                                      "active"
                                  ? SecondaryRadioButton(
                                      value: "self_pickup",
                                      groupValue: watch.groupValue,
                                      onChanged: (value) {
                                        read.onRadioButtonSelected(
                                            value, context);
                                      },
                                      leading: "")
                                  : InkWell(
                                      onTap: () {
                                        Utils.showPrimarySnackbar(context,
                                            "Cannot Select  Select Pickup",
                                            type: SnackType.error);
                                      },
                                      child: Container(
                                        height: 16.w,
                                        width: 16.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0xff03C9CC),
                                            width: 1.w,
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Self Pickup',
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
                        ],
                      ),
                    ),
                    Visibility(
                      visible: watch.groupValue == "self_pickup" ? false : true,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 16.w, top: 20.w, right: 19.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: watch.customerAddress?.length ?? 0,
                          itemBuilder: (context, index) {
                            final element = watch.customerAddress![index];
                            return GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    context: context,
                                    builder: (context) {
                                      // using a scaffold helps to more easily position the FAB
                                      return AddressListSheetView();
                                    });
                              },
                              child: Container(
                                width: double.infinity,
                                child: element.addressId ==
                                        int.parse(watch.addressGroupValue)
                                    ? Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: 15.w,
                                              left: 20.w,
                                              right: 20.w,
                                              top: 15.w),
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
                                                        "${element.customerName}",
                                                        // 'Rachel Green',
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Black,
                                                              letterSpacing: .5,
                                                              fontSize: 16.sp,
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
                                                  Icon(Icons
                                                      .keyboard_arrow_down_outlined),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15.w,
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
                                                    '${element.mobileNo}',
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
                                                height: 15.w,
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
                                                      maxLines: 3,
                                                      "${element.address1} \n${element.address2} ",
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
                                      )
                                    : Container(),
                              ),
                            );
                          },
                          // child:
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 19.w, top: 32.w),
                      child: Text(
                        "Delivery Date",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              // height: 1.5,
                              color: black,
                              // letterSpacing: .05,
                              // overflow: TextOverflow.ellipsis,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20.w, right: 17.w, top: 8.w, bottom: 10.w),
                      margin: EdgeInsets.only(
                          left: 10.w, right: 17.w, top: 8.w, bottom: 10.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: grey3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "Date:",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        // height: 1.5,
                                        color: black,
                                        letterSpacing: .05,
                                        // overflow: TextOverflow.ellipsis,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                watch.slotGroupValue ==
                                            "shop_owner_slot_9_to_12" ||
                                        watch.slotGroupValue ==
                                            "shop_owner_slot_12_to_3"
                                    ? " Delivery Slot:"
                                    : "Delivery Slot",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      // height: 1.5,
                                      color: black,
                                      letterSpacing: .05,
                                      // overflow: TextOverflow.ellipsis,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                              SizedBox(width: 22.w),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          watch.expectedDateController.text != "" ||
                                  watch.slotGroupValue != ""
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          watch.expectedDateController.text,
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                // height: 1.5,
                                                color: black,
                                                // letterSpacing: .05,
                                                // overflow: TextOverflow.ellipsis,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        SvgPicture.asset(
                                          'assets/images/calender.svg',
                                          width: 12.w,
                                          height: 14.h,
                                        ),
                                      ],
                                    ),
                                    // SizedBox(
                                    //   width: 20.w,
                                    // ),
                                    Row(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.end,
                                      // mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          watch.slotGroupValue ==
                                                  "shop_owner_slot_9_to_12"
                                              ? "09:00 AM - 12:00 PM"
                                              : watch.slotGroupValue ==
                                                      "shop_owner_slot_12_to_3"
                                                  ? "12:00 PM - 03:00 PM"
                                                  : watch.slotGroupValue ==
                                                          "shop_owner_slot_3_to_6"
                                                      ? "03:00 PM - 06:00 PM"
                                                      : watch.slotGroupValue ==
                                                              "shop_owner_slot_6_to_9"
                                                          ? "06:00 PM - 09:00 PM"
                                                          : "",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                // height: 1.5,
                                                color: black,
                                                // letterSpacing: .05,
                                                // overflow: TextOverflow.ellipsis,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                backgroundColor: Colors.white,
                                                isScrollControlled: true,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30))),
                                                context: context,
                                                builder: (context) {
                                                  // using a scaffold helps to more easily position the FAB
                                                  return ExpectedDeliveryDateSheetView();
                                                });
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/pencil.svg',
                                            width: 12.w,
                                            height: 14.h,
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 5.w,
                                        // ),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
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
                                              // using a scaffold helps to more easily position the FAB
                                              return ExpectedDeliveryDateSheetView();
                                            });
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/pencil.svg',
                                        width: 12.w,
                                        height: 14.h,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 19.w, top: 30.w, right: 19.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Available Coupon Code",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  // height: 1.5,
                                  color: black,
                                  letterSpacing: .05,
                                  // overflow: TextOverflow.ellipsis,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (watch.finalCouponList!.isEmpty) {
                                Utils.showPrimarySnackbar(
                                    context, "No Coupons Found",
                                    type: SnackType.error);
                                return;
                              }
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  context: context,
                                  builder: (context) {
                                    // using a scaffold helps to more easily position the FAB
                                    return CouponsListSheetView();
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 11.33.w, vertical: 7.w),
                              decoration: BoxDecoration(
                                  color: lightsky,
                                  borderRadius: BorderRadius.circular(10.w),
                                  border: Border.all(color: SplashText)),
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      "Get Code",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                          color: SplashText),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 19.w, right: 19.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter Coupon Code",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black1,
                                  // letterSpacing: .5,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 11.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200.w,
                                height: 34.w,
                                child: TextField(
                                  controller: watch.couponCodeController,
                                  decoration: InputDecoration(
                                    fillColor: grey4,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 30.w,
                              // ),
                              SizedBox(
                                height: 32.h,
                                width: 91.w,
                                child: PrimaryButton(
                                  color: SplashText,

                                  onTap: () {
                                    read.removeCoupon(context);
                                  },
                                  child: Text(
                                    "Remove",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          // letterSpacing: .5,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),

                                  //
                                ),
                              )
                            ],
                          ),
                          watch.discountPercentage != ""
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: 'Congratulations!! ',
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: SplashText,
                                                // letterSpacing: .5,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' ${watch.discountPercentage} Discount applied successfully.',
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: SplashText,
                                                // letterSpacing: .5,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                    watch.fullFillYourCravings!.isNotEmpty
                        ? Container(
                            // height: 203.h,
                            width: ScreenUtil().screenWidth,
                            color: Coupons,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 16.w, left: 18.w),
                                  child: Text(
                                    "Fulfil your cravings",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: SplashText,
                                          // letterSpacing: .5,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(top: 15.w, bottom: 15.w),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(
                                          watch.fullFillYourCravings?.length ??
                                              0, (index) {
                                        final element =
                                            watch.fullFillYourCravings?[index];
                                        return watch
                                                        .fullFillYourCravings?[
                                                            index]
                                                        .mrpPrice !=
                                                    "" &&
                                                int.parse(element?.offerPrice ==
                                                            ""
                                                        ? "0"
                                                        : element?.offerPrice ??
                                                            "0") <
                                                    int.parse(
                                                        element?.mrpPrice ??
                                                            "0")
                                            ? Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      readProductViewController
                                                          .updateProductId(
                                                        element?.id.toString(),
                                                      );
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MainScreenView(
                                                                  index: 1,
                                                                  screenName:
                                                                      ProductScreenView(
                                                                          selectedUnitId: element
                                                                              ?.productUnitId
                                                                              .toString(),
                                                                          categoryId: element
                                                                              ?.categoryId
                                                                              .toString(),
                                                                          // categoryId: watch.categoryId,
                                                                          productId: element
                                                                              ?.id
                                                                              .toString(),
                                                                          shopId: element
                                                                              ?.shopId,
                                                                          productType:
                                                                              element?.productType),
                                                                )),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false,
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          // color: Colors.white,
                                                          // boxShadow: [
                                                          //   BoxShadow(
                                                          //       color: Colors.black
                                                          //           .withOpacity(0.03.w),
                                                          //       blurRadius: 5,
                                                          //       spreadRadius: 0,
                                                          //       offset: Offset(0, 3)),
                                                          // ],
                                                          ),
                                                      child: Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.w)),
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
                                                                  top: 14.w,
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
                                                                              color: lightgreen,
                                                                              borderRadius: BorderRadius.all(Radius.circular(5.w))),
                                                                          child:
                                                                              Center(
                                                                            child: Text("${element?.discountPercentage} off",
                                                                                // textAlign: TextAlign.center,
                                                                                style: GoogleFonts.dmSans(
                                                                                  textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                                                )),
                                                                          ),
                                                                        )
                                                                      : Container(
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
                                                                      ? Container(
                                                                          height:
                                                                              89.w,
                                                                          width:
                                                                              89.w,
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/images/profile_image.png",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          height:
                                                                              89.w,
                                                                          width:
                                                                              89.w,
                                                                          child:
                                                                              Image.network(
                                                                            "${element?.productImagePath}",
                                                                            fit:
                                                                                BoxFit.cover,
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
                                                                      maxLines:
                                                                          1,
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
                                                                children: [
                                                                  Text(
                                                                    "${element?.weight}${element?.unit}",
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                      textStyle: TextStyle(
                                                                          color: Black1,
                                                                          // letterSpacing: .5,
                                                                          fontSize: 12.sp,
                                                                          fontWeight: FontWeight.w600),
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
                                                                      element?.mrpPrice !=
                                                                              ""
                                                                          ? Text(
                                                                              '\u{20B9}${element?.mrpPrice}',
                                                                              style: GoogleFonts.dmSans(textStyle: element?.offerPrice != "" && element?.offerPrice != element?.mrpPrice ? TextStyle(decoration: TextDecoration.lineThrough, color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400) : TextStyle(color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400)))
                                                                          : Text(""),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      element?.offerPrice != "" &&
                                                                              element?.offerPrice != element?.mrpPrice
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
                                                                          : Text(""),
                                                                    ],
                                                                  ),
                                                                  // GestureDetector(
                                                                  //   onTap:
                                                                  //       () async {
                                                                  //     await read.addToCart(
                                                                  //         element
                                                                  //             ?.productType,
                                                                  //         element
                                                                  //             ?.productUnitId,
                                                                  //         element
                                                                  //             ?.shopId,
                                                                  //         context);
                                                                  //     await read
                                                                  //     .initState(
                                                                  //   context,
                                                                  //   element
                                                                  //       ?.shopId,
                                                                  //   watch
                                                                  //       .cartId,
                                                                  //   true,
                                                                  //   "cartDetail",
                                                                  // );
                                                                  //     watch.onFulFilCarvingsSelected(
                                                                  //         index);
                                                                  //   },
                                                                  //   child: watch.isFulFilProductAdded[index] ==
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
                                                                  element?.addToCartCheck ==
                                                                          "no"
                                                                      ? GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            read.addToCart(
                                                                                element?.productType,
                                                                                element?.productUnitId,
                                                                                element?.shopId,
                                                                                context);
                                                                            // watch
                                                                            //     .onOfferSelected(
                                                                            //         index);
                                                                          },
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            'assets/images/add.svg',
                                                                            // width: 15.w,
                                                                            // height: 19.h,
                                                                          ))
                                                                      : GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            read.removeFromCart(
                                                                                element?.productType,
                                                                                element?.productUnitId,
                                                                                element?.shopId,
                                                                                context);
                                                                          },
                                                                          child:
                                                                              SvgPicture.asset("assets/icons/tick_green_bg.svg"),
                                                                        ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container();
                                      }),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(
                                //     top: 19.w,
                                //   ),
                                //   child: CarvingProducts(),
                                // )
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 30.h,
                    ),
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
                          OrderProducts(),
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
                                "Rs. ${watch.subTotal}",
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
                                  watch.couponCodeController.text != ""
                                      ? TextSpan(
                                          text:
                                              ' (${watch.couponCodeController.text}) ',
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: SplashText,
                                                // letterSpacing: .5,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      : TextSpan(text: ""),
                                ]),
                              ),
                              Text(
                                "- Rs.  ${watch.couponDiscount}",
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
                              watch.deliveryCharges == ""
                                  ? Text(
                                      "Rs. 0",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: grey5,
                                            // letterSpacing: .5,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  : Text(
                                      "Rs. ${watch.deliveryCharges}",
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
                                "Rs. ${watch.total}",
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
                    SizedBox(
                      height: 10.w,
                    ),
                    SizedBox(
                      height: 51.h,
                      // width: 390.w,

                      child: PrimaryButton(
                        width: ScreenUtil().screenWidth,
                        color: SplashText,
                        onTap: () {
                          read.onConfirmOrder(context);
                        },

                        child: Text(
                          "Confirm",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // letterSpacing: .5,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),

                        //
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
