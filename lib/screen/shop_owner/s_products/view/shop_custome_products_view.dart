import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/controller/s_shop_configuration_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class ShopCustomProductView extends StatefulWidget {
  const ShopCustomProductView({super.key});

  @override
  State<ShopCustomProductView> createState() => _ShopCustomProductViewState();
}

final TextEditingController controller = TextEditingController();
String initialCountry = 'IN';
PhoneNumber number = PhoneNumber(isoCode: 'IN');
String radioButtonItem = '';
String? dropdown;
final maxLines = 5;
final List<String> genderItems = [
  'Male',
  'Female',
];

String? selectedValue;
// Group Value fo
// r Radio Button.
int id = 1;
bool switchValue = true;
bool switchValue1 = true;

class _ShopCustomProductViewState extends State<ShopCustomProductView> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SShopConfigurationController>();
    final read = context.read<SShopConfigurationController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Add Products",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () {},
        ),
      ),
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
                  SDropDownField(
                    hint: "Select Category ",
                  ),
                  SizedBox(
                    height: 15.w,
                  ),
                  PrimarySTextFormField(
                    // titleHeader: "Shop Name",
                    hintText: "Shop Name",
                  ),
                  SizedBox(
                    height: 15.w,
                  ),
                  SDropDownField(
                    hint: "Select Category ",
                  ),
                  SizedBox(
                    height: 21.w,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onCustomerPickupSelected();
                            },
                            value: watch.isCustomerPickupSelected,
                          ),
                          Text(
                            'Show Under Recommended Product',
                            style: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 19.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onCustomerPickupSelected();
                            },
                            value: watch.isCustomerPickupSelected,
                          ),
                          Text(
                            'Show Under Seasonal Product',
                            style: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 19.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onCustomerPickupSelected();
                            },
                            value: watch.isCustomerPickupSelected,
                          ),
                          Text(
                            'Show Under Seasonal Product',
                            style: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          // SizedBox(
                          //   width: 30.w,
                          // ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Container(
                    child: PrimarySTextFormField(
                      height: 150.w,
                      maxLines: 8,
                      hintText: "Address",
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Product Future Image",
                        style: TextStyle(
                            color: Color(0xff717171),
                            // letterSpacing: .5,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 11.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 100.h,
                        width: 110.w,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10.0,
                          ),
                        ]),
                        child: Card(
                          elevation: 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/gallary.svg",
                                // height: 19.w,
                                // width: 21.w,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Add Image",
                                style: TextStyle(
                                    color: Color(0xffB3B3B3),
                                    // letterSpacing: .5,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xffDDDDDD),
                  ),
                  SizedBox(height: 15.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Unit",
                        style: TextStyle(
                            color: Black,
                            // letterSpacing: .5,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.w),
                        // margin: EdgeInsets.only(right: 15.w),
                        // height: 24.h,
                        // width: 55.w,
                        decoration: BoxDecoration(
                          color: SplashText,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add",
                              style: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: .5,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            SvgPicture.asset(
                              'assets/icons/pluse.svg',
                              height: 7.h,
                              width: 7.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimarySTextFormField(
                          height: 35,
                          // width: 20, // titleHeader: "Shop Name",
                          hintText: "Shop Name",
                          hintFontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                          child: SDropDownField(
                        height: 30.w,
                        hint: "Unit",
                        hintSize: 11.5.sp,
                      )),
                      SizedBox(width: 5.25.w),
                      Expanded(
                        child: PrimarySTextFormField(
                          height: 35,
                          // width: 20, // titleHeader: "Shop Name",
                          hintText: "Shop Name",
                          hintFontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 5.25.w),
                      Expanded(
                        child: PrimarySTextFormField(
                          height: 35,
                          // width: 20, // titleHeader: "Shop Name",
                          hintText: "Shop Name",
                          hintFontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100.h,
                          width: 110.w,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.0,
                            ),
                          ]),
                          child: Card(
                            elevation: 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/gallary.svg",
                                  // height: 19.w,
                                  // width: 21.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Add Image",
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100.h,
                          width: 110.w,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.0,
                            ),
                          ]),
                          child: Card(
                            elevation: 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/gallary.svg",
                                  // height: 19.w,
                                  // width: 21.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Add Image",
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100.h,
                          width: 110.w,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.0,
                            ),
                          ]),
                          child: Card(
                            elevation: 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/gallary.svg",
                                  // height: 19.w,
                                  // width: 21.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Add Image",
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: PrimarySTextFormField(
                          height: 35,
                          // width: 20, // titleHeader: "Shop Name",
                          hintText: "Shop Name",
                          hintFontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                          child: SDropDownField(
                        height: 30.w,
                        hint: "Unit",
                        hintSize: 11.5.sp,
                      )),
                      SizedBox(width: 5.25.w),
                      Expanded(
                        child: PrimarySTextFormField(
                          height: 35,
                          // width: 20, // titleHeader: "Shop Name",
                          hintText: "Shop Name",
                          hintFontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 5.25.w),
                      Expanded(
                        child: PrimarySTextFormField(
                          height: 35,
                          // width: 20, // titleHeader: "Shop Name",
                          hintText: "Shop Name",
                          hintFontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100.h,
                          width: 110.w,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.0,
                            ),
                          ]),
                          child: Card(
                            elevation: 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/gallary.svg",
                                  // height: 19.w,
                                  // width: 21.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Add Image",
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100.h,
                          width: 110.w,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.0,
                            ),
                          ]),
                          child: Card(
                            elevation: 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/gallary.svg",
                                  // height: 19.w,
                                  // width: 21.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Add Image",
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 100.h,
                          width: 110.w,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10.0,
                            ),
                          ]),
                          child: Card(
                            elevation: 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/gallary.svg",
                                  // height: 19.w,
                                  // width: 21.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "Add Image",
                                  style: TextStyle(
                                      color: Color(0xffB3B3B3),
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 94.h,
            )
          ],
        ),
      ),
    );
  }
}
