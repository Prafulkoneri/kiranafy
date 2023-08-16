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
import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/view/offer_seasonal_recommanded.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/controller/s_category_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/controller/s_dashboard_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_custom_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_add_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_edit_admin_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_edit_custom_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/controller/s_shop_configuration_controller.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class SEditCustomProductView extends StatefulWidget {
  final String? categoryId;
  final String? productId;
  final bool? isFromAccountScreen;
  final int? selectedIndex;
  const SEditCustomProductView(
      {super.key,
      required this.productId,
      required this.categoryId,
      required this.isFromAccountScreen,
      this.selectedIndex});

  @override
  State<SEditCustomProductView> createState() => _SEditCustomProductViewState();
}

class _SEditCustomProductViewState extends State<SEditCustomProductView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<EditCustomProductController>().initState(
          context, CreateWidget(0), 0, widget.productId, widget.categoryId);
      context.read<SCategoryListController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<EditCustomProductController>();
    final read = context.read<EditCustomProductController>();
    final watchDashBoardScreen = context.read<SDashBoardController>();
    final selectedCategoryListWatch = context.read<SCategoryListController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            widget.isFromAccountScreen == false
                ? Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SMainScreenView(
                            index: 0,
                            screenName: SSelectedProductView(
                              isRefresh: false,
                              categoryId: widget.categoryId,
                            ))),
                    (Route<dynamic> route) => false,
                  )
                : Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SMainScreenView(
                            index: 4,
                            screenName:
                                ShopSeasonalRecommandedOfferProductsView(
                              selectedProduct: widget.selectedIndex == 0
                                  ? "recommended"
                                  : widget.selectedIndex == 1
                                      ? "seasonal"
                                      : "fullFill",
                              isRefresh: false,
                            ))),
                    (Route<dynamic> route) => false,
                  );
          },
          title: "Edit Product",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () {
            read.validateCustomProuduct(
                context, widget.isFromAccountScreen, widget.selectedIndex);
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
                          value: watch.categoryId,
                          onChanged: (value) {
                            read.onCategorySelected(value);
                          },
                          items: selectedCategoryListWatch.selectedCategoriesList!
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
                                value: watch.brandId,
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
                                value: watch.taxId,
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
                                        read.openGallery(context);
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
                              child: watch.productImage.path == "" &&
                                      watch.productFeatureImage == ""
                                  ? Column(
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
                                    )
                                  : watch.productImage.path == ""
                                      ? AppNetworkImages(
                                          imageUrl: watch.productFeatureImage,
                                          fit: BoxFit.cover,
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
                    height: 100.h,
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
