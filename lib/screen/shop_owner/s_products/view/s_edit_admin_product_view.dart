import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_custom_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_add_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_edit_admin_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/controller/s_shop_configuration_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class SEditAdminProductView extends StatefulWidget {
  final String? categoryId;
  final String? productId;

  const SEditAdminProductView(
      {super.key, required this.productId, required this.categoryId});

  @override
  State<SEditAdminProductView> createState() => _SEditAdminProductViewState();
}

class _SEditAdminProductViewState extends State<SEditAdminProductView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<EditAdminProductController>().initState(
          context, CreateWidget(0), 0, widget.productId, widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<EditAdminProductController>();
    final read = context.read<EditAdminProductController>();
    final readMain = context.read<SMainScreenController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SMainScreenView(
                      index: 0,
                      screenName: SSelectedProductView(
                        isRefresh: false,
                        categoryId: widget.categoryId,
                      ))),
              (Route<dynamic> route) => false,
            );
          },
          title: "Edit Product",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () {
            read.uploadAdminProduct(context);
          },
        ),
      ),
      body:watch.isLoading?Center(
        child: CircularProgressIndicator(),
      ): SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                  Container(
                    height: 48.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffEFEFEF)),
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              watch.categoryName ?? "",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Black1,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Color(0xffB3B3B3),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.w,
                  ),
                  PrimarySTextFormField(
                    readOnly: true,
                    controller: watch.productNameController,
                    // titleHeader: "Shop Name",
                    hintText: "Product Name",
                  ),
                  SizedBox(
                    height: 15.w,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffEFEFEF)),
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Text(
                                    watch.brandName ?? "",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Black1,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Color(0xffB3B3B3),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                        child: Container(
                          height: 48.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffEFEFEF)),
                            borderRadius: BorderRadius.circular(6.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Text(
                                    watch.taxName ?? "",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Black1,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Color(0xffB3B3B3),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                              read.onUnderRecommendedProductSelected(value);
                            },
                            value: watch.showUnderRecommendedProducts,
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
                              read.onUnderSeasonalProductSelected(value);
                            },
                            value: watch.showUnderSeasonalProducts,
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
                              read.onFullFillCraving(value);
                            },
                            value: watch.fullFillCravings,
                          ),
                          Text(
                            'Fulfill Your Cravings',
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
                      readOnly: true,
                      controller: watch.productDescriptionController,
                      height: 150.w,
                      maxLines: 8,
                      hintText: "Product Details",
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Product Feature Image",
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
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 100.h,
                          width: 110.w,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.05),
                              blurRadius: 10.0,
                            ),
                          ]),
                          child: Card(
                              elevation: 0.3,
                              child: watch.productFeatureImage != ""
                                  ? Center(
                                      child: AppNetworkImages(
                                        imageUrl: watch.productFeatureImage,
                                        fit: BoxFit.cover,
                                        height: 90.w,
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    )),
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
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(watch.cards.length);
                              print(watch.valueController.length);
                              read.onAddWidget(CreateWidget(watch.cards.length),
                                  watch.cards.length);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 2.w),
                              // margin: EdgeInsets.only(right: 15.w),
                              // height: 24.h,
                              // width: 55.w,
                              decoration: BoxDecoration(
                                color: SplashText,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
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
                          ),

                          // GestureDetector(
                          //   onTap: () {
                          //     read.onRemoveWidget(watch.cards.length-1);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: 6.w, vertical: 2.w),
                          //     // margin: EdgeInsets.only(right: 15.w),
                          //     // height: 24.h,
                          //     // width: 55.w,
                          //     decoration: BoxDecoration(
                          //       color: Colors.red,
                          //       borderRadius: BorderRadius.all(Radius.circular(5)),
                          //     ),
                          //     child: Row(
                          //       // mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           "Delete",
                          //           style: TextStyle(
                          //               color: Colors.white,
                          //               // letterSpacing: .5,
                          //               fontSize: 12.sp,
                          //               fontWeight: FontWeight.w400),
                          //         ),
                          //         SizedBox(
                          //           width: 7.w,
                          //         ),
                          //        Icon(Icons.clear,color: Colors.white,size: 14.w,)
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: watch.productUnitDetail?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext, index) {
                        final element = watch.productUnitDetail?[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: PrimarySTextFormField(
                                    textInputType: TextInputType.number,
                                    onChanged: (value) {},
                                    controller: watch.valueController[index],
                                    height: 35,
                                    // width: 20, // titleHeader: "Shop Name",
                                    hintText: "value",
                                    hintFontSize: 12.sp,
                                    readOnly: true,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Container(
                                    height: 33.w,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffEFEFEF)),
                                      borderRadius: BorderRadius.circular(6.w),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              element?.unit ?? "",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Black1,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .keyboard_arrow_down_outlined,
                                              color: Color(0xffB3B3B3),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: PrimarySTextFormField(
                                    textInputType: TextInputType.number,
                                    controller: watch.mrpController[index],
                                    height: 35,
                                    // width: 20, // titleHeader: "Shop Name",
                                    hintText: "MRP",
                                    hintFontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: PrimarySTextFormField(
                                    textInputType: TextInputType.number,
                                    controller: watch.offerController[index],
                                    height: 35,
                                    // width: 20, // titleHeader: "Shop Name",
                                    hintText: "Offer Price",
                                    hintFontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Container(
                                  width: 30.w,
                                  child: CupertinoSwitch(
                                    value: watch.switchValue[index],
                                    activeColor: DarkGreen,
                                    onChanged: (value) {
                                      read.onToggleSwitch(value, index);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7.w,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
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
                                        child:
                                            element?.unitBasedProductImage1Path !=
                                                    ""
                                                ? Center(
                                                    child: AppNetworkImages(
                                                      imageUrl: element
                                                              ?.unitBasedProductImage1Path ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                      height: 90.w,
                                                    ),
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                            color: Color(
                                                                0xffB3B3B3),
                                                            // letterSpacing: .5,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // read.openGallery2(index);
                                    },
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
                                        child:
                                            element?.unitBasedProductImage2Path !=
                                                    ""
                                                ? Center(
                                                    child: AppNetworkImages(
                                                      imageUrl: element
                                                              ?.unitBasedProductImage2Path ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                      height: 90.w,
                                                    ),
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                            color: Color(
                                                                0xffB3B3B3),
                                                            // letterSpacing: .5,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // read.openGallery3(index);
                                    },
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
                                        child:
                                            element?.unitBasedProductImage3Path !=
                                                    ""
                                                ? Center(
                                                    child: AppNetworkImages(
                                                      imageUrl: element
                                                              ?.unitBasedProductImage3Path ??
                                                          "",
                                                      fit: BoxFit.cover,
                                                      height: 90.w,
                                                    ),
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                            color: Color(
                                                                0xffB3B3B3),
                                                            // letterSpacing: .5,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                          ],
                        );
                      }),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: watch.cards.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext, index) {
                        return Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                CreateWidget(index),
                                Container(
                                  width: 30.w,
                                  child: CupertinoSwitch(
                                    value: watch.switchCardValue[index],
                                    activeColor: DarkGreen,
                                    onChanged: (value) {
                                      read.onToggleCardSwitch(value, index);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      read.openGallery1(index);
                                    },
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
                                        child: watch.imagefiles1[index].path !=
                                                ""
                                            ? Image.file(
                                                File(watch
                                                    .imagefiles1[index].path),
                                                fit: BoxFit.cover,
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                        color:
                                                            Color(0xffB3B3B3),
                                                        // letterSpacing: .5,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      read.openGallery2(index);
                                    },
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
                                        child: watch.imagefiles2[index].path !=
                                                ""
                                            ? Image.file(
                                                File(watch
                                                    .imagefiles2[index].path),
                                                fit: BoxFit.cover)
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                        color:
                                                            Color(0xffB3B3B3),
                                                        // letterSpacing: .5,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      read.openGallery3(index);
                                    },
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
                                        child: watch.imagefiles3[index].path !=
                                                ""
                                            ? Image.file(
                                                File(watch
                                                    .imagefiles3[index].path),
                                                fit: BoxFit.cover)
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                        color:
                                                            Color(0xffB3B3B3),
                                                        // letterSpacing: .5,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 22.w,
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            )
          ],
        ),
      ),
    );
  }

  Widget CreateWidget(index) {
    // final read=context.read<CustomProductController>();
    final watch =
        Provider.of<EditAdminProductController>(context, listen: false);
    final read =
        Provider.of<EditAdminProductController>(context, listen: false);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: PrimarySTextFormField(
                textInputType: TextInputType.number,
                onChanged: (value) {},
                controller: watch.valueCardController[index],
                height: 35,
                // width: 20, // titleHeader: "Shop Name",
                hintText: "value",
                hintFontSize: 12.sp,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
                child: SDropDownField(
              iconPadding: EdgeInsets.only(right: 5.w),
              onChanged: (value) {
                read.onUnitDataSelect(value, index);
              },
              items: watch.unitData
                  ?.map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(
                          item.unit ?? "",
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      ))
                  .toList(),
              height: 30.w,
              hint: "Unit",
              hintSize: 11.sp,
            )),
            SizedBox(width: 3.w),
            Expanded(
              child: PrimarySTextFormField(
                textInputType: TextInputType.number,
                controller: watch.mrpCardController[index],
                height: 35,
                // width: 20, // titleHeader: "Shop Name",
                hintText: "MRP",
                hintFontSize: 12.sp,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: PrimarySTextFormField(
                textInputType: TextInputType.number,
                controller: watch.offerCardController[index],
                height: 35,
                // width: 20, // titleHeader: "Shop Name",
                hintText: "Offer Price",
                hintFontSize: 12.sp,
              ),
            ),
            SizedBox(width: 45.w),
          ],
        ),
        SizedBox(
          height: 9.h,
        ),
      ],
    );
  }
}
