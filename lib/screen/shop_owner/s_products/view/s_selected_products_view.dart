import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_add_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_selected_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_add_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_edit_admin_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_custom_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_edit_custom_product_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/unit_detail_view.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

import '../../../../widget/app_bar.dart';

class SSelectedProductView extends StatefulWidget {
  final String? categoryId;
  final bool? isRefresh;

  const SSelectedProductView(
      {super.key, required this.categoryId, required this.isRefresh});

  @override
  State<SSelectedProductView> createState() => _SSelectedProductViewState();
}

final TextEditingController _searchController = TextEditingController();

class _SSelectedProductViewState extends State<SSelectedProductView> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    print("widget.categoryId ${widget.categoryId}");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SSelectedProductsController>()
          .initState(context, widget.categoryId, widget.isRefresh);
    });
    setPagination();
  }

  setPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context
              .read<SSelectedProductsController>()
              .onScrollMaxExtent(context, widget.categoryId);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SSelectedProductsController>();
    final readMain = context.read<SMainScreenController>();
    final watch = context.watch<SSelectedProductsController>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            onBackBtnPressed: () {
              readMain.onNavigation(0, SSCategoryListView(), context);
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => SMainScreenView(
              //             index: 0,
              //             screenName: SSCategoryListView(),
              //           )),
              //   (Route<dynamic> route) => false,
              // );
            },
            title: watch.categoryName != ""
                ? '${watch.categoryName ?? ""} - ${watch.totalSelectedAndCustomProducts ?? ""}'
                : "",
            // "Cold Drinks & Juices - 2",
            // action: SvgPicture.asset("assets/icons/forward.svg"),
            onActionTap: () {},
          ),
        ),
        body: watch.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                //  physics: AlwaysScrollableScrollPhysics(),
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 19.0.w,
                    left: 19.0.w,
                    top: 20.h,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            // padding: EdgeInsets.only(
                            //   right: 19.0.w,
                            //   left: 19.0.w,
                            //   top: 13.h,
                            // ),
                            child: SizedBox(
                              width: 352.w,
                              height: 30.h,
                              child: TextField(
                                onChanged: (value) {
                                  read.searchProductList(
                                      context, watch.categoryId);
                                },
                                controller: watch.searchController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  // filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide:
                                        BorderSide(width: 1, color: grey12),
                                  ),
                                  hintText: 'Search Products',
                                  contentPadding: EdgeInsets.only(bottom: 10.w),
                                  hintStyle: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Grey,
                                          // letterSpacing: .5,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400)),
                                  prefixIcon: IconButton(
                                    icon: SvgPicture.asset(
                                      'assets/icons/search.svg',
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                    onPressed: () {
                                      // Perform the search here
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 13.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                    height: 40.h,
                                    color: Custlogin,
                                    onTap: () {
                                      read.onAddProductPressed(
                                          context, widget.categoryId);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/pluse.svg'),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 11.w,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              " Add Product",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 17.w,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                child: PrimaryButton(
                                    height: 40.h,
                                    color: Custlogin,
                                    onTap: () {
                                      readMain.onNavigation(0,  SCustomProductView(
                                          categoryId: widget
                                              .categoryId), context);
                                      // Navigator.pushAndRemoveUntil(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           SMainScreenView(
                                      //             index: 0,
                                      //             screenName:
                                      //                 SCustomProductView(
                                      //                     categoryId: widget
                                      //                         .categoryId),
                                      //           )),
                                      //   (Route<dynamic> route) => false,
                                      // );
                                      // readMainScreen.onNavigation(0,ShopCustomProductView(categoryId: watch.categoryId), context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/pluse.svg'),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 11.w,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Custom Product",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          watch.productsFromAdmins.isNotEmpty == true ||
                                  watch.customProducts.isNotEmpty == true
                              ? Column(
                                  children: [
                                    Container(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount:
                                            watch.productsFromAdmins.length,
                                        //  watch.selectedProductList?.length ?? 0,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final element =
                                              watch.productsFromAdmins[index];
                                          return Column(
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.only(
                                                //     left: 21.w, bottom: 11.w, top: 13.w, right: 21.w),

                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.09),
                                                          blurRadius: 5,
                                                          offset:
                                                              Offset(-.0, 5.0),
                                                          spreadRadius: 0),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: grey1)),
                                                // decoration: BoxDecoration(

                                                //     border: Border.all(width: 1, color: Black1)),
                                                child: ListTileTheme(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  dense: true,
                                                  horizontalTitleGap: -8,
                                                  minLeadingWidth: 0,
                                                  // horizontalTitleGap: 5.0,
                                                  // minLeadingWidth: 6,
                                                  child: Stack(
                                                    children: [
                                                      ExpansionTile(
                                                        trailing:
                                                            SizedBox.shrink(),
                                                        title: Container(
                                                          width: ScreenUtil()
                                                              .screenWidth,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                    element.productImagePath !=
                                                                            ""
                                                                        ? AppNetworkImages(
                                                                            imageUrl:
                                                                                "${element.productImagePath}",
                                                                            height:
                                                                                61.h,
                                                                            width:
                                                                                60.w,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : Image(
                                                                            image:
                                                                                AssetImage(
                                                                              "assets/images/profile_image.png",
                                                                            ),
                                                                            height:
                                                                                61.h,
                                                                            width:
                                                                                60.w,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                    SizedBox(
                                                                      width:
                                                                          8.w,
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        "${element.productName}",
                                                                        // "${element?.productName}",
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Black1,
                                                                              fontSize: 16.sp,
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 7.w,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      readMain.onNavigation(0,  UnitDetailView(
                                                                        categoryId: widget.categoryId,
                                                                        productId: element.id.toString(),
                                                                        productType: element.productType,
                                                                        refresh: true,
                                                                      ), context);
                                                                      // Navigator
                                                                      //     .pushAndRemoveUntil(
                                                                      //   context,
                                                                      //   MaterialPageRoute(
                                                                      //       builder: (context) => SMainScreenView(
                                                                      //           index: 0,
                                                                      //           screenName: UnitDetailView(
                                                                      //             categoryId: widget.categoryId,
                                                                      //             productId: element.id.toString(),
                                                                      //             productType: element.productType,
                                                                      //             refresh: true,
                                                                      //           ))),
                                                                      //   (Route<dynamic>
                                                                      //           route) =>
                                                                      //       false,
                                                                      // );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.only(
                                                                          left: 17
                                                                              .w,
                                                                          right: 15
                                                                              .w,
                                                                          top: 4
                                                                              .w,
                                                                          bottom:
                                                                              5.w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xff39C19D),
                                                                        borderRadius:
                                                                            BorderRadius.circular(50),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        "${element.unitCount} Unit",
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        14.w,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                              readMain.onNavigation(0, SEditAdminProductView(
                                                                                productId: element.id.toString(),
                                                                                categoryId: widget.categoryId,
                                                                                isFromAccountScreen: false,
                                                                              ), context);
                                                                          // Navigator
                                                                          //     .pushAndRemoveUntil(
                                                                          //   context,
                                                                          //   MaterialPageRoute(
                                                                          //       builder: (context) => SMainScreenView(
                                                                          //           index: 0,
                                                                          //           screenName: SEditAdminProductView(
                                                                          //             productId: element.id.toString(),
                                                                          //             categoryId: widget.categoryId,
                                                                          //             isFromAccountScreen: false,
                                                                          //           ))),
                                                                          //   (Route<dynamic> route) =>
                                                                          //       false,
                                                                          // );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(8),
                                                                          decoration: BoxDecoration(
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: grey6,
                                                                                  offset: const Offset(
                                                                                    5.0,
                                                                                    5.0,
                                                                                  ),
                                                                                  blurRadius: 10.0,
                                                                                  spreadRadius: 2.0,
                                                                                ), //BoxShadow
                                                                              ],
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(15)),
                                                                          child:
                                                                              SvgPicture.asset('assets/icons/e1.svg'),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            8.w,
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          read.deleteAdminProduct(
                                                                              context,
                                                                              index,
                                                                              element.id);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(8),
                                                                          decoration: BoxDecoration(
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: grey6,
                                                                                  offset: const Offset(
                                                                                    5.0,
                                                                                    5.0,
                                                                                  ),
                                                                                  blurRadius: 10.0,
                                                                                  spreadRadius: 2.0,
                                                                                ), //BoxShadow
                                                                              ],
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(15)),
                                                                          child:
                                                                              SvgPicture.asset('assets/icons/delete2.svg'),
                                                                        ),
                                                                      )
                                                                      /////////////////
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        16.w,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 11.w,
                                                                    bottom:
                                                                        11.w,
                                                                    right:
                                                                        11.w),
                                                            child: Column(
                                                              children: [
                                                                Divider(),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            "Product Unit",
                                                                            style:
                                                                                GoogleFonts.dmSans(
                                                                              textStyle: TextStyle(color: Black1, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              "MRP",
                                                                              textAlign: TextAlign.end,
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(color: Black1, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                18.w,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              "Offer price",
                                                                              textAlign: TextAlign.end,
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(color: Black1, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                ListView
                                                                    .builder(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  itemCount: watch
                                                                          .productsFromAdmins[
                                                                              index]
                                                                          .unitDetails
                                                                          ?.length ??
                                                                      0,
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  itemBuilder:
                                                                      (context,
                                                                          int) {
                                                                    // final unitDetail = watch
                                                                    //     .productsFromAdmin?[index]
                                                                    //     .unitDetails?[int];
                                                                    final element = watch
                                                                        .productsFromAdmins[
                                                                            index]
                                                                        .unitDetails?[int];

                                                                    return Container(
                                                                      padding: EdgeInsets.only(
                                                                          left: 12
                                                                              .w,
                                                                          right: 20
                                                                              .w,
                                                                          top: 7
                                                                              .w,
                                                                          bottom:
                                                                              8.w),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          // color: Black1,
                                                                          border: Border.all(width: 1, color: grey6)),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text(
                                                                                  "${element?.weightAndUnit}",
                                                                                  style: GoogleFonts.dmSans(
                                                                                    textStyle: TextStyle(color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    "${element?.mrpPrice}",
                                                                                    textAlign: TextAlign.end,
                                                                                    style: GoogleFonts.dmSans(
                                                                                      textStyle: TextStyle(decoration: TextDecoration.lineThrough, color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                // SizedBox(
                                                                                //   width: 45.w,
                                                                                // ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    "\u{20B9}${element?.offerPrice}",
                                                                                    textAlign: TextAlign.end,
                                                                                    style: GoogleFonts.dmSans(
                                                                                      textStyle: TextStyle(color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                        tilePadding:
                                                            EdgeInsets.zero,
                                                        // child:
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 18.w,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: watch.customProducts.length,
                                        //  watch.selectedProductList?.length ?? 0,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final element =
                                              watch.customProducts[index];
                                          return Column(
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.only(
                                                //     left: 21.w, bottom: 11.w, top: 13.w, right: 21.w),

                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.09),
                                                          blurRadius: 5,
                                                          offset:
                                                              Offset(-.0, 5.0),
                                                          spreadRadius: 0),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: grey1)),
                                                // decoration: BoxDecoration(

                                                //     border: Border.all(width: 1, color: Black1)),
                                                child: ListTileTheme(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  dense: true,
                                                  horizontalTitleGap: -8,
                                                  minLeadingWidth: 0,
                                                  // horizontalTitleGap: 5.0,
                                                  // minLeadingWidth: 6,
                                                  child: Stack(
                                                    children: [
                                                      ExpansionTile(
                                                        trailing:
                                                            SizedBox.shrink(),
                                                        title: Container(
                                                          width: ScreenUtil()
                                                              .screenWidth,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                    element.productImagePath !=
                                                                            ""
                                                                        ? AppNetworkImages(
                                                                            imageUrl:
                                                                                "${element.productImagePath}",
                                                                            height:
                                                                                61.h,
                                                                            width:
                                                                                60.w,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : Image(
                                                                            image:
                                                                                AssetImage(
                                                                              "assets/images/profile_image.png",
                                                                            ),
                                                                            height:
                                                                                61.h,
                                                                            width:
                                                                                60.w,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          ),
                                                                    SizedBox(
                                                                      width:
                                                                          8.w,
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        "${element.productName}",
                                                                        // "${element?.productName}",
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Black1,
                                                                              fontSize: 16.sp,
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 7.w,
                                                                  ),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      readMain.onNavigation(0, UnitDetailView(
                                                                        categoryId: widget.categoryId,
                                                                        productId: element.id.toString(),
                                                                        productType: element.productType,
                                                                        refresh: true,
                                                                      ), context);
                                                                      // Navigator
                                                                      //     .pushAndRemoveUntil(
                                                                      //   context,
                                                                      //   MaterialPageRoute(
                                                                      //       builder: (context) => SMainScreenView(
                                                                      //           index: 0,
                                                                      //           screenName: UnitDetailView(
                                                                      //             categoryId: widget.categoryId,
                                                                      //             productId: element.id.toString(),
                                                                      //             productType: element.productType,
                                                                      //             refresh: true,
                                                                      //           ))),
                                                                      //   (Route<dynamic>
                                                                      //           route) =>
                                                                      //       false,
                                                                      // );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.only(
                                                                          left: 17
                                                                              .w,
                                                                          right: 15
                                                                              .w,
                                                                          top: 4
                                                                              .w,
                                                                          bottom:
                                                                              5.w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xff39C19D),
                                                                        borderRadius:
                                                                            BorderRadius.circular(50),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        "${element.unitCount} Unit",
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        14.w,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                              readMain.onNavigation(0, SEditCustomProductView(
                                                                                productId: element.id.toString(),
                                                                                categoryId: widget.categoryId,
                                                                                isFromAccountScreen: false,
                                                                              ), context);
                                                                          // Navigator
                                                                          //     .pushAndRemoveUntil(
                                                                          //   context,
                                                                          //   MaterialPageRoute(
                                                                          //       builder: (context) => SMainScreenView(
                                                                          //           index: 0,
                                                                          //           screenName: SEditCustomProductView(
                                                                          //             productId: element.id.toString(),
                                                                          //             categoryId: widget.categoryId,
                                                                          //             isFromAccountScreen: false,
                                                                          //           ))),
                                                                          //   (Route<dynamic> route) =>
                                                                          //       false,
                                                                          // );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(8),
                                                                          decoration: BoxDecoration(
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: grey6,
                                                                                  offset: const Offset(
                                                                                    5.0,
                                                                                    5.0,
                                                                                  ),
                                                                                  blurRadius: 10.0,
                                                                                  spreadRadius: 2.0,
                                                                                ), //BoxShadow
                                                                              ],
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(15)),
                                                                          child:
                                                                              SvgPicture.asset('assets/icons/e1.svg'),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            8.w,
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          read.deleteCustomProduct(
                                                                              context,
                                                                              index,
                                                                              element.id);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(8),
                                                                          decoration: BoxDecoration(
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: grey6,
                                                                                  offset: const Offset(
                                                                                    5.0,
                                                                                    5.0,
                                                                                  ),
                                                                                  blurRadius: 10.0,
                                                                                  spreadRadius: 2.0,
                                                                                ), //BoxShadow
                                                                              ],
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(15)),
                                                                          child:
                                                                              SvgPicture.asset('assets/icons/delete2.svg'),
                                                                        ),
                                                                      )
                                                                      /////////////////
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        16.w,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 11.w,
                                                                    bottom:
                                                                        11.w,
                                                                    right:
                                                                        11.w),
                                                            child: Column(
                                                              children: [
                                                                Divider(),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            "Product Unit",
                                                                            style:
                                                                                GoogleFonts.dmSans(
                                                                              textStyle: TextStyle(color: Black1, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              "MRP",
                                                                              textAlign: TextAlign.end,
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(color: Black1, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                18.w,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              "Offer price",
                                                                              textAlign: TextAlign.end,
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(color: Black1, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                ListView
                                                                    .builder(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  itemCount: watch
                                                                          .customProducts[
                                                                              index]
                                                                          .unitDetails
                                                                          ?.length ??
                                                                      0,
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  itemBuilder:
                                                                      (context,
                                                                          int) {
                                                                    // final unitDetail = watch
                                                                    //     .productsFromAdmin?[index]
                                                                    //     .unitDetails?[int];
                                                                    final unitElement = watch
                                                                        .customProducts[
                                                                            index]
                                                                        .unitDetails?[int];

                                                                    return Container(
                                                                      padding: EdgeInsets.only(
                                                                          left: 12
                                                                              .w,
                                                                          right: 20
                                                                              .w,
                                                                          top: 7
                                                                              .w,
                                                                          bottom:
                                                                              8.w),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5),
                                                                          // color: Black1,
                                                                          border: Border.all(width: 1, color: grey6)),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text(
                                                                                  "${unitElement?.weightAndUnit}",
                                                                                  style: GoogleFonts.dmSans(
                                                                                    textStyle: TextStyle(color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    "${unitElement?.mrpPrice}",
                                                                                    textAlign: TextAlign.end,
                                                                                    style: GoogleFonts.dmSans(
                                                                                      textStyle: TextStyle(decoration: TextDecoration.lineThrough, color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                // SizedBox(
                                                                                //   width: 45.w,
                                                                                // ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    "\u{20B9}${unitElement?.offerPrice}",
                                                                                    textAlign: TextAlign.end,
                                                                                    style: GoogleFonts.dmSans(
                                                                                      textStyle: TextStyle(color: Black1, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                        tilePadding:
                                                            EdgeInsets.zero,
                                                        // child:
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 18.w,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 80.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: Image.asset(
                                        "assets/images/emptycart.png",
                                        height: 151.h,
                                        width: 151.w,
                                      ),
                                    ),
                                    Text(
                                      "No Products Found",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            letterSpacing: .5,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 100.w,
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 100.w,
                        left: 0,
                        right: 0,
                        child: Visibility(
                          visible: watch.showPaginationLoader,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: SplashText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
