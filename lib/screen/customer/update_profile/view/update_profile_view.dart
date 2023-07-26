import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/update_profile/controller/edit_profile_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({Key? key}) : super(key: key);

  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
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
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreenView(
                      index: 4, screenName: ProfileScreenView())),
              (Route<dynamic> route) => false,
            );
          },
          title: "Update Profile",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () async {
            await read.validateField(context);
          },
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : WillPopScope(
              onWillPop: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreenView(
                          index: 4, screenName: ProfileScreenView())),
                  (Route<dynamic> route) => false,
                );

                return false;
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  width: ScreenUtil().screenWidth,
                  padding: EdgeInsets.symmetric(horizontal: 19.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          read.openGallery();
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            watch.networkImage != ""
                                ? Container(
                                    height: 120.w,
                                    width: 120.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(width: 1, color: grey6)),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.w),
                                        child: AppNetworkImages(
                                          imageUrl: watch.networkImage,
                                          fit: BoxFit.cover,
                                        )))
                                : watch.fileImage.path != ""
                                    ? Container(
                                        height: 120.w,
                                        width: 120.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1, color: grey6)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.w),
                                          child: Image.file(
                                            watch.fileImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 120.w,
                                        width: 120.w,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.w),
                                            child: Image.asset(
                                                "assets/images/profile_image.png")),
                                      ),
                            Positioned(
                                bottom: -10.w,
                                right: 0.w,
                                left: 0.w,
                                child: Container(
                                  height: 31.w,
                                  width: 31.w,
                                  child:
                                      Image.asset("assets/images/camera.png"),
                                )),
                          ],
                        ),
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
                          readOnly: true,
                          enableOrder: false,
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
                          onCountryCodeChanged: (countryCode) {
                            print(countryCode);
                          },
                          enableOrder: false,
                          controller: watch.alernetMobileController,
                        )),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      PrimaryCTextFormField(
                        controller: watch.emailController,
                        titleHeader: "Email ID",
                        hintText: "Email ID",
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Row(
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              SecondaryRadioButton(
                                  value: "male",
                                  groupValue: watch.radioGroupValue,
                                  onChanged: (value) {
                                    read.onRadioButtonSelected(value);
                                  },
                                  leading: ""),
                              SizedBox(
                                width: 10.w,
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
                              SecondaryRadioButton(
                                  value: "female",
                                  groupValue: watch.radioGroupValue,
                                  onChanged: (value) {
                                    read.onRadioButtonSelected(value);
                                  },
                                  leading: ""),
                              SizedBox(
                                width: 10.w,
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
                              SecondaryRadioButton(
                                  value: "other",
                                  groupValue: watch.radioGroupValue,
                                  onChanged: (value) {
                                    read.onRadioButtonSelected(value);
                                  },
                                  leading: ""),
                              SizedBox(
                                width: 10.w,
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
                        hintText: "Date of Birth",
                        suffix: GestureDetector(
                          onTap: () async {
                            var pickedDate = await showDatePicker(
                              builder: (BuildContext, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Color(0xff1767B1),
                                      // <-- SEE HERE
                                      onPrimary: Colors.white,
                                      // <-- SEE HERE
                                      onSurface: Colors.black, // <-- SEE HERE
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        primary: Color(
                                            0xff1767B1), // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1901, 1),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              String date = DateFormat('dd-MM-yyy')
                                  .format(pickedDate ?? DateTime.now());
                              read.onDateSelected(date);
                            }
                          },
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Color(0xff03C9CC),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: watch.countryId == 0
                                ? CDropDownField(
                                    onChanged: (value) async {
                                      read.onCountrySelected(value);
                                      await read.getStateList(context);
                                    },
                                    items: watch.countryList
                                        ?.map(
                                            (item) => DropdownMenuItem<String>(
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
                                  )
                                : CDropDownField(
                                    value: watch.countryId.toString(),
                                    onChanged: (value) async {
                                      read.onCountrySelected(value);
                                      await read.getStateList(context);
                                    },
                                    items: watch.countryList
                                        ?.map(
                                            (item) => DropdownMenuItem<String>(
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
                              child: watch.stateId == 0
                                  ? CDropDownField(
                                      onChanged: (value) async {
                                        await read.onStateSelected(value);
                                        await read.getCityList(context);
                                      },
                                      items: watch.stateList
                                          ?.map((item) =>
                                              DropdownMenuItem<String>(
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
                                      titleHeader: "State",
                                    )
                                  : CDropDownField(
                                      value: watch.stateId.toString(),
                                      onChanged: (value) async {
                                        await read.onStateSelected(value);
                                        await read.getCityList(context);
                                      },
                                      items: watch.stateList
                                          ?.map((item) =>
                                              DropdownMenuItem<String>(
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
                              child: watch.cityId == 0
                                  ? CDropDownField(
                                      onChanged: (value) async {
                                        await read.onCitySelected(value);
                                        await read.getAreaList(context);
                                      },
                                      items: watch.cityList
                                          ?.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.id.toString(),
                                                child: Text(
                                                  item.cityName ?? "",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      hint: "City",
                                      titleHeader: "City",
                                    )
                                  : CDropDownField(
                                      value: watch.cityId.toString(),
                                      onChanged: (value) async {
                                        await read.onCitySelected(value);
                                        await read.getAreaList(context);
                                      },
                                      items: watch.cityList
                                          ?.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.id.toString(),
                                                child: Text(
                                                  item.cityName ?? "",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      hint: "City",
                                      titleHeader: "City",
                                    )),
                          SizedBox(
                            width: 30.w,
                          ),
                          Expanded(
                              child: watch.areaId == 0
                                  ? CDropDownField(
                                      onChanged: (value) async {
                                        read.onAreaSelected(value);
                                        read.getPinCodeList(context);
                                      },
                                      items: watch.areaList
                                          ?.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.id.toString(),
                                                child: Text(
                                                  item.areaName ?? "",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      hint: "Area",
                                      titleHeader: "Area",
                                    )
                                  : CDropDownField(
                                      value: watch.areaId.toString(),
                                      onChanged: (value) async {
                                        read.onAreaSelected(value);
                                        read.getPinCodeList(context);
                                      },
                                      items: watch.areaList
                                          ?.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.id.toString(),
                                                child: Text(
                                                  item.areaName ?? "",
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      hint: "Area",
                                      titleHeader: "Area",
                                    )),
                        ],
                      ),
                      SizedBox(
                        height: 22.w,
                      ),
                      watch.pincode == ""
                          ? CDropDownField(
                              onChanged: (value) async {
                                print(value);
                                read.onPincodeSelected(value);
                              },
                              items: watch.pincodeList
                                  ?.map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item ?? "",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              hint: "Pincode",
                              titleHeader: "Pincode",
                            )
                          : CDropDownField(
                              value: watch.pincode,
                              onChanged: (value) async {
                                print(value);
                                read.onPincodeSelected(value);
                              },
                              items: watch.pincodeList
                                  ?.map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item ?? "",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              hint: "Pincode",
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
                        height: 100.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
