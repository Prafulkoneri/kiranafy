import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

import '../../cart/view/empty_cart_view.dart';
import '../../delivery_view/delivery_view_pending.dart';

class MyOrderView extends StatelessWidget {
  const MyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
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
          "My Orders",
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
                color: Black,
                letterSpacing: .5,
                fontSize: 14.sp,
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
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 20.w,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmptyCartView()),
                );
              },
              child: SvgPicture.asset(
                'assets/images/filter.svg',
                width: 20.w,
                height: 18.h,
              ),
            ),
          ),
        ],
      ),
      // backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
              child: Container(
                height: 119.h,
                width: 352.w,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: grey6),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, right: 13.w, top: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order ID - PAAC001",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black1,
                                  // letterSpacing: .5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 22.h,
                            width: 80.w,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                // backgroundColor: ,
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Yellow,
                                      // width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OrderPendingView()),
                                );
                              },
                              child: Text(
                                "Pending",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Yellow,
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),

                              //
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 5.w),
                      child: Text(
                        "Mar 10, 2023    9:15 am",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: lightblack,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, top: 13.w, right: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black,
                                  // letterSpacing: .5,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            "Total Amount",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, top: 6.w, right: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rs. 3,200",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: lightblack1,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Text(
                            "25",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: lightblack1,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
              child: Container(
                height: 119.h,
                width: 352.w,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: grey6),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, right: 13.w, top: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order ID - PAAC001",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black1,
                                  // letterSpacing: .5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 22.h,
                            width: 80.w,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                // backgroundColor: ,
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Yellow,
                                      // width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Pending",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Yellow,
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),

                              //
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 5.w),
                      child: Text(
                        "Mar 10, 2023    9:15 am",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: lightblack,
                              // letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, top: 13.w, right: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black,
                                  // letterSpacing: .5,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            "Total Amount",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 15.w, top: 6.w, right: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rs. 3,200",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: lightblack1,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Text(
                            "25",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: lightblack1,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
            //   child: Container(
            //     height: 119.h,
            //     width: 352.w,
            //     decoration: BoxDecoration(
            //       border: Border.all(width: 1, color: grey6),
            //       borderRadius: BorderRadius.all(Radius.circular(20)),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding:
            //               EdgeInsets.only(left: 15.w, right: 13.w, top: 12.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Order ID - PAAC001",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: Black1,
            //                       // letterSpacing: .5,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 22.h,
            //                 width: 80.w,
            //                 child: ElevatedButton(
            //                   style: ButtonStyle(
            //                     elevation: MaterialStateProperty.all(0),
            //                     // backgroundColor: ,
            //                     backgroundColor:
            //                         MaterialStateProperty.all(Colors.white),
            //                     shape: MaterialStateProperty.all(
            //                       RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(10),
            //                         side: BorderSide(
            //                           color: Yellow,
            //                           // width: 1,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   onPressed: () {},
            //                   child: Text(
            //                     "Pending",
            //                     style: GoogleFonts.dmSans(
            //                       textStyle: TextStyle(
            //                           color: Yellow,
            //                           // letterSpacing: .5,
            //                           fontSize: 12.sp,
            //                           fontWeight: FontWeight.w700),
            //                     ),
            //                   ),

            //                   //
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(left: 15.w, top: 5.w),
            //           child: Text(
            //             "Mar 10, 2023    9:15 am",
            //             style: GoogleFonts.dmSans(
            //               textStyle: TextStyle(
            //                   color: lightblack,
            //                   // letterSpacing: .5,
            //                   fontSize: 12.sp,
            //                   fontWeight: FontWeight.w400),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding:
            //               EdgeInsets.only(left: 15.w, top: 13.w, right: 15.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Total Amount",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: Black,
            //                       // letterSpacing: .5,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //               Text(
            //                 "Total Amount",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: Black,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding:
            //               EdgeInsets.only(left: 15.w, top: 6.w, right: 15.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Rs. 3,200",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: lightblack1,
            //                       fontSize: 16.sp,
            //                       fontWeight: FontWeight.w400),
            //                 ),
            //               ),
            //               Text(
            //                 "25",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: lightblack1,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w400),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
            //   child: Container(
            //     height: 119.h,
            //     width: 352.w,
            //     decoration: BoxDecoration(
            //       border: Border.all(width: 1, color: grey6),
            //       borderRadius: BorderRadius.all(Radius.circular(20)),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding:
            //               EdgeInsets.only(left: 15.w, right: 13.w, top: 12.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Order ID - PAAC001",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: Black1,
            //                       // letterSpacing: .5,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 22.h,
            //                 width: 80.w,
            //                 child: ElevatedButton(
            //                   style: ButtonStyle(
            //                     elevation: MaterialStateProperty.all(0),
            //                     // backgroundColor: ,
            //                     backgroundColor:
            //                         MaterialStateProperty.all(Colors.white),
            //                     shape: MaterialStateProperty.all(
            //                       RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(10),
            //                         side: BorderSide(
            //                           color: Yellow,
            //                           // width: 1,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   onPressed: () {},
            //                   child: Text(
            //                     "Pending",
            //                     style: GoogleFonts.dmSans(
            //                       textStyle: TextStyle(
            //                           color: Yellow,
            //                           // letterSpacing: .5,
            //                           fontSize: 12.sp,
            //                           fontWeight: FontWeight.w700),
            //                     ),
            //                   ),

            //                   //
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(left: 15.w, top: 5.w),
            //           child: Text(
            //             "Mar 10, 2023    9:15 am",
            //             style: GoogleFonts.dmSans(
            //               textStyle: TextStyle(
            //                   color: lightblack,
            //                   // letterSpacing: .5,
            //                   fontSize: 12.sp,
            //                   fontWeight: FontWeight.w400),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding:
            //               EdgeInsets.only(left: 15.w, top: 13.w, right: 15.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Total Amount",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: Black,
            //                       // letterSpacing: .5,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //               Text(
            //                 "Total Amount",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: Black,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding:
            //               EdgeInsets.only(left: 15.w, top: 6.w, right: 15.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Rs. 3,200",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: lightblack1,
            //                       fontSize: 16.sp,
            //                       fontWeight: FontWeight.w400),
            //                 ),
            //               ),
            //               Text(
            //                 "25",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: lightblack1,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w400),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
            //   child: Container(
            //     height: 119.h,
            //     width: 352.w,
            //     decoration: BoxDecoration(
            //       border: Border.all(width: 1, color: grey6),
            //       borderRadius: BorderRadius.all(Radius.circular(20)),
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding:
            //               EdgeInsets.only(left: 15.w, right: 13.w, top: 12.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Order ID - PAAC001",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: Black1,
            //                       // letterSpacing: .5,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 22.h,
            //                 width: 80.w,
            //                 child: ElevatedButton(
            //                   style: ButtonStyle(
            //                     elevation: MaterialStateProperty.all(0),
            //                     // backgroundColor: ,
            //                     backgroundColor:
            //                         MaterialStateProperty.all(Colors.white),
            //                     shape: MaterialStateProperty.all(
            //                       RoundedRectangleBorder(
            //                         borderRadius: BorderRadius.circular(10),
            //                         side: BorderSide(
            //                           color: Yellow,
            //                           // width: 1,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   onPressed: () {},
            //                   child: Text(
            //                     "Pending",
            //                     style: GoogleFonts.dmSans(
            //                       textStyle: TextStyle(
            //                           color: Yellow,
            //                           // letterSpacing: .5,
            //                           fontSize: 12.sp,
            //                           fontWeight: FontWeight.w700),
            //                     ),
            //                   ),

            //                   //
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(left: 15.w, top: 5.w),
            //           child: Text(
            //             "Mar 10, 2023    9:15 am",
            //             style: GoogleFonts.dmSans(
            //               textStyle: TextStyle(
            //                   color: lightblack,
            //                   // letterSpacing: .5,
            //                   fontSize: 12.sp,
            //                   fontWeight: FontWeight.w400),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding:
            //               EdgeInsets.only(left: 15.w, top: 13.w, right: 15.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Total Amount",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: Black,
            //                       // letterSpacing: .5,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //               Text(
            //                 "Total Amount",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: Black,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w700),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding:
            //               EdgeInsets.only(left: 15.w, top: 6.w, right: 15.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Rs. 3,200",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: lightblack1,
            //                       fontSize: 16.sp,
            //                       fontWeight: FontWeight.w400),
            //                 ),
            //               ),
            //               Text(
            //                 "25",
            //                 style: GoogleFonts.dmSans(
            //                   textStyle: TextStyle(
            //                       color: lightblack1,
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w400),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
