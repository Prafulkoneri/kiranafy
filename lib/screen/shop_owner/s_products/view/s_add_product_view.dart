import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_add_product_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class AddProductView extends StatefulWidget {
  final String? categoryId;
  final bool? refresh;

  const AddProductView(
      {super.key, required this.categoryId, required this.refresh});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

bool _checkbox = false;

class _AddProductViewState extends State<AddProductView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    print("widget.categoryId ${widget.categoryId}");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SAddProductsController>()
          .initState(context, widget.categoryId, widget.refresh);
    });
    setPagination();
  }

  setPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<SAddProductsController>().onScrollMaxExtent(context);
        });
      }
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
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            onBackBtnPressed: () {
              readMainScreen.onNavigation(
                  0,
                  SSelectedProductView(
                      isRefresh: false, categoryId: widget.categoryId),
                  context);
            },
            title: "Add Products",
            action: SvgPicture.asset("assets/icons/forward.svg"),
            onActionTap: () async {
              read.uploadAddProducts(context);
            },
          ),
        ),
        body: watch.isLoading
            ? const Loader()
            : WillPopScope(
                onWillPop: () async {
                  readMainScreen.onNavigation(
                      0,
                      SSelectedProductView(
                          isRefresh: false, categoryId: widget.categoryId),
                      context);
                  return false;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(
                                left: 20.w,
                                right: 28.w,
                                top: 20.w,
                                bottom: 20.w,
                              ),
                              child: watch.allAdminProductList.isNotEmpty ==
                                      true
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            read.onSelecteAllProducts(context);
                                          },
                                          value: watch.isSelectAll,
                                        ),
                                      ],
                                    )
                                  : Container()),

                          ///Products Starts
                          watch.allAdminProductList.isNotEmpty == true
                              ? Container(
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(
                                        left: 19.w,
                                        right: 19.w,
                                      ),
                                      itemCount:
                                          watch.allAdminProductList.length ?? 0,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (BuildContext, index) {
                                        final element =
                                            watch.allAdminProductList[index];
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                read.onProductsSelected(index,
                                                    element.id.toString());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 4.w,
                                                    top: 4,
                                                    bottom: 4,
                                                    right: 9.w),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.03.w),
                                                        blurRadius: 5,
                                                        spreadRadius: 0,
                                                        offset: const Offset(5, 6)),
                                                  ],
                                                  border: Border.all(
                                                      color: Colors.black
                                                          .withOpacity(0.07)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.w),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    element.productImagePath !=
                                                            ""
                                                        ? AppNetworkImages(
                                                            imageUrl:
                                                                "${element.productImagePath}",
                                                            height: 60.h,
                                                            width: 60.w,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image(
                                                            image: const AssetImage(
                                                              "assets/images/image_not_found.png",
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 10.w,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  "${element.productName}",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          16.sp,
                                                                      color:
                                                                          Black1),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10.w,
                                                          ),
                                                          Text(
                                                            "${element.unitWithWeight}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.sp,
                                                                color: Grey),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: 10.w),
                                                      child: PrimaryCheckBox(
                                                        // value: watch.selectedProduct[index],
                                                        onChanged: (value) {
                                                          read.onProductsSelected(
                                                              index,
                                                              element.id
                                                                  .toString());
                                                        },
                                                        value: watch
                                                                .selectedProduct[
                                                            index],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.w,
                                            ),
                                          ],
                                        );
                                      }),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 20.w, top: 120.w),
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
                            child: const Center(
                              child: SizedBox(
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
