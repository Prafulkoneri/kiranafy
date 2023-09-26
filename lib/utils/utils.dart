

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/screen/customer/auth/view/customer_sign_in_view.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
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

  showLoginDialog(BuildContext context,message){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Color(0xffFFFFFF),
            // shape: ,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(10))),

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
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 19.w,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            SharedPreferences pref=await SharedPreferences.getInstance();
                            // pref.clear();
                           Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerSignInView()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 24.w,
                                right: 24.w,
                                top: 9.w,
                                bottom: 9.w),
                            decoration: BoxDecoration(
                                color: Color(0xff39C19D),
                                borderRadius:
                                BorderRadius.circular(8)),
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
                                left: 14.w,
                                right: 15.w,
                                top: 9.w,
                                bottom: 9.w),
                            decoration: BoxDecoration(
                                color: Color(0xffEC7074),
                                // border: Border.all(width: 1, color: Black),
                                borderRadius:
                                BorderRadius.circular(10)),
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
                                        fontWeight:
                                        FontWeight.w700),
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

  Widget showNoInternetDialog(context){
    print("hello");
   return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      // shape: ,


      // scrollable: true,
      body: Container(
        height: 205.h,
        // width: 400.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                "Please Connect to internet",
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
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 19.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      // function();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                          top: 9.w,
                          bottom: 9.w),
                      decoration: BoxDecoration(
                          color: Color(0xff39C19D),
                          borderRadius:
                          BorderRadius.circular(8)),
                      child: Text(
                        "Retry",
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
                  width: 19.w,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  logoutUser(BuildContext context)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.clear();
    Navigator.push(context,MaterialPageRoute(builder: (context)=>OnBoardingScreenView()));
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
