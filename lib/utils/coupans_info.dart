import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
Widget CouponsBottomSheet() {
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
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.w, top: 20.w),
                  child: Image.asset('assets/images/couponslogo.png',
                      height: 33.h, width: 21.w),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 18.0.h),
                      child: Text(
                        "Hi Choice Supermarket",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: Black,
                              letterSpacing: .5,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Text(
                      "Valid until 16 March 2023",
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            color: Black,
                            letterSpacing: .5,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 45.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("50% OFF",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            letterSpacing: .5,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text("UPTO ₹120",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Grey,
                            letterSpacing: .5,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 50.0.w, bottom: 0.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 113.w,
                          height: 34.h,
                          child: ElevatedButton(
                            // style: ElevatedButton.styleFrom(
                            //   //<-- SEE HERE
                            //   side: BorderSide(
                            //     width: 3.0,
                            //   ),
                            // ),
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),

                              // backgroundColor: ,
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(width: 1, color: SplashText),
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
                  EdgeInsets.only(left: 17.75.w, top: 8.w, bottom: 8.w),
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
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              height: 1.5,
                              color: black,
                              letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left: 17.75.w, top: 8.w, right: 13.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                height: 1.5,
                                color: black,
                                letterSpacing: .05,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left: 17.75.w, top: 8.w, bottom: 8.w),
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
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: black,
                              height: 1.5,
                              letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left: 17.75.w, top: 8.w, bottom: 8.w),
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
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: black,
                              height: 1.5,
                              letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(left: 17.75.w, top: 8.w, right: 13.w),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.w),
                        child: SvgPicture.asset(
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
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.dmSans(
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
}