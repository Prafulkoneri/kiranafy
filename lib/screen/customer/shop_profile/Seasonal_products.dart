import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class SeasonalProducts extends StatefulWidget {
  const SeasonalProducts({super.key});

  @override
  State<SeasonalProducts> createState() => _SeasonalProductsState();
}

class _SeasonalProductsState extends State<SeasonalProducts> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            5,
                (index) =>Row(
                  children: [
                    Container(
                      width: 182.w,
                      height: 156.h,
                      margin: EdgeInsets.only(
                          left: index == 0 ? 19.w : 0,
                          right: index == 2 ? 19.w : 5.w),
                      child: Card(
                        // color: black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 17.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 14.w,
                                        // left: 34.w,

                                        right: 18.w),
                                    child: Container(
                                      child: Image.asset(
                                        "assets/images/mango.png",
                                        height: 72.w,
                                        width: 114.w,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "Mango",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black1,
                                      letterSpacing: .5,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "100g",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black1,
                                      letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\u{20B9}${40}',
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          letterSpacing: .5,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: SvgPicture.asset(
                                      'assets/images/add.svg',
                                      // width: 15.w,
                                      // height: 19.h,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
          ),
        ),
      ),

    );
  }
}