// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/widget/app_bar.dart';
// import 'package:local_supper_market/widget/buttons.dart';
// import 'package:local_supper_market/widget/checkbox.dart';
// import 'package:local_supper_market/widget/textfield.dart';
//
// class CustomerProductReturnView extends StatefulWidget {
//   const CustomerProductReturnView({super.key});
//
//   @override
//   State<CustomerProductReturnView> createState() =>
//       _CustomerProductReturnViewState();
// }
//
// class _CustomerProductReturnViewState extends State<CustomerProductReturnView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.w),
//         child: PrimaryAppBar(
//           onBackBtnPressed: () {
//             Navigator.pop(context);
//           },
//           title: "Product Return Request",
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Container(
//           padding:
//               EdgeInsets.only(left: 19.w, bottom: 17.w, top: 20.w, right: 19.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Order ID: LSM012334",
//                   style: GoogleFonts.roboto(
//                     textStyle: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w700,
//                         color: Black1),
//                   )),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Text("New Balaji Trading Company",
//                   style: GoogleFonts.roboto(
//                     textStyle: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Black1),
//                   )),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Text("Order Amount -",
//                           style: GoogleFonts.roboto(
//                             textStyle: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: Black1),
//                           )),
//                       Text("INR 2500",
//                           style: GoogleFonts.roboto(
//                             textStyle: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w400,
//                                 color: Black1),
//                           )),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("Total Products ",
//                           style: GoogleFonts.roboto(
//                             textStyle: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w500,
//                                 color: Black1),
//                           )),
//                       Text(" - 8",
//                           style: GoogleFonts.roboto(
//                             textStyle: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w400,
//                                 color: Black1),
//                           )),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Divider(
//                 thickness: 1,
//                 color: Color(0xffEFEFEF),
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               PrimaryCheckBox(),
//                               Image.asset(
//                                 "assets/images/RED.png",
//                                 width: 44.w,
//                                 height: 44.w,
//                               ),
//                               SizedBox(
//                                 width: 16.w,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Red Label",
//                                       style: GoogleFonts.roboto(
//                                         textStyle: TextStyle(
//                                             fontSize: 14.sp,
//                                             fontWeight: FontWeight.w500,
//                                             color: Black1),
//                                       )),
//                                   SizedBox(
//                                     height: 5.h,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "500g x ",
//                                         style: GoogleFonts.dmSans(
//                                           textStyle: TextStyle(
//                                               color: grey5,
//                                               // letterSpacing: .5,
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                       Text(
//                                         "2",
//                                         style: GoogleFonts.dmSans(
//                                           textStyle: TextStyle(
//                                               color: grey5,
//                                               // letterSpacing: .5,
//                                               fontSize: 14.sp,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Text("INR 500",
//                               style: GoogleFonts.roboto(
//                                 textStyle: TextStyle(
//                                     fontSize: 14.sp,
//                                     fontWeight: FontWeight.w500,
//                                     color: Black1),
//                               )),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       )
//                     ],
//                   );
//                 },
//               ),
//               Divider(
//                 thickness: 1,
//                 color: Color(0xffEFEFEF),
//               ),
//               SizedBox(
//                 height: 15.01.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("3 Products Return",
//                       style: GoogleFonts.roboto(
//                         textStyle: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400,
//                             color: Black1),
//                       )),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text("Refund Amount",
//                           style: GoogleFonts.roboto(
//                             textStyle: TextStyle(
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.w400,
//                                 color: Black1),
//                           )),
//                       Text("INR 605",
//                           style: GoogleFonts.roboto(
//                             textStyle: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w700,
//                                 color: Black1),
//                           )),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15.99.h,
//               ),
//               Divider(
//                 thickness: 1,
//                 color: Color(0xffEFEFEF),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Reason",
//                     style: TextStyle(
//                         color: Color(0xff3A3A3A),
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: 12.h,
//                   ),
//                   ListView.builder(
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: 2,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       // final element = watch.cancelReasondata?[index];
//                       return Column(
//                         children: [
//                           Row(
//                             children: [
//                               PrimaryCheckBox(
//                                   // value: watch.isSelectedReason[index],
//                                   // onChanged: (value) {
//                                   //   read.onSelectReason(index, value, element?.id);
//                                   // },
//                                   ),
//                               Flexible(
//                                 child: Text(
//                                   "Product no longer needed",
//                                   // "${element?.reason}",
//                                   style: TextStyle(
//                                       color: Black1,
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 15.h,
//                           )
//                         ],
//                       );
//                     },
//                   ),
//                   SizedBox(
//                     height: 10.w,
//                   ),
//                   PrimaryCTextFormField(
//                     height: 150.w,
//                     maxLines: 10,
//                   ),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   PrimaryButton(
//                     onTap: () {
//                       // read.CustomerOrderCancel(
//                       //   context,
//                       //   watch.orderId,
//                       //   watch.orderCancelledReason,
//                       //   watch.orderCancelledReasonId,
//                       // );
//                     },
//                     color: Color(0xff39C19D),
//                     child: Text(
//                       'Submit',
//                       style: GoogleFonts.dmSans(
//                         textStyle: const TextStyle(
//                             color: Colors.white,
//                             letterSpacing: .5,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // SizedBox(
//               //   height: 100.h,
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
