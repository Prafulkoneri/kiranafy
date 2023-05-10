import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';

class SPaymentsView extends StatefulWidget {
  const SPaymentsView({Key? key}) : super(key: key);

  @override
  _SPaymentsViewState createState() => _SPaymentsViewState();
}

class _SPaymentsViewState extends State<SPaymentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(title: "Payments"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Overview",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Black1),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.w),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10),
                      ],
                    ),
                    padding: EdgeInsets.only(
                        left: 10.w, top: 5.w, bottom: 5.w, right: 13.w),
                    child: Row(
                      children: [
                        Text("15 March 2023"),
                        SizedBox(
                          width: 12.w,
                        ),
                        SvgPicture.asset("assets/icons/s_calendar_icon.svg"),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.w,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff115B7A),
                          borderRadius: BorderRadius.circular(5.w)),
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12.w,
                          ),
                          Text(
                            "Current Month",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            "₹12000",
                            style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 12.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 22.w,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff39C19D),
                          borderRadius: BorderRadius.circular(5.w)),
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12.w,
                          ),
                          Text(
                            "Total Business",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text(
                            "₹3,05,000",
                            style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 12.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Payment Overview",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Black1),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              ListView.builder(
                  // padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
                  itemCount: 5,
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
                                "Order ID: LSM012334",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.sp,
                                    color: Color(0xff3A3A3A)),
                              ),
                              Text(
                                "₹135.00",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19.sp,
                                    color: Color(0xff39C19D)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 7.w,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "15 March 2023",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Color(0xffA3A3A3)),
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
                                "Ramesh Patil",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                    color: Color(0xffA3A3A3)),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "UPI ID",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: Color(0xffA3A3A3)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
