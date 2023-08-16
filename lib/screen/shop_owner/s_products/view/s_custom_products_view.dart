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
import 'package:local_supper_market/screen/shop_owner/s_category_list/controller/s_category_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/controller/s_dashboard_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_custom_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_add_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/controller/s_shop_configuration_controller.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class SCustomProductView extends StatefulWidget {
  final String? categoryId;

  const SCustomProductView({super.key, required this.categoryId});

  @override
  State<SCustomProductView> createState() => _SCustomProductViewState();
}

class _SCustomProductViewState extends State<SCustomProductView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CustomProductController>().initState(context);
      context.read<SCategoryListController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CustomProductController>();
    final read = context.read<CustomProductController>();
    final readMain = context.read<SMainScreenController>();
    final selectedCategoryListWatch = context.read<SCategoryListController>();
    final watchDashBoardScreen = context.read<SDashBoardController>();
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
          title: "Custom Products",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () {
            read.validateCustomProuduct(context);
          },
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                        SDropDownField(
                          onChanged: (value) {
                            read.onCategorySelected(value);
                          },
                          items:
                              selectedCategoryListWatch.selectedCategoriesList!
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.categoryId.toString(),
                                        child: Text(
                                          item.categoryName ?? "",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                          hint: "Select Category ",
                        ),
                        SizedBox(
                          height: 15.w,
                        ),
                        PrimarySTextFormField(
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
                              child: SDropDownField(
                                onChanged: (value) {
                                  read.onBrandSelected(value);
                                },
                                items: watch.brandData
                                    ?.map((item) => DropdownMenuItem<String>(
                                          value: item.id.toString(),
                                          child: Text(
                                            item.brandName ?? "",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                hint: "Brand",
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Expanded(
                              child: SDropDownField(
                                onChanged: (value) {
                                  read.onTax(value);
                                },
                                items: watch.taxData
                                    ?.map((item) => DropdownMenuItem<String>(
                                          value: item.id.toString(),
                                          child: Text(
                                            item.igstTax ?? "",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                hint: "Tax",
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
                                    read.onUnderRecommendedProductSelected(
                                        value);
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
                                    // read.onUnderSeasonalProductSelected(value);
                                    if (watchDashBoardScreen.specialBenifitlist
                                        .contains("seasonal_products")) {
                                      read.onUnderSeasonalProductSelected(
                                          value);
                                    } else {
                                      Utils.showPrimarySnackbar(context,
                                          "Subscribe to Advanced Plan to use this feature!",
                                          type: SnackType.error);
                                      return;
                                    }
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
                                    // read.onFullFillCraving(value);
                                    if (watchDashBoardScreen.specialBenifitlist
                                        .contains(
                                            "fullfill_craving_products")) {
                                      read.onFullFillCraving(value);
                                    } else {
                                      Utils.showPrimarySnackbar(context,
                                          "Subscribe to Advanced Plan to use this feature!",
                                          type: SnackType.error);
                                      return;
                                    }
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
                        GestureDetector(
                          // onTap: () {
                          //   read.openProductImage();
                          // },
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        read.openCameras(context);
                                      },
                                      child: Text("Camera"),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        read.openGallery1(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Gallery "),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 185.h,
                            width: ScreenUtil().screenWidth,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.05),
                                blurRadius: 10.0,
                              ),
                            ]),
                            child: Card(
                              elevation: 0.3,
                              child: watch.productImage.path == ""
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/picked_product_image.svg",
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
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    )
                                  : Image.file(
                                      watch.productImage,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
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
