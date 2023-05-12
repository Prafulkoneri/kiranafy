import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';

import 'package:provider/provider.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    // final read = context.read<ProfileController>();
    // final watch = context.watch<ProfileController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Customers",
          action: SvgPicture.asset("assets/icons/filter.svg"),
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      left: 19.w, right: 19.0.w, bottom: 0.w, top: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Color(0xffEFEFEF))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 15.w, right: 18.0.w, top: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/ReviewProfile.png',
                                  width: 60.w,
                                  height: 60.w,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 12.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rahul Singh',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.w,
                                      ),
                                      Text(
                                        'Vishrantwadi, Pune',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/s_fvrt.svg',
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  width: 32.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                      color: Color(0xff115B7A),
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      'assets/icons/s_call1.svg',
                                      height: 13.h,
                                      width: 13.w,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xffE8E8E8),
                        thickness: 1,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 15.w, right: 9.0.w, bottom: 8.w, top: 7.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  '9 Orders',
                                  style: TextStyle(
                                      color: Black,
                                      letterSpacing: .5,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'View Details',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/s_forword.svg',
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
