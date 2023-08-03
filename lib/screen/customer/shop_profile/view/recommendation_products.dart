// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
// import 'package:provider/provider.dart';
//
// import 'view_all_recommanded_products.dart';
//
// class RecommendationProducts extends StatefulWidget {
//   final String? shopId;
//   final bool? refreshPage;
//   const RecommendationProducts(
//       {super.key, required this.shopId, required this.refreshPage});
//
//   @override
//   State<RecommendationProducts> createState() => _RecommendationProductsState();
// }
//
// class _RecommendationProductsState extends State<RecommendationProducts> {
//   @override
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       context
//           .read<ShopProfileViewController>()
//           .initState(context, widget.shopId, widget.refreshPage);
//     });
//   }
//
//   setPagination() {
//     scrollController.addListener(() {
//       if (scrollController.position.pixels ==
//           scrollController.position.maxScrollExtent) {
//         SchedulerBinding.instance.addPostFrameCallback((_) {
//           context.read<AllOffersController>().onScrollMaxExtent(context,widget.shopId);
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final watch = context.watch<ShopProfileViewController>();
//     final read = context.read<ShopProfileViewController>();
//     return Container(
//       width: 352.w,
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Recommendations",
//                   style: GoogleFonts.dmSans(
//                     textStyle: TextStyle(
//                         color: DarkBlack,
//                         letterSpacing: .5,
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => MainScreenView(
//                               index: 0,
//                               screenName: AllRecommandedProductsView(
//                                 shopId: widget.shopId,
//                               ))),
//                       (Route<dynamic> route) => false,
//                     );
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //       builder: (context) => AllRecommandedProductsView(
//                     //             shopId: widget.shopId,
//                     //           )),
//                     // );
//                   },
//                   child: Text(
//                     "See all",
//                     style: GoogleFonts.dmSans(
//                       textStyle: TextStyle(
//                           color: CouponsText,
//                           letterSpacing: .5,
//                           fontSize: 11.sp,
//                           fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 15.h,
//             ),
//             Container(
//               // width: 322.w,
//               // height: 86.h,
//               // color: Colors.white,
//
//               child: ListView.builder(
//                   padding: EdgeInsets.zero,
//                   scrollDirection: Axis.vertical,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: watch.recommandedProduct?.length ?? 0,
//                   itemBuilder: (BuildContext, index) {
//                     final element = watch.recommandedProduct?[index];
//                     var row = Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 13.w),
//                               child: element?.mrpPrice != ""
//                                   ? Text('\u{20B9}${element?.mrpPrice}',
//                                       style: GoogleFonts.dmSans(
//                                           textStyle: element?.offerPrice !=
//                                                       "" &&
//                                                   element?.offerPrice !=
//                                                       element?.mrpPrice
//                                               ? TextStyle(
//                                                   decoration: TextDecoration
//                                                       .lineThrough,
//                                                   color: Black1,
//                                                   letterSpacing: .5,
//                                                   fontSize: 12.sp,
//                                                   fontWeight: FontWeight.w400)
//                                               : TextStyle(
//                                                   color: Black1,
//                                                   letterSpacing: .5,
//                                                   fontSize: 12.sp,
//                                                   fontWeight: FontWeight.w400)))
//                                   : Text(""),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(top: 13.w, left: 5.w),
//                               child: element?.offerPrice != "" &&
//                                       element?.offerPrice != element?.mrpPrice
//                                   ? Text(
//                                       '\u{20B9}${element?.offerPrice}',
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: TextStyle(
//                                             // decoration:
//                                             // TextDecoration.lineThrough,
//                                             color: Black,
//                                             letterSpacing: .5,
//                                             fontSize: 13.sp,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                     )
//                                   : Text(""),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SvgPicture.asset(
//                               'assets/images/add.svg',
//                               // width: 30.w,
//                               // height: 30.h,
//                             ),
//                           ],
//                         )
//                       ],
//                     );
//                     return Container(
//                       // color: Colors.white,
//                       decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(top: 9.h, bottom: 9.h),
//                             child: element?.productImagePath == ""
//                                 ? Image(
//                                     image: AssetImage(
//                                         "assets/images/offerone.png"),
//                                     height: 68.h,
//                                     width: 68.w,
//                                   )
//                                 : Image(
//                                     image: NetworkImage(
//                                         element?.productImagePath ?? ''),
//                                     height: 68.h,
//                                     width: 68.w,
//                                   ),
//                           ),
//                           SizedBox(
//                             height: 70.h,
//                             child: VerticalDivider(
//                                 color: lightgrey,
//                                 thickness: 0.5,
//                                 indent: 5,
//                                 endIndent: 5),
//                           ),
//                           Expanded(
//                             child: Container(
//                               padding: EdgeInsets.only(
//                                   left: 9.w, top: 10.h, right: 13.w),
//                               child: Column(
//                                 // mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Flexible(
//                                         child: Text("${element?.productName}",
//                                             style: GoogleFonts.dmSans(
//                                               textStyle: TextStyle(
//                                                   color: Black,
//                                                   letterSpacing: .5,
//                                                   fontSize: 14.sp,
//                                                   fontWeight: FontWeight.w700),
//                                             )),
//                                       ),
//                                       element?.discountPercentage != ""
//                                           ? Container(
//                                               width: 60.w,
//                                               height: 20.h,
//                                               decoration: BoxDecoration(
//                                                   color: lightgreen,
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(
//                                                               5.w))),
//                                               child: Center(
//                                                 child: Text(
//                                                     "${element?.discountPercentage} off",
//                                                     // textAlign: TextAlign.center,
//                                                     style: GoogleFonts.dmSans(
//                                                       textStyle: TextStyle(
//                                                           color: Colors.white,
//                                                           letterSpacing: .5,
//                                                           fontSize: 12.sp,
//                                                           fontWeight:
//                                                               FontWeight.w500),
//                                                     )),
//                                               ),
//                                             )
//                                           : Container(),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 6.h,
//                                   ),
//                                   Text(
//                                     "${element?.weight}${element?.unit}",
//                                     style: GoogleFonts.dmSans(
//                                       textStyle: TextStyle(
//                                           color: Grey,
//                                           letterSpacing: .5,
//                                           fontSize: 12.sp,
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                   ),
//                                   //
//                                   // SizedBox(
//                                   //   height: 10.h,
//                                   // ),
//                                   row,
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       margin: EdgeInsets.only(bottom: index == 2 ? 5 : 10.h),
//                     );
//                   }
//                   // child:
//
//                   ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
