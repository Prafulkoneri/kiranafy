// import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';

// class Coupons extends StatefulWidget {
//   const Coupons({super.key});

//   @override
//   State<Coupons> createState() => _CouponsState();
// }

// class _CouponsState extends State<Coupons> {
//   @override
//   Widget build(BuildContext context) {
//     return  Container (
//               height: 210.h,
//               width: 400.w,
//               // decoration:  const BoxDecoration(color: Coupons),
//               decoration: BoxDecoration(color: Coupons),
//               child: Padding(
//                 padding: EdgeInsets.all(15.h),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Coupons For You",
//                             style: GoogleFonts.dmSans(
//                               textStyle: TextStyle(
//                                   color: Black,
//                                   letterSpacing: .5,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           Text(
//                             "See all",
//                             style: GoogleFonts.dmSans(
//                               textStyle: TextStyle(
//                                   color: CouponsText,
//                                   letterSpacing: .5,
//                                   fontSize: 11.sp,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       Text(
//                         "Popular Offers of the Day",
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: Grey,
//                               letterSpacing: .5,
//                               fontSize: 11.sp,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),

//                       Stack(
//                         alignment: AlignmentDirectional.centerStart,
//                         children: <Widget>[
//                           Container(
//                             height: 125.h, width: 352.w,

//                             // padding: EdgeInsets.only(bottom: 400),
//                             padding: EdgeInsets.only(bottom: 18.h),
//                             child: AspectRatio(
//                               aspectRatio: 2.6,
//                               child: Image.asset('assets/images/Coupons.png',
//                                   height: 125.h, width: 352.w
//                                   // fit: BoxFit.cover
//                                   ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: 35.h,
//                               bottom: 20.h,
//                             ),
//                             child: ClipRRect(
//                               // borderRadius: new BorderRadius.circular(40.0),
//                               child: Image.asset(
//                                   'assets/images/couponslogo.png',
//                                   height: 62.h,
//                                   width: 38.w),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: 80.h,
//                               bottom: 20.h,
//                             ),
//                             child: FDottedLine(
//                               color: Grey,
//                               height: 100.0,
//                               strokeWidth: 2.0,
//                               dottedLength: 18.0,
//                               space: 2.0,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 75.h, bottom: 25.h),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   // crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text(
//                                       "Hi Choice Supermarket",
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: TextStyle(
//                                             color: Black,
//                                             letterSpacing: .5,
//                                             fontSize: 12.sp,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                     ),
//                                     // SizedBox(
//                                     //   width: 5.w,
//                                     // ),
//                                     SvgPicture.asset(
//                                       'assets/images/logo1.svg',
//                                       width: 15.w,
//                                       height: 15.h,
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Column(
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                         left: 18.h,
//                                       ),
//                                       child: Text(
//                                         "Valid until 16 March 2023",
//                                         style: GoogleFonts.dmSans(
//                                           textStyle: TextStyle(
//                                               color: Black,
//                                               letterSpacing: .5,
//                                               fontSize: 10.sp,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(left: 18.0.h),
//                                       child: Text("50% OFF",
//                                           style: GoogleFonts.dmSans(
//                                             textStyle: TextStyle(
//                                                 color: Black,
//                                                 letterSpacing: .5,
//                                                 fontSize: 15.sp,
//                                                 fontWeight: FontWeight.w700),
//                                           )),
//                                     ),
//                                     SizedBox(
//                                       width: 12.w,
//                                     ),
//                                     Text("UPTO ₹120",
//                                         style: GoogleFonts.dmSans(
//                                           textStyle: TextStyle(
//                                               color: Grey,
//                                               letterSpacing: .5,
//                                               fontSize: 10.sp,
//                                               fontWeight: FontWeight.w400),
//                                         ))
//                                   ],
//                                 ),
//                                 Padding(
//                                   padding:
//                                       EdgeInsets.only(left: 18.0.h, top: 5.h),
//                                   child: SizedBox(
//                                     width: 115.w,
//                                     height: 30.h,
//                                     child: ElevatedButton(
//                                       // style: ElevatedButton.styleFrom(
//                                       //   //<-- SEE HERE
//                                       //   side: BorderSide(
//                                       //     width: 3.0,
//                                       //   ),
//                                       // ),
//                                       style: ButtonStyle(
//                                         // backgroundColor: ,
//                                         backgroundColor:
//                                             MaterialStateProperty.all(
//                                                 Colors.white),
//                                         shape: MaterialStateProperty.all(
//                                           RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                             side: const BorderSide(
//                                                 width: 1, color: SplashText),
//                                           ),
//                                         ),
//                                       ),
//                                       onPressed: () {},
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(
//                                             "OFF100",
//                                             style: GoogleFonts.dmSans(
//                                               textStyle: TextStyle(
//                                                   color: SplashText,
//                                                   letterSpacing: .5,
//                                                   fontSize: 12.sp,
//                                                   fontWeight: FontWeight.w700),
//                                             ),
//                                           ), // <-- Text
//                                           SizedBox(
//                                             width: 19.w,
//                                           ),
//                                           SvgPicture.asset(
//                                             'assets/images/svg2.svg',
//                                             width: 17.w,
//                                             height: 17.h,
//                                           ),
//                                         ],
//                                       ),

//                                       //
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       )
//                     ]),
//               ),
//             );
//   }
// }

import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/coupons/couponsall.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188.h,
      width: 392.w,
      decoration: BoxDecoration(color: Coupons),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          // padding: const EdgeInsets.all(8.0),
          padding: EdgeInsets.only(left: 20.w, right: 15.w),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coupons For You",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Black,
                      letterSpacing: .5,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllCoupons()),
                  );
                },
                child: Text(
                  "See all",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: CouponsText,
                        letterSpacing: .5,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 5.h,
        // ),
        Padding(
          padding: EdgeInsets.only(
            left: 20.w,
          ),
          child: Text(
            "Popular Offers of the Day",
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  color: Grey,
                  letterSpacing: .5,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        // SizedBox(
        //   height: 15.h,
        // ),
        //   Image.asset(
        //     "assets/images/Coupons.png",
        //   )
        // ],
        Padding(
          padding: EdgeInsets.only(
            left: 19.w,
            top: 10.h,
            right: 10.h,
          ),
          child: SizedBox(
            height: 130.h,
            width: 350.w,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 2.2,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Image.asset('assets/images/Coupons.png',
                            height: 125.h, width: 352.w
                            // fit: BoxFit.cover
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 35.h,
                        bottom: 20.h,
                      ),
                      child: ClipRRect(
                        // borderRadius: new BorderRadius.circular(40.0),
                        child: Image.asset('assets/images/couponslogo.png',
                            height: 62.h, width: 38.w),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 80.h,
                        bottom: 20.h,
                      ),
                      child: FDottedLine(
                        color: Grey,
                        height: 100.0,
                        strokeWidth: 2.0,
                        dottedLength: 18.0,
                        space: 2.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 75.h, top: 6.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                "Hi Choice Supermarket",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0.w),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            // Container(
                                            // ,
                                            // ),
                                            Container(
                                              // height: MediaQuery.of(context).size.height * 0.50,
                                              height: 300.h,
                                              width: 390.w,
                                              decoration: new BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    new BorderRadius.only(
                                                  topLeft:
                                                      const Radius.circular(
                                                          25.0),
                                                  topRight:
                                                      const Radius.circular(
                                                          25.0),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 13.w,
                                                                top: 20.w),
                                                        child: Image.asset(
                                                            'assets/images/couponslogo.png',
                                                            height: 33.h,
                                                            width: 21.w),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top:
                                                                        18.0.h),
                                                            child: Text(
                                                              "Hi Choice Supermarket",
                                                              style: GoogleFonts
                                                                  .inter(
                                                                textStyle: const TextStyle(
                                                                    color:
                                                                        Black,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10.w,
                                                          ),
                                                          Text(
                                                            "Valid until 16 March 2023",
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle: const TextStyle(
                                                                  color: Black,
                                                                  letterSpacing:
                                                                      .5,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 45.w),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      // mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text("50% OFF",
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
                                                            )),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Text("UPTO ₹120",
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle: TextStyle(
                                                                  color: Grey,
                                                                  letterSpacing:
                                                                      .5,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            )),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 50.0.w,
                                                                  bottom: 0.w),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 113.w,
                                                                height: 34.h,
                                                                child:
                                                                    ElevatedButton(
                                                                  // style: ElevatedButton.styleFrom(
                                                                  //   //<-- SEE HERE
                                                                  //   side: BorderSide(
                                                                  //     width: 3.0,
                                                                  //   ),
                                                                  // ),
                                                                  style:
                                                                      ButtonStyle(
                                                                    elevation:
                                                                        MaterialStateProperty
                                                                            .all(0),

                                                                    // backgroundColor: ,
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            Colors.white),
                                                                    shape:
                                                                        MaterialStateProperty
                                                                            .all(
                                                                      RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                        side: BorderSide(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                SplashText),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () {},
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Text(
                                                                        "OFF100",
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: SplashText,
                                                                              letterSpacing: .5,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                      ), // <-- Text
                                                                      SizedBox(
                                                                        width:
                                                                            19.w,
                                                                      ),
                                                                      SvgPicture
                                                                          .asset(
                                                                        'assets/images/svg2.svg',
                                                                        width:
                                                                            17.w,
                                                                        height:
                                                                            17.h,
                                                                      ),
                                                                    ],
                                                                  ),

                                                                  //
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Divider(
                                                    // height: 20,
                                                    thickness: 1,
                                                    indent: 14,
                                                    endIndent: 25.5,
                                                    color: Grey,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 17.75.w,
                                                                top: 8.w,
                                                                bottom: 8.w),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/images/checked.svg',
                                                              width: 17.w,
                                                              height: 17.h,
                                                            ),
                                                            SizedBox(
                                                              width: 6.27,
                                                            ),
                                                            Text(
                                                              "Lorem ipsum dolor sit amet, consectetur",
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    height: 1.5,
                                                                    color:
                                                                        black,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 17.75.w,
                                                                top: 8.w,
                                                                right: 13.w),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/images/checked.svg',
                                                              width: 17.w,
                                                              height: 17.h,
                                                            ),
                                                            SizedBox(
                                                              width: 6.27,
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                maxLines: 2,
                                                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sit nunc, netus ac vulputate sed",
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                style:
                                                                    GoogleFonts
                                                                        .dmSans(
                                                                  textStyle: TextStyle(
                                                                      height:
                                                                          1.5,
                                                                      color:
                                                                          black,
                                                                      letterSpacing:
                                                                          .05,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 17.75.w,
                                                                top: 8.w,
                                                                bottom: 8.w),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/images/checked.svg',
                                                              width: 17.w,
                                                              height: 17.h,
                                                            ),
                                                            SizedBox(
                                                              width: 6.27,
                                                            ),
                                                            Text(
                                                              "Lorem ipsum dolor sit amet, consectetur",
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                        black,
                                                                    height: 1.5,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 17.75.w,
                                                                top: 8.w,
                                                                bottom: 8.w),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/images/checked.svg',
                                                              width: 17.w,
                                                              height: 17.h,
                                                            ),
                                                            SizedBox(
                                                              width: 6.27,
                                                            ),
                                                            Text(
                                                              "Lorem ipsum dolor sit amet, consectetur",
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                        black,
                                                                    height: 1.5,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 17.75.w,
                                                                top: 8.w,
                                                                right: 13.w),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      bottom:
                                                                          10.w),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/checked.svg',
                                                                width: 17.w,
                                                                height: 17.h,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 6.27,
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                softWrap: true,
                                                                maxLines: 3,
                                                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sit nunc, netus ac vulputate sed",
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                style:
                                                                    GoogleFonts
                                                                        .dmSans(
                                                                  textStyle: TextStyle(
                                                                      color: black,
                                                                      height: 1.5,

                                                                      // letterSpacing: .05,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      fontSize: 12.sp,
                                                                      fontWeight: FontWeight.w400),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            ///top icon
                                            Positioned(
                                                top: -60.w,
                                                left: 0.w,
                                                right: 0.w,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 50.w,
                                                    width: 50.w,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.black,
                                                    ),
                                                    child: Center(
                                                      child: SvgPicture.asset(
                                                        'assets/images/Cross.svg',
                                                        width: 15.w,
                                                        height: 15.h,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/logo1.svg',
                                    width: 15.w,
                                    height: 15.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 4.h,
                          // ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 19.w, top: 2.h),
                                child: Text(
                                  "Valid until 16 March 2023",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 18.0.h),
                                child: Text("50% OFF",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black,
                                          letterSpacing: .5,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text("UPTO ₹120",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Grey,
                                        letterSpacing: .5,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 18.0.h, top: 5.h),
                            child: SizedBox(
                              width: 115.w,
                              height: 30.h,
                              child: ElevatedButton(
                                // style: ElevatedButton.styleFrom(
                                //   //<-- SEE HERE
                                //   side: BorderSide(
                                //     width: 3.0,
                                //   ),
                                // ),
                                style: ButtonStyle(
                                  // backgroundColor: ,
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          width: 1, color: SplashText),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "OFF100",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: SplashText,
                                            letterSpacing: .5,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ), // <-- Text
                                    SizedBox(
                                      width: 19.w,
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/svg2.svg',
                                      width: 17.w,
                                      height: 17.h,
                                    ),
                                  ],
                                ),

                                //
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 2.2,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Image.asset('assets/images/Coupons.png',
                            height: 125.h, width: 352.w
                            // fit: BoxFit.cover
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 35.h,
                        bottom: 20.h,
                      ),
                      child: ClipRRect(
                        // borderRadius: new BorderRadius.circular(40.0),
                        child: Image.asset('assets/images/couponslogo.png',
                            height: 62.h, width: 38.w),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 80.h,
                        bottom: 20.h,
                      ),
                      child: FDottedLine(
                        color: Grey,
                        height: 100.0,
                        strokeWidth: 2.0,
                        dottedLength: 18.0,
                        space: 2.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 75.h, top: 6.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                "Hi Choice Supermarket",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                width: 35.w,
                              ),
                              SvgPicture.asset(
                                'assets/images/logo1.svg',
                                width: 15.w,
                                height: 15.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 18.h,
                                ),
                                child: Text(
                                  "Valid until 16 March 2023",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 18.0.h),
                                child: Text("50% OFF",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black,
                                          letterSpacing: .5,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w700),
                                    )),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text("UPTO ₹120",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Grey,
                                        letterSpacing: .5,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 18.0.h, top: 5.h),
                            child: SizedBox(
                              width: 115.w,
                              height: 30.h,
                              child: ElevatedButton(
                                // style: ElevatedButton.styleFrom(
                                //   //<-- SEE HERE
                                //   side: BorderSide(
                                //     width: 3.0,
                                //   ),
                                // ),
                                style: ButtonStyle(
                                  // backgroundColor: ,
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          width: 1, color: SplashText),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "OFF100",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: SplashText,
                                            letterSpacing: .5,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ), // <-- Text
                                    SizedBox(
                                      width: 19.w,
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/svg2.svg',
                                      width: 17.w,
                                      height: 17.h,
                                    ),
                                  ],
                                ),

                                //
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],

              // child:
            ),
          ),
        ),
      ]),
    );
  }
}
