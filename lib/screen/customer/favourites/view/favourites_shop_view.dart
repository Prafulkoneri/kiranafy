// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
//
//
// class CFavouritesShopView extends StatefulWidget {
//   const CFavouritesShopView({super.key});
//
//   @override
//   State<CFavouritesShopView> createState() => _CFavouritesShopViewState();
// }
//
// class _CFavouritesShopViewState extends State<CFavouritesShopView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SizedBox(
//         child: ListView.builder(
//             // scrollDirection: Axis.vertical,p
//             physics: NeverScrollableScrollPhysics(),
//             // physics: BouncingScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: 10,
//             itemBuilder: (BuildContext, index) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ShopProfile()),
//                   );
//                 },
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           left: 19.w,
//                           right: 12,
//                           // top: 20.w,
//                           bottom: 14.w),
//                       child: Container(
//                         height: 160.h,
//                         width: 352.w,
//
//                         // margin: EdgeInsets.only(
//                         //     left: index == 0 ? 19.w : 0,
//                         //     right: index == 2 ? 19.w : 5.w),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15.w),
//                             image: DecorationImage(
//                                 // scale: 1.0,
//                                 image:
//                                     AssetImage('assets/images/nearshop2.png'),
//                                 fit: BoxFit.fill)),
//                         child: Padding(
//                           padding: EdgeInsets.all(10.h),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {},
//                                     child: SvgPicture.asset(
//                                       "assets/images/favorite.svg",
//                                       width: 26.w,
//                                       height: 14.h,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text("New Balaji Trading Co..",
//                                           style: GoogleFonts.roboto(
//                                               textStyle: TextStyle(
//                                                   color: Colors.white,
//                                                   // letterSpacing: .5,
//                                                   fontSize: 15.sp,
//                                                   fontWeight:
//                                                       FontWeight.w600))),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           SvgPicture.asset(
//                                               "assets/icons/location1.svg",
//                                               width: 12.w,
//                                               height: 16.h),
//                                           Padding(
//                                             padding: EdgeInsets.only(left: 8.w),
//                                             child: Text("Vishrantwadi, Pune",
//                                                 style: GoogleFonts.roboto(
//                                                     textStyle: TextStyle(
//                                                         color: Colors.white,
//                                                         letterSpacing: .5,
//                                                         fontSize: 12.sp,
//                                                         // height: 10,
//                                                         fontWeight:
//                                                             FontWeight.w400))),
//                                           ),
//                                         ],
//                                       ),
//                                       Container(
//                                         height: 21.49.h,
//                                         width: 49.w,
//                                         decoration: BoxDecoration(
//                                           color: yellow,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15)),
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             SvgPicture.asset(
//                                               "assets/images/star.svg",
//                                               height: 12.h,
//                                               width: 12.w,
//                                             ),
//                                             SizedBox(
//                                               width: 4.3.w,
//                                             ),
//                                             Text(
//                                               "0.0",
//                                               style: GoogleFonts.dmSans(
//                                                 textStyle: TextStyle(
//                                                     color: Black,
//                                                     letterSpacing: .5,
//                                                     fontSize: 12.sp,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         child: Container(
//                       margin: EdgeInsets.only(
//                           left: index == 0 ? 19.w : 0,
//                           right: index == 2 ? 19.w : 5.w),
//                       height: 160.h,
//                       width: 352.w,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(13.w),
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             stops: [
//                               0.1,
//                               0.9,
//                             ],
//                             colors: [
//                               Colors.white.withOpacity(0),
//                               Colors.black.withOpacity(0.15),
//                             ],
//                           )),
//                     )),
//                   ],
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }
