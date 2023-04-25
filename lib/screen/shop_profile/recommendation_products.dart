import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class RecommendationProducts extends StatefulWidget {
  const RecommendationProducts({super.key});

  @override
  State<RecommendationProducts> createState() => _RecommendationProductsState();
}

class _RecommendationProductsState extends State<RecommendationProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 361.h,
      // color: Colors.white,
      width: 352.w,
      // decoration: BoxDecoration(
      //     color: Coupons, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recommendations",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: DarkBlack,
                        letterSpacing: .5,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: CouponsText,
                        letterSpacing: .5,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              // width: 322.w,
              // height: 86.h,
              // color: Colors.white,

              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext, index) {
                    return Container(
                      width: 322.w,
                      height: 86.h,
                      // color: Colors.white,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 9.h, bottom: 9.h),
                            child: Image(
                              image: AssetImage("assets/images/offerone.png"),
                              height: 68.h,
                              width: 68.w,
                            ),
                          ),
                          SizedBox(
                            height: 70.h,
                            child: VerticalDivider(
                                color: lightgrey,
                                thickness: 0.5,
                                indent: 5,
                                endIndent: 5),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 9.w, top: 10.h),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Nescafe Coffee",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700),
                                        )),
                                    SizedBox(
                                      width: 50.w,
                                    ),
                                    Container(
                                      width: 60.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: lightgreen,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.w))),
                                      child: Center(
                                        child: Text("50% off",
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
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  "500g",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Grey,
                                        letterSpacing: .5,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                //
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 13.w),
                                      child: Text(
                                        '\u{20B9}${25.00}',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 13.w, left: 5.w),
                                      child: Text(
                                        '\u{20B9}${25.00}',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              // decoration:
                                              // TextDecoration.lineThrough,
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 100.w),
                                          child: SvgPicture.asset(
                                            'assets/images/add.svg',
                                            // width: 30.w,
                                            // height: 30.h,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: index == 2 ? 5 : 10.h),
                    );
                  }
                  // child:

                  ),
            )
          ],
        ),
      ),
    );
  }
}
