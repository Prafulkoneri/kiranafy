// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// // import 'package:flutter/src/widgets/placeholder.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:local_supper_market/const/color.dart';

// // class AllSeasonalProducts extends StatefulWidget {
// //   const AllSeasonalProducts({super.key});

// //   @override
// //   State<AllSeasonalProducts> createState() => _AllSeasonalProductsState();
// // }

// // class _AllSeasonalProductsState extends State<AllSeasonalProducts> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //           elevation: 0,
// //           systemOverlayStyle: SystemUiOverlayStyle(
// //             systemNavigationBarIconBrightness: Brightness.dark,
// //             // Status bar color
// //             statusBarColor: kstatusbar,
// //             // Status bar brightness (optional)
// //             statusBarIconBrightness:
// //                 Brightness.dark, // For Android (dark icons)
// //             statusBarBrightness: Brightness.dark, // For iOS (dark icons)
// //           ),
// //           toolbarHeight: 65,
// //           // backgroundColor: kappbar,
// //           leading: IconButton(
// //             icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
// //             onPressed: () => Navigator.of(context).pop(),
// //           ),
// //           title: Text(
// //             "Seasonal Product",
// //             style: GoogleFonts.dmSans(
// //               textStyle: const TextStyle(
// //                   color: Black,
// //                   letterSpacing: .5,
// //                   fontSize: 14,
// //                   fontWeight: FontWeight.w700),
// //             ),
// //           ),
// //           centerTitle: true,
// //           shape: const RoundedRectangleBorder(
// //             borderRadius: BorderRadius.vertical(
// //               bottom: Radius.circular(40),
// //             ),
// //           ),
// //           flexibleSpace: Container(
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(40),
// //               gradient: LinearGradient(
// //                   end: Alignment.topCenter,
// //                   begin: Alignment.bottomCenter,
// //                   colors: <Color>[
// //                     kstatusbar.withOpacity(0.55),
// //                     kstatusbar.withOpacity(0.98),
// //                   ]),
// //             ),
// //           ),
// //         ),
// //         body: Padding(
// //           padding:
// //               EdgeInsets.only(left: 12.h, top: 20.w, right: 12.h, bottom: 15.w),
// //           child: SizedBox(
// //             // height: 156.h,
// //             // width: 2.w,
// //             child: GridView.builder(
// //                 itemCount: 10,
// //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: 2,
// //                     crossAxisSpacing: 4.0,
// //                     mainAxisSpacing: 4.0),
// //                 itemBuilder: (BuildContext, index) {
// //                   return Container(
// //                     height: 160.h,
// //                     child: Card(
// //                       // color: black,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(15.0),
// //                       ),
// //                       child: Padding(
// //                         padding: EdgeInsets.only(left: 17.w),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Card(
// //                                 child: Image.asset(
// //                               "assets/images/mango.png",
// //                               height: 72.w,
// //                               width: 114.w,
// //                             )),
// //                             SizedBox(
// //                               height: 3.w,
// //                             ),
// //                             Text(
// //                               "Red Label",
// //                               style: GoogleFonts.dmSans(
// //                                 textStyle: TextStyle(
// //                                     color: Black1,
// //                                     letterSpacing: .5,
// //                                     fontSize: 16.sp,
// //                                     fontWeight: FontWeight.w600),
// //                               ),
// //                             ),
// //                             // SizedBox(
// //                             //   height: 2.h,
// //                             // ),
// //                             Text(
// //                               "100g",
// //                               style: GoogleFonts.dmSans(
// //                                 textStyle: TextStyle(
// //                                     color: Black1,
// //                                     letterSpacing: .5,
// //                                     fontSize: 12.sp,
// //                                     fontWeight: FontWeight.w600),
// //                               ),
// //                             ),
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               // crossAxisAlignment: CrossAxisAlignment.end,
// //                               children: [
// //                                 Text(
// //                                   '\u{20B9}${40}',
// //                                   style: GoogleFonts.dmSans(
// //                                     textStyle: TextStyle(
// //                                         color: Black1,
// //                                         letterSpacing: .5,
// //                                         fontSize: 12.sp,
// //                                         fontWeight: FontWeight.w600),
// //                                   ),
// //                                 ),
// //                                 Padding(
// //                                   padding: EdgeInsets.only(right: 10.w),
// //                                   child: SvgPicture.asset(
// //                                     'assets/images/add.svg',
// //                                     // width: 15.w,
// //                                     // height: 19.h,
// //                                   ),
// //                                 ),
// //                                 // SizedBox(
// //                                 //   height: 20.h,
// //                                 // )
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 }),
// //           ),
// //         ));
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/customer/shop_profile/controller/recommanded_controller.dart';
// import 'package:provider/provider.dart';

// class AllRecommandedProducts extends StatefulWidget {
// final String? shopId;
// const AllRecommandedProducts({super.key, required this.shopId});

//   @override
//   State<AllRecommandedProducts> createState() => _AllRecommandedProductsState();
// }

// class _AllRecommandedProductsState extends State<AllRecommandedProducts> {
// @override
// void initState() {
//   SchedulerBinding.instance.addPostFrameCallback((_) {
//     context
//         .read<ShopAllRecommandedProducts>()
//         .initState(context, widget.shopId);
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     final watch = context.watch<ShopAllRecommandedProducts>();
//     final read = context.read<ShopAllRecommandedProducts>();
//     return Scaffold(
//         // backgroundColor: Colors.red,
// appBar: AppBar(
//   elevation: 0,
//   systemOverlayStyle: SystemUiOverlayStyle(
//     systemNavigationBarIconBrightness: Brightness.dark,
//     // Status bar color
//     statusBarColor: kstatusbar,
//     // Status bar brightness (optional)
//     statusBarIconBrightness:
//         Brightness.dark, // For Android (dark icons)
//     statusBarBrightness: Brightness.dark, // For iOS (dark icons)
//   ),
//   toolbarHeight: 65,
//   // backgroundColor: kappbar,
//   leading: IconButton(
//     icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//     onPressed: () => Navigator.of(context).pop(),
//   ),
//   title: Text(
//     "Recommanded Product",
//     style: GoogleFonts.dmSans(
//       textStyle: const TextStyle(
//           color: Black,
//           letterSpacing: .5,
//           fontSize: 14,
//           fontWeight: FontWeight.w700),
//     ),
//   ),
//   centerTitle: true,
//   shape: const RoundedRectangleBorder(
//     borderRadius: BorderRadius.vertical(
//       bottom: Radius.circular(40),
//     ),
//   ),
//   flexibleSpace: Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(40),
//       gradient: LinearGradient(
//           end: Alignment.topCenter,
//           begin: Alignment.bottomCenter,
//           colors: <Color>[
//             kstatusbar.withOpacity(0.55),
//             kstatusbar.withOpacity(0.98),
//           ]),
//     ),
//   ),
// ),
//         body: Container(
//           margin: EdgeInsets.only(left: 10.w, right: 10.w),
//           child:
// GridView.builder(
//               itemCount: watch.recommandedProducts?.length ?? 0,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 4.0,
//                   mainAxisSpacing: 4.0),
// itemBuilder: (BuildContext, index) {
//   final element = watch.recommandedProducts?[index];
//   return watch.recommandedProducts?[index].mrpPrice != "" &&
//           watch.recommandedProducts?[index].offerPrice != "" &&
//           int.parse(element?.offerPrice ?? "") <
//               int.parse(element?.mrpPrice ?? "")
//       ? Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: Container(
//             padding: EdgeInsets.only(
//                 left: 17.w, right: 12.w, top: 0, bottom: 0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(right: 0.w, top: 8.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       element?.discountPercentage != ""
//                           ? Container(
//                               width: 60.w,
//                               height: 20.h,
//                               decoration: BoxDecoration(
//                                   color: lightgreen,
//                                   borderRadius: BorderRadius.all(
//                                       Radius.circular(5.w))),
//                               child: Center(
//                                 child: Text(
//                                     "${element?.discountPercentage} off",
//                                     style: GoogleFonts.dmSans(
//                                       textStyle: TextStyle(
//                                           color: Colors.white,
//                                           letterSpacing: .5,
//                                           fontSize: 12.sp,
//                                           fontWeight:
//                                               FontWeight.w500),
//                                     )),
//                               ),
//                             )
//                           : Container(),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     element?.productImagePath == ""
//                         ? Container(
//                             height: 68.w,
//                             width: 68.w,
//                             child: Image.asset(
//                               "assets/images/profile_image.png",
//                               fit: BoxFit.cover,
//                             ),
//                           )
//                         : Container(
//                             height: 68.w,
//                             width: 68.w,
//                             child: Image.network(
//                               "${element?.productImagePath}",
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                   ],
//                 ),

//                 Row(
//                   children: [
//                     Flexible(
//                       child: Text(
//                         "${element?.productName}",
//                         maxLines: 1,
//                         style: GoogleFonts.roboto(
//                           textStyle: TextStyle(
//                             color: Black1,
//                             overflow: TextOverflow.ellipsis,
//                             // letterSpacing: .5,
//                             fontSize: 16.sp,

//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // SizedBox(
//                 //   height: 2.w,
//                 // ),
//                 Row(
//                   children: [
//                     Text(
//                       "${element?.weight}${element?.unit}",
//                       style: GoogleFonts.roboto(
//                         textStyle: TextStyle(
//                             color: Black1,
//                             // letterSpacing: .5,
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // SizedBox(
//                 //   height: 2.w,
//                 // ),
//                 Container(
//                   padding:
//                       EdgeInsets.only(right: 5.w, bottom: 0.w),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           element?.mrpPrice != ""
//                               ? Text(
//                                   '\u{20B9}${element?.mrpPrice}',
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         decoration: TextDecoration
//                                             .lineThrough,
//                                         color: Black1,
//                                         letterSpacing: .5,
//                                         fontSize: 12.sp,
//                                         fontWeight:
//                                             FontWeight.w400),
//                                   ),
//                                 )
//                               : Text(""),
//                           SizedBox(
//                             width: 5.w,
//                           ),
//                           element?.offerPrice != ""
//                               ? Text(
//                                   "₹${element?.offerPrice ?? 0}",
//                                   style: GoogleFonts.roboto(
//                                     textStyle: TextStyle(
//                                         color: Black1,
//                                         // letterSpacing: .5,
//                                         fontSize: 12.sp,
//                                         fontWeight:
//                                             FontWeight.w400),
//                                   ),
//                                 )
//                               : Text(""),
//                         ],
//                       ),
//                       SvgPicture.asset(
//                         'assets/images/add.svg',
//                         // width: 15.w,
//                         // height: 19.h,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       : Container();
// }),
//         ));
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
import 'package:local_supper_market/screen/customer/shop_profile/controller/recommanded_controller.dart';
import 'package:provider/provider.dart';

class AllRecommandedProducts extends StatefulWidget {
  final String? shopId;
  const AllRecommandedProducts({super.key, required this.shopId});

  @override
  State<AllRecommandedProducts> createState() => _AllRecommandedProductsState();
}

class _AllRecommandedProductsState extends State<AllRecommandedProducts> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<AllShopRecommandedController>()
          .initState(context, widget.shopId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<AllShopRecommandedController>();
    final read = context.read<AllShopRecommandedController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          // Status bar color
          statusBarColor: kstatusbar,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        toolbarHeight: 65,
        // backgroundColor: kappbar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Recommanded Product",
          style: GoogleFonts.dmSans(
            textStyle: const TextStyle(
                color: Black,
                letterSpacing: .5,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: <Color>[
                  kstatusbar.withOpacity(0.55),
                  kstatusbar.withOpacity(0.98),
                ]),
          ),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 10.w, top: 20.w, right: 10.w),
          child: GridView.builder(
              itemCount: watch.recommandedProducts?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1.5 / 1.7),
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext, index) {
                final element = watch.recommandedProducts?[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 17.w,
                      right: 12.w,
                    ),
                    width: 156.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 0.w, top: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              element?.discountPercentage != ""
                                  ? Container(
                                      width: 60.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: lightgreen,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.w))),
                                      child: Center(
                                        child: Text(
                                            "${element?.discountPercentage} off",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: .5,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ),
                                    )
                                  : Container(
                                      width: 60.w,
                                      height: 20.h,
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            element?.productImagePath == ""
                                ? Container(
                                    height: 68.w,
                                    width: 68.w,
                                    child: Image.asset(
                                      "assets/images/profile_image.png",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 68.w,
                                    width: 68.w,
                                    child: Image.network(
                                      "${element?.productImagePath}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "${element?.productName}",
                                maxLines: 1,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    color: Black1,
                                    overflow: TextOverflow.ellipsis,
                                    // letterSpacing: .5,
                                    fontSize: 16.sp,

                                    fontWeight: FontWeight.w600,
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
                              style: GoogleFonts.roboto(
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
                        Container(
                          // padding: EdgeInsets.only(right: 0.w, bottom: 0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  element?.mrpPrice != ""
                                      ? Text('\u{20B9}${element?.mrpPrice}',
                                          style: GoogleFonts.dmSans(
                                              textStyle: element?.offerPrice !=
                                                          "" &&
                                                      element?.offerPrice !=
                                                          element?.mrpPrice
                                                  ? TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Black1,
                                                      letterSpacing: .5,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400)
                                                  : TextStyle(
                                                      color: Black1,
                                                      letterSpacing: .5,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400)))
                                      : Text(""),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  element?.offerPrice != "" &&
                                          element?.offerPrice !=
                                              element?.mrpPrice
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
                              SvgPicture.asset(
                                'assets/images/add.svg',
                                // width: 15.w,
                                // height: 19.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
