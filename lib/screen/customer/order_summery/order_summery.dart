import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/order_payment/order_payment.dart';
import 'package:local_supper_market/screen/customer/order_summery/controller/order_summery_controller.dart';
import 'package:local_supper_market/screen/customer/order_summery/cravings_products.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen_view.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:provider/provider.dart';

import 'order_products.dart';

class OrderSummery extends StatefulWidget {
  final String? shopId;
  final String? cartId;
  const OrderSummery({super.key, this.cartId, this.shopId});

  @override
  State<OrderSummery> createState() => _OrderSummeryState();
}

// enum Fruit { apple, banana }

class _OrderSummeryState extends State<OrderSummery> {
  String radioButtonItem = '';

  // Group Value for Radio Button.
  int id = 1;
  @override
  void initState() {
    print(widget.shopId);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<OrderSummeryController>().initState(
            context,
            widget.shopId,
            widget.cartId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<OrderSummeryController>();
    final read = context.read<OrderSummeryController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          // Status bar color
          statusBarColor: kstatusbar,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        toolbarHeight: 65,
        // backgroundColor: kappbar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Order Summary",
          style: GoogleFonts.dmSans(
            textStyle: const TextStyle(
                color: Black,
                letterSpacing: .5,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: <Color>[
                  kstatusbar.withOpacity(0.55),
                  kstatusbar.withOpacity(0.98),
                ]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 17.w, top: 20.w),
              child: Text(
                "${watch.shopDetailData?.shopName}",

                // "${watch.shopDetailData?.shopName}",

                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Black1,
                      letterSpacing: .5,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.w),
              // height: 70.h,
              // decoration: BoxDecoration(
              //   border: Border(
              //     // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
              //     bottom: BorderSide(width: 1, color: grey2),
              //   ),
              // ),

              // color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/location2.svg',
                        width: 23.w,
                        height: 28.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        width: 200.w,
                        child: Text(
                          // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                          "${watch.shopDetailData?.shopAddress}\n${watch.shopDetailData?.cityName} - ${watch.shopDetailData?.shopPincode}",
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Black,
                                // letterSpacing: .5,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          read.launchPhone(
                              watch.shopDetailData?.shopOwnerSupportNumber ??
                                  "",
                              context);
                        },
                        child: SvgPicture.asset(
                          'assets/images/call.svg',
                          // width: 15.w,
                          // height: 19.h,
                        ),
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      InkWell(
                        onTap: () {
                          watch.favAllShop
                              ? read.removeAllShopFavList(
                                  context, watch.shopDetailData?.id)
                              : read.updateAllShopFavList(
                                  context, watch.shopDetailData?.id);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 13.w, right: 13.w, top: 14.w, bottom: 14.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff4689EC),
                          ),
                          child: watch.favAllShop
                              ? SvgPicture.asset(
                                  "assets/icons/fav_selected.svg",
                                  width: 26.w,
                                  height: 14.h,
                                )
                              : SvgPicture.asset(
                                  "assets/images/favorite.svg",
                                  width: 26.w,
                                  height: 14.h,
                                ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 16.w, top: 15.w, bottom: 17.w),
            //   child: Row(
            //     children: [
            //       SvgPicture.asset(
            //         'assets/images/location2.svg',
            //         width: 23.w,
            //         height: 28.h,
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(
            //           left: 8.w,
            //         ),
            //         child: Text(
            //           "Bhairav Nagar, Vishrantwadi\nPune - 411015",
            //           style: GoogleFonts.dmSans(
            //             textStyle: TextStyle(
            //                 color: Black,
            //                 letterSpacing: .5,
            //                 fontSize: 13.sp,
            //                 fontWeight: FontWeight.w400),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Divider(
              // height: 100,
              color: grey2,
              thickness: 1,
              indent: 5,
              endIndent: 5,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, top: 10.w),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Radio(
                    fillColor:
                        MaterialStateColor.resolveWith((states) => Button1),
                    value: 1,
                    groupValue: id,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'Delivery To';
                        id = 1;
                      });
                    },
                  ),
                  Text(
                    'Delivery To',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          letterSpacing: .5,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.w),
                    child: Radio(
                      fillColor:
                          MaterialStateColor.resolveWith((states) => Button1),
                      value: 2,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          radioButtonItem = 'Self Pickup';
                          id = 2;
                        });
                      },
                    ),
                  ),
                  Text(
                    'Self Pickup',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          letterSpacing: .5,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            //  Container(
            //           padding: EdgeInsets.only(right: 28.w),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: <Widget>[
            //               Row(
            //                 children: [
            //                   SecondaryRadioButton(
            //                       value: "full_order_amount",
            //                       groupValue: read.groupValue,
            //                       onChanged: (value) {
            //                         read.onRadioBtnToggled(value);
            //                       },
            //                       leading: ""),
            //                   SizedBox(
            //                     width: 10.w,
            //                   ),
            //                   Text(
            //                     'Full Order Amount',
            //                     style: GoogleFonts.dmSans(
            //                       textStyle: TextStyle(
            //                           color: Black,
            //                           // letterSpacing: .5,
            //                           fontSize: 12.sp,
            //                           fontWeight: FontWeight.w400),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 children: [
            //                   SecondaryRadioButton(
            //                       value: "category_and_product",
            //                       groupValue: watch.groupValue,
            //                       onChanged: (value) {
            //                         read.onRadioBtnToggled(value);
            //                       },
            //                       leading: ""),
            //                   SizedBox(
            //                     width: 10.w,
            //                   ),
            //                   Text(
            //                     'Category & Product',
            //                     style: GoogleFonts.dmSans(
            //                       textStyle: TextStyle(
            //                           color: Black,
            //                           fontSize: 12.sp,
            //                           fontWeight: FontWeight.w400),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 20.w, right: 19.w),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: watch.customerAddress?.length ?? 0,
                itemBuilder: (context, index) {
                  final element = watch.customerAddress![index];
                  return Container(
                    // padding: EdgeInsets.only(bottom: 20.w),
                    // height: 156.h,
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        // side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: 20.w, left: 20.w, right: 20.w, top: 20.w),
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
                                      "${element.customerName}",
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
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: lighrgreen,
                                            // width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "${element.deliveryAddressType}",
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
                                  '${element.mobileNo}',
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
                                    maxLines: 3,
                                    "${element.address1} \n${element.address2} ",
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
                            SizedBox(
                              height: 10.w,
                            ),
                            element.deliveryAddressIsDefault == "yes"
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        'Default',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              // letterSpacing: .5,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  );
                },
                // child:
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 32.w),
              child: Text(
                "Delivery Date",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      // height: 1.5,
                      color: black,
                      // letterSpacing: .05,
                      // overflow: TextOverflow.ellipsis,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
              child: Container(
                width: 352.w,
                height: 65.h,
                decoration: BoxDecoration(
                    border: Border.all(color: grey3),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, top: 8.w, right: 92.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date:",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  // height: 1.5,
                                  color: black,
                                  letterSpacing: .05,
                                  // overflow: TextOverflow.ellipsis,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            "Delivery Slot",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  // height: 1.5,
                                  color: black,
                                  letterSpacing: .05,
                                  // overflow: TextOverflow.ellipsis,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        top: 8.w,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "25 Nov 2021",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  // height: 1.5,
                                  color: black,
                                  letterSpacing: .05,
                                  // overflow: TextOverflow.ellipsis,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            'assets/images/calender.svg',
                            width: 12.w,
                            height: 14.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Text(
                              "9:00 am - 12:00 pm",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    // height: 1.5,
                                    color: black,
                                    letterSpacing: .05,
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            'assets/images/pencil.svg',
                            width: 12.w,
                            height: 14.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 19.w,
                top: 30.w,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Available Coupon Code",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          // height: 1.5,
                          color: black,
                          letterSpacing: .05,
                          // overflow: TextOverflow.ellipsis,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    width: 45.w,
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 91.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        // backgroundColor: ,
                        backgroundColor: MaterialStateProperty.all(lightsky),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: SplashText,
                              // width: 1,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Get Code",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: SplashText,
                              // letterSpacing: .5,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      //
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 18.w,
                top: 10.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Coupon Code",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          // letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 11.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 200.w,
                        height: 34.w,
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: grey4,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      SizedBox(
                        height: 34.h,
                        width: 91.w,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            // backgroundColor: ,
                            backgroundColor:
                                MaterialStateProperty.all(SplashText),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                // side: BorderSide(
                                //   color: SplashText,
                                //   // width: 1,
                                // ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Remove",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: .5,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),

                          //
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      // left: 18.w,
                      top: 10.w,
                    ),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Congratulations!!',
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: SplashText,
                                // letterSpacing: .5,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        TextSpan(
                          text: '10% Discount applied successfully.',
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: SplashText,
                                // letterSpacing: .5,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.w,
            ),
            Container(
              // height: 203.h,
              width: ScreenUtil().screenWidth,
              color: Coupons,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.w, left: 18.w),
                    child: Text(
                      "Fulfil your cravings",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: SplashText,
                            // letterSpacing: .5,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.w, bottom: 15.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(
                            watch.fullFillYourCravings?.length ?? 0, (index) {
                          final element = watch.fullFillYourCravings?[index];
                          return watch.fullFillYourCravings?[index].mrpPrice !=
                                      "" &&
                                  watch.fullFillYourCravings?[index]
                                          .offerPrice !=
                                      "" &&
                                  int.parse(element?.offerPrice ?? "0") <
                                      int.parse(element?.mrpPrice ?? "0")
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainScreenView(
                                                      index: 1,
                                                      screenName:
                                                          ProductScreenView(
                                                        categoryId: element
                                                            ?.categoryId
                                                            .toString(),
                                                        productId: element?.id
                                                            .toString(),
                                                        shopId: element?.shopId,
                                                      ))),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            // color: Colors.white,
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //       color: Colors.black
                                            //           .withOpacity(0.03.w),
                                            //       blurRadius: 5,
                                            //       spreadRadius: 0,
                                            //       offset: Offset(0, 3)),
                                            // ],
                                            ),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.w)),
                                          elevation: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.w),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    element?.discountPercentage !=
                                                            ""
                                                        ? Container(
                                                            width: 60.w,
                                                            height: 20.h,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    lightgreen,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.w))),
                                                            child: Center(
                                                              child: Text(
                                                                  "${element?.discountPercentage} off",
                                                                  // textAlign: TextAlign.center,
                                                                  style:
                                                                      GoogleFonts
                                                                          .dmSans(
                                                                    textStyle: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        letterSpacing:
                                                                            .5,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  )),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    element?.productImagePath ==
                                                            ""
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
                                                            child:
                                                                Image.network(
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
                                                        style:
                                                            GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                            color: Black1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            // letterSpacing: .5,
                                                            fontSize: 16.sp,

                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.w,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        element?.mrpPrice != ""
                                                            ? Text(
                                                                '\u{20B9}${element?.mrpPrice}',
                                                                style: GoogleFonts.dmSans(
                                                                    textStyle: element?.offerPrice != "" &&
                                                                            element?.offerPrice !=
                                                                                element
                                                                                    ?.mrpPrice
                                                                        ? TextStyle(
                                                                            decoration: TextDecoration
                                                                                .lineThrough,
                                                                            color:
                                                                                Black1,
                                                                            letterSpacing:
                                                                                .5,
                                                                            fontSize: 12
                                                                                .sp,
                                                                            fontWeight: FontWeight
                                                                                .w400)
                                                                        : TextStyle(
                                                                            color:
                                                                                Black1,
                                                                            letterSpacing:
                                                                                .5,
                                                                            fontSize:
                                                                                12.sp,
                                                                            fontWeight: FontWeight.w400)))
                                                            : Text(""),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        element?.offerPrice !=
                                                                    "" &&
                                                                element?.offerPrice !=
                                                                    element
                                                                        ?.mrpPrice
                                                            ? Text(
                                                                '\u{20B9}${element?.offerPrice}',
                                                                style:
                                                                    GoogleFonts
                                                                        .dmSans(
                                                                  textStyle: TextStyle(
                                                                      // decoration:
                                                                      // TextDecoration.lineThrough,
                                                                      color: Black,
                                                                      letterSpacing: .5,
                                                                      fontSize: 13.sp,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              )
                                                            : Text(""),
                                                      ],
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        read.addToCart(
                                                            element
                                                                ?.productType,
                                                            element
                                                                ?.productUnitId,
                                                            element?.shopId,
                                                            context);
                                                      },
                                                      child: SvgPicture.asset(
                                                        'assets/images/add.svg',
                                                        // width: 15.w,
                                                        // height: 19.h,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
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
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: 19.w,
                  //   ),
                  //   child: CarvingProducts(),
                  // )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.w),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 19.w),
                    child: Text(
                      "Product Details",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black1,
                            // letterSpacing: .5,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 19.w, right: 19.w),
                    child: Divider(
                      // height: 100,
                      color: grey2,
                      thickness: 1,
                      // indent: 10,
                      // endIndent: 5,
                    ),
                  ),
                  OrderProducts()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sub Total",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          // letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    "Rs ${watch.orderFinalTotals?.subTotal}",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: grey5,
                          // letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 19.w, right: 19.w, bottom: 10.w, top: 10.w),
              child: Divider(
                // height: 100,
                color: grey2,
                thickness: 1,
                // indent: 10,
                // endIndent: 5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Discount!!',
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black1,
                              // letterSpacing: .5,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      TextSpan(
                        text: '  (PROMO0001AFF) ',
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: SplashText,
                              // letterSpacing: .5,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ]),
                  ),
                  Text(
                    "Rs  ${watch.orderFinalTotals?.couponDiscount}",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: grey5,
                          // letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Charges",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          // letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    "Rs. ${watch.orderFinalTotals?.deliveryCharges}",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: grey5,
                          // letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 19.w, right: 19.w, bottom: 10.w, top: 10.w),
              child: Divider(
                // height: 100,
                color: grey2,
                thickness: 1,
                // indent: 10,
                // endIndent: 5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          // letterSpacing: .5,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    "Rs. ${watch.orderFinalTotals?.total}",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          // letterSpacing: .5,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 19.w,
                right: 19.w,
                // bottom: 10.w,
              ),
              child: Divider(
                // height: 100,
                color: grey2,
                thickness: 1,
                // indent: 10,
                // endIndent: 5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 10.w, bottom: 27.w),
              child: Text(
                "You will save Rs. ${watch.orderFinalTotals?.productTotalDiscount}",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: SplashText,
                      // letterSpacing: .5,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 51.h,
              width: 390.w,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  // backgroundColor: ,
                  backgroundColor: MaterialStateProperty.all(SplashText),
                  // shape: MaterialStateProperty.all(
                  //   RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     // side: BorderSide(
                  //     //   color: SplashText,
                  //     //   // width: 1,
                  //     // ),
                  //   ),
                  // ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPayment()),
                  );
                },

                child: Text(
                  "Confirm",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Colors.white,
                        // letterSpacing: .5,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),

                //
              ),
            )
          ],
        ),
      ),
    );
  }
}
