import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/view/offer_seasonal_recommanded.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/controller/s_dashboard_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_edit_admin_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class SEditAdminProductView extends StatefulWidget {
  final String? categoryId;
  final String? productId;
  final bool? isFromAccountScreen;
  final int? selectedIndex;

  const SEditAdminProductView({
    super.key,
    required this.productId,
    required this.categoryId,
    required this.isFromAccountScreen,
    this.selectedIndex,
  });

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
    final watchDashBoardScreen = context.read<SDashBoardController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            widget.isFromAccountScreen == false
                ? readMain.onNavigation(
                    0,
                    SSelectedProductView(
                      isRefresh: false,
                      categoryId: widget.categoryId,
                    ),
                    context)
                : readMain.onNavigation(
                    0,
                    ShopSeasonalRecommandedOfferProductsView(
                      selectedProduct: widget.selectedIndex == 0
                          ? "recommended"
                          : widget.selectedIndex == 1
                              ? "seasonal"
                              : "fullFill",
                      isRefresh: false,
                    ),
                    context);
          },
          title: "Edit Product",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () {
            read.uploadAdminProduct(
                context, widget.isFromAccountScreen, widget.selectedIndex);
          },
        ),
      ),
      body: watch.isLoading
          ? const Loader()
          : WillPopScope(
              onWillPop: () async {
                widget.isFromAccountScreen == false
                    ? readMain.onNavigation(
                        0,
                        SSelectedProductView(
                          isRefresh: false,
                          categoryId: widget.categoryId,
                        ),
                        context)
                    : readMain.onNavigation(
                        0,
                        ShopSeasonalRecommandedOfferProductsView(
                          selectedProduct: widget.selectedIndex == 0
                              ? "recommended"
                              : widget.selectedIndex == 1
                                  ? "seasonal"
                                  : "fullFill",
                          isRefresh: false,
                        ),
                        context);
                return false;
              },
              child: SingleChildScrollView(
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
                                      if (watchDashBoardScreen
                                          .specialBenifitlist
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
                                      if (watchDashBoardScreen
                                          .specialBenifitlist
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
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 185.w,
                              width: ScreenUtil().screenWidth,
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
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        )),
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
