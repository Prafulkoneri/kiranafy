import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
import 'package:provider/provider.dart';
class SeasonalProducts extends StatefulWidget {
  const SeasonalProducts({super.key});

  @override
  State<SeasonalProducts> createState() => _SeasonalProductsState();
}

class _SeasonalProductsState extends State<SeasonalProducts> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ShopProfileController>();
    final read = context.read<ShopProfileController>();
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            watch.seasonalProduct?.length??0,
            (index) {
              final element=watch.seasonalProduct?[index];
           return  element?.discountPercentage!=""?Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.03.w),
                            blurRadius: 5,
                            spreadRadius: 0,
                            offset: Offset(0, 3)),
                      ],
                    ),
                    child: Card(
                      elevation: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        width: 156.w,
                        padding: EdgeInsets.only(
                            left: 19.w, top: 14.w, right: 12.w, bottom: 12.w),
                        child: Column(
                          children: [
                            element?.discountPercentage!="" ?Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 60.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                      color: lightgreen,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.w))),
                                  child: Center(
                                    child: Text("${element?.discountPercentage} off",
                                        // textAlign: TextAlign.center,
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  ),
                                ),
                              ],
                            ):Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                element?.productImagePath == "" ?
                                Container(
                                  height: 89.w, width: 89.w,
                                  child: Image.asset(
                                    "assets/images/profile_image.png",
                                    fit: BoxFit.cover,
                                  ),
                                ) : Container(
                                  height: 89.w, width: 89.w,
                                  child: Image.network(
                                    "${element?.productImagePath}",
                                    fit: BoxFit.cover,
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
                                    maxLines: 1,
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          overflow: TextOverflow.ellipsis,
                                          // letterSpacing: .5,
                                          fontSize: 16.sp,

                                          fontWeight: FontWeight.w600,),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    element?.mrpPrice!=""?
                                    Text(
                                      '\u{20B9}${element?.mrpPrice}',
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            decoration:
                                            TextDecoration.lineThrough,
                                            color: Black1,
                                            letterSpacing: .5,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ):Text(""),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    element?.offerPrice!=""?
                                    Text(
                                      "₹${element?.offerPrice??0}",
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            // letterSpacing: .5,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ):Text(""),
                                  ],
                                ),
                                SvgPicture.asset(
                                  'assets/images/add.svg',
                                  // width: 15.w,
                                  // height: 19.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ):Container();
            }
          ),
        ),
      ),

      // ListView.builder(
      //     scrollDirection: Axis.horizontal,
      //     physics: BouncingScrollPhysics(),
      //     shrinkWrap: true,
      //     itemCount: 3,
      //     itemBuilder: (BuildContext, index) {
      //       return Row(
      //         children: [
      //           Container(
      //             // decoration: BoxDecoration(
      //             //   boxShadow: [
      //             //     BoxShadow(
      //             //       color: Colors.grey.shade200,
      //             //       spreadRadius: 10,
      //             //       blurRadius: 200,
      //             //       offset: Offset(0, 5), // changes position of shadow
      //             //     ),
      //             //   ],
      //             // ),
      //             width: 182.w,
      //             height: 156.h,
      //             margin: EdgeInsets.only(
      //                 left: index == 0 ? 19.w : 0,
      //                 right: index == 2 ? 19.w : 5.w),
      //             child: Card(
      //               elevation: 1,
      //               // color: black,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(15.0),
      //               ),
      //               child: Padding(
      //                 padding: EdgeInsets.only(left: 17.w),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Padding(
      //                           padding: EdgeInsets.only(
      //                               top: 14.w,
      //                               left: 34.w,
      //                               right: 40.w,
      //                               bottom: 2.w),
      //                           child: Card(
      //                               child: Image.asset(
      //                                   "assets/images/redlabel.png")),
      //                         ),
      //                       ],
      //                     ),
      //                     Text(
      //                       "Red Label",
      //                       style: GoogleFonts.roboto(
      //                         textStyle: TextStyle(
      //                             color: Black1,
      //                             // letterSpacing: .5,
      //                             fontSize: 16.sp,
      //                             fontWeight: FontWeight.w600),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 2.h,
      //                     ),
      //                     Text(
      //                       "100g",
      //                       style: GoogleFonts.roboto(
      //                         textStyle: TextStyle(
      //                             color: Black1,
      //                             // letterSpacing: .5,
      //                             fontSize: 12.sp,
      //                             fontWeight: FontWeight.w600),
      //                       ),
      //                     ),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.end,
      //                       children: [
      //                         Text(
      //                           '\u{20B9}${40}',
      //                           style: GoogleFonts.roboto(
      //                             textStyle: TextStyle(
      //                                 color: Black1,
      //                                 // letterSpacing: .5,
      //                                 fontSize: 12.sp,
      //                                 fontWeight: FontWeight.w600),
      //                           ),
      //                         ),
      //                         Padding(
      //                           padding: EdgeInsets.only(right: 12.w),
      //                           child: SvgPicture.asset(
      //                             'assets/images/add.svg',
      //                             // width: 15.w,
      //                             // height: 19.h,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           )
      //         ],
      //       );
      //     }),
    );
  }
}
