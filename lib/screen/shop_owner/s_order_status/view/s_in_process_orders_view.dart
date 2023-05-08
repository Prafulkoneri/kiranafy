import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget SInProcessOrdersView() {
  return ListView.builder(
      padding: EdgeInsets.only(left: 19.w, right: 19.w,top: 20.w),
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext, index) {
        return Container(
          padding: EdgeInsets.all(14.w),
          margin: EdgeInsets.only(bottom: 15.w),
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Colors.white,
            border: Border.all(color: Color(0xffEFEFEF)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ramesh Patil",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: Color(0xff3A3A3A)),
                  ),
                  Text(
                    "Order ID: LSM012334",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: Color(0xff3A3A3A)),
                  ),
                ],
              ),
              SizedBox(
                height: 7.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "4 Products",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: Color(0xff3A3A3A)),
                  ),
                  Text(
                    "₹135.00",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff39C19D)),
                  ),
                ],
              ),
              SizedBox(
                height: 7.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "28 March 2023 11:34 am",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: Color(0xffA3A3A3)),
                  ),
                  Row(
                    children: [
                      Text(
                        "Details",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Color(0xff3A3A3A)),
                      ),
                      SizedBox(
                        width:7.w,
                      ),
                      SvgPicture.asset("assets/icons/arrow_right.svg"),
                    ],
                  ),


                ],
              ),
            ],
          ),
        );
      });

}
