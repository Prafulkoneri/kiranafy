import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/screen/order_summery/cravings_products.dart';
import 'package:local_supper_market/screen/order_summery/order_products.dart';

import '../../const/color.dart';

class OrderSummery extends StatefulWidget {
  const OrderSummery({super.key});

  @override
  State<OrderSummery> createState() => _OrderSummeryState();
}

// enum Fruit { apple, banana }

class _OrderSummeryState extends State<OrderSummery> {
  String radioButtonItem = '';

  // Group Value for Radio Button.
  int id = 1;

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 20.w),
              child: Text(
                "New Balaji Trading Company",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Black1,
                      letterSpacing: .5,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 15.w, bottom: 17.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/location2.svg',
                    width: 23.w,
                    height: 28.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.w,
                    ),
                    child: Text(
                      "Bhairav Nagar, Vishrantwadi\nPune - 411015",
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
            ),
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
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 20.w, right: 19.w),
              child: SizedBox(
                height: 156.h,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    // side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          top: 20.w,
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,/
                          children: [
                            SvgPicture.asset(
                              'assets/images/person.svg',
                              width: 11.w,
                              height: 15.h,
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            Text(
                              'Rachel Green',
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
                            Padding(
                              padding: EdgeInsets.only(left: 75.w),
                              child: SizedBox(
                                height: 21.h,
                                width: 71.w,
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
                                    "Home",
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
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 19.w,
                          top: 20.w,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/phone.svg',
                              width: 14.w,
                              height: 15.h,
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            Text(
                              '+91 986 095 3315',
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 19.w,
                          top: 19.w,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/images/location.svg',
                              color: SplashText1,
                              width: 17.w,
                              height: 17.h,
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            Expanded(
                              child: Text(
                                maxLines: 3,
                                "Nand Nivas Building floor 3 B-3,Lane No.13 Bhatrau Nivas Vishrantwadi Pune -411015.",
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
                      ),
                    ],
                  ),
                ),
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
            Padding(
              padding: EdgeInsets.only(top: 30.w),
              child: Container(
                height: 203.h,
                width: 390.w,
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: 19.w,
                      ),
                      child: CarvingProducts(),
                    )
                  ],
                ),
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
                    "Rs. 200",
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
                    " - Rs. 20",
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
                    "Rs. 0",
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
                    "Rs. 170",
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
                "You will save Rs. 20",
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
                onPressed: () {},
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
