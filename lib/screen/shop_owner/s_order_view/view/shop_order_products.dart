import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/controller/shop_owner_order_view_controller.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class ShopOrderProducts extends StatefulWidget {
  const ShopOrderProducts({super.key});

  @override
  State<ShopOrderProducts> createState() => _ShopOrderProductsState();
}

class _ShopOrderProductsState extends State<ShopOrderProducts> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ShopOwnerOrderViewController>();
    final read = context.read<ShopOwnerOrderViewController>();
    final readMain = context.read<SMainScreenController>();
    return SizedBox(
      // height: 140.h,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          // scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          // physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: watch.orderProductDetails?.length ?? 0,
          itemBuilder: (BuildContext, index) {
            final element = watch.orderProductDetails?[index];
            return Column(
              children: [
                watch.orderDetails?.orderStatus == "Pending" ||
                        watch.orderDetails?.orderStatus == "Confirmed"
                    ? SizedBox(
                        width: ScreenUtil().screenWidth,
                        child: Row(
                          children: [
                            element?.productImagePath == ""
                                ? SizedBox(
                                    height: 89.w,
                                    width: 89.w,
                                    child: Image.asset(
                                      "assets/images/image_not_found.png",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : SizedBox(
                                    height: 89.w,
                                    width: 89.w,
                                    child: AppNetworkImages(
                                      imageUrl: "${element?.productImagePath}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          // "",
                                          "${element?.productName}",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                // letterSpacing: .5,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      watch.orderDetails?.orderStatus ==
                                                  "Pending" ||
                                              watch.orderDetails?.orderStatus ==
                                                  "Confirmed"
                                          ? PrimaryCheckBox(
                                              onChanged: (value) {
                                                LoadingOverlay.of(context)
                                                    .show();
                                                read.selectProducts(context,
                                                    index, element?.id, value);
                                              },
                                              value: watch
                                                  .selectedProductList[index],
                                            )
                                          : watch.orderDetails?.orderStatus ==
                                                  "Order Refund"
                                              ? Container(
                                                  child: Text(
                                                    element?.refundStatus ==
                                                            "YES"
                                                        ? "Return"
                                                        : '',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 13.sp,
                                                        color:
                                                            const Color(0xffFF0000)),
                                                  ),
                                                )
                                              : Container(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    // "",/
                                    "${element?.productWeight}  ${element?.unit}",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: grey5,
                                          // letterSpacing: .5,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 11.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      element?.productOfferPrice ==
                                                  element?.productOfferPrice ||
                                              element?.productOfferPrice == ""
                                          ? Row(
                                              children: [
                                                Text(
                                                  // "",
                                                  "\u{20B9} ${element?.productOfferPrice} x ",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: grey5,
                                                        // letterSpacing: .5,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                Text(
                                                  // "",
                                                  "${element?.productQuantity}",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: grey5,
                                                        // letterSpacing: .5,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Text(
                                                  // "",
                                                  "\u{20B9} ${element?.productMrpPrice}  ",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: grey5,
                                                        // letterSpacing: .5,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                Text(
                                                  // "",
                                                  "\u{20B9} ${element?.productOfferPrice} x ",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: grey5,
                                                        // letterSpacing: .5,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                Text(
                                                  // "",
                                                  "${element?.productQuantity}",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: grey5,
                                                        // letterSpacing: .5,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      Text(
                                        // "",
                                        "\u{20B9} ${element?.productTotalPrice}",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: grey5,
                                              // letterSpacing: .5,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : watch.orderDetails?.orderStatus != "Pending" &&
                            watch.orderDetails?.orderStatus != "Confirmed" &&
                            element?.status == "active"
                        ? SizedBox(
                            width: ScreenUtil().screenWidth,
                            child: Row(
                              children: [
                                element?.productImagePath == ""
                                    ? SizedBox(
                                        height: 89.w,
                                        width: 89.w,
                                        child: Image.asset(
                                          "assets/images/image_not_found.png",
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : SizedBox(
                                        height: 89.w,
                                        width: 89.w,
                                        child: AppNetworkImages(
                                          imageUrl:
                                              "${element?.productImagePath}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              // "",
                                              "${element?.productName}",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black1,
                                                    // letterSpacing: .5,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                          watch.orderDetails?.orderStatus ==
                                                  "Pending"
                                              ? PrimaryCheckBox(
                                                  onChanged: (value) {
                                                    LoadingOverlay.of(context)
                                                        .show();
                                                    read.selectProducts(
                                                        context,
                                                        index,
                                                        element?.id,
                                                        value);
                                                  },
                                                  value:
                                                      watch.selectedProductList[
                                                          index],
                                                )
                                              : watch.orderDetails
                                                          ?.orderStatus ==
                                                      "Order Refund"
                                                  ? Container(
                                                      child: Text(
                                                        element?.refundStatus ==
                                                                "YES"
                                                            ? "Return"
                                                            : '',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 13.sp,
                                                            color: const Color(
                                                                0xffFF0000)),
                                                      ),
                                                    )
                                                  : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text(
                                        // "",/
                                        "${element?.productWeight}  ${element?.unit}",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: grey5,
                                              // letterSpacing: .5,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 11.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          element?.productOfferPrice ==
                                                      element
                                                          ?.productOfferPrice ||
                                                  element?.productOfferPrice ==
                                                      ""
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      // "",
                                                      "\u{20B9} ${element?.productOfferPrice} x ",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: grey5,
                                                            // letterSpacing: .5,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Text(
                                                      // "",
                                                      "${element?.productQuantity}",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: grey5,
                                                            // letterSpacing: .5,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      // "",
                                                      "\u{20B9} ${element?.productMrpPrice}  ",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: grey5,
                                                            // letterSpacing: .5,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Text(
                                                      // "",
                                                      "\u{20B9} ${element?.productOfferPrice} x ",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: grey5,
                                                            // letterSpacing: .5,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    Text(
                                                      // "",
                                                      "${element?.productQuantity}",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: grey5,
                                                            // letterSpacing: .5,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          Text(
                                            // "",
                                            "\u{20B9} ${element?.productTotalPrice}",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: grey5,
                                                  // letterSpacing: .5,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            ),
                            // foregroundDecoration: BoxDecoration(
                            //   color: Colors.grey.withOpacity(0.2),
                            //   // backgroundBlendMode: BlendMode.color,
                            // ),

                            // width: ScreenUtil().screenWidth,
                            child: Container(
                              color: grey12,
                              child: Row(
                                children: [
                                  element?.productImagePath == ""
                                      ? SizedBox(
                                          height: 89.w,
                                          width: 89.w,
                                          child: Image.asset(
                                            "assets/images/image_not_found.png",
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : SizedBox(
                                          height: 89.w,
                                          width: 89.w,
                                          child: AppNetworkImages(
                                            imageUrl:
                                                "${element?.productImagePath}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                // "",
                                                "${element?.productName}",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: Black1,
                                                      // letterSpacing: .5,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ),
                                            watch.orderDetails?.orderStatus ==
                                                    "Pending"
                                                ? PrimaryCheckBox(
                                                    onChanged: (value) {
                                                      LoadingOverlay.of(context)
                                                          .show();
                                                      read.selectProducts(
                                                          context,
                                                          index,
                                                          element?.id,
                                                          value);
                                                    },
                                                    value: watch
                                                            .selectedProductList[
                                                        index],
                                                  )
                                                : watch.orderDetails
                                                            ?.orderStatus ==
                                                        "Order Refund"
                                                    ? Container(
                                                        child: Text(
                                                          element?.refundStatus ==
                                                                  "YES"
                                                              ? "Return"
                                                              : '',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 13.sp,
                                                            color: const Color(
                                                                0xffFF0000),
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                          // "",/
                                          "${element?.productWeight}  ${element?.unit}",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: grey5,
                                                // letterSpacing: .5,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400),
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 11.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            element?.productOfferPrice ==
                                                        element
                                                            ?.productOfferPrice ||
                                                    element?.productOfferPrice ==
                                                        ""
                                                ? Row(
                                                    children: [
                                                      Text(
                                                        // "",
                                                        "\u{20B9} ${element?.productOfferPrice} x ",
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: grey5,
                                                              // letterSpacing: .5,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                      Text(
                                                        // "",
                                                        "${element?.productQuantity}",
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: grey5,
                                                              // letterSpacing: .5,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      Text(
                                                        // "",
                                                        "\u{20B9} ${element?.productMrpPrice}  ",
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: grey5,
                                                              // letterSpacing: .5,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                      Text(
                                                        // "",
                                                        "\u{20B9} ${element?.productOfferPrice} x ",
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: grey5,
                                                              // letterSpacing: .5,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                      Text(
                                                        // "",
                                                        "${element?.productQuantity}",
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: grey5,
                                                              // letterSpacing: .5,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0.w),
                                              child: Text(
                                                // "",
                                                "\u{20B9} ${element?.productTotalPrice}",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: grey5,
                                                      // letterSpacing: .5,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 1.w,
                                            // )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                Divider(
                  // height: 100,
                  color: grey2,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
              ],
            );
          }),
    );
  }
}
