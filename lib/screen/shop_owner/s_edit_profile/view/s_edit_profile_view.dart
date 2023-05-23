import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/controller/shop_edit_profile_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class SEditProfileView extends StatefulWidget {
  const SEditProfileView({super.key});

  @override
  State<SEditProfileView> createState() => _SEditProfileViewState();
}

// final TextEditingController controller = TextEditingController();
// String initialCountry = 'IN';
// PhoneNumber number = PhoneNumber(isoCode: 'IN');
// String radioButtonItem = '';
// String? dropdown;

final List<String> genderItems = [
  'Male',
  'Female',
];

class _SEditProfileViewState extends State<SEditProfileView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ShopEditProfileDetailController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopEditProfileDetailController>();
    final watch = context.watch<ShopEditProfileDetailController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Edit profile",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () {
            read.UpdateProfile(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
            // Container(
            //     width: ScreenUtil().screenWidth,
            //     height: 70.h,
            //     child: ListView.builder(
            //       padding: EdgeInsets.only(left: 19.w),
            //       scrollDirection: Axis.horizontal,
            //       physics: BouncingScrollPhysics(),
            //       shrinkWrap: true,
            //       itemCount: watch.bannerImageList?.length,
            //       itemBuilder: (BuildContext, index) {
            //         return watch.bannerImageList!.isEmpty
            //             ? Row(
            //                 children: [
            //                   index == 0
            //                       ? GestureDetector(
            //                     onTap:(){
            //                       read.openGallery();
            //                     },
            //                         child: Container(
            //                             height: 70.h,
            //                             width: 84.41.w,
            //                             decoration: BoxDecoration(
            //                                 borderRadius:
            //                                     BorderRadius.circular(8),
            //                                 border: Border.all(
            //                                     width: 1, color: grey6)),
            //
            //                               child: Image.file(watch.imageFileList[index],fit: BoxFit.cover,)
            //
            //                           ),
            //                       )
            //                       :
            //                   GestureDetector(
            //                     onTap:(){
            //                       read.openGallery();
            //                     },
            //                     child:Container(
            //                       height: 70.h,
            //                       width: 84.41.w,
            //                       decoration: BoxDecoration(
            //                           borderRadius:
            //                           BorderRadius.circular(8),
            //                           border: Border.all(
            //                               width: 1, color: grey6)),
            //                     ),
            //                   ),
            //
            //                   SizedBox(
            //                     width: 5.w,
            //                   ),
            //                 ],
            //               )
            //             : Row(
            //           children: [
            //
            //           ],
            //         );
            //       },
            //     )),

            Container(
              width: ScreenUtil().screenWidth,
              height: 70.h,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
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
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(width: 1, color: grey6)),
                                child: Image.network(
                                  watch.networkImage1,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : watch.fileImage1.path != ""
                                ? Container(
                                    height: 70.h,
                                    width: 84.41.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(width: 1, color: grey6)),
                                    child: Image.file(
                                      watch.fileImage1,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 70.h,
                                    width: 84.41.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(width: 1, color: grey6)),
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
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(width: 1, color: grey6)),
                                child: Image.network(
                                  watch.networkImage2,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : watch.fileImage2.path != ""
                                ? Container(
                                    height: 70.h,
                                    width: 84.41.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(width: 1, color: grey6)),
                                    child: Image.file(
                                      watch.fileImage2,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 70.h,
                                    width: 84.41.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(width: 1, color: grey6)),
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
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(width: 1, color: grey6)),
                                child: Image.network(
                                  watch.networkImage3,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : watch.fileImage3.path != ""
                                ? Container(
                                    height: 70.h,
                                    width: 84.41.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(width: 1, color: grey6)),
                                    child: Image.file(
                                      watch.fileImage3,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 70.h,
                                    width: 84.41.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(width: 1, color: grey6)),
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
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(width: 1, color: grey6)),
                                child: Image.network(
                                  watch.networkImage4,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : watch.fileImage4.path != ""
                                ? Container(
                                    height: 70.h,
                                    width: 84.41.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(width: 1, color: grey6)),
                                    child: Image.file(
                                      watch.fileImage4,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 70.h,
                                    width: 84.41.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(width: 1, color: grey6)),
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
                    controller: watch.ShopNameController,
                    titleHeader: "Shop Name",
                    hintText: "Shop Name",
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    controller: watch.OwnerNameController,
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
                      initialSelection: watch.countryCode,
                      controller: watch.PhoneNumberController,
                      enableOrder: true,
                    )),
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    controller: watch.EmailIdController,
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
                        value: watch.selectedCountryId,
                        onChanged: (value) async {
                          print(value);
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
                      )),
                      SizedBox(
                        width: 30.w,
                      ),
                      Expanded(
                          child: SDropDownField(
                        value: watch.selectedStateId,
                        onChanged: (value) async {
                          print(value);
                        },
                        items: watch.stateDataList
                            ?.map((item) => DropdownMenuItem<String>(
                                  value: item.id.toString(),
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
                  SDropDownField(
                    value: watch.selectedCityId,
                    onChanged: (value) async {
                      print(value);
                    },
                    items: watch.cityDataList
                        ?.map((item) => DropdownMenuItem<String>(
                              value: item.id.toString(),
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
                  SDropDownField(
                    value: watch.selectedAreaId,
                    onChanged: (value) async {
                      print(value);
                    },
                    items: watch.areaDataList
                        ?.map((item) => DropdownMenuItem<String>(
                              value: item.id.toString(),
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
                    controller: watch.ShopAddressController,
                    titleHeader: "Shop Address",
                    hintText: "Shop Address",
                  ),
                  SizedBox(
                    height: 22.w,
                  ),
                  PrimarySTextFormField(
                    controller: watch.PinCodeController,
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
