import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

import '../order_status/order_status.dart';

class OrderPayment extends StatefulWidget {
  const OrderPayment({super.key});

  @override
  State<OrderPayment> createState() => _OrderPaymentState();
}

class _OrderPaymentState extends State<OrderPayment> {
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
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          toolbarHeight: 65,
          // backgroundColor: kappbar,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Order Payment",
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w, top: 20.w),
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
            SizedBox(
              height: 7.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.w, bottom: 15.w),
                  child: SvgPicture.asset(
                    'assets/images/location2.svg',
                    // width: 15.w,
                    // height: 19.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, bottom: 10.w),
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
            Divider(thickness: 1, color: grey2),
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 14.w, right: 19.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "4 Items",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          letterSpacing: .5,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    "Total Amount",
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
              padding: EdgeInsets.only(left: 19.w, top: 14.w, right: 19.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "You will save Rs. 20",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: SplashText,
                          letterSpacing: .5,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    "Rs. 170",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          letterSpacing: .5,
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 19.w,
                top: 40.w,
              ),
              child: Text(
                "Mode of Payment",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Black,
                      letterSpacing: .5,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
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
                        radioButtonItem = 'Cash on Delivery';
                        id = 1;
                      });
                    },
                  ),
                  Text(
                    'Cash on Delivery',
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
              padding: EdgeInsets.only(
                left: 5.w,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Radio(
                    fillColor:
                        MaterialStateColor.resolveWith((states) => Button1),
                    value: 2,
                    groupValue: id,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'UPI ID  -  9175712289@ybl';
                        id = 2;
                      });
                    },
                  ),
                  Text(
                    'UPI ID  -  9175712289@ybl',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0.w),
                    child: SizedBox(
                      width: 74.w,
                      height: 19.h,
                      child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //   //<-- SEE HERE
                        //   side: BorderSide(
                        //     width: 3.0,
                        //   ),
                        // ),
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),

                          // backgroundColor: ,
                          backgroundColor: MaterialStateProperty.all(
                              SplashText.withOpacity(0.3)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(width: 1, color: SplashText),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Copy",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: SplashText,
                                    // letterSpacing: .5,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ), // <-- Text
                            SizedBox(
                              width: 5.w,
                            ),
                            SvgPicture.asset(
                              'assets/images/svg2.svg',
                              width: 11.w,
                              height: 11.h,
                            ),
                          ],
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
                left: 5.w,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Radio(
                    fillColor:
                        MaterialStateColor.resolveWith((states) => Button1),
                    value: 3,
                    groupValue: id,
                    onChanged: (val) {
                      setState(() {
                        radioButtonItem = 'Payment QR Code';
                        id = 3;
                      });
                    },
                  ),
                  Text(
                    'Payment QR Code',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/qrcode.png",
                    height: 165.h,
                    width: 165.w,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 5.w),
              child: Text(
                'Payment Transaction ID ',
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Black,
                      letterSpacing: .5,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 5.w),
              child: SizedBox(
                height: 48.h,
                width: 352.w,
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 2,
                        style: BorderStyle.none,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: grey6), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 19.w, top: 5.w),
              child: Text(
                'Copy and paste your payment successful transaction details on above input box',
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: grey8,
                      letterSpacing: .5,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.w),
              child: SizedBox(
                height: 45.h,
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
                      MaterialPageRoute(builder: (context) => OderStatus()),
                    );
                  },
                  child: Text(
                    "Submit Order",
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
              ),
            )
          ]),
        ));
  }
}
