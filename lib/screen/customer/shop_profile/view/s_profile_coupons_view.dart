import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/coupons/view/coupon_all_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:provider/provider.dart';

class CShopCouponsView extends StatefulWidget {
  const CShopCouponsView({super.key});

  @override
  State<CShopCouponsView> createState() => _CShopCouponsViewState();
}

class _CShopCouponsViewState extends State<CShopCouponsView> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ShopProfileViewController>();
    return Container(
      decoration: BoxDecoration(color: Coupons),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          // padding: const EdgeInsets.all(8.0),
          padding: EdgeInsets.only(left: 20.w, top: 16.w, right: 15.w),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Coupons For You",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Black,
                      // letterSpacing: .5,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => AllCoupons()),
                  // );
                },
                child: Text(
                  "See all",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: CouponsText,
                        // letterSpacing: .5,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 5.h,
        // ),
        Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            bottom: 10.w,
            top: 5.w,
          ),
          child: Text(
            "Popular Offers of the Day",
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: Grey,
                  // letterSpacing: .5,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children:
                List.generate(watch.shopCouponsList?.length ?? 0, (index) {
              final element = watch.shopCouponsList?[index];
              return Container(
                margin: EdgeInsets.only(left: index == 0 ? 19.w : 5.w),
                width: 326.w,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    Image.asset('assets/images/Coupons.png',
                        height: 125.h, width: 352.w
                        // fit: BoxFit.cover
                        ),
                    Container(
                      padding: EdgeInsets.only(top: 12.5.w, bottom: 15.5.w),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 37.42.w,
                          ),
                          ClipRRect(
                            // borderRadius: new BorderRadius.circular(40.0),
                            child: Image.asset('assets/images/couponslogo.png',
                                height: 62.h, width: 38.w),
                          ),
                          SizedBox(
                            width: 9.38.w,
                          ),
                          DottedLine(
                            dashColor: const Color(0xff666666).withOpacity(0.2),
                            dashGapLength: 5.w,
                            direction: Axis.vertical,
                            lineLength: 90.w,
                            lineThickness: 2.w,
                            dashLength: 8.w,
                          ),
                          // FDottedLine(
                          //   color: Grey,
                          //   height: 120.0.w,
                          //   strokeWidth: 2.0,
                          //   dottedLength: 10.0,
                          //   space: 1.0,
                          // ),
                          SizedBox(
                            width: 19.25.w,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      element?.shopName ?? "",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            // letterSpacing: .5,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 50.w,
                                    // ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.white,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30))),
                                          context: context,
                                          builder: (context) {
                                            return CCouponsDetailView(
                                                shopName: element?.shopName,
                                                CounponCode:
                                                    element?.couponCode,
                                                discountmaxAmount: element
                                                    ?.couponDiscountMaxAmount,
                                                disscountPerscentage: element
                                                    ?.couponDiscountPercentage
                                                    .toString(),
                                                startDate:
                                                    element?.couponToDate,
                                                termCondition: element
                                                    ?.couponTermsAndConditions
                                                    .toString());
                                          },
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/logo1.svg',
                                        width: 15.w,
                                        height: 15.h,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7.w,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Valid until ${element?.couponToDate}",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            // letterSpacing: .5,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.w,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${element?.couponDiscountPercentage}% OFF",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              // letterSpacing: .5,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700),
                                        )),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text(
                                        "UPTO ₹${element?.couponDiscountMaxAmount}",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Grey,
                                              letterSpacing: .5,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 6.w,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.33.w, vertical: 6.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.w),
                                          border:
                                              Border.all(color: SplashText)),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              element?.couponCode ?? "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.sp,
                                                  color: SplashText),
                                            ),
                                            SizedBox(
                                              width: 19.w,
                                            ),
                                            SvgPicture.asset(
                                              'assets/images/svg2.svg',
                                              width: 14.w,
                                              height: 14.w,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 9.5.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        SizedBox(
          height: 14.w,
        ),
      ]),
    );
  }
}
