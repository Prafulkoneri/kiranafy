import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/coupons/controller/coupon_all_controler.dart';
import 'package:local_supper_market/screen/customer/coupons/view/coupon_all_view.dart';
import 'package:local_supper_market/screen/customer/coupons/view/coupon_filtter_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/my_order/view/order_filtter_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

class AllCoupons extends StatefulWidget {
  final String? upToValue;
  final String? shopId;
  final String? categoryId;

  const AllCoupons({super.key, this.upToValue, this.shopId, this.categoryId});

  @override
  State<AllCoupons> createState() => _AllCouponsState();
}

class _AllCouponsState extends State<AllCoupons> {
  String? selectedValue;
  // final List<String> genderItems = [];
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CAllCouponController>().initState(context, "", "", "");
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CAllCouponController>();
    final read = context.read<CAllCouponController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          isBackButtonEnabled: false,
          title: "Offers & Coupons",
          action: InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return CouponFiltter();
                  });
                },
              );
            },
            child: SvgPicture.asset(
              'assets/images/filter.svg',
              width: 20.w,
              height: 18.h,
            ),
          ),
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  height: 50.h,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: watch.filterCouponList?.length ?? 0,
                      itemBuilder: (BuildContext, index) {
                        final element = watch.filterCouponList?[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 15.w : 10.w,
                              top: 20.w,
                              right: index ==
                                      int.parse(watch.filterCouponList?.length
                                                  .toString() ??
                                              "0") -
                                          1
                                  ? 19.w
                                  : 0.w),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // width: 95.w,
                                height: 25.h,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    // backgroundColor: ,
                                    backgroundColor: MaterialStateProperty.all(
                                        watch.selectedIndex == index
                                            ? pink
                                            : Colors.white),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color: watch.selectedIndex == index
                                              ? Colors.transparent
                                              : Grey,
                                          // width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    print("j");
                                    read.getAllCouponList(
                                        context,
                                        element?.value,
                                        watch.shopId,
                                        watch.categoryId,
                                        index);
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        element?.key ?? "",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color:
                                                  watch.selectedIndex == index
                                                      ? Colors.white
                                                      : Grey,
                                              // letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      watch.selectedIndex == index
                                          ? SizedBox(
                                              width: 8.w,
                                            )
                                          : Container(),
                                      watch.selectedIndex == index
                                          ? SvgPicture.asset(
                                              'assets/images/Cross.svg',
                                              width: 7.w,
                                              height: 7.h,
                                            )
                                          : Container()
                                    ],
                                  ),

                                  //
                                ),
                              ),

                              //
                            ],
                          ),
                        );
                      }),
                ),
                watch.allCouponlistdata?.shopEnquiriesDetails?.isNotEmpty ??
                        false
                    ? Expanded(
                        child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          // height: 125.h,
                          // width: 352.w,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              // physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // itemCount: watch.shopEnquiriesDetails?.length??0,
                              itemCount: watch.allCouponlistdata
                                      ?.shopEnquiriesDetails?.length ??
                                  0,
                              itemBuilder: (BuildContext, index) {
                                final element = watch.allCouponlistdata
                                    ?.shopEnquiriesDetails?[index];

                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 19.0.w, right: 19.w, top: 15.0.w),
                                  child: Stack(
                                    alignment: AlignmentDirectional.centerStart,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: Image.asset(
                                          'assets/images/Coupons.png',
                                          // height: 125.h, width: 352.w
                                          // fit: BoxFit.cover
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 35.h,
                                          bottom: 10.h,
                                        ),
                                        child: ClipRRect(
                                          // borderRadius: new BorderRadius.circular(40.0),
                                          child: Image.asset(
                                              'assets/images/couponslogo.png',
                                              height: 62.h,
                                              width: 37.w),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 80.h,
                                          bottom: 15.h,
                                        ),
                                        child: FDottedLine(
                                          color: Grey,
                                          height: 120.0,
                                          strokeWidth: 1.0,
                                          dottedLength: 10.0,
                                          space: 3.0,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 80.h,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 19.w, right: 9.w),
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${element?.shopName}",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: Black,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                              Colors.white,
                                                          isScrollControlled:
                                                              true,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          30),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          30))),
                                                          context: context,
                                                          builder: (context) {
                                                            // using a scaffold helps to more easily position the FAB
                                                            return CCouponsDetailView(
                                                                CounponCode: element
                                                                    ?.couponCode,
                                                                discountmaxAmount:
                                                                    element
                                                                        ?.couponDiscountMaxAmount,
                                                                startDate: element
                                                                    ?.couponToDate,
                                                                termCondition:
                                                                    element
                                                                        ?.couponTermsAndConditions,
                                                                disscountPerscentage:
                                                                    element
                                                                        ?.couponDiscountMaxAmount,
                                                                shopName: element
                                                                    ?.shopName);
                                                          });
                                                    },
                                                    child: SvgPicture.asset(
                                                      'assets/images/logo1.svg',
                                                      width: 15.w,
                                                      height: 15.h,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 19.w,
                                                  ),
                                                  child: Text(
                                                    "Valid until ${element?.couponToDate}",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: Black,
                                                          letterSpacing: .5,
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 18.0.h),
                                                  child: Text(
                                                      "${element?.couponDiscountPercentage} %OFF",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Black,
                                                            letterSpacing: .5,
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 12.w,
                                                ),
                                                Text(
                                                    "UPTO ₹${element?.couponDiscountMaxAmount}",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: Grey,
                                                          letterSpacing: .5,
                                                          fontSize: 10.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 18.0.h,
                                              ),
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
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all(0),

                                                    // backgroundColor: ,
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        side: BorderSide(
                                                            width: 1,
                                                            color: SplashText),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    read.copyCodeForCoupanList(
                                                        context,
                                                        element?.couponCode ??
                                                            "");
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          "${element?.couponCode}",
                                                          style:
                                                              GoogleFonts.dmSans(
                                                            textStyle: TextStyle(
                                                                color: SplashText,
                                                                letterSpacing: .5,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
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
                                            ),
                                            SizedBox(
                                              height: 25.h,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ))
                    : Container(
                        child: Expanded(
                          child: Center(
                            child: Column(
                              // mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/emptycart.png",
                                  height: 151.h,
                                  width: 151.w,
                                ),
                                Text(
                                  "No Coupons Found",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        letterSpacing: .5,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                // SizedBox(
                //   height: 80.h,
                // )
              ],
            ),
    );
  }

  // Widget CouponsBottomSheet() {
  //   return Stack(
  //     clipBehavior: Clip.none,
  //     children: [
  //       // Container(
  //       // ,
  //       // ),
  //       Container(
  //         // height: MediaQuery.of(context).size.height * 0.50,
  //         height: 300.h,
  //         width: 390.w,
  //         decoration: new BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: new BorderRadius.only(
  //             topLeft: const Radius.circular(25.0),
  //             topRight: const Radius.circular(25.0),
  //           ),
  //         ),
  //         child: Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.only(left: 13.w, top: 20.w),
  //                   child: Image.asset('assets/images/couponslogo.png',
  //                       height: 33.h, width: 21.w),
  //                 ),
  //                 SizedBox(
  //                   width: 10.w,
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(top: 18.0.h),
  //                       child: Text(
  //                         "Hi Choice Supermarket",
  //                         style: GoogleFonts.inter(
  //                           textStyle: const TextStyle(
  //                               color: Black,
  //                               letterSpacing: .5,
  //                               fontSize: 18,
  //                               fontWeight: FontWeight.w700),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 10.w,
  //                     ),
  //                     Text(
  //                       "Valid until 16 March 2023",
  //                       style: GoogleFonts.inter(
  //                         textStyle: const TextStyle(
  //                             color: Black,
  //                             letterSpacing: .5,
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w400),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(left: 45.w),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 // mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text("50% OFF",
  //                       style: GoogleFonts.dmSans(
  //                         textStyle: TextStyle(
  //                             color: Black,
  //                             letterSpacing: .5,
  //                             fontSize: 16.sp,
  //                             fontWeight: FontWeight.w700),
  //                       )),
  //                   SizedBox(
  //                     width: 10.w,
  //                   ),
  //                   Text("UPTO ₹120",
  //                       style: GoogleFonts.dmSans(
  //                         textStyle: TextStyle(
  //                             color: Grey,
  //                             letterSpacing: .5,
  //                             fontSize: 12.sp,
  //                             fontWeight: FontWeight.w400),
  //                       )),
  //                   Padding(
  //                     padding: EdgeInsets.only(left: 50.0.w, bottom: 0.w),
  //                     child: Row(
  //                       children: [
  //                         SizedBox(
  //                           width: 113.w,
  //                           height: 34.h,
  //                           child: ElevatedButton(
  //                             // style: ElevatedButton.styleFrom(
  //                             //   //<-- SEE HERE
  //                             //   side: BorderSide(
  //                             //     width: 3.0,
  //                             //   ),
  //                             // ),
  //                             style: ButtonStyle(
  //                               elevation: MaterialStateProperty.all(0),
  //
  //                               // backgroundColor: ,
  //                               backgroundColor:
  //                                   MaterialStateProperty.all(Colors.white),
  //                               shape: MaterialStateProperty.all(
  //                                 RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(10.0),
  //                                   side:
  //                                       BorderSide(width: 1, color: SplashText),
  //                                 ),
  //                               ),
  //                             ),
  //                             onPressed: () {},
  //                             child: Row(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 Text(
  //                                   "OFF100",
  //                                   style: GoogleFonts.dmSans(
  //                                     textStyle: TextStyle(
  //                                         color: SplashText,
  //                                         letterSpacing: .5,
  //                                         fontSize: 12.sp,
  //                                         fontWeight: FontWeight.w700),
  //                                   ),
  //                                 ), // <-- Text
  //                                 SizedBox(
  //                                   width: 19.w,
  //                                 ),
  //                                 SvgPicture.asset(
  //                                   'assets/images/svg2.svg',
  //                                   width: 17.w,
  //                                   height: 17.h,
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             //
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               height: 10.h,
  //             ),
  //             Divider(
  //               // height: 20,
  //               thickness: 1,
  //               indent: 14,
  //               endIndent: 25.5,
  //               color: Grey,
  //             ),
  //             Column(
  //               children: [
  //                 Padding(
  //                   padding:
  //                       EdgeInsets.only(left: 17.75.w, top: 8.w, bottom: 8.w),
  //                   child: Row(
  //                     children: [
  //                       SvgPicture.asset(
  //                         'assets/images/checked.svg',
  //                         width: 17.w,
  //                         height: 17.h,
  //                       ),
  //                       SizedBox(
  //                         width: 6.27,
  //                       ),
  //                       Text(
  //                         "Lorem ipsum dolor sit amet, consectetur",
  //                         style: GoogleFonts.dmSans(
  //                           textStyle: TextStyle(
  //                               height: 1.5,
  //                               color: black,
  //                               letterSpacing: .5,
  //                               fontSize: 12.sp,
  //                               fontWeight: FontWeight.w400),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding:
  //                       EdgeInsets.only(left: 17.75.w, top: 8.w, right: 13.w),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       SvgPicture.asset(
  //                         'assets/images/checked.svg',
  //                         width: 17.w,
  //                         height: 17.h,
  //                       ),
  //                       SizedBox(
  //                         width: 6.27,
  //                       ),
  //                       Flexible(
  //                         child: Text(
  //                           maxLines: 2,
  //                           "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sit nunc, netus ac vulputate sed",
  //                           textAlign: TextAlign.justify,
  //                           style: GoogleFonts.dmSans(
  //                             textStyle: TextStyle(
  //                                 height: 1.5,
  //                                 color: black,
  //                                 letterSpacing: .05,
  //                                 overflow: TextOverflow.ellipsis,
  //                                 fontSize: 12.sp,
  //                                 fontWeight: FontWeight.w400),
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding:
  //                       EdgeInsets.only(left: 17.75.w, top: 8.w, bottom: 8.w),
  //                   child: Row(
  //                     children: [
  //                       SvgPicture.asset(
  //                         'assets/images/checked.svg',
  //                         width: 17.w,
  //                         height: 17.h,
  //                       ),
  //                       SizedBox(
  //                         width: 6.27,
  //                       ),
  //                       Text(
  //                         "Lorem ipsum dolor sit amet, consectetur",
  //                         style: GoogleFonts.dmSans(
  //                           textStyle: TextStyle(
  //                               color: black,
  //                               height: 1.5,
  //                               letterSpacing: .5,
  //                               fontSize: 12.sp,
  //                               fontWeight: FontWeight.w400),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding:
  //                       EdgeInsets.only(left: 17.75.w, top: 8.w, bottom: 8.w),
  //                   child: Row(
  //                     children: [
  //                       SvgPicture.asset(
  //                         'assets/images/checked.svg',
  //                         width: 17.w,
  //                         height: 17.h,
  //                       ),
  //                       SizedBox(
  //                         width: 6.27,
  //                       ),
  //                       Text(
  //                         "Lorem ipsum dolor sit amet, consectetur",
  //                         style: GoogleFonts.dmSans(
  //                           textStyle: TextStyle(
  //                               color: black,
  //                               height: 1.5,
  //                               letterSpacing: .5,
  //                               fontSize: 12.sp,
  //                               fontWeight: FontWeight.w400),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding:
  //                       EdgeInsets.only(left: 17.75.w, top: 8.w, right: 13.w),
  //                   child: Row(
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.only(bottom: 10.w),
  //                         child: SvgPicture.asset(
  //                           'assets/images/checked.svg',
  //                           width: 17.w,
  //                           height: 17.h,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 6.27,
  //                       ),
  //                       Flexible(
  //                         child: Text(
  //                           softWrap: true,
  //                           maxLines: 3,
  //                           "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sit nunc, netus ac vulputate sed",
  //                           textAlign: TextAlign.justify,
  //                           style: GoogleFonts.dmSans(
  //                             textStyle: TextStyle(
  //                                 color: black,
  //                                 height: 1.5,
  //
  //                                 // letterSpacing: .05,
  //                                 overflow: TextOverflow.ellipsis,
  //                                 fontSize: 12.sp,
  //                                 fontWeight: FontWeight.w400),
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //
  //       ///top icon
  //       Positioned(
  //           top: -60.w,
  //           left: 0.w,
  //           right: 0.w,
  //           child: InkWell(
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //             child: Container(
  //               height: 50.w,
  //               width: 50.w,
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: Colors.black,
  //               ),
  //               child: Center(
  //                 child: SvgPicture.asset(
  //                   'assets/images/Cross.svg',
  //                   width: 15.w,
  //                   height: 15.h,
  //                 ),
  //               ),
  //             ),
  //           ))
  //     ],
  //   );
  // }
}
