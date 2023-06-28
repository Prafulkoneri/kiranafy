import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/controller/shop_owner_order_view_controller.dart';
import 'package:local_supper_market/widget/checkbox.dart';
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
    final readMain = context.read<MainScreenController>();
    return SizedBox(
      // height: 140.h,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          // scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          // physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: watch.orderProductDetails?.length ?? 0,
          itemBuilder: (BuildContext, index) {
            final element = watch.orderProductDetails?[index];
            return Column(
              children: [
                Container(
                  width: ScreenUtil().screenWidth,
                  child: Row(
                    children: [
                      element?.productImagePath == ""
                          ? Container(
                              height: 89.w,
                              width: 89.w,
                              child: Image.asset(
                                "assets/images/profile_image.png",
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                PrimaryCheckBox(
                                  onChanged: (value) {
                                    // read.onAddOnServicesSelected(
                                    //     index, element?.id);
                                  },
                                  // value:
                                  //     watch.selectAddonServicesList[index],
                                ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                element?.productOfferPrice ==
                                            element?.productOfferPrice ||
                                        element?.productOfferPrice == ""
                                    ? Row(
                                        children: [
                                          Text(
                                            // "",
                                            "Rs. ${element?.productMrpPrice} x ",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: grey5,
                                                  // letterSpacing: .5,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400),
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
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            // "",
                                            "Rs. ${element?.productMrpPrice}  ",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: grey5,
                                                  // letterSpacing: .5,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Text(
                                            // "",
                                            "Rs. ${element?.productOfferPrice} x ",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: grey5,
                                                  // letterSpacing: .5,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400),
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
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                Text(
                                  // "",
                                  "Rs. ${element?.productTotalPrice}",
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
