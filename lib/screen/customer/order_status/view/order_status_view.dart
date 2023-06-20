import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/order_payment/view/order_payment_view.dart';
import 'package:local_supper_market/screen/customer/order_summery/order_summary_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';

class OrderStatusView extends StatelessWidget {
  OrderStatusView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Random random = new Random();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrderPaymentView()),
            );
          },
          title: "Order Status",
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("",
                      // "${watch.shopDetails?.shopName}",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Black1),
                      )),
                  SizedBox(
                    height: 10.w,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/images/location2.svg',
                                width: 28.w,
                                height: 28.w,
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              Flexible(
                                child: Text(
                                  "",
                                  // "${watch.shopDetails?.shopAddress}\n${watch.shopDetails?.cityName} - ${watch.shopDetails?.shopPincode}",
                                  // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        Row(
                          children: [
                            // GestureDetector(
                            //   onTap: () {
                            //     read.launchPhone(
                            //         watch.shopDetails
                            //                 ?.shopOwnerSupportNumber ??
                            //             "",
                            //         context);
                            //   },
                            //   child: SvgPicture.asset(
                            //     'assets/images/call.svg',
                            //     // width: 15.w,
                            //     // height: 19.h,
                            //   ),
                            // ),
                            InkWell(
                              onTap: () {
                                // read.launchPhone(
                                //     watch.shopDetails
                                //             ?.shopOwnerSupportNumber ??
                                //         "",
                                //     context);
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 13.w,
                                      right: 13.w,
                                      top: 14.w,
                                      bottom: 14.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff23AA49),
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/new_call.svg",
                                    width: 26.w,
                                    height: 14.h,
                                  )),
                            ),
                            SizedBox(
                              width: 13.w,
                            ),
                            InkWell(
                              onTap: () {
                                // watch.favAllShop
                                //     ? read.removeAllShopFavList(
                                //         context,
                                //         watch.shopDetails?.id)
                                //     : read.updateAllShopFavList(
                                //         context,
                                //         watch.shopDetails?.id);
                              },
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 13.w,
                                      right: 13.w,
                                      top: 14.w,
                                      bottom: 14.w),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff4689EC),
                                  ),
                                  child:
                                      // watch.favAllShop
                                      //     ?
                                      SvgPicture.asset(
                                    "assets/icons/fav_selected.svg",
                                    width: 26.w,
                                    height: 14.h,
                                  )
                                  // :
                                  // SvgPicture.asset(
                                  //     "assets/images/favorite.svg",
                                  //     width: 26.w,
                                  //     height: 14.h,
                                  //   ),
                                  ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1, color: grey2),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20.w,
              ),
              child: Text(
                "Delivery Address",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Black,
                      // letterSpacing: .5,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 19.w, right: 19.w),
              // height: 156.h,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  // side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: 20.w, left: 20.w, right: 15.w, top: 20.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/person.svg',
                                width: 11.w,
                                height: 15.h,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "",
                                // "${element.customerName}",
                                // 'Rachel Green',
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      letterSpacing: .5,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              // SizedBox(
                              //   width: 11.w,
                              // ),
                            ],
                          ),
                          SizedBox(
                            // height: 21.h,/
                            // width: 71.w,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                // backgroundColor: ,
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: lighrgreen,
                                      // width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                "",
                                // "${element.deliveryAddressType}",
                                // "Home",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: SplashText1,
                                      // letterSpacing: .5,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),

                              //
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/phone.svg',
                            width: 14.w,
                            height: 15.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "",
                            // '${element.mobileNo}',
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black,
                                  letterSpacing: .5,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/location.svg',
                            color: SplashText1,
                            width: 17.w,
                            height: 17.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Text(
                              "",
                              maxLines: 3,
                              // "${element.address1} \n${element.address2} ",
                              // "Nand Nivas Building floor 3 B-3,Lane No.13 Bhatrau Nivas Vishrantwadi Pune -411015.",
                              // textAlign: TextAlign.start,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    // height: 1.5,
                                    color: black,
                                    // letterSpacing: .05,
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                      // SizedBox(
                      //   height: 10.w,
                      // ),
                      // element.deliveryAddressIsDefault == "yes"
                      //     ?  Row(
                      //         children: [
                      //           SizedBox(
                      //             width: 10.w,
                      //           ),
                      //           Text(
                      //             'Default',
                      //             style: GoogleFonts.dmSans(
                      //               textStyle: TextStyle(
                      //                   color: Black,
                      //                   // letterSpacing: .5,
                      //                   fontSize: 16.sp,
                      //                   fontWeight: FontWeight.w400),
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //     : Container()
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 19.w, top: 20.w, bottom: 30.w),
              child: Text(
                // maxLines: 3,
                "Order Status",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Black1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 80.w, bottom: 32.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Placed",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "We have received your order.",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "Sep 30 2021 20:15 AM.",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      index == 4
                          ? Container()
                          : Positioned(
                              left: 42,
                              top: 25,
                              // bottom: 20,
                              child: Container(
                                height: 100,
                                width: 1.0,
                                color: Colors.grey.shade400,
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(left: 25.0.w, bottom: 78.w
                            // right: 30.w,
                            ),
                        child: Container(
                            child: index == 0
                                ? SvgPicture.asset(
                                    'assets/images/check.svg',
                                    width: 21.w,
                                    height: 21.h,
                                  )
                                : Container(
                                    height: 21.h,
                                    width: 24.w,
                                    // color: Grey,
                                    decoration: new BoxDecoration(
                                      color: grey9,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  )
                            //
                            ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
