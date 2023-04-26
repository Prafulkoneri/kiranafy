import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class OfferProducts extends StatefulWidget {
  const OfferProducts({super.key});

  @override
  State<OfferProducts> createState() => _OfferProductsState();
}

class _OfferProductsState extends State<OfferProducts> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (BuildContext, index) {
            return Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 10,
                        blurRadius: 200,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  width: 182.w,
                  height: 156.h,
                  margin: EdgeInsets.only(
                      left: index == 0 ? 19.w : 0,
                      right: index == 2 ? 19.w : 5.w),
                  child: Card(
                    elevation: 1,
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
                                    left: 34.w,
                                    right: 40.w,
                                    bottom: 2.w),
                                child: Card(
                                    child: Image.asset(
                                        "assets/images/redlabel.png")),
                              ),
                            ],
                          ),
                          Text(
                            "Red Label",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Black1,
                                  // letterSpacing: .5,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "100g",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Black1,
                                  // letterSpacing: .5,
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
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Black1,
                                      // letterSpacing: .5,
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
            );
          }),
    );
  }
}
