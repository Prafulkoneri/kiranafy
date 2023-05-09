import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding:  EdgeInsets.symmetric(horizontal: 19.w),
          child: Column(
            children: [
           SizedBox(
             height: 20.w,
           ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment Overview",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,color:Black1),),
                  Text("15 March 2023",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color:Black1),)
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
