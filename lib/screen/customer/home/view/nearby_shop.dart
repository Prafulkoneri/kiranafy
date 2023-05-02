import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCarousal extends StatefulWidget {
  const HomeCarousal({super.key});

  @override
  State<HomeCarousal> createState() => _HomeCarousalState();
}

class _HomeCarousalState extends State<HomeCarousal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (BuildContext, index) {
            return Stack(
              children: [
                Row(
                  children: [
                    Container(
                      height: 120.h,
                      width: 168.w,
                      margin: EdgeInsets.only(
                          left: index == 0 ? 19.w : 0,
                          right: index == 2 ? 19.w : 5.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.w),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/property3.png'),
                              fit: BoxFit.fill),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("New Balaji Trading Co..",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        // letterSpacing: .5,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600))),
                            Text("Vishrantwadi, Pune",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        // letterSpacing: .5,
                                        fontSize: 12.sp,
                                        // height: 10,
                                        fontWeight: FontWeight.w400))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    child: Container(
                  margin: EdgeInsets.only(
                      left: index == 0 ? 19.w : 0,
                      right: index == 2 ? 19.w : 5.w),
                  height: 120.h,
                  width: 168.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.w),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.1,
                          0.9,
                        ],
                        colors: [
                          Colors.white.withOpacity(0),
                          Colors.black.withOpacity(0.05),
                        ],
                      )),
                )),
              ],
            );
          }),
    );
  }
}
