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
import 'package:local_supper_market/screen/shop_owner/s_products/controller/new/get_product_unit_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/add_unit_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_edit_custom_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class UnitDetailView extends StatefulWidget {
  final String? categoryId;
  final String? productId;
  final String? productType;

  const UnitDetailView(
      {super.key, required this.categoryId, this.productId, this.productType});

  @override
  State<UnitDetailView> createState() => _UnitDetailViewState();
}

class _UnitDetailViewState extends State<UnitDetailView> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SGetProductUnitListController>()
          .initState(context, widget.productId, widget.productType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SGetProductUnitListController>();
    final watch = context.watch<SGetProductUnitListController>();
    final readMainScreen = context.watch<SMainScreenController>();
    return Scaffold(
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
                              isRefresh: false, //
                              categoryId: widget.categoryId))),
                  (Route<dynamic> route) => false,
                );
              },
              title: "Unit Details",
              action: SvgPicture.asset("assets/icons/addressadd.svg"),
              onActionTap: () {}),
        ),
        body: watch.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              // "${watch.getproductunitlistdata.unitDetails.}"
                              "Product Name",
                              // "${watch.categoryName} -  ${watch.allProductsCount}",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          padding: EdgeInsets.only(
                            left: 19.w,
                            right: 19.w,
                          ),
                          itemCount: 8,
                          //  watch.productDetails?.length ?? 0,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext, index) {
                            // final element = watch.productDetails?[index];
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 4.96.w,
                                      top: 4,
                                      bottom: 9,
                                      right: 13.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Colors.black.withOpacity(0.03.w),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // AppNetworkImages(
                                      //   imageUrl: "${element?.productImagePath}",
                                      //   width: 60.w,
                                      //   height: 61.h,
                                      //   fit: BoxFit.fill,
                                      // ),
                                      // element?.productImagePath != ""
                                      //     ? AppNetworkImages(
                                      //         imageUrl:
                                      //             "${element?.productImagePath}",
                                      //         height: 60.h,
                                      //         width: 60.w,
                                      //         fit: BoxFit.cover,
                                      //       )
                                      //     :
                                      Image(
                                        image: AssetImage(
                                          "assets/images/profile_image.png",
                                        ),
                                        height: 60.h,
                                        width: 60.w,
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
                                              height: 11.h,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "200 ml",
                                                      // "${element?.productName}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 15.43.sp,
                                                          color: Black1),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "Active",
                                                      // "${element?.productName}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 11.43.sp,
                                                          color: Color(
                                                              0xff39C19D)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.w,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Rs. 60",

                                                      // "${element?.unitWithWeight}",//
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp,
                                                          color: Grey),
                                                    ),
                                                    SizedBox(
                                                      width: 33.w,
                                                    ),
                                                    Text(
                                                      "Rs. 24",
                                                      // "${element?.unitWithWeight}",//
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14.sp,
                                                          color: Grey),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator
                                                            .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SMainScreenView(
                                                                      index: 0,
                                                                      screenName:
                                                                          AddUnitView(
                                                                        categoryId:
                                                                            widget.categoryId,
                                                                        // productId: "",
                                                                        // categoryId: widget
                                                                        //     .categoryId,
                                                                      ))),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false,
                                                        );
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: grey6,
                                                                offset:
                                                                    const Offset(
                                                                  5.0,
                                                                  5.0,
                                                                ),
                                                                blurRadius:
                                                                    10.0,
                                                                spreadRadius:
                                                                    2.0,
                                                              ), //BoxShadow
                                                            ],
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: SvgPicture.asset(
                                                            'assets/icons/e1.svg'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // read.deleteAdminProduct(
                                                        //     context,
                                                        //     index,
                                                        //     element?.id);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: grey6,
                                                                offset:
                                                                    const Offset(
                                                                  5.0,
                                                                  5.0,
                                                                ),
                                                                blurRadius:
                                                                    10.0,
                                                                spreadRadius:
                                                                    2.0,
                                                              ), //BoxShadow
                                                            ],
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: SvgPicture.asset(
                                                            'assets/icons/delete2.svg'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
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
                        height: 100.w,
                      ),
                    ]),
              ));
  }
}
