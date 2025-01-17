import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/controller/shop_edit_profile_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class SEditProfileView extends StatefulWidget {
  final bool? fromDashBoard;

  const SEditProfileView({super.key, required this.fromDashBoard});

  @override
  State<SEditProfileView> createState() => _SEditProfileViewState();
}

class _SEditProfileViewState extends State<SEditProfileView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ShopEditProfileDetailController>().initState(context);
    });
  }

  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopEditProfileDetailController>();
    final watch = context.watch<ShopEditProfileDetailController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            read.onBackPressed(context, widget.fromDashBoard);
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => SMainScreenView(
            //               index: 4,
            //               screenName: SAccountScreenView(refresh: false),
            //             )));
          },
          title: "Edit profile",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () async {
            read.validateField(context);
            // await readMainScreen.onBackPressed(4, )
            // await readMainScreen.onBackPressed(
            //     4,
            //     SAccountScreenView(
            //         // updateMessage: 'Upadated Succefully',
            //         ));
          },
        ),
      ),
      body: watch.isLoading
          ? const Loader()
          : WillPopScope(
              onWillPop: () async {
                read.onBackPressed(context, widget.fromDashBoard);
                return false;
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.only(left: 19.w, top: 12.w, bottom: 10.w),
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
                    SizedBox(
                      width: ScreenUtil().screenWidth,
                      height: 70.h,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 19.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  read.openGallery1();
                                },
                                child: watch.networkImage1 != ""
                                    ? Container(
                                        height: 70.h,
                                        width: 84.41.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1, color: grey6)),
                                        child: AppNetworkImages(
                                          imageUrl: watch.networkImage1,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : watch.fileImage1.path != ""
                                        ? Container(
                                            height: 70.h,
                                            width: 84.41.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1, color: grey6)),
                                            child: Image.file(
                                              watch.fileImage1,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Container(
                                            height: 70.h,
                                            width: 84.41.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1, color: grey6)),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                  "assets/icons/camera1.svg"),
                                            ),
                                          ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  read.openGallery2();
                                },
                                child: watch.networkImage2 != ""
                                    ? Container(
                                        height: 70.h,
                                        width: 84.41.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1, color: grey6)),
                                        child: AppNetworkImages(
                                          imageUrl: watch.networkImage2,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : watch.fileImage2.path != ""
                                        ? Container(
                                            height: 70.h,
                                            width: 84.41.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1, color: grey6)),
                                            child: Image.file(
                                              watch.fileImage2,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Container(
                                            height: 70.h,
                                            width: 84.41.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1, color: grey6)),
                                          ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  read.openGallery3();
                                },
                                child: watch.networkImage3 != ""
                                    ? Container(
                                        height: 70.h,
                                        width: 84.41.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1, color: grey6)),
                                        child: AppNetworkImages(
                                          imageUrl: watch.networkImage3,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : watch.fileImage3.path != ""
                                        ? Container(
                                            height: 70.h,
                                            width: 84.41.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1, color: grey6)),
                                            child: Image.file(
                                              watch.fileImage3,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Container(
                                            height: 70.h,
                                            width: 84.41.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1, color: grey6)),
                                          ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  read.openGallery4();
                                },
                                child: watch.networkImage4 != ""
                                    ? Container(
                                        height: 70.h,
                                        width: 84.41.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1, color: grey6)),
                                        child: AppNetworkImages(
                                          imageUrl: watch.networkImage4,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : watch.fileImage4.path != ""
                                        ? Container(
                                            height: 70.h,
                                            width: 84.41.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1, color: grey6)),
                                            child: Image.file(
                                              watch.fileImage4,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Container(
                                            height: 70.h,
                                            width: 84.41.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1, color: grey6)),
                                          ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
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
                            controller: watch.shopNameController,
                            titleHeader: "Shop Name",
                            hintText: "Shop Name",
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          PrimarySTextFormField(
                            controller: watch.ownerNameController,
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
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
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
                              initialSelection: watch.countryCode,
                              controller: watch.phoneNumberController,
                              enableOrder: true,
                            )),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          PrimarySTextFormField(
                            controller: watch.emailIdController,
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
                                      child: watch.countryName==""?
                                      SearchDropDownField(
                                    textEditingController:
                                        watch.countrySearchController,
                                    onChanged: (value) async {
                                      read.onCountrySelected(value);
                                      read.getStateList(context);
                                    },
                                    items: watch.countryDataList
                                        ?.map((item) => DropdownMenuItem<String>(
                                              value: item.id.toString(),
                                              child: Text(
                                                item.countryName ?? "",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    hint: "Country",
                                    titleHeader: "Country",
                                  ): SearchDropDownField(
                                        textEditingController:
                                        watch.countrySearchController,
                                        value: watch.countryName,
                                        onChanged: (value) async {
                                          read.onCountrySelected(value);
                                          read.getStateList(context);
                                        },
                                        items: watch.countryDataList
                                            ?.map((item) => DropdownMenuItem<String>(
                                          value: item.countryName.toString(),
                                          child: Text(
                                            item.countryName ?? "",
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                            .toList(),
                                        hint: "Country",
                                        titleHeader: "Country",
                                      )),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Expanded(
                                      child: watch.showValueStateField
                                          ? SearchDropDownField(
                                              textEditingController:
                                                  watch.stateSearchController,
                                              value: watch.stateName,
                                              onChanged: (value) async {
                                                read.onStateSelected(value);
                                                read.getCityList(context);
                                              },
                                              items: watch.stateDataList
                                                  ?.map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item.stateName.toString(),
                                                        child: Text(
                                                          item.stateName ?? "",
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              hint: "State",
                                              titleHeader: "State",
                                            )
                                          : SearchDropDownField(
                                              textEditingController:
                                                  watch.stateSearchController,
                                              onChanged: (value) async {
                                                read.onStateSelected(value);
                                                read.getCityList(context);
                                              },
                                              items: watch.stateDataList
                                                  ?.map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item.stateName.toString(),
                                                        child: Text(
                                                          item.stateName ?? "",
                                                          style: const TextStyle(
                                                            fontSize: 14,
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
                          watch.showValueCityField
                              ? SearchDropDownField(
                                  textEditingController:
                                      watch.citySearchController,
                                  value: watch.cityName,
                                  onChanged: (value) async {
                                    read.onCitySelected(value);
                                    read.getAreaList(context);
                                  },
                                  items: watch.cityDataList
                                      ?.map((item) => DropdownMenuItem<String>(
                                            value: item.cityName.toString(),
                                            child: Text(
                                              item.cityName ?? "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  hint: "City",
                                  titleHeader: "City",
                                )
                              : SearchDropDownField(
                                  textEditingController:
                                      watch.citySearchController,
                                  onChanged: (value) async {
                                    read.onCitySelected(value);
                                    read.getAreaList(context);
                                  },
                                  items: watch.cityDataList
                                      ?.map((item) => DropdownMenuItem<String>(
                                            value: item.cityName.toString(),
                                            child: Text(
                                              item.cityName ?? "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  hint: "City",
                                  titleHeader: "City",
                                ),
                          SizedBox(
                            width: 30.w,
                          ),
                          SizedBox(
                            height: 22.w,
                          ),
                          watch.showValueAreaField
                              ? SearchDropDownField(
                                  textEditingController:
                                      watch.areaSearchController,
                                  value: watch.areaName,
                                  onChanged: (value) async {
                                    read.onAreaSelected(value);
                                    read.getPinCodeList(context);
                                  },
                                  items: watch.areaDataList
                                      ?.map((item) => DropdownMenuItem<String>(
                                            value: item.areaName.toString(),
                                            child: Text(
                                              item.areaName ?? "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  hint: "Area",
                                  titleHeader: "Area",
                                )
                              : SearchDropDownField(
                                  textEditingController:
                                      watch.areaSearchController,
                                  onChanged: (value) async {
                                    read.onAreaSelected(value);
                                    read.getPinCodeList(context);
                                  },
                                  items: watch.areaDataList
                                      ?.map((item) => DropdownMenuItem<String>(
                                            value: item.areaName.toString(),
                                            child: Text(
                                              item.areaName ?? "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  hint: "Area",
                                  titleHeader: "Area",
                                ),
                          SizedBox(
                            width: 30.w,
                          ),
                          SizedBox(
                            height: 22.w,
                          ),
                          PrimarySTextFormField(
                            controller: watch.shopAddressController,
                            titleHeader: "Shop Address",
                            hintText: "Shop Address",
                          ),
                          SizedBox(
                            height: 22.w,
                          ),
                          watch.showValuePincodeField
                              ? SDropDownField(
                                  value: watch.selectedPincode.toString(),
                                  onChanged: (value) async {
                                    read.onPincodeSelected(value);
                                  },
                                  items: watch.pincodeList
                                      ?.map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  hint: "Pincode",
                                  titleHeader: "Pincode",
                                )
                              : SDropDownField(
                                  onChanged: (value) async {
                                    read.onPincodeSelected(value);
                                  },
                                  items: watch.pincodeList
                                      ?.map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  hint: "Pincode",
                                  titleHeader: "Pincode",
                                ),
                        ],
                      ),
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
