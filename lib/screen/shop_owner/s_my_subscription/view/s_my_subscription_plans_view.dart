import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/view/benifits_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/radio_button.dart';

class SMySubscriptionView extends StatefulWidget {
  const SMySubscriptionView({super.key});

  @override
  State<SMySubscriptionView> createState() => _SMySubscriptionViewState();
}

class _SMySubscriptionViewState extends State<SMySubscriptionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "My Subscription",
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          // mainAxisAlignment: M,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18.w, top: 15.w, right: 19.w,bottom: 20.w),
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Custlogin,
                              gradient: LinearGradient(
                                  end: Alignment.topCenter,
                                  begin: Alignment.bottomCenter,
                                  colors: <Color>[
                                    Color(0xff4EC0FA).withOpacity(1),
                                    Color(0xff32DFAC).withOpacity(1),
                                  ]),

                              // border: Border.all(width: 1, color: Black),
                              borderRadius: BorderRadius.circular(10.w)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.w,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 19.w,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "My Current Subscription Plan",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            // letterSpacing: .5,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 22.h,
                                    // width: 68.w,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        // backgroundColor: ,
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            LightGreen1),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            side: BorderSide(
                                              color: DarkGreen1,
                                              // width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        "Activated",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: DarkGreen1,
                                              // letterSpacing: .5,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),

                                      //
                                    ),
                                  ),
                                  SizedBox(
                                    width: 19.w,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40.w,
                              ),
                              // SizedBox(
                              //   height: 22.w,
                              // ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.w),
                                child: Image.asset(
                                  'assets/images/my_subscription_home.png',
                                  // width: 352.w,
                                  // height: 60.h,
                                ),

                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            top: 55.w,
                            left: 17.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Advanced Plan ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 28.sp),
                                ),
                                SizedBox(
                                  height: 6.w,
                                ),
                                Container(
                                  // width: ScreenUtil().screenWidth / 1.23.w,
                                  child: Text(
                                    "Expiry Date : 1st January 2024",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 6.w,
                                ),
                                Text(
                                  "₹ 6000",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 28.sp),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 18.w, top: 15.w, right: 19.w),
                child: Column(
                  children: [
                    Text(
                      "Benefits",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black1,
                            // height: 1.5,

                            // letterSpacing: .05,
                            // overflow: TextOverflow.ellipsis,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 32.w, top: 10.w, right: 34.w),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.circle_rounded,
                              size: 5.w,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Ready item master",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    // height: 1.5,

                                    // letterSpacing: .05,
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/correct.svg")
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.circle_rounded,
                              size: 5.w,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Link customer to your shop",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    // height: 1.5,

                                    // letterSpacing: .05,
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/correct.svg")
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.circle_rounded,
                              size: 5.w,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Order management",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    // height: 1.5,

                                    // letterSpacing: .05,
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/correct.svg")
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.circle_rounded,
                              size: 5.w,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Shop banner design",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    // height: 1.5,

                                    // letterSpacing: .05,
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/correct.svg")
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 19.h,
              ),
              ////////////////////////show more//////////////////


              // Container(
              //   // padding: EdgeInsets.all(100),
              //   child: Column(
              //     children: [
              //       ExpandedTileList.builder(
              //         itemCount: 1,
              //         maxOpened: 1,
              //         reverse: true,
              //         itemBuilder: (context, index, controller) {
              //           return ExpandedTile(
              //             // title: Container(),
              //             theme: const ExpandedTileThemeData(
              //               headerColor: Colors.white,
              //               headerRadius: 24.0,
              //               headerPadding: EdgeInsets.all(24.0),
              //               headerSplashColor: Colors.white,
              //               contentBackgroundColor: Colors.white,
              //               contentPadding: EdgeInsets.all(24.0),
              //               contentRadius: 12.0,
              //             ),
              //             controller: index == 1
              //                 ? controller.copyWith(isExpanded: true)
              //                 : controller,
              //             title: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Text(
              //                   "Show More",
              //                   style: GoogleFonts.dmSans(
              //                     textStyle: TextStyle(
              //                         color: Grey,
              //                         fontSize: 12.sp,
              //                         fontWeight: FontWeight.w400),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: 5.w,
              //                 ),
              //                 SvgPicture.asset("assets/icons/dropdown.svg")
              //               ],
              //             ),
              //             onTap: () {
              //               print(
              //                 "heloo",
              //               );
              //             },
              //             trailing: Container(),
              //             content: Column(
              //               children: [
              //                 Container(
              //                   padding: EdgeInsets.only(
              //                       left: 12.w, top: 0.w, right: 18.w),
              //                   child: Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Row(
              //                         children: [
              //                           Icon(
              //                             Icons.circle_rounded,
              //                             size: 5.w,
              //                           ),
              //                           SizedBox(
              //                             width: 10,
              //                           ),
              //                           Text(
              //                             "Order management",
              //                             textAlign: TextAlign.center,
              //                             style: GoogleFonts.dmSans(
              //                               textStyle: TextStyle(
              //                                   color: Black1,
              //                                   fontSize: 14.sp,
              //                                   fontWeight: FontWeight.w400),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                       Row(
              //                         children: [
              //                           SvgPicture.asset(
              //                               "assets/icons/correct.svg")
              //                         ],
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //                 // TextButton(
              //                 //   onPressed: () {
              //                 //     controller.collapse();
              //                 //   },
              //                 //   child: Text("close it!"),
              //                 // )
              //               ],
              //             ),
              //           );
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 30.h,
              ),
              // BenifitsView()

              Container(
                padding: EdgeInsets.only(left: 18.w, right: 18.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subscription History",
                      // textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black1,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    PrimaryButton(
                      height: 30.h,
                      width: 109.w,
                      // color: Colors.transparent,
                      color: Color(0xff4689EC),
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>SSubscriptionScreenView(loggedIn:true)));
                      },
                      textColor: Colors.white,
                      text: "New Plan",
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 11.w),
                // margin: EdgeInsets.only(left: 15.w, right: 15.w,b top: 4.w),
                child: Column(children: <Widget>[
                  Table(
                    // defaultColumnWidth: FixedColumnWidth(120.0),
                    border: TableBorder(
                        horizontalInside: BorderSide(color: Colors.white, width: 5)),
                    children: [
                      TableRow(
                          children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10.w, //
                              right: 27.w,
                              bottom: 10.w,
                              top: 8.w),
                          color: Color(0xff4EEFC1),
                          child: Text(
                            "Plan",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: SplashText1,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            // left: 15.w,//
                            // right: 27.w,
                              bottom: 10.w,
                              top: 8.w),
                          color: Color(0xff4EEFC1),
                          child: Text(
                            "Duration",
                            //  overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: SplashText1,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            // left: 15.w,//
                            // right: 27.w,
                              bottom: 10.w,
                              top: 8.w),
                          color: Color(0xff4EEFC1),
                          child: Text(
                            "Expiry Date",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: SplashText1,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                              // left: 15.w,//
                                right: 27.w,
                                bottom: 10.w,
                                top: 8.w),
                            color: Color(0xff4EEFC1),
                            child: Center(
                              child: Text(
                                "Amount",
                                style: TextStyle(
                                    color: SplashText1,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            )),
                      ]),

                      /////////////////

                      TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xffF2F2F2),
                          ),
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                  // right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    'Standard',
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: SplashText1,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    '1 Year',
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: SplashText1,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    '12 Jan 2023',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                color: Color(0xffF2F2F2),
                                child: Column(children: [
                                  Text(
                                    '₹ 3500',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xffF2F2F2),
                          ),
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    'Standard',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    '1 Year',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    '12 Jan 2023',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                color: Color(0xffF2F2F2),
                                child: Column(children: [
                                  Text(
                                    '₹ 3500',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xffF2F2F2),
                          ),
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    'Standard',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    '1 Year',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    '12 Jan 2023',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                color: Color(0xffF2F2F2),
                                child: Column(children: [
                                  Text(
                                    '₹ 3500',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xffF2F2F2),
                          ),
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    'Standard',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    '1 Year',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                child: Column(children: [
                                  Text(
                                    '12 Jan 2023',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                            Container(
                                padding: EdgeInsets.only(
                                  // left: 15.w,//
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                color: Color(0xffF2F2F2),
                                child: Column(children: [
                                  Text(
                                    '₹ 3500',
                                    // overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ])),
                          ]),
                    ],
                  ),
                ]),
              )
            ]),
      ),
    );
  }
}
