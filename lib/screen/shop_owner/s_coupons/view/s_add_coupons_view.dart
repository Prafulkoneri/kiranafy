import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/controller/s_add_coupons_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/view/s_coupons_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';
import '../../../../widget/radio_button.dart';

class SAddCouponsView extends StatefulWidget {
  final bool? isEditCoupon;
  final String? couponId;
  final bool? isNavFromDashboard;

  const SAddCouponsView(
      {super.key,
      required this.isEditCoupon,
      this.couponId,
      required this.isNavFromDashboard});

  @override
  State<SAddCouponsView> createState() => _SAddCouponsViewState();
}

class _SAddCouponsViewState extends State<SAddCouponsView> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SAddCouponsController>()
          .initState(context, widget.isEditCoupon, widget.couponId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SAddCouponsController>();
    final read = context.read<SAddCouponsController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: widget.isEditCoupon == false ? "Add Coupon" : "Edit Coupon",
          onBackBtnPressed: () {
            if (widget.isNavFromDashboard == true) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => SMainScreenView(
                        index: 3,
                        screenName: ShopCouponsView(
                          isRefresh: false,
                          isNavFromDashBoard: true,
                        ))),
                (Route<dynamic> route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => SMainScreenView(
                        index: 4,
                        screenName: ShopCouponsView(
                          isRefresh: false,
                          isNavFromDashBoard: false,
                        ))),
                (Route<dynamic> route) => false,
              );
            }
          },
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 26.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "From Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Color(0xff3A3A3A)),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                          child: Text(
                            "To Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Color(0xff3A3A3A)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: PrimarySTextFormField(
                            readOnly: true,
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
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                String date = DateFormat('dd-MM-yyy')
                                    .format(pickedDate ?? DateTime.now());
                                read.onFromDateSelected(date);
                              }
                            },
                            controller: watch.fromDateController,
                            suffix: Container(
                              width: 15.h,
                              height: 17.w,
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/icons/shop_cal.svg",
                                ),
                              ),
                            ),
                            hintFontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                          child: PrimarySTextFormField(
                            readOnly: true,
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
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                String date = DateFormat('dd-MM-yyy')
                                    .format(pickedDate ?? DateTime.now());
                                read.onToDateSelected(date);
                              }
                            },
                            controller: watch.toDateController,
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
                                          onSurface:
                                              Colors.black, // <-- SEE HERE
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
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  String date = DateFormat('dd-MM-yyy')
                                      .format(pickedDate ?? DateTime.now());
                                  read.onToDateSelected(date);
                                }
                              },
                              child: Container(
                                width: 15.h,
                                height: 17.w,
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/icons/shop_cal.svg",
                                  ),
                                ),
                              ),
                            ),
                            hintFontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Discount Percentage (%)",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Color(0xff3A3A3A)),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                          child: Text(
                            "Minimum Order Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Color(0xff3A3A3A)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: PrimarySTextFormField(
                            textInputType: TextInputType.number,
                            controller: watch.discountPercentageController,
                            // hintText: "Delivery Charge",
                            hintFontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                          child: PrimarySTextFormField(
                            textInputType: TextInputType.number,
                            controller: watch.minOrderAmountController,
                            // hintText: "Delivery Charge",
                            hintFontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Discount Max Amount",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Color(0xff3A3A3A)),
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                          child: Text(
                            "Coupon Code",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Color(0xff3A3A3A)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: PrimarySTextFormField(
                            textInputType: TextInputType.number,
                            controller: watch.maxDiscountAmountController,
                            hintFontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Expanded(
                          child: PrimarySTextFormField(
                            // textInputType: TextInputType.number,
                            controller: watch.couponCodeController,
                            onChanged: (value) {
                              read.checkCouponCodeExist(context);
                            },
                            hintFontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 28.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              SecondaryRadioButton(
                                  value: "full_order_amount",
                                  groupValue: read.groupValue,
                                  onChanged: (value) {
                                    read.onRadioBtnToggled(value);
                                  },
                                  leading: ""),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Full Order Amount',
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SecondaryRadioButton(
                                  value: "category_and_product",
                                  groupValue: watch.groupValue,
                                  onChanged: (value) {
                                    read.onRadioBtnToggled(value);
                                  },
                                  leading: ""),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Category & Product',
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: watch.groupValue == "full_order_amount"
                          ? false
                          : true,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          widget.isEditCoupon == true &&
                                  watch.details?.shopOwnerCategoryId != ""
                              ? SDropDownField(
                                  value: watch.categoryId,
                                  // hintText: "Delivery Charge",
                                  hintSize: 15.sp,
                                  onChanged: (value) {
                                    read.onCategorySelect(value, context);
                                  },
                                  items: watch.categoriesList
                                      ?.map((item) => DropdownMenuItem<String>(
                                            value: item.id.toString(),
                                            child: Text(
                                              item.categoryName ?? "",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  titleHeader: "Select Category",
                                  titleSize: 12.sp,
                                )
                              : SDropDownField(
                                  // hintText: "Delivery Charge",
                                  hintSize: 15.sp,
                                  onChanged: (value) {
                                    read.onCategorySelect(value, context);
                                  },
                                  items: watch.categoriesList
                                      ?.map((item) => DropdownMenuItem<String>(
                                            value: item.id.toString(),
                                            child: Text(
                                              item.categoryName ?? "",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  titleHeader: "Select Category",
                                  titleSize: 12.sp,
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                          widget.isEditCoupon == true &&
                                  watch.details?.shopOwnerProductId != ""
                              ? SDropDownField(
                                  value: watch.productId,
                                  // hintText: "Delivery Charge",
                                  hintSize: 15.sp,
                                  onChanged: (value) {
                                    read.onProductSelect(value, context);
                                  },
                                  items: watch.productList
                                      ?.map((item) => DropdownMenuItem<String>(
                                            value: item.id.toString(),
                                            child: Text(
                                              item.productName ?? "",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  titleHeader: "Select Product",
                                  titleSize: 12.sp,
                                )
                              : SDropDownField(
                                  // hintText: "Delivery Charge",
                                  hintSize: 15.sp,
                                  onChanged: (value) {
                                    read.onProductSelect(value, context);
                                  },
                                  items: watch.productList
                                      ?.map((item) => DropdownMenuItem<String>(
                                            value: item.id.toString(),
                                            child: Text(
                                              item.productName ?? "",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  titleHeader: "Select Product",
                                  titleSize: 12.sp,
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Terms and Conditions",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: Color(0xff3A3A3A)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    PrimarySTextFormField(
                      controller: watch.termsAndConditionController,
                      height: 150.w,
                      maxLines: 10,
                      // hintText: "Address",/
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    PrimaryButton(
                      fontSize: 20.sp,
                      height: 50.w,
                      text: "Submit",
                      color: Color(0xff4689EC),
                      onTap: () {
                        widget.isEditCoupon == true
                            ? read.uploadEditedCouponDetails(
                                context, widget.isNavFromDashboard)
                            : read.uploadCouponDetails(
                                context, widget.isNavFromDashboard);
                      },
                    ),
                    SizedBox(
                      height: 90.h,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
