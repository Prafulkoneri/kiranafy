import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_in_view.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/view/s_my_subscription_plans_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SnackType {
  error,
  success,
  invalidated,
  info,

  /// only works in debug mode
  debug,

  /// only works in debug mode
  debugError,
}

class Utils {

// /////////////////////////////////////////.
//   bool ActiveConnection = false;
//   String T = "";
//   Future CheckUserConnection(context, function) async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         ActiveConnection = true;
//         T = "Turn off the data and repress again";
//       }
//     } on SocketException catch (_) {
//       ActiveConnection = false;
//       print("not connected");

//       Utils().showInternetConnectionDailog(context, function);
//       return;
//     }
//   }

//   showInternetConnectionDailog(BuildContext context, function) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             backgroundColor: Color(0xffFFFFFF),
//             // shape: ,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10))),

//             // scrollable: true,
//             child: Container(
//               height: 205.h,
//               // width: 400.w,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Flexible(
//                     child: Text(
//                       "Please Connect to the internet",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.dmSans(
//                         textStyle: TextStyle(
//                             color: Color(0xff006F94),
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 37.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: 19.w,
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () async {
//                             SharedPreferences pref =
//                                 await SharedPreferences.getInstance();
//                             function;
//                             // pref.clear();
//                             // Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //         builder: (context) =>
//                             //             CustomerSignInView()));
//                           },
//                           child: Container(
//                             padding: EdgeInsets.only(
//                                 left: 24.w, right: 24.w, top: 9.w, bottom: 9.w),
//                             decoration: BoxDecoration(
//                                 color: Color(0xff39C19D),
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: Text(
//                               "Go",
//                               textAlign: TextAlign.center,
//                               style: GoogleFonts.dmSans(
//                                 textStyle: TextStyle(
//                                     color: Colors.white,
//                                     // letterSpacing: .5,
//                                     fontSize: 20.sp,
//                                     fontWeight: FontWeight.w700),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10.w,
//                       ),
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             padding: EdgeInsets.only(
//                                 left: 14.w, right: 15.w, top: 9.w, bottom: 9.w),
//                             decoration: BoxDecoration(
//                                 color: Color(0xffEC7074),
//                                 // border: Border.all(width: 1, color: Black),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   "Cancel",
//                                   textAlign: TextAlign.center,
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         color: Colors.white,
//                                         // letterSpacing: .5,
//                                         fontSize: 20.sp,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10.w,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

/////////////////////////////////////////
  showLoginDialog(BuildContext context, message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Color(0xffFFFFFF),
            // shape: ,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),

            // scrollable: true,
            child: Container(
              height: 205.h,
              // width: 400.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "Please login to use this feature!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Color(0xff006F94),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 37.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 19.w,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            // pref.clear();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomerSignInView()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 24.w, right: 24.w, top: 9.w, bottom: 9.w),
                            decoration: BoxDecoration(
                                color: Color(0xff39C19D),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Go",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    // letterSpacing: .5,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 14.w, right: 15.w, top: 9.w, bottom: 9.w),
                            decoration: BoxDecoration(
                                color: Color(0xffEC7074),
                                // border: Border.all(width: 1, color: Black),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Text(
                                  "Cancel",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        // letterSpacing: .5,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

////////////////////////////////////////////////////////////////////
  showByesubscriptionDialog(BuildContext context, message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Color(0xffFFFFFF),
            // shape: ,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),

            // scrollable: true,
            child: Container(
              height: 320.h,
              // width: 400.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: 11.w, right: 10.w, top: 10.w, bottom: 10.w),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Color(0xff000000).withOpacity(0.15)),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.only(
                        left: 82.w, right: 78.w, top: 30, bottom: 19),
                    child: Image(
                      image: AssetImage(
                        "assets/images/order_detail_condition.png",
                      ),
                      fit: BoxFit.cover,
                      // width: 168.w,
                      // height: 135.h,
                    ),
                  ),
                  // SizedBox(
                  //   height: 37.h,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Renew Subscription",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black,
                                  // letterSpacing: .5,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    ),
                  ),

                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, top: 10.w, right: 10.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "•",
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Text(
                            // softWrap: true,
                            // maxLines: 3,//
                            "Dear Shop Owner, your subscription has expired and your shop listing is currently inactive on customer app, Please renew to continue using the services. On successful subscription activation, your shop will be reactivated and made visible on the customer app. ",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black1,
                                  // height: 1.5,
                                  // letterSpacing:
                                  //     0.5,
                                  // overflow: TextOverflow.ellipsis,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  PrimaryButton(
                      width: 108.h,
                      height: 30,
                      color: SplashText,
                      child: Text(
                        "Okay",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Colors.white,

                              // letterSpacing: .05,
                              // overflow: TextOverflow.ellipsis,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        final readMainScreen = Provider.of<SMainScreenController>(context, listen: false);
                        readMainScreen.onNavigation(
                            0,
                            SSubscriptionScreenView(
                                loggedIn: true,
                                routeName:
                               "dashboard"),
                            context);
                        readMainScreen.hideBottomNavigationBar();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SSubscriptionScreenView(
                        //             loggedIn: true, routeName: "dashboard")));

                        //   4,
                        //   SMySubscriptionView(
                        //     screenName: "accounts",
                        //   ),
                        //   context);
                        // Navigator.pop(
                        //     context);
                        // readMain.onNavigation(
                        //     2,
                        //     OrderSummaryView(
                        //       route:
                        //           "cartDetail",
                        //       isRefresh:
                        //           true,
                        //       cartId: watch
                        //           .orderCartId
                        //           .toString(),
                        //       shopId: watch
                        //           .shopDetailData
                        //           ?.id
                        //           .toString(),
                        //     ),
                        //     context);
                        //
                        // readMain.hideBottomNavigationBar();

                        // Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           OrderSummaryView(
                        //             route:
                        //                 "cartDetail",
                        //             isRefresh:
                        //                 true,
                        //             cartId: watch
                        //                 .orderCartId
                        //                 .toString(),
                        //             shopId: watch
                        //                 .shopDetailData
                        //                 ?.id
                        //                 .toString(),
                        //           )),
                        // );
                        // your code
                      }),
                ],
              ),
            ),
          );
        });
  }
///////////////////////////////////////////////////////////////////
  // Widget showNoInternetDialog(context) {
  //   print("hello");
  //   return Scaffold(
  //     backgroundColor: Color(0xffFFFFFF),
  //     // shape: ,

  //     // scrollable: true,
  //     body: Container(
  //       height: 205.h,
  //       // width: 400.w,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Flexible(
  //             child: Text(
  //               "Please Connect to internet",
  //               textAlign: TextAlign.center,
  //               style: GoogleFonts.dmSans(
  //                 textStyle: TextStyle(
  //                     color: Color(0xff006F94),
  //                     fontSize: 18.sp,
  //                     fontWeight: FontWeight.w700),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 37.h,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               SizedBox(
  //                 width: 19.w,
  //               ),
  //               Expanded(
  //                 child: GestureDetector(
  //                   onTap: () async {
  //                     // function();
  //                   },
  //                   child: Container(
  //                     padding: EdgeInsets.only(
  //                         left: 24.w, right: 24.w, top: 9.w, bottom: 9.w),
  //                     decoration: BoxDecoration(
  //                         color: Color(0xff39C19D),
  //                         borderRadius: BorderRadius.circular(8)),
  //                     child: Text(
  //                       "Retry",
  //                       textAlign: TextAlign.center,
  //                       style: GoogleFonts.dmSans(
  //                         textStyle: TextStyle(
  //                             color: Colors.white,
  //                             // letterSpacing: .5,
  //                             fontSize: 20.sp,
  //                             fontWeight: FontWeight.w700),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 19.w,
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  logoutUser(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => OnBoardingScreenView()));
  }

  static ScaffoldFeatureController showPrimarySnackbar(
      BuildContext context, text,
      {SnackType? type}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    Color? color, textColor;
    switch (type) {
      case SnackType.error:
        debugPrint('\x1B[35mError: $text\x1B[0m');

        color = const Color(0xFFDC3545);
        textColor = Colors.white;
        break;
      case SnackType.invalidated:
        debugPrint('\x1B[35mInvalidated: $text\x1B[0m');

        color = const Color(0xFFDC3545);
        textColor = Colors.white;
        break;
      case SnackType.success:
        color = const Color(0xFF28A745);
        textColor = Colors.white;
        break;
      case SnackType.info:
        color = Colors.red;
        break;
      case SnackType.debug:
        if (kReleaseMode) break;
        debugPrint('\x1B[33mDebug: $text\x1B[0m');
        color = const Color(0xFFFFC107);
        textColor = const Color(0xFF343A40);
        text = 'Debug: $text';
        break;
      case SnackType.debugError:
        if (kReleaseMode) break;
        debugPrint('\x1B[31mDebugError: $text\x1B[0m');
        color = const Color.fromARGB(255, 7, 110, 255);
        textColor = Colors.white;
        text = 'Debug Error: $text';
        break;
      default:
        color = Colors.grey;
        break;
    }

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // margin: isOverSheet ? EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.6) : null,
        behavior: SnackBarBehavior.floating,
        // margin: EdgeInsets.only(bottom: 83.w),
        // duration: Duration(seconds:1),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        content: Text(
          text ?? '',
          style: TextStyle(color: textColor, fontSize: 14.sp),
          maxLines: 4,
        ),
        backgroundColor: color,
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
