import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';

class ShopSettingView extends StatefulWidget {
  const ShopSettingView({super.key});

  @override
  State<ShopSettingView> createState() => _ShopSettingViewState();
}

String? selectedValue;
// Group Value fo
// r Radio Button.
int id = 1;
bool switchValue = true;
bool switchValue1 = true;

class _ShopSettingViewState extends State<ShopSettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(title: "Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 19.w, top: 20.w, right: 19.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "App Notification",
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Black1),
                ),
                CupertinoSwitch(
                  // This bool value toggles the switch.
                  value: switchValue1,
                  activeColor: DarkGreen,
                  onChanged: (bool? value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      switchValue1 = value ?? false;
                    });
                  },
                ),
              ],
            ),
            Text(
              "Enable or disable the notifications coming up.",
              style: TextStyle(
                  fontSize: 13.sp, fontWeight: FontWeight.w400, color: Black1),
            ),
            SizedBox(
              height: 40.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Email Notification",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Black1),
                    ),
                    CupertinoSwitch(
                      // This bool value toggles the switch.
                      value: switchValue,
                      activeColor: DarkGreen,
                      onChanged: (bool? value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          switchValue = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  "Enable or disable  the  Email notifications",
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Black1),
                ),
              ],
            ),
            SizedBox(
              height: 41.h,
            ),
            Container(
              padding: EdgeInsets.only(right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Delete Account",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Black1),
                  ),
                  SvgPicture.asset(
                    "assets/icons/delete2.svg",
                    height: 20.h,
                    width: 18.w,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 31.h,
            ),
            Divider(
              thickness: 1,
              color: Color(0xffE0E0E0),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "App Version - 1.0.12",
              style: TextStyle(
                  fontSize: 18.sp, fontWeight: FontWeight.w400, color: Black1),
            ),
          ],
        ),
      ),
    );
  }
}
