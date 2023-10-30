// import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/customer/account/controller/profile_controller.dart';
// import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
// import 'package:local_supper_market/screen/customer/coupons/view/coupon_all_view.dart';
// import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
// import 'package:local_supper_market/screen/customer/my_vouchers/view/my_vouchers_detail_view.dart';
// import 'package:local_supper_market/screen/customer/ref_and_earn/controller/ref_and_earn_controller.dart';
// import 'package:local_supper_market/widget/app_bar.dart';
// import 'package:provider/provider.dart';

// class MyVouchersView extends StatefulWidget {
//   const MyVouchersView({super.key});

//   @override
//   State<MyVouchersView> createState() => _MyVouchersViewState();
// }

// class _MyVouchersViewState extends State<MyVouchersView> {
//   @override
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       context.read<ProfileController>().initState(context, true);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final read=context.read<RefAndEarnController>();
//     // final watch = context.read<ProfileController>();
//     final readMain = context.read<MainScreenController>();
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.w),
//         child: PrimaryAppBar(
//           onBackBtnPressed: () {
//             readMain.onNavigation(
//                 4,
//                 const ProfileScreenView(
//                   isRefreshed: false,
//                 ),
//                 context);
//           },
//           title: "My Vouchers",
//         ),
//       ),
//       body: WillPopScope(
//         onWillPop: () async {
//           readMain.onNavigation(
//               4,
//               const ProfileScreenView(
//                 isRefreshed: false,
//               ),
//               context);

//           return false;
//         },
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               // Text(watch.referAndEarnCouponDetails?.discountAmount ?? "null"),
//               ListView.builder(
//                 padding: EdgeInsets.zero,
//                 scrollDirection: Axis.vertical,
//                 physics: BouncingScrollPhysics(),
//                 // physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: 5,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     padding:
//                         EdgeInsets.only(left: 19.w, right: 19.w, top: 24.w),
//                     child: Stack(
//                       // alignment: AlignmentDirectional.topCenter,
//                       children: [
//                         const Image(
//                           image: AssetImage(
//                             "assets/images/my_vouchers.png",
//                           ),
//                           // width: ScreenUtil().screenWidth,
//                           fit: BoxFit.cover,
//                         ),
//                         Positioned(
//                           right: 10.w,
//                           top: 10.w,
//                           child: InkWell(
//                             onTap: () {
//                               showModalBottomSheet(
//                                   backgroundColor: Colors.white,
//                                   isScrollControlled: true,
//                                   shape: const RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(30),
//                                           topRight: Radius.circular(30))),
//                                   context: context,
//                                   builder: (context) {
//                                     // using a scaffold helps to more easily position the FAB
//                                     return MyVoucherDetailView(
//                                       CounponCode: "",
//                                       discountmaxAmount: "",
//                                       startDate: "",
//                                       termCondition: "",
//                                       disscountPerscentage: "",
//                                       shopName: "",
//                                     );
//                                   });
//                             },
//                             child: SvgPicture.asset(
//                               'assets/images/logo1.svg',
//                               width: 15.w,
//                               height: 15.h,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                             left: 30.w,
//                             bottom: 10.w,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                     top: 10.h,
//                                   ),
//                                   child:
//                                       // ClipRRect(
//                                       //   // borderRadius: new BorderRadius.circular(40.0),
//                                       //   child: Image.asset(
//                                       //       'assets/images/my_vouchers_logo.png',
//                                       //       height: 62.h,
//                                       //       width: 37.w),
//                                       // ),
//                                       Image.asset(
//                                     'assets/images/my_vouchers_logo.png',
//                                     width: 37.w,
//                                     height: 62.h,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     top: 22.0,
//                                   ),
//                                   child: FDottedLine(
//                                     color: Grey,
//                                     height: 120.0,
//                                     strokeWidth: 1.0,
//                                     dottedLength: 10.0,
//                                     space: 3.0,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 19,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   // mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Special discount voucher for referring",
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: const TextStyle(
//                                             color: Black,
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 3.h,
//                                     ),
//                                     Text(
//                                       "Shambhu Traders",
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: const TextStyle(
//                                             color: Black,
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w700),
//                                       ),
//                                     ),
//                                     Text(
//                                       "Valid until 31 March 2023",
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: const TextStyle(
//                                             color: Black,
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.w400),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10.w,
//                                     ),
//                                     Text(
//                                       "₹1000 OFF on order from any shop!",
//                                       style: GoogleFonts.dmSans(
//                                         textStyle: const TextStyle(
//                                             color: Black,
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.w400),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 8.h,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                           padding: EdgeInsets.only(
//                                               left: 10.w,
//                                               right: 10.w,
//                                               top: 4.w,
//                                               bottom: 4.w),
//                                           decoration: BoxDecoration(
//                                               border:
//                                                   Border.all(color: SplashText),
//                                               borderRadius:
//                                                   BorderRadius.circular(8)),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 "ghnuhrf",
//                                                 style: GoogleFonts.dmSans(
//                                                   textStyle: const TextStyle(
//                                                       color: Black,
//                                                       fontSize: 12,
//                                                       fontWeight:
//                                                           FontWeight.w700),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 19.w,
//                                               ),
//                                               SvgPicture.asset(
//                                                 'assets/images/svg2.svg',
//                                                 width: 17.w,
//                                                 height: 17.h,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 10.w,
//                                         ),
//                                         ////////////////////
//                                         Container(
//                                           padding: EdgeInsets.only(
//                                               left: 30.w,
//                                               right: 30.w,
//                                               top: 7.w,
//                                               bottom: 6.w),
//                                           decoration: BoxDecoration(
//                                               color: Color(0xff39C19D)
//                                                   .withOpacity(0.5),
//                                               border:
//                                                   Border.all(color: SplashText),
//                                               borderRadius:
//                                                   BorderRadius.circular(8)),
//                                           child: Text(
//                                             "Active",
//                                             style: GoogleFonts.poppins(
//                                               textStyle: const TextStyle(
//                                                   color: Black,
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w600),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ))
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(
//                 height: 100.h,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/my_vouchers/controller/my_voucher_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';

import 'package:provider/provider.dart';

class MyVouchersView extends StatefulWidget {
  const MyVouchersView({
    super.key,
  });

  @override
  State<MyVouchersView> createState() => _MyVouchersViewState();
}

class _MyVouchersViewState extends State<MyVouchersView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<MyVocherScreenController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MyVocherScreenController>();
    final read = context.read<MyVocherScreenController>();
    final readMain = context.watch<MainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            readMain.onNavigation(
                4,
                const ProfileScreenView(
                  isRefreshed: false,
                ),
                context);
          },
          title: "My Vouchers",
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          readMain.onNavigation(
              4,
              const ProfileScreenView(
                isRefreshed: false,
              ),
              context);

          return false;
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: watch.myvoucherListData?.length ?? 0,
                itemBuilder: (context, index) {
                  final element = watch.myvoucherListData?[index];
                  return Container(
                    padding:
                        EdgeInsets.only(left: 19.w, right: 19.w, top: 24.w),
                    child: Stack(
                      // alignment: AlignmentDirectional.topCenter,
                      children: [
                        const Image(
                          image: AssetImage(
                            "assets/images/my_vouchers.png",
                          ),
                          // width: ScreenUtil().screenWidth,
                          fit: BoxFit.cover,
                        ),
                        // Positioned(
                        //   right: 10.w,
                        //   top: 10.w,
                        //   child: InkWell(
                        //     onTap: () {
                        //       showModalBottomSheet(
                        //           backgroundColor: Colors.white,
                        //           isScrollControlled: true,
                        //           shape: const RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.only(
                        //                   topLeft: Radius.circular(30),
                        //                   topRight: Radius.circular(30))),
                        //           context: context,
                        //           builder: (context) {
                        //             // using a scaffold helps to more easily position the FAB
                        //             return MyVoucherDetailView(
                        //               CounponCode: "",
                        //               discountmaxAmount: "",
                        //               startDate: "",
                        //               termCondition: "",
                        //               disscountPerscentage: "",
                        //               shopName: "",
                        //             );
                        //           });
                        //     },
                        //     child: SvgPicture.asset(
                        //       'assets/images/logo1.svg',
                        //       width: 15.w,
                        //       height: 15.h,
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                            left: 30.w,
                            bottom: 10.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10.h,
                                  ),
                                  child:
                                      // ClipRRect(
                                      //   // borderRadius: new BorderRadius.circular(40.0),
                                      //   child: Image.asset(
                                      //       'assets/images/my_vouchers_logo.png',
                                      //       height: 62.h,
                                      //       width: 37.w),
                                      // ),
                                      Image.asset(
                                    'assets/images/my_vouchers_logo.png',
                                    width: 37.w,
                                    height: 62.h,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 22.0,
                                  ),
                                  child: FDottedLine(
                                    color: Grey,
                                    height: 120.0,
                                    strokeWidth: 1.0,
                                    dottedLength: 10.0,
                                    space: 3.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 19,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Special discount voucher for referring",
                                      style: GoogleFonts.dmSans(
                                        textStyle: const TextStyle(
                                            color: Black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      "${element?.shopName}",
                                      // "Shambhu Traders",
                                      style: GoogleFonts.dmSans(
                                        textStyle: const TextStyle(
                                            color: Black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Text(
                                      "Valid until ${element?.toDate}",
                                      style: GoogleFonts.dmSans(
                                        textStyle: const TextStyle(
                                            color: Black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    Text(
                                      "Rs. ${element?.discountAmount} OFF on order from any shop!",
                                      style: GoogleFonts.dmSans(
                                        textStyle: const TextStyle(
                                            color: Black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10.w,
                                              right: 10.w,
                                              top: 4.w,
                                              bottom: 4.w),
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: SplashText),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 58.w,
                                                child: Text(
                                                  "${element?.uniqueNo}",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: const TextStyle(
                                                        color: Black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  read.copyCode(context,
                                                      element?.uniqueNo);
                                                },
                                                child: SvgPicture.asset(
                                                  'assets/images/svg2.svg',
                                                  width: 17.w,
                                                  height: 17.h,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        ////////////////////

                                        element?.status == "active"
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                    left: 30.w,
                                                    right: 30.w,
                                                    top: 7.w,
                                                    bottom: 6.w),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff39C19D)
                                                        .withOpacity(0.5),
                                                    border: Border.all(
                                                        color: SplashText),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Text(
                                                  "Active",
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        color: Black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.only(
                                                    left: 30.w,
                                                    right: 30.w,
                                                    top: 7.w,
                                                    bottom: 6.w),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffFEE6E3)
                                                        .withOpacity(0.5),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xffEC1E24)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Text(
                                                  "Expired",
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        color: Black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 100.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
