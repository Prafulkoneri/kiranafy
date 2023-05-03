import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          right: 19.w,
          left: 19.w,
        ),
        child: Container(
          // height: 361.h,
          width: 352.w,
          decoration: BoxDecoration(
              color: Coupons,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Say Hello to Offers!",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: DarkBlack,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "Best price ever of all time",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Grey,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400),
                  ),
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
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext, index) {
                        return Container(
                          width: 322.w,
                          height: 86.h,
                          // color: Colors.white,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 9.h, bottom: 9.h),
                                child: Image(
                                  image:
                                      AssetImage("assets/images/offerone.png"),
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
                                padding: EdgeInsets.only(left: 0.w, top: 10.h),
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
                                                  // letterSpacing: .5,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(left: 48.0),
                                          child: Container(
                                            width: 60.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    lightgreen.withOpacity(0.6),
                                                    lightgreen.withOpacity(0.6)
                                                  ],
                                                ),

                                                // color:
                                                //     lightgreen.withOpacity(1.0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.w))),
                                            child: Center(
                                              child: Text("50% off",
                                                  // textAlign: TextAlign.center,
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        // letterSpacing: .5,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "500g",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Grey,
                                                // letterSpacing: .5,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          '\u{20B9}${25.00}',
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black,
                                                letterSpacing: .5,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/location.svg',
                                          width: 10.w,
                                          height: 12.h,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          'Kirana Store, Pune',
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black,
                                                // letterSpacing: .5,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          margin:
                              EdgeInsets.only(bottom: index == 2 ? 5 : 10.h),
                        );
                      }
                      // child:

                      ),
                )
              ],
            ),
          ),
        ));
  }
}