import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_registration_controller.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class ShopRegistrationView extends StatefulWidget {
  ShopRegistrationView({super.key});

  @override
  State<ShopRegistrationView> createState() => _ShopRegistrationViewState();
// String dropdownValue = 'Dog';
}

class _ShopRegistrationViewState extends State<ShopRegistrationView> {
  // String? selectedValue;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ShopRegistrationController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopRegistrationController>();
    final watch = context.watch<ShopRegistrationController>();
    // var dropdownValue;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            title: "Shop Registration",
            isBackButtonEnabled: false,
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -30.w,
                left: 0.w,
                child: Image.asset(
                  "assets/images/splash1.png",
                  height: 235.w,
                  width: 361.w,
                ),
              ),
              Positioned(
                bottom: -25.w,
                right: 0.w,
                child: Image.asset(
                  "assets/images/splash2.png",
                  height: 235.w,
                  width: 361.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, top: 20.w, bottom: 20.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please provide all required details to\nregister your business with us",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: Black,
                              letterSpacing: .5,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      PrimarySTextFormField(
                        controller: watch.shopNameController,
                        hintText: "Shop Name",
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      PrimarySTextFormField(
                        controller: watch.ownerNameController,
                        hintText: "Owner Name",
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      SDropDownField(
                        onChanged: (value) {
                          read.onShopTypeSelected(value);
                        },
                        hint: "Shop Type",
                        items: [
                          DropdownMenuItem(
                            value: "1",
                            child: Text(
                              "Retailer",
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "2",
                            child: Text(
                              "Wholesaler",
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      // MobileNoTextFormField(
                      //   controller: watch.mobController,
                      //   enableOrder: true,
                      // ),
                      MobileNoTextFormField(
                        readOnly: true,
                        initialSelection: watch.selectedCountryCode,
                        controller: watch.mobController,
                        enableOrder: true,
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      PrimarySTextFormField(
                        controller: watch.emailIdController,
                        hintText: "Email ID",
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SDropDownField(
                              onChanged: (value) async {
                                await read.onCountrySelected(value);
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
                            ),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          Expanded(
                              child: watch.stateId == 0
                                  ? SDropDownField(
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
                                    )
                                  : SDropDownField(
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
                                    )),
                        ],
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      watch.cityId == 0
                          ? SDropDownField(
                              onChanged: (value) async {
                                await read.onCitySelected(value);
                                await read.getAreaList(context);
                              },
                              items: watch.cityList
                                  ?.map((item) => DropdownMenuItem<String>(
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
                            )
                          : SDropDownField(
                              value: watch.cityId.toString(),
                              onChanged: (value) async {
                                await read.onCitySelected(value);
                                await read.getAreaList(context);
                              },
                              items: watch.cityList
                                  ?.map((item) => DropdownMenuItem<String>(
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
                            ),
                      SizedBox(
                        height: 18.w,
                      ),
                      watch.areaId == 0
                          ? SDropDownField(
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
                                    ),
                                  )
                                  .toList(),
                              hint: "Area",
                            )
                          : SDropDownField(
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
                                    ),
                                  )
                                  .toList(),
                              hint: "Area",
                            ),

                      SizedBox(
                        height: 18.w,
                      ),
                      Container(
                        child: PrimarySTextFormField(
                          controller: watch.addressController,
                          height: 108.w,
                          maxLines: 5,
                          hintText: "Address",
                        ),
                      ),
                      SizedBox(
                        height: 18.w,
                      ),

                      watch.pincode == ""
                          ? SDropDownField(
                              onChanged: (value) async {
                                print(value);
                                read.onPincodeSelected(value);
                              },
                              items: watch.pincodeList
                                  ?.map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item ?? "",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              hint: "Pincode",
                            )
                          : SDropDownField(
                              value: watch.pincode,
                              onChanged: (value) async {
                                print(value);
                                read.onPincodeSelected(value);
                              },
                              items: watch.pincodeList
                                  ?.map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item ?? "",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              hint: "Pincode",
                            ),
                      SizedBox(
                        height: 18.w,
                      ),
                      PrimarySTextFormField(
                        controller: watch.upiController,
                        hintText: "UPI",
                      ),
                      SizedBox(
                        height: 3.w,
                      ),
                      Row(
                        children: [
                          Text(
                            "This UPI ID will be used for payment from customers.",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xff3A3A3A),
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 36.w,
                      ),

                      SizedBox(
                        height: 12.w,
                      ),
                      PrimaryButton(
                        fontSize: 20.sp,
                        height: 45.w,
                        text: "Next",
                        color: Color(0xff4689EC),
                        onTap: () {
                          print("uicvneuiqboewybte");
                          read.onNextClicked(context);
                        },
                      ),
                    ]),
              ),
            ],
          ),
        ));
  }
}
