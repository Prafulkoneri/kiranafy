import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/widget/buttons.dart';

import '../../const/color.dart';
import '../../widget/app_bar.dart';
import '../Home/product_screen.dart';
import '../order_summery/order_summery.dart';

class CartDetail extends StatelessWidget {
  const CartDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.w),
          child: PrimaryAppBar(
            title: "Cart Details",
            action: SvgPicture.asset("assets/images/delete.svg"),
            onActionTap: () {},
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  Padding(
                    padding:
                        EdgeInsets.only(left: 45.h, right: 11.w, bottom: 12.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/call.svg',
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        SvgPicture.asset(
                          'assets/images/fvrt.svg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: grey2),
              Container(
                // height: 360.h,
                // width: 352.w,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductScreen()));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 18.w,
                                  top: index == 0 ? 14.w : 24.w,
                                  right: 17.w),
                              child: Container(
                                // decoration: BoxDecoration(
                                // border: Border.all(
                                //     color: Colors.black.withOpacity(0.07),
                                //     width: 1),

                                //
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.07),
                                      width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 5,
                                        offset: Offset(-.0, 5.0),
                                        spreadRadius: 0),
                                  ],
                                ),
                                height: 95.h,
                                width: 355.w,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                    12.w,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          'assets/images/sprite.png',
                                          width: 39.w,
                                          height: 92.h,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      VerticalDivider(
                                        color: lightgrey,
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        width: 17.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Ariel Washing Powder",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Black1,
                                                        // letterSpacing: .5,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0.91.w,
                                                      horizontal: 7.84.w),
                                                  // width: 60.w,
                                                  // height: 20.h,
                                                  decoration: BoxDecoration(
                                                      color: lightgreen
                                                          .withOpacity(0.6),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.w))),
                                                  child: Center(
                                                    child: Text("50% off",
                                                        // textAlign: TextAlign.center,
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              // letterSpacing:
                                                              //     .5,
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.w,
                                            ),
                                            Text("500mg",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: Grey,
                                                      // letterSpacing: .5,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                            SizedBox(
                                              height: 9.48.w,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Padding(
                                                //   padding: EdgeInsets.only(
                                                //       top: 12.w),
                                                //   child:
                                                Row(
                                                  // crossAxisAlignment:
                                                  //     CrossAxisAlignment.start,
                                                  // mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '\u{20B9}${25.00}',
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Black,
                                                            // letterSpacing:
                                                            //     .5,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(
                                                      '\u{20B9}${25.00}',
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            // decoration:
                                                            // TextDecoration.lineThrough,
                                                            color: Black,
                                                            // letterSpacing:
                                                            //     .5,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                  // ),
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/minus.svg',
                                                      // width: 30.w,
                                                      // height: 30.h,
                                                    ),
                                                    SizedBox(
                                                      width: 12.w,
                                                    ),
                                                    Text("1"),
                                                    SizedBox(
                                                      width: 12.w,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/images/add.svg',
                                                      // width: 30.w,
                                                      // height: 30.h,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // decoration: BoxDecoration(
                                //   // color: Colors.blueAccent,
                                //   border: Border.all(width: 1, color: grey1),
                                // ),
                                // decoration: BoxDecoration(color: Black),
                              ),
                            ),
                            index == 4
                                ? SizedBox(
                                    height: 20.h,
                                  )
                                : Container()
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ))),
          // SizedBox(
          //   height: 40.h,
          // ),
          Container(
            padding:
                EdgeInsets.only(left: 20.w, bottom: 6, right: 15.w, top: 6.w),
            height: 30.h,
            width: 390.w,
            color: Button1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          // letterSpacing: .5,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700),
                    )),
                Text("4 Items",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          // letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 20.w, top: 12.w, right: 15.w, bottom: 8.w),
            height: 70.h,
            width: 390.w,
            color: SplashText,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("₹132.00",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              // letterSpacing: .5,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700),
                        )),
                    SizedBox(
                      height: 8.w,
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/check1.svg',
                          height: 18.w,
                          width: 18.w,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text("saved ₹132.00",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: .5,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    ),
                  ],
                ),
                Container(
                  child: PrimaryButton(
                      color: Colors.white,
                      height: 36.h,
                      width: 160.w,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: Text("saved ₹132.00",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700),
                                    )),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Name',
                                            icon: Icon(Icons.account_box),
                                          ),
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                            icon: Icon(Icons.email),
                                          ),
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Message',
                                            icon: Icon(Icons.message),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      child: Text("Submit"),
                                      onPressed: () {
                                        // your code
                                      })
                                ],
                              );
                            });
                      },
                      text: 'Place Order',
                      textColor: SplashText1,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ]));
  }
}
