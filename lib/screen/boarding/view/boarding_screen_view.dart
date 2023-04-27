import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/widget/buttons.dart';
class BoardingScreenView extends StatefulWidget {
  const BoardingScreenView({Key? key}) : super(key: key);

  @override
  _BoardingScreenViewState createState() => _BoardingScreenViewState();
}

class _BoardingScreenViewState extends State<BoardingScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0.w,
            child: Image.asset(
              "assets/images/splash1.png",
              height: 235.w,
              width: 361.w,
            ),
          ),
          Positioned(
            bottom: 0.w,
            right: 0.w,
            child: Image.asset(
              "assets/images/splash2.png",
              height: 235.w,
              width: 361.w,
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60.w,
                      ),
                      Image.asset(
                        "assets/images/splash4.png",
                        height: 112.w,
                        width: 59.w,
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LOCAL",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: SplashText),
                          ),
                          Text(
                            " SUPERMART",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: SplashText1),
                          ),
                        ],
                      ),
                      Text(
                        "Hameshase aapke sath....",
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Container(
                        height: 383.w,
                        child: PageView(

                          children: [
                         Column(
                           children: [
                             Image.asset(
                               "assets/images/introone.png",
                               height: 262.w,
                               width: 262.w,
                             ),
                             Text(
                               "We Are Open",
                               style: TextStyle(
                                   fontSize: 26.sp,
                                   fontWeight: FontWeight.w700,
                                   color: Color(0xff006F94),
                                   letterSpacing: 1),
                             ),
                             SizedBox(
                               height: 3.w,
                             ),
                             Text(
                               "On Online",
                               style: TextStyle(
                                   fontSize: 26.sp,
                                   fontWeight: FontWeight.w700,
                                   color: Color(0xff006F94),
                                   letterSpacing: 1),
                             ),
                             SizedBox(
                               height: 10.w,
                             ),
                             Container(
                               margin: EdgeInsets.only(left: 34.w, right: 34.w),
                               child: Text(
                                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                                 style: TextStyle(
                                     fontSize: 16.sp,
                                     fontWeight: FontWeight.w500,
                                     color: Color(0xff263238)),
                               ),
                             ),
                           ],
                         ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/introtwo.png",
                                  height: 262.w,
                                  width: 262.w,
                                ),
                                Text(
                                  "We Are Open",
                                  style: TextStyle(
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff006F94),
                                      letterSpacing: 1),
                                ),
                                SizedBox(
                                  height: 3.w,
                                ),
                                Text(
                                  "On Online",
                                  style: TextStyle(
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff006F94),
                                      letterSpacing: 1),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 34.w, right: 34.w),
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff263238)),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/introthree.png",
                                  height: 262.w,
                                  width: 262.w,
                                ),
                                SizedBox(
                                  height: 3.w,
                                ),
                                Text(
                                  "We Are Open",
                                  style: TextStyle(
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff006F94),
                                      letterSpacing: 1),
                                ),
                                SizedBox(
                                  height: 3.w,
                                ),
                                Text(
                                  "On Online",
                                  style: TextStyle(
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff006F94),
                                      letterSpacing: 1),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 34.w, right: 34.w),
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff263238)),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/introfour.png",
                                  height: 262.w,
                                  width: 262.w,
                                ),
                                Text(
                                  "We Are Open",
                                  style: TextStyle(
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff006F94),
                                      letterSpacing: 1),
                                ),
                                SizedBox(
                                  height: 3.w,
                                ),
                                Text(
                                  "On Online",
                                  style: TextStyle(
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff006F94),
                                      letterSpacing: 1),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 34.w, right: 34.w),
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff263238)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20.w,
                      ),
                      Container(
                        height: 4.w,
                        width: 4.w,
                        color: Colors.green,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 27.w,
                          ),
                          Expanded(child:PrimaryButton(color:Color(0xff4EEFC1), onTap:(){},textColor: Colors.black,text: "Customer",),),
                          SizedBox(
                            width: 17.w,
                          ),
                          Expanded(child:PrimaryButton(color:Color(0xff4EEFC1), onTap:(){},textColor: Colors.black,text: "Customer",),),
                          SizedBox(
                            width: 27.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
