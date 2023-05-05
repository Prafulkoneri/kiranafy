import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';

class SEditProfileView extends StatefulWidget {
  const SEditProfileView({super.key});

  @override
  State<SEditProfileView> createState() => _SEditProfileViewState();
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

class _SEditProfileViewState extends State<SEditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Edit profile",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 19.w, top: 12.w, bottom: 10.w),
              child: Row(
                children: [
                  Text(
                    "Banner Images",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 70.h,
              child: ListView(
                shrinkWrap: true,
                // physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 19.w),
                    child: Row(
                      children: [
                        Container(
                          height: 70.h,
                          width: 84.41.w,
                          // padding:
                          //     EdgeInsets.symmetric(vertical: 25.w, horizontal: 32.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1, color: grey6)),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/icons/camera1.svg",
                              // height: 19.w,
                              // width: 21.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          height: 70.h,
                          width: 84.41.w,

                          // padding:
                          //     EdgeInsets.symmetric(vertical: 35.w, horizontal: 40.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1, color: grey6)),
                          // child: SvgPicture.asset("assets/icons/camera1.svg"),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          height: 70.h,
                          width: 84.41.w,

                          // padding:
                          //     EdgeInsets.symmetric(vertical: 35.w, horizontal: 40.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1, color: grey6)),
                          // child: SvgPicture.asset("assets/icons/camera1.svg"),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          height: 70.h,
                          width: 84.41.w,

                          // padding:
                          //     EdgeInsets.symmetric(vertical: 35.w, horizontal: 40.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1, color: grey6)),
                          // child: SvgPicture.asset("assets/icons/camera1.svg"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.5.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Shop Name",
                    hintText: "Shop Name",
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Owner Name",
                    hintText: "Owner Name",
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                        child: MobileNoTextFormField(
                      controller: controller,
                      enableOrder: true,
                    )),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Email ID",
                    hintText: "Email ID",
                  ),
                  SizedBox(
                    height: 22.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: SDropDownField(
                        hint: "Country",
                        titleHeader: "Country",
                      )),
                      SizedBox(
                        width: 30.w,
                      ),
                      Expanded(
                          child: SDropDownField(
                        hint: "State",
                        titleHeader: "State",
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 22.w,
                  ),
                  SDropDownField(
                    hint: "City",
                    titleHeader: "City",
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  SizedBox(
                    height: 22.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Shop Address",
                    hintText: "Shop Address",
                  ),
                  SizedBox(
                    height: 22.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Pincode",
                    hintText: "Pincode",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22.w,
            ),
          ],
        ),
      ),
    );
  }
}
