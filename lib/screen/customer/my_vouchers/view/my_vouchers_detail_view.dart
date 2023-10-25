import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/coupons/controller/coupon_all_controler.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/widget/text.dart';
import 'package:provider/provider.dart';

class MyVoucherDetailView extends StatefulWidget {
  final bool? fromCouponScreen;
  final String? shopName;
  final String? termCondition;
  final String? startDate;
  final String? disscountPerscentage;
  final String? discountmaxAmount;
  final String? CounponCode;

  const MyVoucherDetailView(
      {super.key,
      this.fromCouponScreen,
      required this.shopName,
      required this.CounponCode,
      required this.discountmaxAmount,
      required this.disscountPerscentage,
      required this.startDate,
      required this.termCondition});

  @override
  State<MyVoucherDetailView> createState() => _MyVoucherDetailViewState();
}

class _MyVoucherDetailViewState extends State<MyVoucherDetailView> {
  @override
  // void initState() {
  //   SchedulerBinding.instance.addPostFrameCallback((_) {
  //     context.read<CAllCouponController>().initState(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CAllCouponController>();
    final read = context.read<CAllCouponController>();
    final readMain = context.read<MainScreenController>();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Container(
        // ,
        // ),
        Container(
          // height: MediaQuery.of(context).size.height * 0.50,
          height: 300.h,
          width: 390.w,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 13.w, top: 20.w),
                    child: Image.asset('assets/images/my_vouchers_logo.png',
                        height: 33.h, width: 21.w),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 18.0.h),
                          child: CouponsTitleText(
                            text: "${widget.shopName}",
                          )),
                      SizedBox(
                        height: 10.w,
                      ),
                      CouponsTwoText(
                        text: "Valid until ${widget.startDate}",
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 45.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CouponsOff(
                            text: "${widget.disscountPerscentage}%" " OFF"),
                        SizedBox(
                          width: 10.w,
                        ),
                        CouponsUpto(
                            text: "UPTO ₹${widget.disscountPerscentage}")
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 0.w, right: 13.w),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              read.copyCode(context, widget.CounponCode ?? "");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 11.33.w, vertical: 7.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  border: Border.all(color: SplashText)),
                              child: Center(
                                child: Row(
                                  children: [
                                    Couponsode(
                                      text: "${widget.CounponCode}",
                                    ),
                                    SizedBox(
                                      width: 19.w,
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/svg2.svg',
                                      width: 17.w,
                                      height: 17.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                // height: 20,
                thickness: 1,
                indent: 14,
                endIndent: 25.5,
                color: Grey,
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17.75.w, top: 8.w, bottom: 8.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/checked.svg',
                          width: 17.w,
                          height: 17.h,
                        ),
                        SizedBox(
                          width: 6.27,
                        ),
                        Flexible(
                            child: ShopRating(text: "${widget.termCondition}"))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        ///top icon
        Positioned(
            top: -60.w,
            left: 0.w,
            right: 0.w,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50.w,
                width: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/Cross.svg',
                    width: 15.w,
                    height: 15.h,
                  ),
                ),
              ),
            )),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Visibility(
            visible: watch.isOfferCopied,
            child: Container(
              padding: EdgeInsets.only(
                  top: 15.w, bottom: 15.w, left: 10.w, right: 10.w),
              margin: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
              color: Colors.green,
              width: ScreenUtil().screenWidth,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Coupon Code Copied",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          read.onDismiss();
                        },
                        child: Text(
                          "Dismiss",
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
