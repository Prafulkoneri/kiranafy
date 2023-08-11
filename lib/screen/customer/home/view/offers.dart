import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeScreenController>();
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
              borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                SizedBox(
                  height: 5.h,
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
                ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: watch.hellotoffersdata?.length ?? 0,
                    itemBuilder: (BuildContext, index) {
                      final element = watch.hellotoffersdata?[index];
                      return element?.off != "0"
                          ? Container(
                              padding: EdgeInsets.only(
                                  top: 9.w, bottom: 10.h, right: 12.w),
                              width: ScreenUtil().screenWidth,
                              // color: Colors.white,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              margin: EdgeInsets.only(
                                  bottom: index == 2 ? 5 : 10.h),
                              child: Row(
                                children: [
                                  element?.productImagePath == ""
                                      ? Container(
                                          height: 68.w,
                                          width: 68.w,
                                          child: Image.asset(
                                            "assets/images/profile_image.png",
                                            // fit:
                                            //     BoxFit.cover,
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
                                  SizedBox(
                                    height: 70.h,
                                    child: VerticalDivider(
                                        color: lightgrey,
                                        thickness: 0.5,
                                        indent: 5,
                                        endIndent: 5),
                                  ),
                                  Expanded(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                  "${element?.productName}",
                                                  // "Nescafe Coffee",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Black,
                                                        // letterSpacing: .5,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )),
                                            ),
                                            Container(
                                              width: 60.w,
                                              height: 20.h,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      lightgreen
                                                          .withOpacity(0.6),
                                                      lightgreen
                                                          .withOpacity(0.6)
                                                    ],
                                                  ),

                                                  // color:
                                                  //     lightgreen.withOpacity(1.0),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.w))),
                                              child: Center(
                                                child: element?.off != ""
                                                    ? Center(
                                                        child: Text(
                                                            "${element?.off}  % off",
                                                            // textAlign: TextAlign.center,
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      .5,
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )),
                                                      )
                                                    : Container(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "${element?.weight} ${element?.unit}",
                                              // "500g",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Grey,
                                                    // letterSpacing: .5,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Text(
                                              "\u{20B9}${element?.mrpPrice}",
                                              // '\u{20B9}${25.00}',
                                              style: GoogleFonts.dmSans(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                textStyle: TextStyle(
                                                    color: Black,
                                                    letterSpacing: .5,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '\u{20B9}${element?.offerPrice}',
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: Black,
                                                          letterSpacing: .5,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
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
                                              '${element?.shopName}',
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black,
                                                    // letterSpacing: .5,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                    }
                    // child:

                    )
              ],
            ),
          ),
        ));
  }
}
