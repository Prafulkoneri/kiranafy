import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';

class CCustomerSupportView extends StatefulWidget {
  const CCustomerSupportView({super.key});

  @override
  State<CCustomerSupportView> createState() => _CCustomerSupportViewState();
}

class _CCustomerSupportViewState extends State<CCustomerSupportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            title: "Customer Support",
            action: SvgPicture.asset("assets/icons/addressadd.svg"),
            onActionTap: () {},
          ),
        ),
        body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 17.w, right: 17.w, bottom: 17.w, top: 14.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 5,
                              offset: Offset(-.0, 5.0),
                              spreadRadius: 0),
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Color(0xffE2E2E2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Ticket Id-',
                                  style: TextStyle(
                                      color: Black,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'PAG122E551',
                                  style: TextStyle(
                                      color: Black,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Text(
                              'Status',
                              style: TextStyle(
                                  color: Black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Sep 30, 2021',
                                  style: TextStyle(
                                      color: Color(0xff5B5B5B),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  '2:15 AM',
                                  style: TextStyle(
                                      color: Color(0xff5B5B5B),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Text(
                              'Pending',
                              style: TextStyle(
                                  color: Color(0xffFF3636),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Divider(thickness: 1, color: Color(0xffE2E2E2)),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          'Subject',
                          style: TextStyle(
                              color: Black1,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing.',
                          style: TextStyle(
                              color: Color(0xff5B5B5B),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        Text(
                          'Remark',
                          style: TextStyle(
                              color: Black1,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet.',
                          style: TextStyle(
                              color: Color(0xff5B5B5B),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
