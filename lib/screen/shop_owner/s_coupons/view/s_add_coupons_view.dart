import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';

class ShopAddCoupons extends StatefulWidget {
  const ShopAddCoupons({super.key});

  @override
  State<ShopAddCoupons> createState() => _ShopAddCouponsState();
}

class _ShopAddCouponsState extends State<ShopAddCoupons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(title: "Add Coupon"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 26.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "From Date",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: Color(0xff3A3A3A)),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Text(
                      "Delivery Charge",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: Color(0xff3A3A3A)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PrimarySTextFormField(
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
                      hintText: "Delivery Charge",
                      hintFontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: PrimarySTextFormField(
                      hintText: "Delivery Charge",
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
                      hintFontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Discount Percentage (%)",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: Color(0xff3A3A3A)),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Text(
                      "Minimum Order Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: Color(0xff3A3A3A)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PrimarySTextFormField(
                      // hintText: "Delivery Charge",
                      hintFontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: PrimarySTextFormField(
                      // hintText: "Delivery Charge",
                      hintFontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Discount Max Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: Color(0xff3A3A3A)),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Text(
                      "Coupon Code",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: Color(0xff3A3A3A)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PrimarySTextFormField(
                      // hintText: "Delivery Charge",
                      hintFontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: PrimarySTextFormField(
                      // hintText: "Delivery Charge",
                      hintFontSize: 15.sp,
                    ),
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
                    "Terms and Conditions",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: Color(0xff3A3A3A)),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              PrimarySTextFormField(
                height: 150.w,
                maxLines: 10,
                // hintText: "Address",/
              ),
              SizedBox(
                height: 60.h,
              ),
              PrimaryButton(
                fontSize: 20.sp,
                height: 50.w,
                text: "Submit",
                color: Color(0xff4689EC),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
