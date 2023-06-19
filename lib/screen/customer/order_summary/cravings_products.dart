// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';

// class CarvingProducts extends StatefulWidget {
//   const CarvingProducts({super.key});

//   @override
//   State<CarvingProducts> createState() => _CarvingProductsState();
// }

// class _CarvingProductsState extends State<CarvingProducts> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 140.h,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           physics: BouncingScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: 1,
//           itemBuilder: (BuildContext, index) {
//             return Row(
//               children: [
//                 Container(
//                   // padding: EdgeInsets.only(top: 30),
//                   width: 130.w,
// //                   // height: 140.h,
//                   margin: EdgeInsets.only(
//                       left: index == 0 ? 12.w : 0,
//                       right: index == 2 ? 19.w : 5.w),
//                   child: Card(
//                     // color: black,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 8.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 14.w, left: 0.w, right: 10.w),
//                                 child:
//                                     Image.asset("assets/images/redlabel.png"),
//                               ),
//                             ],
//                           ),
//                           Text(
//                             "Red Label",
//                             style: GoogleFonts.dmSans(
//                               textStyle: TextStyle(
//                                   color: Black1,
//                                   letterSpacing: .5,
//                                   fontSize: 14.sp,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 1.h,
//                           ),
//                           Text(
//                             "100g",
//                             style: GoogleFonts.dmSans(
//                               textStyle: TextStyle(
//                                   color: Black1,
//                                   letterSpacing: .5,
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             // crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 '\u{20B9}${40}',
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       color: Black1,
//                                       letterSpacing: .5,
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w600),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(right: 12.w),
//                                 child: SvgPicture.asset(
//                                   'assets/images/add.svg',
//                                   // width: 15.w,
//                                   // height: 19.h,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             );
//           }),
//     );
//   }
// }
