import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/view/s_add_coupons_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/new/s_add_edit_unit_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_edit_custom_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/unit_detail_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class AddUnitView extends StatefulWidget {
  final String? categoryId;
  final String? productId;
  final String? productType;
  final String? productName;
  final String? productUnitId;
  final bool? isEdit;
  final String? routeName;
  const AddUnitView(
      {super.key,
      required this.categoryId,
      required this.productType,
      required this.productId,
      required this.productName,
      required this.productUnitId,
      required this.isEdit,
      required this.routeName});

  @override
  State<AddUnitView> createState() => _AddUnitViewState();
}

class _AddUnitViewState extends State<AddUnitView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<AddEditUnitController>().initState(
          context,
          widget.productId,
          widget.productUnitId,
          widget.categoryId,
          widget.productType,
          widget.isEdit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<AddEditUnitController>();
    final read = context.read<AddEditUnitController>();
    final readMain = context.read<SMainScreenController>();
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
            onBackBtnPressed: () {
              if (widget.routeName == "selectedProductView") {
                // readMain.onNavigation(0, UnitDetailView(
                //   refresh: false, //
                //   categoryId: widget.categoryId,
                //   productType: widget.productType,
                //   productId: widget.productId,
                // ), context);
                readMain.onNavigation(
                    0,
                    SSelectedProductView(
                      // refresh: false, //
                      categoryId: widget.categoryId,
                      productType: widget.productType,
                      productId: widget.productId, isRefresh: false,
                    ),
                    context);
              } else {
                readMain.onNavigation(
                    0,
                    UnitDetailView(
                      refresh: false, //
                      categoryId: widget.categoryId,
                      productType: widget.productType,
                      productId: widget.productId,
                    ),
                    context);
              }
            },
            title: "Add Unit",
            action: SvgPicture.asset("assets/icons/forward.svg"),
            onActionTap: () {
              if (widget.isEdit == true) {
                if (watch.fileImage1.path == "" &&
                    watch.fileImage2.path == "" &&
                    watch.fileImage3.path == "") {
                  read.updateEditUnitDetails(context);
                } else {
                  read.addUnit(context, "update");
                }
              } else {
                read.addUnit(context, "add");
              }
            }),
      ),
      body: watch.isLoading
          ? const Loader()
          : WillPopScope(
              onWillPop: () async {
                readMain.onNavigation(
                    0,
                    UnitDetailView(
                      refresh: false, //
                      categoryId: widget.categoryId,
                      productType: widget.productType,
                      productId: widget.productId,
                    ),
                    context);
                return false;
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 28.w,
                    top: 20.w,
                    bottom: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              widget.productName ?? "",
                              // "${watch.categoryName} -  ${watch.allProductsCount}",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Container(
                            width: 26.w,
                            child: CupertinoSwitch(
                              value: watch.switchValue,
                              activeColor: DarkGreen,
                              onChanged: (value) {
                                read.onToggleSwitch(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 38.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: PrimarySTextFormField(
                              textInputType: TextInputType.number,
                              controller: watch.valueController,
                              titleHeader: "Value",
                              // controller: watch.emailIdController,
                              hintText: "Value",
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                              child: watch.unitId == ""
                                  ? SDropDownField(
                                      items: watch.unitList
                                          ?.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.id.toString(),
                                                child: Text(
                                                  item.unit ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      titleHeader: "Unit",
                                      onChanged: (value) async {
                                        read.onUnitSelect(value);
                                      },
                                      hint: "Select Unit",
                                    )
                                  : SDropDownField(
                                      value: watch.unitId,
                                      items: watch.unitList
                                          ?.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item.id.toString(),
                                                child: Text(
                                                  item.unit ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      titleHeader: "Unit",
                                      onChanged: (value) async {
                                        read.onUnitSelect(value);
                                      },
                                      hint: "Select Unit",
                                    )),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: PrimarySTextFormField(
                              textInputType: TextInputType.number,
                              controller: watch.mrpController,
                              titleHeader: "MRP",
                              // controller: watch.emailIdController,
                              hintText: "MRP",
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                            child: PrimarySTextFormField(
                              textInputType: TextInputType.number,
                              controller: watch.offerPriceController,
                              titleHeader: "Offer Price",
                              // controller: watch.emailIdController,
                              hintText: "Offer Price",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      Text(
                        "Unit Images",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black1,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 11.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            read.openCamera1(context);
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
                                  child: watch.fileImage1.path == "" &&
                                          watch.networkImage1 == ""
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
                                            ),
                                          ],
                                        )
                                      : watch.networkImage1 != ""
                                          ? Center(
                                              child: AppNetworkImages(
                                                imageUrl: watch.networkImage1,
                                                fit: BoxFit.cover,
                                                height: 90.w,
                                              ),
                                            )
                                          : Image.file(watch.fileImage1),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            read.openCamera2(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Camera"),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            read.openGallery2(context);
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
                                  child: watch.fileImage2.path == "" &&
                                          watch.networkImage2 == ""
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
                                            ),
                                          ],
                                        )
                                      : watch.networkImage2 != ""
                                          ? Center(
                                              child: AppNetworkImages(
                                                imageUrl: watch.networkImage2,
                                                fit: BoxFit.cover,
                                                height: 90.w,
                                              ),
                                            )
                                          : Image.file(watch.fileImage2),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            read.openCamera3(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text("Camera"),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            read.openGallery3(context);
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
                                  child: watch.fileImage3.path == "" &&
                                          watch.networkImage3 == ""
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
                                            ),
                                          ],
                                        )
                                      : watch.networkImage3 != ""
                                          ? Center(
                                              child: AppNetworkImages(
                                                imageUrl: watch.networkImage3,
                                                fit: BoxFit.cover,
                                                height: 90.w,
                                              ),
                                            )
                                          : Image.file(watch.fileImage3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
