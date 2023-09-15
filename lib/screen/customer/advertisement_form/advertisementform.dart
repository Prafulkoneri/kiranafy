import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/textfield.dart';

class AdvertisementForm extends StatefulWidget {
  const AdvertisementForm({super.key});

  @override
  State<AdvertisementForm> createState() => _AdvertisementFormState();
}

class _AdvertisementFormState extends State<AdvertisementForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(title: "Promotion Request form"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Promotion Subject",
                    // hintText: "Enter Name of the Bank",
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Plan for Start",
                    // hintText: "Delivery Charge",
                    suffix: Container(
                      padding: EdgeInsets.only(right: 17.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/shop_cal.svg",
                            // width: 5.h,
                            // height: 5.w,
                          ),
                        ],
                      ),
                    ),
                    // hintFontSize: 15.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
