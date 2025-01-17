import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/delivery_view/controller/customer_order_view_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class OrderProductsListView extends StatefulWidget {
  const OrderProductsListView({super.key});

  @override
  State<OrderProductsListView> createState() => _OrderProductsListViewState();
}

class _OrderProductsListViewState extends State<OrderProductsListView> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CustomerOrderViewController>();
    final read = context.read<CustomerOrderViewController>();
    final readMain = context.read<MainScreenController>();
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
                                      imageUrl: "${element?.productImagePath}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
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
                                      element?.returnStatus == "YES"
                                          ? Text(
                                              "Return",
                                              style: TextStyle(
                                                  color: const Color(0xffFF0000),
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          : Container()
                                    ],
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
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
                                                  element?.productMrpPrice ||
                                              element?.productOfferPrice == ""
                                          ? Row(
                                              children: [
                                                Text(
                                                  "\u{20B9} ${element?.productMrpPrice} x ",
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
                                                  "\u{20B9}${element?.productOfferPrice} x ",
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
                        colorFilter: ColorFilter.mode(
                          grey12,
                          // Colors.grey,
                          BlendMode.saturation,
                        ),
                        child: Container(
                          color: grey12,
                          // width: ScreenUtil().screenWidth,
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
                                width: 5.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${element?.productName}",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Black1,
                                                  // letterSpacing: .5,
                                                  fontSize: 14.sp,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        element?.returnStatus == "YES"
                                            ? Text(
                                                "Return",
                                                style: TextStyle(
                                                    color: const Color(0xffFF0000),
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      "${element?.productWeight}  ${element?.unit}",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: grey5,
                                            // letterSpacing: .5,
                                            fontSize: 13.sp,
                                            decoration:
                                                TextDecoration.lineThrough,
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
                                                    element?.productMrpPrice ||
                                                element?.productOfferPrice == ""
                                            ? Row(
                                                children: [
                                                  Text(
                                                    "\u{20B9} ${element?.productMrpPrice} x ",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: grey5,
                                                          // letterSpacing: .5,
                                                          fontSize: 16.sp,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Text(
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
                                                    "\u{20B9}${element?.productOfferPrice} x ",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: grey5,
                                                          // letterSpacing: .5,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${element?.productQuantity}",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
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
                                          "\u{20B9} ${element?.productTotalPrice}",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
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
