import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/delivery_address/controller/add_address_controller.dart';
import 'package:local_supper_market/screen/customer/delivery_address/view/my_delivery_address.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class AddAddressView extends StatefulWidget {
  final bool? isEditAdress;
  final String? addressId;
  const AddAddressView({super.key, required this.isEditAdress, this.addressId});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final TextEditingController controller = TextEditingController();

  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<AddAddressController>()
          .initState(context, widget.isEditAdress, widget.addressId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<AddAddressController>();
    final read = context.read<AddAddressController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreenView(
                      index: 4,
                      screenName: MyDeliveryAddressView(
                        isRefresh: false,
                      ))),
              (Route<dynamic> route) => false,
            );
          },
          title: widget.isEditAdress == false ? "Add Address" : "Edit Address",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () async {
            await read.validateField(context);
          },
        ),
      ),
      // body: const Center(
      //   child: Text('Flutter Demo'),
      // ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            SecondaryRadioButton(
                                value: "home",
                                groupValue: watch.groupValue,
                                // groupValue: watch.radioGroupValue,
                                onChanged: (value) {
                                  read.onRadioButtonSelected(value);
                                },
                                leading: ""),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Home',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SecondaryRadioButton(
                                value: "office",
                                groupValue: watch.groupValue,
                                onChanged: (value) {
                                  read.onRadioButtonSelected(value);
                                },
                                leading: ""),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Office',
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
                                groupValue: watch.groupValue,
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
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Black1),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Container(
                        child: MobileNoTextFormField(
                      controller: watch.mobNoController,
                      onCountryCodeChanged: (countryCode) {
                        print(countryCode);
                      },
                      enableOrder: false,
                    )),
                    SizedBox(
                      height: 22.w,
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
                                )
                              : CDropDownField(
                                  value: watch.countryId.toString(),
                                  onChanged: (value) async {
                                    read.onCountrySelected(value);
                                    await read.getStateList(context);
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
                            child: watch.stateId == 0
                                ? CDropDownField(
                                    onChanged: (value) async {
                                      await read.onStateSelected(value);
                                      await read.getCityList(context);
                                    },
                                    items: watch.stateList
                                        ?.map(
                                            (item) => DropdownMenuItem<String>(
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
                                        ?.map(
                                            (item) => DropdownMenuItem<String>(
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
                      children: [
                        Expanded(
                            child: watch.cityId == 0
                                ? CDropDownField(
                                    onChanged: (value) async {
                                      await read.onCitySelected(value);
                                      await read.getAreaList(context);
                                    },
                                    items: watch.cityList
                                        ?.map(
                                            (item) => DropdownMenuItem<String>(
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
                                        ?.map(
                                            (item) => DropdownMenuItem<String>(
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
                      ],
                    ),
                    SizedBox(
                      height: 22.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: watch.areaId == 0
                                ? CDropDownField(
                                    onChanged: (value) async {
                                      read.onAreaSelected(value);
                                      read.getPinCodeList(context);
                                    },
                                    items: watch.areaList
                                        ?.map(
                                            (item) => DropdownMenuItem<String>(
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
                                        ?.map(
                                            (item) => DropdownMenuItem<String>(
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
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: watch.pincode == "null" ||
                                  !watch.showPincodeValueField
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22.w,
                    ),
                    Row(
                      children: [
                        Text(
                          "Detail Address",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Black1),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 22.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: PrimaryCTextFormField(
                          controller: watch.apartmentNameController,
                          titleHeader: "Apartment Name",
                        )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: PrimaryCTextFormField(
                          controller: watch.houseNoController,
                          titleHeader: "House No.",
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
                            child: PrimaryCTextFormField(
                          controller: watch.streetController,
                          titleHeader: "Street",
                        )),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                            child: PrimaryCTextFormField(
                          controller: watch.areaController,
                          titleHeader: "Area",
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10.5.w,
                    ),
                    PrimaryCTextFormField(
                      controller: watch.landMarkController,
                      titleHeader: "Landmark",
                    ),
                    SizedBox(
                      height: 100.w,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
