// import 'package:flutter/material.dart';

// import 'package:flutter/scheduler.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_my_subscription/view/s_my_subscription_plans_view.dart';
// import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/controller/s_subscription_controller.dart';
// import 'package:local_supper_market/widget/app_bar.dart';
// import 'package:local_supper_market/widget/buttons.dart';
// import 'package:local_supper_market/widget/checkbox.dart';
// import 'package:local_supper_market/widget/loader.dart';
// import 'package:local_supper_market/widget/radio_button.dart';
// import 'package:local_supper_market/widget/textfield.dart';
// import 'package:provider/provider.dart';

// class SSubscriptionScreenView extends StatefulWidget {
//   final bool? loggedIn;
//   final String? routeName;
//   final String? screenName;

//   const SSubscriptionScreenView(
//       {Key? key,
//       required this.loggedIn,
//       required this.routeName,
//       this.screenName})
//       : super(key: key);

//   @override
//   _SSubscriptionScreenViewState createState() =>
//       _SSubscriptionScreenViewState();
// }

// class _SSubscriptionScreenViewState extends State<SSubscriptionScreenView> {
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       context.read<SSubscriptionController>().initState(context);
//     });
//     print(context.read<SSubscriptionController>().subscriptionData);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final read = context.read<SSubscriptionController>();
//     final watch = context.watch<SSubscriptionController>();
//     final readMainScreen = context.read<SMainScreenController>();
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.w),
//         child: PrimaryAppBar(
//           isBackButtonEnabled: widget.loggedIn == true ? true : false,
//           // isBackButtonEnabled: false,
//           onBackBtnPressed: () {
//             print(widget.routeName);
//             if (widget.loggedIn == true) {
//               if (widget.routeName == "accounts") {
//                 readMainScreen.onNavigation(
//                     4, SMySubscriptionView(screenName: "accounts"), context);
//               } else {
//                 readMainScreen.onNavigation(
//                     0, SMySubscriptionView(screenName: "dashboard"), context);
//               }

//               readMainScreen.showBottomNavigationBar();
//             } else {
//               Navigator.pop(context);
//             }
//           },
//           title: "Subscription Plans",
//         ),
//       ),
//       body: watch.isLoading
//           ? const Loader()
//           : WillPopScope(
//               onWillPop: () async {
//                 print(widget.routeName);
//                 if (widget.loggedIn == true) {
//                   if (widget.routeName == "accounts") {
//                     readMainScreen.onNavigation(4,
//                         SMySubscriptionView(screenName: "accounts"), context);
//                   } else {
//                     readMainScreen.onNavigation(0,
//                         SMySubscriptionView(screenName: "dashboard"), context);
//                   }

//                   readMainScreen.showBottomNavigationBar();
//                 } else {
//                   Navigator.pop(context);
//                 }
//                 return false;
//               },
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Stack(
//                       alignment: Alignment.topLeft,
//                       clipBehavior: Clip.none,
//                       children: [
//                         Positioned(
//                           left: 0.w,
//                           top: -25,
//                           child: Image.asset(
//                             "assets/images/splash1.png",
//                             height: 235.w,
//                             width: 361.w,
//                           ),
//                         ),
//                         Positioned(
//                           bottom: -80.w,
//                           // top: 0,
//                           right: 0.w,
//                           child: Image.asset(
//                             "assets/images/splash2.png",
//                             height: 235.w,
//                             width: 361.w,
//                           ),
//                         ),
//                         SingleChildScrollView(
//                           physics: BouncingScrollPhysics(),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ListView.builder(
//                                   physics: NeverScrollableScrollPhysics(),
//                                   shrinkWrap: true,
//                                   itemCount:
//                                       watch.subscriptionData?.length ?? 0,
//                                   itemBuilder: (BuildContext, index) {
//                                     final element =
//                                         watch.subscriptionData?[index];
//                                     return Padding(
//                                       padding: EdgeInsets.only(
//                                           left: 19.w, top: 15.w, right: 19.w),
//                                       child: Stack(
//                                         alignment: Alignment.topCenter,
//                                         clipBehavior: Clip.none,
//                                         children: <Widget>[
//                                           Stack(
//                                             children: [
//                                               Container(
//                                                 decoration: BoxDecoration(
//                                                     color: Custlogin,
//                                                     gradient: LinearGradient(
//                                                         end:
//                                                             Alignment.topCenter,
//                                                         begin: Alignment
//                                                             .bottomCenter,
//                                                         colors: [
//                                                           index.isEven
//                                                               ? yellow1
//                                                                   .withOpacity(
//                                                                       1)
//                                                               : Color(0xff4EC0FA)
//                                                                   .withOpacity(
//                                                                       1),
//                                                           index.isEven
//                                                               ? yellow2
//                                                                   .withOpacity(
//                                                                       1)
//                                                               : Color(0xff32DFAC)
//                                                                   .withOpacity(
//                                                                       1),
//                                                         ]),

//                                                     // border: Border.all(width: 1, color: Black),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10.w)),
//                                                 child: Column(
//                                                   children: [
//                                                     SizedBox(
//                                                       height: 10.w,
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         SizedBox(
//                                                           width: 14.w,
//                                                         ),
// PrimaryRadioButton(
//   value:
//       watch.radioValue[
//           index],
//   groupValue: watch
//       .radioGrpValue,
//   onChanged: (value) {
//     read.onRadioBtnChanged(
//         value,
//         element?.id,
//         element
//             ?.subscriptionPrice);
//   },
//   leading: "",
// ),
//                                                         SizedBox(
//                                                           width: 7.w,
//                                                         ),
//                                                         Text(
//                                                           element?.planName ??
//                                                               "",
//                                                           style: TextStyle(
//                                                               color:
//                                                                   Colors.white),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     SizedBox(
//                                                       height: 30.w,
//                                                     ),
//                                                     SizedBox(
//                                                       height: 22.w,
//                                                     ),
//                                                     index.isEven
//                                                         ? ClipRRect(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10.w),
//                                                             child: Image.asset(
//                                                               'assets/images/subscription3.png',
//                                                               // width: 352.w,
//                                                               // height: 60.h,
//                                                             ),
//                                                           )
//                                                         : ClipRRect(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10.w),
//                                                             child: Image.asset(
//                                                               'assets/images/subscription2.png',
//                                                               // width: 352.w,
//                                                               // height: 60.h,
//                                                             ),
//                                                           ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                   top: 35.w,
//                                                   left: 37.w,
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         "\u{20B9} ${element?.subscriptionPrice}",
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.w400,
//                                                             color: Colors.white,
//                                                             fontSize: 28.sp),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 4.w,
//                                                       ),
//                                                       Container(
//                                                         width: ScreenUtil()
//                                                                 .screenWidth /
//                                                             1.29.w,
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(
//                                                               "${element?.validityNumbers} ${element?.validityIn} Validity",
//                                                               style: TextStyle(
//                                                                   fontSize:
//                                                                       14.sp,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   color: Colors
//                                                                       .white),
//                                                             ),
//                                                             Container(
//                                                               child:
//                                                                   GestureDetector(
//                                                                 onTap: () {
//                                                                   showDialog(
//                                                                       context:
//                                                                           context,
//                                                                       builder:
//                                                                           (context) {
//                                                                         return Dialog(
//                                                                           child:
//                                                                               SingleChildScrollView(
//                                                                             child:
//                                                                                 Column(
//                                                                               children: [
//                                                                                 Padding(
//                                                                                   padding: EdgeInsets.only(top: 11.w, right: 14.w, left: 25.w),
//                                                                                   child: Row(
//                                                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                     children: [
//                                                                                       Row(
//                                                                                         children: [
//                                                                                           Text("${element?.planName}",
//                                                                                               style: GoogleFonts.dmSans(
//                                                                                                 textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
//                                                                                               )),
//                                                                                           SizedBox(
//                                                                                             width: 2.w,
//                                                                                           ),
//                                                                                           Text("-",
//                                                                                               style: GoogleFonts.dmSans(
//                                                                                                 textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
//                                                                                               )),
//                                                                                           SizedBox(
//                                                                                             width: 2.w,
//                                                                                           ),
//                                                                                           Text("\u{20B9} ${element?.subscriptionPrice}",
//                                                                                               style: GoogleFonts.dmSans(
//                                                                                                 textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
//                                                                                               )),
//                                                                                         ],
//                                                                                       ),
//                                                                                       InkWell(
//                                                                                         onTap: () {
//                                                                                           Navigator.pop(context);
//                                                                                         },
//                                                                                         child: SvgPicture.asset("assets/icons/pop_delete.svg"),
//                                                                                       )
//                                                                                     ],
//                                                                                   ),
//                                                                                 ),
//                                                                                 Divider(),
//                                                                                 Container(
//                                                                                   padding: EdgeInsets.only(
//                                                                                     // left: 23.w,
//                                                                                     bottom: 11.6.w,
//                                                                                     // right: 16.w,
//                                                                                   ),
//                                                                                   // height:
//                                                                                   //     646.h,
//                                                                                   // width: 362.w,
//                                                                                   child: HtmlWidget(
//                                                                                     element?.planBenifits ?? "",
//                                                                                     textStyle: TextStyle(
//                                                                                         color: Black1,
//                                                                                         // height: 1.5,
//                                                                                         // letterSpacing: .05,
//                                                                                         // overflow: TextOverflow.ellipsis,
//                                                                                         fontSize: 14.sp,
//                                                                                         fontWeight: FontWeight.w400),
//                                                                                     // watch.?.description ?? "",
//                                                                                   ),
//                                                                                 )
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                         );
//                                                                       });
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   padding: EdgeInsets.symmetric(
//                                                                       horizontal:
//                                                                           11.w,
//                                                                       vertical:
//                                                                           4.w),
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             7.w),
//                                                                     color: Color(
//                                                                             0xff000000)
//                                                                         .withOpacity(
//                                                                             0.35),
//                                                                   ),
//                                                                   child: Row(
//                                                                     // mainAxisAlignment:
//                                                                     //     MainAxisAlignment.start,
//                                                                     // mainAxisSize: MainAxisSize.min,
//                                                                     children: [
//                                                                       Text(
//                                                                         'View Benefits',
//                                                                         style: GoogleFonts
//                                                                             .dmSans(
//                                                                           textStyle: TextStyle(
//                                                                               color: Colors.white,
//                                                                               // letterSpacing: .5,
//                                                                               fontSize: 12.sp,
//                                                                               fontWeight: FontWeight.w400),
//                                                                         ),
//                                                                       ), // <-- Text
//                                                                       SizedBox(
//                                                                           width:
//                                                                               4.w),
//                                                                       SvgPicture
//                                                                           .asset(
//                                                                               "assets/icons/forward1.svg"),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 22.w,
//                                                       ),
//                                                     ],
//                                                   ))
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 19.w,
//                                   top: 30.w,
//                                 ),
//                                 child: Text(
//                                   'Add on Services:',
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         color: Black,
//                                         // letterSpacing: .5,
//                                         fontSize: 18.sp,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 17.w,
//                               ),
//                               ListView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 padding: EdgeInsets.zero,
//                                 itemCount: watch.addOnServicesList?.length ?? 0,
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   final element =
//                                       watch.addOnServicesList?[index];
//                                   return Container(
//                                     padding: EdgeInsets.only(
//                                       left: 19.w,
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           // mainAxisAlignment: MainAxisAlignment.start,
//                                           children: [
//                                             PrimaryCheckBox(
//                                               onChanged: (value) {
//                                                 read.onAddOnServicesSelected(
//                                                     index, element?.id);
//                                               },
//                                               value:
//                                                   watch.selectAddonServicesList[
//                                                       index],
//                                             ),
//                                             Text(
//                                               '${element?.addOnService}',
//                                               style: GoogleFonts.dmSans(
//                                                 textStyle: TextStyle(
//                                                     color: Black1,
//                                                     // letterSpacing: .5,
//                                                     fontSize: 14.sp,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                               SizedBox(
//                                 height: 10.h,
//                               ),
//                               Padding(
//                                 padding:
//                                     EdgeInsets.only(left: 19.w, bottom: 20.w),
//                                 child: Text(
//                                   "To know more about add-on services and pricing\ndetails, request for a call back.",
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         color: Black1,
//                                         // letterSpacing: .5,
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ),
//                               // widget.routeName == "accounts"
//                               //     ? Container()
//                               //     : Column(

//                               //         children: [
//                               //           Container(
//                               //             padding: EdgeInsets.only(left: 19.w),
//                               //             child: Row(
//                               //               mainAxisAlignment:
//                               //                   MainAxisAlignment.spaceBetween,
//                               //               children: [
//                               //                 Text(
//                               //                   "Available Referal Code",
//                               //                   style: GoogleFonts.dmSans(
//                               //                     textStyle: TextStyle(
//                               //                         // height: 1.5,
//                               //                         color: black,
//                               //                         letterSpacing: .05,
//                               //                         // overflow: TextOverflow.ellipsis,
//                               //                         fontSize: 16.sp,
//                               //                         fontWeight:
//                               //                             FontWeight.w700),
//                               //                   ),
//                               //                 ),
//                               //               ],
//                               //             ),
//                               //           ),
//                               //           SizedBox(
//                               //             height: 5.h,
//                               //           ),
//                               //           Container(
//                               //             padding: EdgeInsets.only(
//                               //                 left: 19.w, right: 19.w),
//                               //             child: Column(
//                               //               crossAxisAlignment:
//                               //                   CrossAxisAlignment.start,
//                               //               children: [
//                               //                 Text(
//                               //                   "Enter Referal Code",
//                               //                   style: GoogleFonts.dmSans(
//                               //                     textStyle: TextStyle(
//                               //                         color: Black1,
//                               //                         // letterSpacing: .5,
//                               //                         fontSize: 14.sp,
//                               //                         fontWeight:
//                               //                             FontWeight.w400),
//                               //                   ),
//                               //                 ),
//                               //                 SizedBox(
//                               //                   height: 11.h,
//                               //                 ),
//                               //                 Row(
//                               //                   mainAxisAlignment:
//                               //                       MainAxisAlignment
//                               //                           .spaceBetween,
//                               //                   children: [
//                               //                     Expanded(
//                               //                       child: Container(
//                               //                         height: 34.w,
//                               //                         child: TextField(
//                               //                           controller: watch
//                               //                               .applyreferalCodeController,
//                               //                           decoration:
//                               //                               InputDecoration(
//                               //                             contentPadding:
//                               //                                 EdgeInsets.only(
//                               //                                     bottom: 10.w,
//                               //                                     left: 8.w),
//                               //                             fillColor: grey4,
//                               //                             filled: true,
//                               //                             border:
//                               //                                 OutlineInputBorder(
//                               //                               borderSide:
//                               //                                   BorderSide.none,
//                               //                               borderRadius:
//                               //                                   BorderRadius
//                               //                                       .circular(
//                               //                                           10.0),
//                               //                             ),
//                               //                           ),
//                               //                         ),
//                               //                       ),
//                               //                     ),
//                               //                     SizedBox(
//                               //                       width: 20.w,
//                               //                     ),
//                               //                     !watch.isReferalCodeApplied
//                               //                         ? SizedBox(
//                               //                             height: 32.h,
//                               //                             width: 91.w,
//                               //                             child: PrimaryButton(
//                               //                               color: SplashText,

//                               //                               onTap: () {
//                               //                                 read.applyReferCode(
//                               //                                     context);
//                               //                                 // read.removeCoupon(context, true);
//                               //                               },
//                               //                               child: Text(
//                               //                                 "Apply",
//                               //                                 style: GoogleFonts
//                               //                                     .dmSans(
//                               //                                   textStyle:
//                               //                                       TextStyle(
//                               //                                           color: Colors
//                               //                                               .white,
//                               //                                           // letterSpacing: .5,
//                               //                                           fontSize: 15
//                               //                                               .sp,
//                               //                                           fontWeight:
//                               //                                               FontWeight.w500),
//                               //                                 ),
//                               //                               ),

//                               //                               //
//                               //                             ),
//                               //                           )
//                               //                         : SizedBox(
//                               //                             height: 32.h,
//                               //                             width: 91.w,
//                               //                             child: PrimaryButton(
//                               //                               color: Colors.red,
//                               //                               onTap: () {
//                               //                                 read.removeReferCode(
//                               //                                     context);
//                               //                                 // read.removeCoupon(context, true);
//                               //                               },
//                               //                               child: Text(
//                               //                                 "Remove",
//                               //                                 style: GoogleFonts
//                               //                                     .dmSans(
//                               //                                   textStyle:
//                               //                                       TextStyle(
//                               //                                           color: Colors
//                               //                                               .white,
//                               //                                           // letterSpacing: .5,
//                               //                                           fontSize: 15
//                               //                                               .sp,
//                               //                                           fontWeight:
//                               //                                               FontWeight.w500),
//                               //                                 ),
//                               //                               ),

//                               //                               //
//                               //                             ),
//                               //                           )
//                               //                   ],
//                               //                 ),
//                               //               ],
//                               //             ),
//                               //           ),
//                               //           SizedBox(
//                               //             height: 11.h,
//                               //           ),
//                               //         ],
//                               //       ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 19.w,
//                                   // top: 30.w,
//                                 ),
//                                 child: Text(
//                                   'Mode of Payment:',
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         color: Black,
//                                         // letterSpacing: .5,
//                                         fontSize: 18.sp,
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
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 5.h,
//                                     ),
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       // mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         PrimaryCheckBox(
//                                           value: watch.isSelectedPaymentUpi,
//                                           onChanged: (value) {
//                                             read.onPaymentModeSelected(value);
//                                           },
//                                         ),
//                                         Text(
//                                           'UPI ID - ',
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Black1,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                         ),
//                                         SelectableText(
//                                           'dhanashree203@oksbi ',
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Black1,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10.h,
//                                     ),
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       // mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         PrimaryCheckBox(
//                                             onChanged: (value) {
//                                               read.onOrderedButNotFavSelected(
//                                                   context);
//                                             },
//                                             value: watch.isQrCodeSeleted
//                                             // watch.selectAddonServicesList[
//                                             //     index],
//                                             ),
//                                         Text(
//                                           'QR Code',
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Black1,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w400),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 31.h,
//                               ),
//                               Visibility(
//                                 visible: watch.isQrCodeSeleted,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       "assets/images/new_qrcode.jpg",
//                                       width: 200.w,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 20.h,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                         left: 19.w, right: 19.w),
//                                     child: Text(
//                                       'Payment Transaction ID ',
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: TextStyle(
//                                             color: Black,
//                                             letterSpacing: .5,
//                                             fontSize: 14.sp,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10.h,
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                         left: 19.w, right: 19.w),
//                                     // height: 48.h,
//                                     // width: 352.w,
//                                     child: PrimarySTextFormField(
//                                       controller: watch.transactionIdController,
//                                       hintText: "Enter Transaction ID",
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10.h,
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                         left: 19.w, right: 19.w),
//                                     child: Text(
//                                       'Copy and paste your payment successful transaction details on above input box',
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: TextStyle(
//                                             color: grey8,
//                                             letterSpacing: .5,
//                                             fontSize: 12.sp,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 31.h,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 70.h,
//                     width: 390.w,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         elevation: MaterialStateProperty.all(0),
//                         backgroundColor: MaterialStateProperty.all(SplashText),
//                       ),
//                       onPressed: () {
//                         read.buySubscriptionPlan(
//                             context, widget.loggedIn, widget.screenName);
//                       },
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 // mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   watch.planAmount != ""
//                                       ? Text(
//                                           '\u{20B9} ${(double.parse(watch.planAmount) - watch.discountAmount).round()}',
//                                           // "₹ 4,000",

//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Colors.white,
//                                                 // letterSpacing: .5,
//                                                 fontSize: 23.sp,
//                                                 fontWeight: FontWeight.w700),
//                                           ),
//                                         )
//                                       : Container(),
//                                   Text(
//                                     "Inclusive of 18% GST",
//                                     style: GoogleFonts.dmSans(
//                                       textStyle: TextStyle(
//                                           color: Colors.white,
//                                           // letterSpacing: .5,
//                                           fontSize: 12.sp,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                 child: PrimaryButton(
//                                     color: Colors.white,
//                                     height: 36.h,
//                                     width: 160.w,
//                                     onTap: () async {
//                                       print("hello");
//                                       await read.buySubscriptionPlan(context,
//                                           widget.loggedIn, widget.screenName);
//                                       // readMainScreen.onNavigation(
//                                       //     4, SShopConfigurationView(), context);
//                                       // };
//                                     },
//                                     text: 'Make Payment',
//                                     textColor: SplashText1,
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.w500),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),

//                       //
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/view/s_my_subscription_plans_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/view/s_shop_configuration_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/controller/s_subscription_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSubscriptionScreenView extends StatefulWidget {
  final bool? loggedIn;
  final String? routeName;

  const SSubscriptionScreenView(
      {Key? key, required this.loggedIn, this.routeName})
      : super(key: key);

  @override
  _SSubscriptionScreenViewState createState() =>
      _SSubscriptionScreenViewState();
}

class _SSubscriptionScreenViewState extends State<SSubscriptionScreenView> {
  late Razorpay _razorpay;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SSubscriptionController>().initState(context);
    });
    print(context.read<SSubscriptionController>().subscriptionData);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Success: ${response.paymentId}");
    final read = Provider.of<SMainScreenController>(context, listen: false);

    LoadingOverlay.of(context).hide();

    if (widget.loggedIn == true) {
      // print(screenName);
      if (widget.routeName == "dashboard") {
        read.onNavigation(
            0,
            const ShopDashBoardView(
              refresh: true,
            ),
            context);
        read.showBottomNavigationBar();
      } else {
        read.onNavigation(
            4, const SMySubscriptionView(screenName: "accounts"), context);
        read.showBottomNavigationBar();
      }
    } else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('status', 'subscriptionCompleted');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const SShopConfigurationView(initialShopConfigration: true)));
    }
    // Navigate to the CheckOrderStatusView screen
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CheckOrderStatusView(
    //       // orderId: widget.orderId.toString(),
    //       orderId: response.paymentId.toString(),
    //     ),
    //   ),
    // );${(double.parse(watch.planAmount) - watch.discountAmount).round()}
    // Show the bottom navigation bar
    // read.showBottomNavigationBar();
    // context.read<MainScreenController>().showBottomNavigationBar();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.code} - ${response.message}");
    // Handle payment error
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet: ${response.walletName}");
    // Handle external wallet
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SSubscriptionController>();
    final watch = context.watch<SSubscriptionController>();
    final readMainScreen = context.read<SMainScreenController>();
    paymentSubscription() {
      var options = {
        'key': 'rzp_live_fy46LNuzfXcOnW', // Replace with your actual API key
        'amount':
            ((double.parse(watch.planAmount) - watch.discountAmount).round() *
                100), // Amount in smallest currency unit (e.g., 100 = Rs 1)
        'name': 'Local Supermart',
        'description': ' Payment',
        // 'prefill': {
        //   'contact': '9036721241',
        //   'email': 'localsupermarts@gmail.com'
        // },
        'external': {
          'wallets': ['paytm', 'phonepe', 'googlepay'] // Add more wallets here
        }
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        print('Error: ${e.toString()}');
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          isBackButtonEnabled: widget.loggedIn == true ? true : false,
          // isBackButtonEnabled: false,
          onBackBtnPressed: () {
            print(widget.routeName);
            if (widget.loggedIn == true) {
              if (widget.routeName == "accounts") {
                readMainScreen.onNavigation(4,
                    const SMySubscriptionView(screenName: "accounts"), context);
              } else {
                readMainScreen.onNavigation(
                    0,
                    const SMySubscriptionView(screenName: "dashboard"),
                    context);
              }

              readMainScreen.showBottomNavigationBar();
            } else {
              // Navigator.pop(context);
              isBackButtonEnabled:
              false;
            }
          },
          title: "Subscription Plans",
        ),
      ),
      body: watch.isLoading
          ? const Loader()
          : WillPopScope(
              onWillPop: () async {
                print(widget.routeName);
                if (widget.loggedIn == true) {
                  if (widget.routeName == "accounts") {
                    readMainScreen.onNavigation(
                        4,
                        const SMySubscriptionView(screenName: "accounts"),
                        context);
                  } else {
                    readMainScreen.onNavigation(
                        0,
                        const SMySubscriptionView(screenName: "dashboard"),
                        context);
                  }

                  readMainScreen.showBottomNavigationBar();
                }
                // else {
                //   Navigator.pop(context);
                // }
                return false;
              },
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.topLeft,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0.w,
                          top: -25,
                          child: Image.asset(
                            "assets/images/splash1.png",
                            height: 235.w,
                            width: 361.w,
                          ),
                        ),
                        Positioned(
                          bottom: -80.w,
                          // top: 0,
                          right: 0.w,
                          child: Image.asset(
                            "assets/images/splash2.png",
                            height: 235.w,
                            width: 361.w,
                          ),
                        ),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      watch.subscriptionData?.length ?? 0,
                                  itemBuilder: (BuildContext, index) {
                                    final element =
                                        watch.subscriptionData?[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 19.w, top: 15.w, right: 19.w),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        clipBehavior: Clip.none,
                                        children: <Widget>[
                                          Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Custlogin,
                                                    gradient: LinearGradient(
                                                        end:
                                                            Alignment.topCenter,
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          index.isEven
                                                              ? yellow1
                                                                  .withOpacity(
                                                                      1)
                                                              : const Color(
                                                                      0xff4EC0FA)
                                                                  .withOpacity(
                                                                      1),
                                                          index.isEven
                                                              ? yellow2
                                                                  .withOpacity(
                                                                      1)
                                                              : const Color(
                                                                      0xff32DFAC)
                                                                  .withOpacity(
                                                                      1),
                                                        ]),

                                                    // border: Border.all(width: 1, color: Black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.w)),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10.w,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 14.w,
                                                        ),
                                                        PrimaryRadioButton(
                                                          value:
                                                              watch.radioValue[
                                                                  index],
                                                          groupValue: watch
                                                              .radioGrpValue,
                                                          onChanged: (value) {
                                                            read.onRadioBtnChanged(
                                                                value,
                                                                element?.id,
                                                                element
                                                                    ?.subscriptionPrice);
                                                          },
                                                          leading: "",
                                                        ),
                                                        SizedBox(
                                                          width: 7.w,
                                                        ),
                                                        Text(
                                                          element?.planName ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 30.w,
                                                    ),
                                                    SizedBox(
                                                      height: 22.w,
                                                    ),
                                                    index.isEven
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.w),
                                                            child: Image.asset(
                                                              'assets/images/subscription3.png',
                                                              // width: 352.w,
                                                              // height: 60.h,
                                                            ),
                                                          )
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.w),
                                                            child: Image.asset(
                                                              'assets/images/subscription2.png',
                                                              // width: 352.w,
                                                              // height: 60.h,
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                  top: 35.w,
                                                  left: 37.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "\u{20B9} ${element?.subscriptionPrice}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontSize: 28.sp),
                                                      ),
                                                      SizedBox(
                                                        height: 4.w,
                                                      ),
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                                .screenWidth /
                                                            1.29.w,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${element?.validityNumbers} ${element?.validityIn} Validity",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Container(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Dialog(
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(top: 11.w, right: 14.w, left: 25.w),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Text("${element?.planName}",
                                                                                              style: GoogleFonts.dmSans(
                                                                                                textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                                                                              )),
                                                                                          SizedBox(
                                                                                            width: 2.w,
                                                                                          ),
                                                                                          Text("-",
                                                                                              style: GoogleFonts.dmSans(
                                                                                                textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                                                                              )),
                                                                                          SizedBox(
                                                                                            width: 2.w,
                                                                                          ),
                                                                                          Text("\u{20B9} ${element?.subscriptionPrice}",
                                                                                              style: GoogleFonts.dmSans(
                                                                                                textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                                                                              )),
                                                                                        ],
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: SvgPicture.asset("assets/icons/pop_delete.svg"),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                const Divider(),
                                                                                Container(
                                                                                  padding: EdgeInsets.only(
                                                                                    // left: 23.w,
                                                                                    bottom: 11.6.w,
                                                                                    // right: 16.w,
                                                                                  ),
                                                                                  // height:
                                                                                  //     646.h,
                                                                                  // width: 362.w,
                                                                                  child: HtmlWidget(
                                                                                    element?.planBenifits ?? "",
                                                                                    textStyle: TextStyle(
                                                                                        color: Black1,
                                                                                        // height: 1.5,
                                                                                        // letterSpacing: .05,
                                                                                        // overflow: TextOverflow.ellipsis,
                                                                                        fontSize: 14.sp,
                                                                                        fontWeight: FontWeight.w400),
                                                                                    // watch.?.description ?? "",
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          11.w,
                                                                      vertical:
                                                                          4.w),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7.w),
                                                                    color: const Color(
                                                                            0xff000000)
                                                                        .withOpacity(
                                                                            0.35),
                                                                  ),
                                                                  child: Row(
                                                                    // mainAxisAlignment:
                                                                    //     MainAxisAlignment.start,
                                                                    // mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Text(
                                                                        'View Benefits',
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Colors.white,
                                                                              // letterSpacing: .5,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ), // <-- Text
                                                                      SizedBox(
                                                                          width:
                                                                              4.w),
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/forward1.svg"),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 22.w,
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 19.w,
                                  top: 30.w,
                                ),
                                child: Text(
                                  'Add on Services:',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        // letterSpacing: .5,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 17.w,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: watch.addOnServicesList?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final element =
                                      watch.addOnServicesList?[index];
                                  return Container(
                                    padding: EdgeInsets.only(
                                      left: 19.w,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            PrimaryCheckBox(
                                              onChanged: (value) {
                                                read.onAddOnServicesSelected(
                                                    index, element?.id);
                                              },
                                              value:
                                                  watch.selectAddonServicesList[
                                                      index],
                                            ),
                                            Text(
                                              '${element?.addOnService}',
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black1,
                                                    // letterSpacing: .5,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 19.w, bottom: 20.w),
                                child: Text(
                                  "To know more about add-on services and pricing\ndetails, request for a call back.",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              widget.routeName == "accounts"
                                  ? Container()
                                  : Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 19.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Available Referal Code",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      // height: 1.5,
                                                      color: black,
                                                      letterSpacing: .05,
                                                      // overflow: TextOverflow.ellipsis,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 19.w, right: 19.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Enter Referal Code",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: Black1,
                                                      // letterSpacing: .5,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 11.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 34.w,
                                                      child: TextField(
                                                        controller: watch
                                                            .applyreferalCodeController,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 10.w,
                                                                  left: 8.w),
                                                          fillColor: grey4,
                                                          filled: true,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  !watch.isReferalCodeApplied
                                                      ? SizedBox(
                                                          height: 32.h,
                                                          width: 91.w,
                                                          child: PrimaryButton(
                                                            color: SplashText,

                                                            onTap: () {
                                                              read.applyReferCode(
                                                                  context);
                                                              // read.removeCoupon(context, true);
                                                            },
                                                            child: Text(
                                                              "Apply",
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle:
                                                                    TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 15
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                              ),
                                                            ),

                                                            //
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 32.h,
                                                          width: 91.w,
                                                          child: PrimaryButton(
                                                            color: Colors.red,
                                                            onTap: () {
                                                              read.removeReferCode(
                                                                  context);
                                                              // read.removeCoupon(context, true);
                                                            },
                                                            child: Text(
                                                              "Remove",
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle:
                                                                    TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 15
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                              ),
                                                            ),

                                                            //
                                                          ),
                                                        )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 11.h,
                                        ),
                                      ],
                                    ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 19.w,
                                  // top: 30.w,
                                ),
                                child: Text(
                                  'Mode of Payment:',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        // letterSpacing: .5,
                                        fontSize: 18.sp,
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
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    // Row(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   // mainAxisAlignment: MainAxisAlignment.start,
                                    //   children: [
                                    //     PrimaryCheckBox(
                                    //       value: watch.isSelectedPaymentUpi,
                                    //       onChanged: (value) {
                                    //         read.onPaymentModeSelected(value);
                                    //       },
                                    //     ),
                                    //     Text(
                                    //       'UPI ID - ',
                                    //       style: GoogleFonts.dmSans(
                                    //         textStyle: TextStyle(
                                    //             color: Black1,
                                    //             // letterSpacing: .5,
                                    //             fontSize: 14.sp,
                                    //             fontWeight: FontWeight.w400),
                                    //       ),
                                    //     ),
                                    //     SelectableText(
                                    //       'dhanashree203@oksbi ',
                                    //       style: GoogleFonts.dmSans(
                                    //         textStyle: TextStyle(
                                    //             color: Black1,
                                    //             // letterSpacing: .5,
                                    //             fontSize: 14.sp,
                                    //             fontWeight: FontWeight.w700),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 10.h,
                                    // ),
                                    // Row(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   // mainAxisAlignment: MainAxisAlignment.start,
                                    //   children: [
                                    //     PrimaryCheckBox(
                                    //         onChanged: (value) {
                                    //           read.onOrderedButNotFavSelected(
                                    //               context);
                                    //         },
                                    //         value: watch.isQrCodeSeleted
                                    //         // watch.selectAddonServicesList[
                                    //         //     index],
                                    //         ),
                                    //     Text(
                                    //       'QR Code',
                                    //       style: GoogleFonts.dmSans(
                                    //         textStyle: TextStyle(
                                    //             color: Black1,
                                    //             // letterSpacing: .5,
                                    //             fontSize: 14.sp,
                                    //             fontWeight: FontWeight.w400),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        PrimaryCheckBox(
                                          value: watch.isSelectedPaymentOnline,
                                          onChanged: (value) {
                                            read.onPaymentModeSelectedOnline(
                                                value);
                                          },
                                        ),
                                        Text(
                                          'Online ',
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                // letterSpacing: .5,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        // SelectableText(
                                        //   'dhanashree203@oksbi ',
                                        //   style: GoogleFonts.dmSans(
                                        //     textStyle: TextStyle(
                                        //         color: Black1,
                                        //         // letterSpacing: .5,
                                        //         fontSize: 14.sp,
                                        //         fontWeight: FontWeight.w700),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 31.h,
                              ),
                              // Visibility(
                              //   visible: watch.isQrCodeSeleted,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Image.asset(
                              //         "assets/images/new_qrcode.jpg",
                              //         width: 200.w,
                              //       )
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                height: 20.h,
                              ),
                              // watch.isSelectedPaymentOnline == false
                              //     ? Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Container(
                              //             padding: EdgeInsets.only(
                              //                 left: 19.w, right: 19.w),
                              //             child: Text(
                              //               'Payment Transaction ID ',
                              //               style: GoogleFonts.dmSans(
                              //                 textStyle: TextStyle(
                              //                     color: Black,
                              //                     letterSpacing: .5,
                              //                     fontSize: 14.sp,
                              //                     fontWeight: FontWeight.w500),
                              //               ),
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: 10.h,
                              //           ),
                              //           Container(
                              //             padding: EdgeInsets.only(
                              //                 left: 19.w, right: 19.w),
                              //             // height: 48.h,
                              //             // width: 352.w,
                              //             child: PrimarySTextFormField(
                              //               controller:
                              //                   watch.transactionIdController,
                              //               hintText: "Enter Transaction ID",
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             height: 10.h,
                              //           ),
                              //           Container(
                              //             padding: EdgeInsets.only(
                              //                 left: 19.w, right: 19.w),
                              //             child: Text(
                              //               'Copy and paste your payment successful transaction details on above input box',
                              //               style: GoogleFonts.dmSans(
                              //                 textStyle: TextStyle(
                              //                     color: grey8,
                              //                     letterSpacing: .5,
                              //                     fontSize: 12.sp,
                              //                     fontWeight: FontWeight.w500),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       )
                              //     : Container(),
                              SizedBox(
                                height: 31.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                    width: 390.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(SplashText),
                      ),
                      onPressed: () {
                        // print(widget.screenName);
                        read.buySubscriptionPlan(
                            context, widget.loggedIn, widget.routeName);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  watch.planAmount != ""
                                      ? Text(
                                          '\u{20B9} ${(double.parse(watch.planAmount) - watch.discountAmount).round()}',
                                          // "₹ 4,000",

                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                // letterSpacing: .5,
                                                fontSize: 23.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      : Container(),
                                  Text(
                                    "Inclusive of 18% GST",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          // letterSpacing: .5,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: PrimaryButton(
                                    color: Colors.white,
                                    height: 36.h,
                                    width: 160.w,
                                    onTap: () async {
                                      if (watch.isSelectedPaymentOnline ==
                                          true) {
                                        print("o");
                                        // return;

                                        await paymentSubscription();

                                        print("hello");
                                        // await read.buySubscriptionPlan(context,
                                        //     widget.loggedIn, widget.routeName);
                                      } else {
                                        await read.buySubscriptionPlan(context,
                                            widget.loggedIn, widget.routeName);
                                      }
                                    },
                                    text: 'Make Payment',
                                    textColor: SplashText1,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),

                      //
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
