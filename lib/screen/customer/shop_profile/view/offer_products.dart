import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
import 'package:provider/provider.dart';

class OfferProducts extends StatefulWidget {
  const OfferProducts({super.key});

  @override
  State<OfferProducts> createState() => _OfferProductsState();
}

class _OfferProductsState extends State<OfferProducts> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ShopProfileController>();
    final read = context.read<ShopProfileController>();
    final readMain = context.read<MainScreenController>();
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(watch.offerProduct?.length ?? 0, (index) {
            final element = watch.offerProduct?[index];
            return watch.offerProduct?[index].mrpPrice != "" &&
                    watch.offerProduct?[index].offerPrice != "" &&
                    int.parse(element?.offerPrice ?? "0") <
                        int.parse(element?.mrpPrice ?? "0")
                ? Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.03.w),
                                blurRadius: 5,
                                spreadRadius: 0,
                                offset: Offset(0, 3)),
                          ],
                        ),
                        child: Card(
                          // shape: ShapeBorder.
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                            width: 156.w,
                            padding: EdgeInsets.only(
                                left: 19.w,
                                top: 14.w,
                                right: 12.w,
                                bottom: 12.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    element?.discountPercentage != ""
                                        ? Container(
                                            width: 60.w,
                                            height: 20.h,
                                            decoration: BoxDecoration(
                                                color: lightgreen,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.w))),
                                            child: Center(
                                              child: Text(
                                                  "${element?.discountPercentage} off",
                                                  // textAlign: TextAlign.center,
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        letterSpacing: .5,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                            child: Image.network(
                                              "${element?.productImagePath}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.w,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${element?.productName}",
                                        maxLines: 1,
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            color: Black1,
                                            overflow: TextOverflow.ellipsis,
                                            // letterSpacing: .5,
                                            fontSize: 16.sp,

                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.w,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${element?.weight}${element?.unit}",
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            // letterSpacing: .5,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.w,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        element?.mrpPrice != ""
                                            ? Text(
                                                '\u{20B9}${element?.mrpPrice}',
                                                style: GoogleFonts.dmSans(
                                                    textStyle: element
                                                                    ?.offerPrice !=
                                                                "" &&
                                                            element?.offerPrice !=
                                                                element
                                                                    ?.mrpPrice
                                                        ? TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Black1,
                                                            letterSpacing: .5,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w400)
                                                        : TextStyle(
                                                            color: Black1,
                                                            letterSpacing: .5,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)))
                                            : Text(""),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        element?.offerPrice != "" &&
                                                element?.offerPrice !=
                                                    element?.mrpPrice
                                            ? Text(
                                                '\u{20B9}${element?.offerPrice}',
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      // decoration:
                                                      // TextDecoration.lineThrough,
                                                      color: Black,
                                                      letterSpacing: .5,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            : Text(""),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/add.svg',
                                      // width: 15.w,
                                      // height: 19.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container();
          }),
        ),
      ),
    );
  }
}
