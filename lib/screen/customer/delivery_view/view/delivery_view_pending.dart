import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/order_summary/order_products.dart';

class OrderPendingView extends StatelessWidget {
  const OrderPendingView({super.key});

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
            "Order",
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 54.w,
                // ),
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
                                  //     SvgPicture.asset(
                                  //         "assets/icons/fav_selected.svg",
                                  //         width: 26.w,
                                  //         height: 14.h,
                                  //       )
                                  //     :
                                  SvgPicture.asset(
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
              ],
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          Divider(thickness: 1, color: grey2),
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 19.w, right: 17.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID: LSM012334",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black,
                        letterSpacing: .5,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                // SizedBox(
                //   height: 22.h,
                //   width: 80.w,
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       elevation: MaterialStateProperty.all(0),
                //       // backgroundColor: ,
                //       backgroundColor: MaterialStateProperty.all(Colors.white),
                //       shape: MaterialStateProperty.all(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           side: BorderSide(
                //             color: Yellow,
                //             // width: 1,
                //           ),
                //         ),
                //       ),
                //     ),
                //     onPressed: () {},
                //     child: Text(
                //       "Pending",
                //       style: GoogleFonts.dmSans(
                //         textStyle: TextStyle(
                //             color: Yellow,
                //             // letterSpacing: .5,
                //             fontSize: 12.sp,
                //             fontWeight: FontWeight.w700),
                //       ),
                //     ),

                //     //
                //   ),
                // ),
                SizedBox(
                  height: 22.h,
                  width: 85.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      // backgroundColor: ,
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Red,
                            // width: 1,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Cancelled",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Red,
                            // letterSpacing: .5,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    //
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 11.h,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 19.w,
            ),
            child: Text(
              "28 March 2023    11:34 am",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black,
                    // letterSpacing: .5,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
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
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 19.w),
            child: Text(
              // maxLines: 3,
              "Expected Delivery Date & Slot",
              // textAlign: TextAlign.start,
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    // height: 1.5,
                    color: black,
                    // letterSpacing: .05,
                    // overflow: TextOverflow.ellipsis,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 19.w),
            child: Text(
              // maxLines: 3,
              "29 March 2023",
              // textAlign: TextAlign.start,
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    // height: 1.5,
                    color: SplashText,
                    // letterSpacing: .05,
                    // overflow: TextOverflow.ellipsis,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 19.w, right: 19.w),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "9:00 am - 12:00 pm",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  // height: 30.h,
                  width: 96.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      // backgroundColor: ,
                      backgroundColor: MaterialStateProperty.all(
                          SplashText.withOpacity(0.3)),
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
                      "Track Order",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            // letterSpacing: .5,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    //
                  ),
                ),
              ],
            ),
          ),
          //////////////
          Container(
            padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Details",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black1,
                        // letterSpacing: .5,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Divider(
                  // height: 100,
                  color: grey2,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                OrderProducts(),
                Row(
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
                      "Rs",
                      //  ${watch.orderFinalTotals?.subTotal}",
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
                SizedBox(
                  height: 10.w,
                ),
                Divider(
                  // height: 100,
                  color: grey2,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                Row(
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
                      "Rs ",
                      //  ${watch.orderFinalTotals?.couponDiscount}",
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
                SizedBox(
                  height: 10.w,
                ),
                Row(
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
                      "Rs.",
                      //  ${watch.orderFinalTotals?.deliveryCharges}",
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
                SizedBox(
                  height: 10.w,
                ),
                Divider(
                  // height: 100,
                  color: grey2,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                Row(
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
                      "Rs. ",
                      // ${watch.orderFinalTotals?.total}",
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
                SizedBox(
                  height: 10.w,
                ),
                Divider(
                  // height: 100,
                  color: grey2,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                SizedBox(
                  height: 10.w,
                ),
                Container(
                  child: Text(
                    "You will save Rs.",
                    //  ${watch.orderFinalTotals?.productTotalDiscount}",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: SplashText,
                          // letterSpacing: .5,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //////////////////
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 19.w,
            ),
            child: Text(
              "Mode of Payment",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black,
                    // letterSpacing: .5,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 19.w,
            ),
            child: Text(
              "QR Code",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: SplashText,
                    // letterSpacing: .5,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),

          Container(
            padding: EdgeInsets.only(
              left: 19.w,
            ),
            child: Text(
              "Transaction ID : 436287101123",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black,
                    // letterSpacing: .5,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 26.h,
          ),
          // Container(
          //   padding: EdgeInsets.only(
          //       left: 19.w, right: 19.w, top: 15.w, bottom: 15.w),
          //   // height: 111.h,
          //   width: ScreenUtil().screenWidth,
          //   color: lightblue,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     // mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Refund Amount",
          //             style: GoogleFonts.dmSans(
          //               textStyle: TextStyle(
          //                   color: Black,
          //                   // letterSpacing: .5,
          //                   fontSize: 18.sp,
          //                   fontWeight: FontWeight.w700),
          //             ),
          //           ),
          //           SizedBox(
          //             height: 22.h,
          //             // width: 126.w,
          //             child: ElevatedButton(
          //               style: ButtonStyle(
          //                 elevation: MaterialStateProperty.all(0),
          //                 // backgroundColor: ,
          //                 backgroundColor:
          //                     MaterialStateProperty.all(Colors.white),
          //                 shape: MaterialStateProperty.all(
          //                   RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                     side: BorderSide(
          //                       color: SplashText1,
          //                       // width: 1,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               onPressed: () {},
          //               child: Text(
          //                 "Payment Pending",
          //                 style: GoogleFonts.dmSans(
          //                   textStyle: TextStyle(
          //                       color: SplashText1,
          //                       // letterSpacing: .5,
          //                       fontSize: 12.sp,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ),

          //               //
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 13.w),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Text(
          //             "INR 3000",
          //             style: GoogleFonts.dmSans(
          //               textStyle: TextStyle(
          //                   color: Black,
          //                   // letterSpacing: .5,
          //                   fontSize: 18.sp,
          //                   fontWeight: FontWeight.w700),
          //             ),
          //           ),
          //           Text(
          //             "28 March 2023   11:34 am",
          //             style: GoogleFonts.dmSans(
          //               textStyle: TextStyle(
          //                   color: Black,
          //                   // letterSpacing: .5,
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.w400),
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 8.h,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           Text(
          //             "Transaction ID : 647393025546",
          //             style: GoogleFonts.dmSans(
          //               textStyle: TextStyle(
          //                   color: Black,
          //                   // letterSpacing: .5,
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.w400),
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // )
          Container(
            padding: EdgeInsets.only(
                left: 19.w, right: 19.w, top: 25.w, bottom: 15.w),
            // height: 250.h,
            // width: 390.w,
            width: ScreenUtil().screenWidth,
            color: lightblue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Refund Amount",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black,
                        // letterSpacing: .5,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                // SizedBox(width: 10.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "INR 3000",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            // letterSpacing: .5,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                      // width: 126.w,
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
                                color: SplashText1,
                                // width: 1,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Payment Pending",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: SplashText1,
                                // letterSpacing: .5,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

                        //
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      // height: 35.h,
                      width: 155.w,
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
                          "Yes Received",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // letterSpacing: .5,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

                        //
                      ),
                    ),
                    // SizedBox(
                    //   width: 25.w,
                    // ),
                    SizedBox(
                      // height: 35.h,
                      width: 155.w,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          // backgroundColor: ,
                          backgroundColor: MaterialStateProperty.all(Red),
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
                          "Not Received",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // letterSpacing: .5,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

                        //
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Note",
                  style: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                        // color: SplashTex
                        letterSpacing: .5,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 20.w),
                          child: Icon(
                            Icons.circle_rounded,
                            size: 5.w,
                          )),
                      SizedBox(width: 10.w),
                      Flexible(
                        child: Text(
                          // softWrap: true,
                          // maxLines: 3,//
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sit nunc, netus ac vulputate sed",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: black,
                                // height: 1.5,

                                // letterSpacing: .05,
                                // overflow: TextOverflow.ellipsis,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.circle_rounded,
                //       size: 5.w,
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Text(
                //       "Lorem ipsum dolor sit amet, consectetur",
                //       style: GoogleFonts.dmSans(
                //         textStyle: TextStyle(
                //             height: 1.5,
                //             color: black,
                //             letterSpacing: .5,
                //             fontSize: 14.sp,
                //             fontWeight: FontWeight.w400),
                //       ),
                //     )
                //   ],
                // ),
                // Row(
                //   children: [
                //     Padding(
                //         padding: EdgeInsets.only(bottom: 0.w),
                //         child: Icon(
                //           Icons.circle_rounded,
                //           size: 5.w,
                //         )),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Text(
                //       "Lorem ipsum dolor sit amet, consectetur",
                //       style: GoogleFonts.dmSans(
                //         textStyle: TextStyle(
                //             height: 1.5,
                //             color: black,
                //             letterSpacing: .5,
                //             fontSize: 14.sp,
                //             fontWeight: FontWeight.w400),
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          )
        ])));
  }
}
