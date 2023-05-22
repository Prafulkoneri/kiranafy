import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/profile/controller/edit_profile_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({Key? key}) : super(key: key);

  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  // final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String radioButtonItem = '';
  // String? dropdown;
  // final maxLines = 5;
  // final List<String> genderItems = [
  //   'Male',
  //   'Female',
  // ];

  String? selectedValue;
  // Group Value fo
  // r Radio Button.
  int id = 1;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<UpdateProfileController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<UpdateProfileController>();
    final watch = context.watch<UpdateProfileController>();
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
                controller: watch.nameController,
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
                    child: MobileNoTextFormField(
                  controller: watch.mobilrController,
                )),
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
                    child: MobileNoTextFormField(
                  controller: watch.alernetMobileController,
                )),
              ),
              SizedBox(
                height: 20.w,
              ),
              PrimaryCTextFormField(
                controller: watch.emailController,
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
                  controller: watch.dateOfBirthController,
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
                      onChanged: (value) async {
                        await read.onCountrySelected(value);
                        // await read.getStateList(context);
                      },
                      items: watch.countryList
                          ?.map((item) => DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(
                                  item.countryName ?? "",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ))
                          .toList(),
                      hint: "Country",
                      titleHeader: "Country",
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Expanded(
                      child: CDropDownField(
                    onChanged: (value) async {
                      await read.onStateSelected(value);
                      // await read.getCityList(context);
                    },
                    items: watch.stateList
                        ?.map((item) => DropdownMenuItem<String>(
                              value: item.id.toString(),
                              child: Text(
                                item.stateName ?? "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ))
                        .toList(),
                    hint: "State",
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
                      child: CDropDownField(
                    hint: "Area",
                    titleHeader: "Area",
                  )),
                ],
              ),
              SizedBox(
                height: 22.w,
              ),
              CDropDownField(
                hint: "pinCode",
                titleHeader: "Pincode",
              ),
              SizedBox(
                height: 22.w,
              ),
              PrimaryCTextFormField(
                controller: watch.addressController,
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
