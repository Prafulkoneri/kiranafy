// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/customer/order_summery/order_products.dart';

// class OrderDeliveryView extends StatefulWidget {
//   const OrderDeliveryView({super.key});

//   @override
//   State<OrderDeliveryView> createState() => _OrderDeliveryViewState();
// }

// // enum Fruit { apple, banana }

// class _OrderDeliveryViewState extends State<OrderDeliveryView> {
//   String radioButtonItem = '';

//   // Group Value for Radio Button.
//   int id = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         systemOverlayStyle: SystemUiOverlayStyle(
//           systemNavigationBarIconBrightness: Brightness.dark,
//           // Status bar color
//           statusBarColor: kstatusbar,
//           // Status bar brightness (optional)
//           statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
//           statusBarBrightness: Brightness.dark, // For iOS (dark icons)
//         ),
//         toolbarHeight: 65,
//         // backgroundColor: kappbar,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           "Order",
//           style: GoogleFonts.dmSans(
//             textStyle: const TextStyle(
//                 color: Black,
//                 letterSpacing: .5,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700),
//           ),
//         ),
//         centerTitle: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(40),
//           ),
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(40),
//             gradient: LinearGradient(
//                 end: Alignment.topCenter,
//                 begin: Alignment.bottomCenter,
//                 colors: <Color>[
//                   kstatusbar.withOpacity(0.55),
//                   kstatusbar.withOpacity(0.98),
//                 ]),
//           ),
//         ),
//       ),
//       // backgroundColor: backgroundColor,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 15.w, top: 20.w),
//               child: Text(
//                 "New Balaji Trading Company",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: Black1,
//                       letterSpacing: .5,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//             Container(
//               height: 70.h,
//               decoration: BoxDecoration(
//                 border: Border(
//                   // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
//                   bottom: BorderSide(width: 1, color: grey2),
//                 ),
//               ),

//               // color: Colors.white,
//               child: Row(
//                 children: [
//                   Padding(
//                     padding:
//                         EdgeInsets.only(left: 12.w, top: 20.w, bottom: 20.w),
//                     child: SvgPicture.asset(
//                       'assets/images/location2.svg',
//                       // width: 15.w,
//                       // height: 19.h,
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         EdgeInsets.only(left: 8.w, top: 24.w, bottom: 15.w),
//                     child: Text(
//                       "Bhairav Nagar, Vishrantwadi\nPune - 411015",
//                       style: GoogleFonts.dmSans(
//                         textStyle: TextStyle(
//                             color: Black,
//                             letterSpacing: .5,
//                             fontSize: 13.sp,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         left: 36.h, right: 11.w, top: 10.w, bottom: 12.w),
//                     child: Row(
//                       children: [
//                         SvgPicture.asset(
//                           'assets/images/call.svg',
//                           // width: 15.w,
//                           // height: 19.h,
//                         ),
//                         SizedBox(
//                           width: 12.w,
//                         ),
//                         SvgPicture.asset(
//                           'assets/images/fvrt.svg',
//                           // width: 15.w,
//                           // height: 19.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 20.w, right: 17.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Order ID: LSM012334",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Black,
//                           letterSpacing: .5,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 22.h,
//                     width: 85.w,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         elevation: MaterialStateProperty.all(0),
//                         // backgroundColor: ,
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.white),
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             side: BorderSide(
//                               color: SplashText,
//                               // width: 1,
//                             ),
//                           ),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         "Delivered",
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: SplashText,
//                               // letterSpacing: .5,
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),

//                       //
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 left: 20.w,
//               ),
//               child: Row(
//                 children: [
//                   Text(
//                     "28 March 2023",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Black,
//                           letterSpacing: .5,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   SizedBox(width: 9.w),
//                   Text(
//                     "11:34 am",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Black,
//                           letterSpacing: .5,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 20.w, top: 17.w, right: 19.w),
//               child: Container(
//                 height: 47.h,
//                 width: 351.w,
//                 decoration: BoxDecoration(
//                     border: Border.all(color: SplashText),
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 13.w, right: 19.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Delivery Code",
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: Black,
//                               letterSpacing: .5,
//                               fontSize: 17.sp,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Text(
//                         "243986",
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: SplashText,
//                               letterSpacing: .5,
//                               fontSize: 22.sp,
//                               fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 20.w, top: 19.w, bottom: 10.w),
//               child: Text(
//                 "Delivery Address",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: Black,
//                       letterSpacing: .5,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 16.w, right: 10.w),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Container(
//                   height: 156.h,
//                   // width: double.infinity,
//                   // width: 400.w,
//                   // decoration: BoxDecoration(
//                   //     // color: grey7,
//                   //     border: Border.all(color: grey7),
//                   //     borderRadius: BorderRadius.all(Radius.circular(20))),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: 20.w,
//                           top: 20.w,
//                         ),
//                         child: Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,/
//                           children: [
//                             SvgPicture.asset(
//                               'assets/images/person.svg',
//                               width: 11.w,
//                               height: 15.h,
//                             ),
//                             SizedBox(
//                               width: 11.w,
//                             ),
//                             Text(
//                               'Rachel Green',
//                               style: GoogleFonts.dmSans(
//                                 textStyle: TextStyle(
//                                     color: Black,
//                                     letterSpacing: .5,
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             ),
//                             // SizedBox(
//                             //   width: 11.w,
//                             // ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 75.w),
//                               child: SizedBox(
//                                 height: 21.h,
//                                 width: 71.w,
//                                 child: ElevatedButton(
//                                   style: ButtonStyle(
//                                     elevation: MaterialStateProperty.all(0),
//                                     // backgroundColor: ,
//                                     backgroundColor:
//                                         MaterialStateProperty.all(Colors.white),
//                                     shape: MaterialStateProperty.all(
//                                       RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         side: BorderSide(
//                                           color: lighrgreen,
//                                           // width: 1,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   onPressed: () {},
//                                   child: Text(
//                                     "Home",
//                                     style: GoogleFonts.dmSans(
//                                       textStyle: TextStyle(
//                                           color: SplashText1,
//                                           // letterSpacing: .5,
//                                           fontSize: 12.sp,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ),

//                                   //
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: 19.w,
//                           top: 20.w,
//                         ),
//                         child: Row(
//                           children: [
//                             SvgPicture.asset(
//                               'assets/images/phone.svg',
//                               width: 14.w,
//                               height: 15.h,
//                             ),
//                             SizedBox(
//                               width: 11.w,
//                             ),
//                             Text(
//                               '+91 986 095 3315',
//                               style: GoogleFonts.dmSans(
//                                 textStyle: TextStyle(
//                                     color: Black,
//                                     letterSpacing: .5,
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.w400),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: 19.w,
//                           top: 19.w,
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SvgPicture.asset(
//                               'assets/images/location.svg',
//                               color: SplashText1,
//                               width: 17.w,
//                               height: 17.h,
//                             ),
//                             SizedBox(
//                               width: 11.w,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 maxLines: 3,
//                                 "Nand Nivas Building floor 3 B-3,Lane No.13 Bhatrau Nivas Vishrantwadi Pune -411015.",
//                                 // textAlign: TextAlign.start,
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       // height: 1.5,
//                                       color: black,
//                                       // letterSpacing: .05,
//                                       // overflow: TextOverflow.ellipsis,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   left: 19.w, right: 0.w, bottom: 0.w, top: 20.w),
//               child: Row(
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     height: 38.h,
//                     width: 150.w,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         elevation: MaterialStateProperty.all(0),
//                         // backgroundColor: ,
//                         backgroundColor: MaterialStateProperty.all(SplashText),
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             // side: BorderSide(
//                             //   color: SplashText,
//                             //   // width: 1,
//                             // ),
//                           ),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         "Reorder",
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: Colors.white,
//                               // letterSpacing: .5,
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),

//                       //
//                     ),
//                   ),
//                   SizedBox(
//                     width: 25.w,
//                   ),
//                   SizedBox(
//                     height: 38.h,
//                     width: 150.w,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         elevation: MaterialStateProperty.all(0),
//                         // backgroundColor: ,
//                         backgroundColor: MaterialStateProperty.all(SplashText1),
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             // side: BorderSide(
//                             //   color: SplashText,
//                             //   // width: 1,
//                             // ),
//                           ),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         "Invoice",
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: Colors.white,
//                               // letterSpacing: .5,
//                               fontSize: 15.sp,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),

//                       //
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   left: 19.w, right: 19.w, top: 25.w, bottom: 15.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     "Expected Delivery Date:",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Black,
//                           // letterSpacing: .5,
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   // SizedBox(width: 10.w),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "29 March 2023",
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: SplashText,
//                               // letterSpacing: .5,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30.h,
//                         width: 100.w,
//                         child: ElevatedButton(
//                           style: ButtonStyle(
//                             elevation: MaterialStateProperty.all(0),
//                             // backgroundColor: ,
//                             backgroundColor: MaterialStateProperty.all(
//                                 SplashText.withOpacity(0.3)),
//                             shape: MaterialStateProperty.all(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 side: BorderSide(
//                                   color: SplashText,
//                                   // width: 1,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: Text(
//                             "Track Order",
//                             style: GoogleFonts.dmSans(
//                               textStyle: TextStyle(
//                                   color: Black,
//                                   // letterSpacing: .5,
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),

//                           //
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             //
//             Padding(
//               padding: EdgeInsets.only(top: 0.w),
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 19.w, bottom: 17.w),
//                     child: Text(
//                       "Product Details",
//                       style: GoogleFonts.dmSans(
//                         textStyle: TextStyle(
//                             color: Black1,
//                             // letterSpacing: .5,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 19.w, right: 19.w),
//                     child: Divider(
//                       // height: 100,
//                       color: grey2,
//                       thickness: 1,
//                       // indent: 10,
//                       // endIndent: 5,
//                     ),
//                   ),
//                   OrderProducts()
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Sub Total",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Black1,
//                           // letterSpacing: .5,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   Text(
//                     "Rs. 200",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: grey5,
//                           // letterSpacing: .5,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   left: 19.w, right: 19.w, bottom: 10.w, top: 10.w),
//               child: Divider(
//                 // height: 100,
//                 color: grey2,
//                 thickness: 1,
//                 // indent: 10,
//                 // endIndent: 5,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   RichText(
//                     text: TextSpan(children: [
//                       TextSpan(
//                         text: 'Discount!!',
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: Black1,
//                               // letterSpacing: .5,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                       TextSpan(
//                         text: '  (PROMO0001AFF) ',
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: SplashText,
//                               // letterSpacing: .5,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ]),
//                   ),
//                   Text(
//                     " - Rs. 20",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: grey5,
//                           // letterSpacing: .5,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Delivery Charges",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Black1,
//                           // letterSpacing: .5,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   Text(
//                     "Rs. 0",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: grey5,
//                           // letterSpacing: .5,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   left: 19.w, right: 19.w, bottom: 10.w, top: 10.w),
//               child: Divider(
//                 // height: 100,
//                 color: grey2,
//                 thickness: 1,
//                 // indent: 10,
//                 // endIndent: 5,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Total Amount",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Black1,
//                           // letterSpacing: .5,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   Text(
//                     "Rs. 170",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Black1,
//                           // letterSpacing: .5,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 left: 19.w,
//                 right: 19.w,
//                 // bottom: 10.w,
//               ),
//               child: Divider(
//                 // height: 100,
//                 color: grey2,
//                 thickness: 1,
//                 // indent: 10,
//                 // endIndent: 5,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 10.w, bottom: 10.w),
//               child: Text(
//                 "You will save Rs. 20",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: SplashText,
//                       // letterSpacing: .5,
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 left: 19.w,
//               ),
//               child: Text(
//                 "Mode of Payment",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: Black,
//                       // letterSpacing: .5,
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 5.w),
//               child: Text(
//                 "Cash on Delivery",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: Black,
//                       // letterSpacing: .5,
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 15.w, right: 19.w),
//               child: SizedBox(
//                 height: 38.h,
//                 width: 352.w,
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     elevation: MaterialStateProperty.all(0),
//                     // backgroundColor: ,
//                     backgroundColor: MaterialStateProperty.all(DarkGrey),
//                     shape: MaterialStateProperty.all(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         // side: BorderSide(
//                         //   color: SplashText,
//                         //   // width: 1,
//                         // ),
//                       ),
//                     ),
//                   ),
//                   onPressed: () {},
//                   child: Text(
//                     "Product Return Request",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Colors.white,
//                           // letterSpacing: .5,
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),

//                   //
//                 ),
//               ),
//             ),

//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 15.w),
//               child: Text(
//                 "Your Ratings",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: Black,
//                       // letterSpacing: .5,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 10.w),
//               child: Row(
//                 children: [
//                   SvgPicture.asset(
//                     'assets/images/stars.svg',
//                     // width: 15.w,
//                     // height: 19.h,
//                   ),
//                   SizedBox(
//                     width: 10.w,
//                   ),
//                   SvgPicture.asset(
//                     'assets/images/stars.svg',
//                     // width: 15.w,
//                     // height: 19.h,
//                   ),
//                   SizedBox(
//                     width: 10.w,
//                   ),
//                   SvgPicture.asset(
//                     'assets/images/stars.svg',
//                     // width: 15.w,
//                     // height: 19.h,
//                   ),
//                   SizedBox(
//                     width: 10.w,
//                   ),
//                   SvgPicture.asset(
//                     'assets/images/stars.svg',
//                     // width: 15.w,
//                     // height: 19.h,
//                   ),
//                   SizedBox(
//                     width: 10.w,
//                   ),
//                   SvgPicture.asset(
//                     'assets/images/stars.svg',
//                     // width: 15.w,
//                     // height: 19.h,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 30.w),
//               child: Text(
//                 "Your Feedback",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: Black,
//                       // letterSpacing: .5,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
//               child: SizedBox(
//                 height: 104.h,
//                 width: 352.w,
//                 // height: 200.h,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 80.w), // <-- SEE HERE

//                     fillColor: Colors.white,
//                     // border: OutlineInputBorder(
//                     //   borderRadius: BorderRadius.circular(10.0),
//                     //   borderSide: BorderSide(width: 100, color: grey6
//                     //       // style: BorderStyle.none,
//                     //       ),
//                     // ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         width: 0,
//                         style: BorderStyle.none,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           BorderSide(width: 1, color: grey6), //<-- SEE HERE
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     filled: true,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 19.w, top: 15.w, right: 19.w),
//               child: SizedBox(
//                 height: 38.h,
//                 width: 352.w,
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     elevation: MaterialStateProperty.all(0),
//                     // backgroundColor: ,
//                     backgroundColor: MaterialStateProperty.all(SplashText),
//                     shape: MaterialStateProperty.all(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         // side: BorderSide(
//                         //   color: SplashText,
//                         //   // width: 1,
//                         // ),
//                       ),
//                     ),
//                   ),
//                   onPressed: () {},
//                   child: Text(
//                     "Submit",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: Colors.white,
//                           // letterSpacing: .5,
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),

//                   //
//                 ),
//               ),
//             ),

//             Container(
//               width: 352.h,
//               height: 161.w,
//               decoration: BoxDecoration(
//                 // color: Colors.red,
//                 border: Border.all(),
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               ),
//               child: Row(
//                 children: [
//                   // CircleAvatar(
//                   //   backgroundColor: Colors.black,
//                   //   radius: 50,
//                   //   child: CircleAvatar(
//                   //     // radius: 100,/

//                   //     child: SvgPicture.asset(
//                   //       'assets/images/profile.svg',
//                   //       width: 15.w,
//                   //       height: 19.h,
//                   //     ),
//                   //     radius: 50,
//                   //   ),
//                   // ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
