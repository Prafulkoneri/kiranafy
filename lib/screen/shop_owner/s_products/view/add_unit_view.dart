import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/view/s_add_coupons_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_edit_custom_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/unit_detail_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/textfield.dart';

class AddUnitView extends StatefulWidget {
  final String? categoryId;
  const AddUnitView({super.key, required this.categoryId});

  @override
  State<AddUnitView> createState() => _AddUnitViewState();
}

class _AddUnitViewState extends State<AddUnitView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
            onBackBtnPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => SMainScreenView(
                        index: 0,
                        screenName: UnitDetailView(
                            // isRefresh: false, //
                            categoryId: widget.categoryId))),
                (Route<dynamic> route) => false,
              );
            },
            title: "Add Unit",
            action: SvgPicture.asset("assets/icons/forward.svg"),
            onActionTap: () {}),
      ),
      body: SingleChildScrollView(
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
                children: [
                  Text(
                    "Product Name",
                    // "${watch.categoryName} -  ${watch.allProductsCount}",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 26.w,
                    child: CupertinoSwitch(
                      value: true,
                      activeColor: DarkGreen,
                      onChanged: (value) {
                        // read.onToggleSwitch(value, index);
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
                      titleHeader: "Value",
                      // controller: watch.emailIdController,
                      hintText: "200",
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: SDropDownField(
                    titleHeader: "Unit",
                    onChanged: (value) async {
                      // await read.onStateSelected(value);
                      // await read.getCityList(context);
                    },
                    hint: "Gms",
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
                      titleHeader: "MRP",
                      // controller: watch.emailIdController,
                      hintText: "200",
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: PrimarySTextFormField(
                      titleHeader: "Offer Price",
                      // controller: watch.emailIdController,
                      hintText: "175",
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
                              // element?.unitBasedProductImage1Path !=
                              //         ""
                              //     ? Center(
                              //         child: AppNetworkImages(
                              //           imageUrl: element
                              //                   ?.unitBasedProductImage1Path ??
                              //               "",
                              //           fit: BoxFit.cover,
                              //           height: 90.w,
                              //         ),
                              //       )
                              //     :
                              Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              // element?.unitBasedProductImage2Path !=
                              //         ""
                              //     ?
                              //     Center(
                              //         child: AppNetworkImages(
                              //           imageUrl: element
                              //                   ?.unitBasedProductImage2Path ??
                              //               "",
                              //           fit: BoxFit.cover,
                              //           height: 90.w,
                              //         ),
                              //       )
                              //     :
                              Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              // element?.unitBasedProductImage3Path !=
                              //         ""
                              //     ?
                              //      Center(
                              //         child: AppNetworkImages(
                              //           imageUrl: element
                              //                   ?.unitBasedProductImage3Path ??
                              //               "",
                              //           fit: BoxFit.cover,
                              //           height: 90.w,
                              //         ),
                              //       )
                              //     :
                              Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                          ),
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
    );
  }
}
