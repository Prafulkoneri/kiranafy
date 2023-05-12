import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';

import 'package:provider/provider.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    // final read = context.read<ProfileController>();
    // final watch = context.watch<ProfileController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Reviews",
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "New Balaji Trading Company",
                style: TextStyle(
                    color: Black, fontSize: 18.sp, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                  bottom: BorderSide(width: 1, color: grey2),
                ),
              ),

              // color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 12.w, top: 20.w, bottom: 20.w),
                    child: SvgPicture.asset(
                      'assets/images/location2.svg',
                      width: 23.w,
                      height: 28.h,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 8.w, top: 15.w, bottom: 15.w),
                    child: Text(
                      "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Black,
                            // letterSpacing: .5,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 40.h, top: 12.w, bottom: 12.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/call.svg',
                          // width: 15.w,
                          // height: 19.h,
                        ),
                        SizedBox(
                          width: 13.w,
                        ),
                        SvgPicture.asset(
                          'assets/images/fvrt.svg',
                          // width: 15.w,
                          // height: 19.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Text("All Reviews",
                  style: TextStyle(
                      color: Black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w800)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.w,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 10.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Image.asset('assets/images/profile.png'),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 35,
                                            ),
                                            child: Text(
                                              'Rahul Singh',
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black,
                                                    letterSpacing: .5,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Pune, Maharashtra',
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black,
                                                    letterSpacing: .5,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 45),
                                            child: Text(
                                              '30/11/2021',
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black,
                                                    letterSpacing: .5,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/rating.svg',
                                        width: 14.w,
                                        height: 14.h,
                                      ),
                                      Text(
                                        '4.1',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Divider(
                                color: grey,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Euismod sit ipsum neque pulvinar gravidamoles tie semper diam ac. Semper arcu ultricies. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Euismod sit ipsum neque pulvinar gravidamoles',
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      letterSpacing: .5,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
