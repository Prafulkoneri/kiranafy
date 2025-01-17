import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/category/controller/product_as_per_category_controller.dart';
import 'package:local_supper_market/screen/customer/category/view/filter_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/products/controller/product_view_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';
import '../../products/views/product_screen_view.dart';

class CategoryScreenView extends StatefulWidget {
  final String? shopId;
  final String? categoryId;

  const CategoryScreenView(
      {super.key, required this.categoryId, required this.shopId});

  @override
  State<CategoryScreenView> createState() => _CategoryScreenViewState();
}

class _CategoryScreenViewState extends State<CategoryScreenView> {
  bool checkedValue = false;
  String? gender; //no radio button will be selected

  // final List<String> genderItems = [];
  void setThis(newValue) {
    setState(() {
      checkedValue = newValue;
    });
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProductCategoryController>()
          .initState(context, widget.shopId, widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ProductCategoryController>();
    final read = context.read<ProductCategoryController>();
    final readMain = context.read<MainScreenController>();
    final readProductViewController = context.read<ProductViewController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            readMain.onNavigation(
                1,
                ShopProfileView(
                  shopId: widget.shopId.toString(),
                  routeName: "categoryView",
                  refreshPage: true,
                ),
                context);
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => MainScreenView(
            //           index: 1,
            //           screenName: ShopProfileView(
            //             shopId: widget.shopId.toString(),
            //             routeName: "categoryView",
            //             refreshPage: true,
            //           ))),
            //   (Route<dynamic> route) => false,
            // );
          },
          title: "Category",
          action: InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return const FilterScreenView();
                  });
                },
              );
            },
            child: SvgPicture.asset(
              'assets/images/filter.svg',
              width: 20.w,
              height: 18.h,
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          readMain.onNavigation(
              1,
              ShopProfileView(
                shopId: widget.shopId.toString(),
                routeName: "categoryView",
                refreshPage: true,
              ),
              context);
          return false;
        },
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 19.0.w,
                left: 19.0.w,
                top: 20.h,
              ),
              child: SizedBox(
                height: 36.h,
                width: 351.w,
                child: TextField(
                  onChanged: (value) {
                    read.getSearchList(context, watch.shopId, watch.categoryId);
                  },
                  controller: watch.searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 10.w),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: splashnone),
                        borderRadius: BorderRadius.circular(8.w)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: splashnone),
                        borderRadius: BorderRadius.circular(8.w)),
                    hintText: 'Search your products..',
                    hintStyle: TextStyle(
                        color: kgrey,
                        letterSpacing: .5,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),

                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Black,
                        size: 25.h,
                      ),
                      onPressed: () {
                        // Perform the search here
                      },
                    ),

                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(15.w),
                    // ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: watch.allCategoryList?.length ?? 0,
                  itemBuilder: (BuildContext, index) {
                    final element = watch.allCategoryList?[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 19.w : 10.w,
                          top: 20.w,
                          right: index ==
                                  int.parse(watch.allCategoryList?.length
                                              .toString() ??
                                          "0") -
                                      1
                              ? 19.w
                              : 0.w),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.h,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                // backgroundColor: ,
                                backgroundColor: MaterialStateProperty.all(
                                    element?.selectedCategory == "yes"
                                        ? SplashText
                                        : Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: element?.selectedCategory == "yes"
                                          ? Colors.transparent
                                          : Grey,
                                      // width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                print("j");
                                read.getFilterProductList(
                                    context, true, element?.id.toString());
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    element?.categoryName ?? "",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color:
                                              element?.selectedCategory == "yes"
                                                  ? Colors.white
                                                  : Grey,
                                          // letterSpacing: .5,
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //
                        ],
                      ),
                    );
                  }),
            ),
            watch.isLoading
                ? Container(
                    padding: EdgeInsets.only(top: 200.w),
                    child: const Loader(),
                  )
                : Expanded(
                    child: watch.productList?.isNotEmpty == true ||
                            watch.customProductList?.isNotEmpty == true
                        ? SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Container(
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      physics: const BouncingScrollPhysics(),
                                      // physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: watch.productList?.length ?? 0,
                                      itemBuilder: (BuildContext, index) {
                                        final element =
                                            watch.productList?[index];
                                        return GestureDetector(
                                          onTap: () {
                                            readProductViewController
                                                .updateProductId(
                                                    element?.id.toString(),
                                                    context,
                                                    false);
                                            readMain.onNavigation(
                                                1,
                                                ProductScreenView(
                                                    routeName: "categoryView",
                                                    selectedUnitId: element
                                                        ?.productUnitId
                                                        .toString(),
                                                    categoryId:
                                                        watch.categoryId,
                                                    productId:
                                                        element?.id.toString(),
                                                    shopId: widget.shopId,
                                                    productType:
                                                        element?.productType),
                                                context);
                                            // Navigator.pushAndRemoveUntil(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           MainScreenView(
                                            //             index: 1,
                                            //             screenName: ProductScreenView(
                                            //                 selectedUnitId: element
                                            //                     ?.productUnitId
                                            //                     .toString(),
                                            //                 categoryId: watch
                                            //                     .categoryId,
                                            //                 productId: element
                                            //                     ?.id
                                            //                     .toString(),
                                            //                 shopId:
                                            //                     widget.shopId,
                                            //                 productType: element
                                            //                     ?.productType),
                                            //           )),
                                            //   (Route<dynamic> route) => false,
                                            // );
                                            print(
                                              element?.productUnitId.toString(),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 18.w,
                                                    top: 8.w,
                                                    right: 17.w),
                                                child: Container(
                                                  child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 8.w,
                                                          ),
                                                          element?.productImagePath ==
                                                                  ""
                                                              ? Image.asset(
                                                                  'assets/images/image_not_found.png',
                                                                  width: 80.w,
                                                                  height: 80.h,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : AppNetworkImages(
                                                                  imageUrl:
                                                                      element?.productImagePath ??
                                                                          "",
                                                                  width: 80.w,
                                                                  height: 80.h,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20.0
                                                                          .w,
                                                                      top: 12.w,
                                                                      right:
                                                                          13.w),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Text(
                                                                          element?.productName ??
                                                                              "",
                                                                          style:
                                                                              GoogleFonts.dmSans(
                                                                            textStyle: TextStyle(
                                                                                color: Black1,
                                                                                letterSpacing: .5,
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.w700),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      element?.discountPercentage !=
                                                                              ""
                                                                          ? Container(
                                                                              width: 60.w,
                                                                              height: 20.h,
                                                                              decoration: BoxDecoration(color: lightgreen, borderRadius: BorderRadius.all(Radius.circular(5.w))),
                                                                              child: Center(
                                                                                child: Text("${element?.discountPercentage} off",
                                                                                    // textAlign: TextAlign.center,
                                                                                    style: GoogleFonts.dmSans(
                                                                                      textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                                                    )),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 6.h,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                          "${element?.weight} ${element?.unit}",
                                                                          // textAlign: TextAlign.center,
                                                                          style:
                                                                              GoogleFonts.dmSans(
                                                                            textStyle: TextStyle(
                                                                                color: Grey,
                                                                                letterSpacing: .5,
                                                                                fontSize: 14.sp,
                                                                                fontWeight: FontWeight.w500),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 12.w),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  element?.mrpPrice != "" ? Text('\u{20B9}${element?.mrpPrice}', style: GoogleFonts.dmSans(textStyle: element?.offerPrice != "" && element?.offerPrice != element?.mrpPrice ? TextStyle(decoration: TextDecoration.lineThrough, color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400) : TextStyle(color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400))) : const Text(""),
                                                                                  SizedBox(
                                                                                    width: 10.w,
                                                                                  ),
                                                                                  element?.offerPrice != "" && element?.offerPrice != element?.mrpPrice
                                                                                      ? Text(
                                                                                          '\u{20B9}${element?.offerPrice}',
                                                                                          style: GoogleFonts.dmSans(
                                                                                            textStyle: TextStyle(
                                                                                                // decoration:
                                                                                                // TextDecoration.lineThrough,
                                                                                                color: Black,
                                                                                                letterSpacing: .5,
                                                                                                fontSize: 13.sp,
                                                                                                fontWeight: FontWeight.w500),
                                                                                          ),
                                                                                        )
                                                                                      : Container()
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      watch.quantityList[index] ==
                                                                              0
                                                                          ? GestureDetector(
                                                                              onTap: () {
                                                                                read.addToCart(element?.productType, element?.productUnitId, element?.shopId, index, context);
                                                                              },
                                                                              child: SvgPicture.asset(
                                                                                'assets/images/add.svg',
                                                                              ))
                                                                          : Row(
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    if (watch.isQuanityBtnPressed) {
                                                                                      return;
                                                                                    }
                                                                                    read.subtractItemQuantity(context, element?.cartItemId.toString(), index, element?.productType, element?.productUnitId);
                                                                                  },
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/icons/minus.svg',
                                                                                    // width: 30.w,
                                                                                    // height: 30.h,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 12.w,
                                                                                ),
                                                                                Text(
                                                                                  "${watch.quantityList[index]}",
                                                                                  style: GoogleFonts.dmSans(
                                                                                    textStyle: TextStyle(
                                                                                        // decoration:
                                                                                        // TextDecoration.lineThrough,
                                                                                        color: Black,
                                                                                        // letterSpacing:
                                                                                        //     .5,
                                                                                        fontSize: 16.sp,
                                                                                        fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 12.w,
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    print(watch.isQuanityBtnPressed);
                                                                                    // return;
                                                                                    if (watch.isQuanityBtnPressed) {
                                                                                      return;
                                                                                    }
                                                                                    print(element?.productType);
                                                                                    read.addItemQuantity(context, element?.cartItemId.toString(), element?.productType, index);
                                                                                  },
                                                                                  child: SvgPicture.asset(
                                                                                    'assets/images/add.svg',
                                                                                    // width: 30.w,
                                                                                    // height: 30.h,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                      // GestureDetector(
                                                                      //   onTap: () {
                                                                      //     read.addToCart(
                                                                      //         element
                                                                      //             ?.productType,
                                                                      //         element
                                                                      //             ?.productUnitId,
                                                                      //         element
                                                                      //             ?.shopId,
                                                                      //         index,
                                                                      //         context);
                                                                      //     watch.onCategoryProductSelected(
                                                                      //         index);
                                                                      //   },
                                                                      //   child: watch.isCategoryProductAdded[index] ==
                                                                      //           false
                                                                      //       ? SvgPicture
                                                                      //           .asset(
                                                                      //           'assets/images/add.svg',
                                                                      //           // width: 15.w,
                                                                      //           // height: 19.h,
                                                                      //         )
                                                                      //       : SvgPicture.asset(
                                                                      //           "assets/icons/tick_green_bg.svg"),
                                                                      // )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        12.w,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                  // decoration: BoxDecoration(
                                                  //   // color: Colors.blueAccent,
                                                  //   border: Border.all(width: 1, color: grey1),
                                                  // ),
                                                  // decoration: BoxDecoration(color: Black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 100.w,
                                ),
                              ],
                            ),
                          )
                        :
                        // Container(
                        //         child: Center(child: Text("No Products found")),
                        //       )
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                          ))
          ],
        ),
      ),
    );
  }
}
