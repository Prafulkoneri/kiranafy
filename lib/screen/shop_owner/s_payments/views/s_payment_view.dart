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
                  Text("Payment Overview",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,color:Black1),),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(left: 10.w,top: 5.w,bottom: 5.w,right: 13.w),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff115B7A),
                        borderRadius: BorderRadius.circular(5.w)
                      ),
                      padding: EdgeInsets.only(left: 12.w,right: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12.w,
                          ),
                          Text("Current Month",style: TextStyle(fontSize: 13.sp,color: Colors.white,fontWeight: FontWeight.w400),),
                          SizedBox(
                            height: 7.w,
                          ),
                          Text("₹12000",style: TextStyle(fontSize: 24.sp,color: Colors.white,fontWeight: FontWeight.w500),),
                          SizedBox(
                            height: 12.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
