import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:provider/provider.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    // final read = context.read<ProfileController>();
    // final watch = context.watch<ProfileController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "Customer Details",
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 20.w, bottom: 15.w, left: 19.w, right: 19.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/ReviewProfile.png',
                        width: 80.w,
                        height: 80.h,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Rahul Singh',
                            style: TextStyle(
                                color: black,
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/shop_location.svg',
                                // width: 15.w,
                                // height: 15.h,
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                'Vishrantwadi, Pune',
                                style: TextStyle(
                                    color: black,
                                    letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/call_shop.svg',
                                // width: 14.w,
                                // height: 14.h,
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                '+91 9420992370',
                                style: TextStyle(
                                    color: black,
                                    letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: const BoxDecoration(
                        color: Color(0xff115B7A), shape: BoxShape.circle),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/s_call1.svg',
                        height: 13.h,
                        width: 13.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, right: 19.w),
              child: const Divider(),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Orders",
                      style: TextStyle(
                          color: Black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.only(left: 19.0, right: 19.0, top: 10.0),
                  // padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffEFEFEF)),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order ID - PAAC001',
                            style: TextStyle(
                                color: Black,
                                letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffE4C400)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Text(
                              'In process',
                              style: TextStyle(
                                  color: Color(0xffE4C400),
                                  letterSpacing: .5,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Mar 10, 2023   9:15 am',
                            style: TextStyle(
                                color: const Color(0xff5B5B5B),
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                                color: Black,
                                letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            'Total Quantity',
                            style: TextStyle(
                                color: Black,
                                letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rs. 3,200',
                            style: TextStyle(
                                color: const Color(0xff5B5B5B),
                                letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w200),
                          ),
                          Text(
                            '25',
                            style: TextStyle(
                                color: const Color(0xff5B5B5B),
                                letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
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
