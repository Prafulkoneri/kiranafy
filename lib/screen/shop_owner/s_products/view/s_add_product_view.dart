import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_add_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class AddProductView extends StatefulWidget {
  final String? categoryId;

  const AddProductView({super.key, required this.categoryId});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

bool _checkbox = false;

class _AddProductViewState extends State<AddProductView> {
  void initState() {
    print("widget.categoryId ${widget.categoryId}");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SAddProductsController>()
          .initState(context, widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SAddProductsController>();
    final watch = context.watch<SAddProductsController>();
    final readMainScreen = context.watch<SMainScreenController>();
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
                              categoryId: widget.categoryId),
                        )),
                (Route<dynamic> route) => false,
              );
            },
            title: "Add Products",
            action: SvgPicture.asset("assets/icons/forward.svg"),
            onActionTap: () async {
              read.uploadAddProducts(context);
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
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 28.w,
                        top: 20.w,
                        bottom: 20.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${watch.categoryName} -  ${watch.allProductsCount}",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black1,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),

                          ///check Box
                          PrimaryCheckBox(
                            // value: watch.selectedProduct[index],
                            onChanged: (value) {
                              read.onSelecteAllProducts();
                            },
                            value: watch.isSelectAll,
                          ),
                        ],
                      ),
                    ),

                    ///Products Starts

                    ListView.builder(
                        padding: EdgeInsets.only(
                          left: 19.w,
                          right: 19.w,
                        ),
                        itemCount: watch.productDetails?.length ?? 0,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext, index) {
                          final element = watch.productDetails?[index];
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 21.w, top: 6, bottom: 7, right: 9.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.03.w),
                                        blurRadius: 5,
                                        spreadRadius: 0,
                                        offset: Offset(5, 6)),
                                  ],
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.07)),
                                  borderRadius: BorderRadius.circular(7.w),
                                ),
                                // padding: EdgeInsets.only(
                                //     top: 6.w, bottom: 7.w, right: 9.w, left: 21.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppNetworkImages(
                                      imageUrl: "${element?.productImagePath}",
                                      width: 60.w,
                                      height: 61.h,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "${element?.productName}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.sp,
                                                      color: Black1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Text(
                                            "${element?.unitWithWeight}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                color: Grey),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 10.w),
                                      child: PrimaryCheckBox(
                                        // value: watch.selectedProduct[index],
                                        onChanged: (value) {
                                          read.onProductsSelected(
                                              index, element?.id.toString());
                                        },
                                        value: watch.selectedProduct[index],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.w,
                              ),
                            ],
                          );
                        }),
                    SizedBox(
                      height: 85.w,
                    ),
                  ],
                ),
              ));
  }
}
