import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({Key? key}) : super(key: key);

  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Update Profile",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: Column(
            children: [
              SizedBox(
                height: 18.w,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 120.w,
                    width: 120.w,
                    child: Image.asset("assets/images/account.png"),
                  ),
                  Positioned(
                      bottom: -10.w,
                      right: 0.w,
                      left: 0.w,
                      child: Container(
                        height: 31.w,
                        width: 31.w,
                        child: Image.asset("assets/images/camera.png"),
                      )),
                ],
              ),
              SizedBox(
                height: 10.5.w,
              ),
              PrimaryCTextFormField(
                titleHeader: "Name",
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                children: [
                  Text(
                    "Mobile No.",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Container(
                    child: MobileNoTextFormField(controller: controller)),
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                children: [
                  Text(
                    "Alternate Mobile No.",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Container(
                    child: MobileNoTextFormField(controller: controller)),
              ),
              SizedBox(
                height: 20.w,
              ),
              PrimaryCTextFormField(
                titleHeader: "Email ID",
              ),
              SizedBox(
                height: 20.w,
              ),
              Row(
                children: [
                  Text(
                    "Gender",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      Radio(
                        fillColor:
                            MaterialStateColor.resolveWith((states) => Button1),
                        value: 1,
                        groupValue: id,
                        onChanged: (val) {
                          setState(() {
                            radioButtonItem = 'Delivery To';
                            id = 1;
                          });
                        },
                      ),
                      Text(
                        'Male',
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              letterSpacing: .5,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25.w),
                        child: Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Button1),
                          value: 2,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Self Pickup';
                              id = 2;
                            });
                          },
                        ),
                      ),
                      Text(
                        'Female',
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              letterSpacing: .5,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25.w),
                        child: Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Button1),
                          value: 3,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'Other';
                              id = 3;
                            });
                          },
                        ),
                      ),
                      Text(
                        'Other',
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              letterSpacing: .5,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 13.w,
              ),
              PrimaryCTextFormField(
                  titleHeader: "Date of Birth",
                  suffix: Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xff03C9CC),
                  )),
              SizedBox(
                height: 22.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: CDropDownField(
                    hint: "Country",
                    titleHeader: "Country",
                  )),
                  SizedBox(
                    width: 30.w,
                  ),
                  Expanded(
                      child: CDropDownField(
                    hint: "State",
                    titleHeader: "State",
                  )),
                ],
              ),
              SizedBox(
                height: 22.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: CDropDownField(
                    hint: "City",
                    titleHeader: "City",
                  )),
                  SizedBox(
                    width: 30.w,
                  ),
                  Expanded(
                      child: PrimaryCTextFormField(
                    titleHeader: "Pincode",
                    hintText: "Pincode",
                  )),
                ],
              ),
              SizedBox(
                height: 22.w,
              ),
              PrimaryCTextFormField(
                titleHeader: "Address",
                hintText: "Address",
              ),
              SizedBox(
                height: 22.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
