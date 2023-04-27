import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
class BoardingScreenView extends StatefulWidget {
  const BoardingScreenView({Key? key}) : super(key: key);

  @override
  _BoardingScreenViewState createState() => _BoardingScreenViewState();
}

class _BoardingScreenViewState extends State<BoardingScreenView> {
  int currentIndex=0;
  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 6.w,
        height: 6.w,
        decoration: BoxDecoration(
            color: currentIndex == index ? indicator : Grey,
            shape: BoxShape.circle),
      );
    });
  }
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
                      // SizedBox(
                      //   height: currentIndex==0?40.w:currentIndex==1?40:currentIndex==2?60.w:currentIndex==3?40.w:0.w,
                      // ),


                      ExpandablePageView(children: [

                      ]),







                      // Container(
                      //   height:currentIndex==0? 409.w:currentIndex==1?404.w:currentIndex==2?365.w:currentIndex==3?460.w:0,
                      //   child: PageView(
                      //     onPageChanged: (int index){
                      //       setState(() {
                      //         currentIndex=index;
                      //       });
                      //     },
                      //     padEnds: true,
                      //     children: [
                      //       Column(
                      //         children: [
                      //           Image.asset(
                      //             "assets/images/introone.png",
                      //             height: 262.w,
                      //             width: 262.w,
                      //           ),
                      //           SizedBox(
                      //             height: 15.w,
                      //           ),
                      //           Text(
                      //             "We Are Open",
                      //             style: TextStyle(
                      //                 fontSize: 26.sp,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: Color(0xff006F94),
                      //                 letterSpacing: 1),
                      //           ),
                      //           SizedBox(
                      //             height: 3.w,
                      //           ),
                      //           Text(
                      //             "On Online",
                      //             style: TextStyle(
                      //                 fontSize: 26.sp,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: Color(0xff006F94),
                      //                 letterSpacing: 1),
                      //           ),
                      //           SizedBox(
                      //             height: 22.w,
                      //           ),
                      //           Container(
                      //             margin:
                      //                 EdgeInsets.only(left: 34.w, right: 34.w),
                      //             child: Text(
                      //               "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                      //               style: TextStyle(
                      //                   fontSize: 15.sp,
                      //                   fontWeight: FontWeight.w500,
                      //                   color: Color(0xff263238)),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ),
                      //
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           Image.asset(
                      //             "assets/images/introtwo.png",
                      //             height: 232.w,
                      //             width: 304.96.w,
                      //           ),
                      //           SizedBox(
                      //             height: 40.w,
                      //           ),
                      //           Text(
                      //             "You Can Find",
                      //             style: TextStyle(
                      //                 fontSize: 26.sp,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: Color(0xff006F94),
                      //                 letterSpacing: 1),
                      //           ),
                      //           SizedBox(
                      //             height: 3.w,
                      //           ),
                      //           Text(
                      //             "Local Location",
                      //             style: TextStyle(
                      //                 fontSize: 26.sp,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: Color(0xff006F94),
                      //                 letterSpacing: 1),
                      //           ),
                      //           SizedBox(
                      //             height: 22.w,
                      //           ),
                      //           Container(
                      //             margin:
                      //             EdgeInsets.only(left: 34.w, right: 34.w),
                      //             child: Text(
                      //               "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                      //               style: TextStyle(
                      //                   fontSize: 15.sp,
                      //                   fontWeight: FontWeight.w500,
                      //                   color: Color(0xff263238)),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ),
                      //
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           Image.asset(
                      //             "assets/images/introthree.png",
                      //             height: 185.w,
                      //             width: 285.7.w,
                      //           ),
                      //           SizedBox(
                      //             height:43.w,
                      //           ),
                      //
                      //           Text(
                      //             "Maintain",
                      //             style: TextStyle(
                      //                 fontSize: 26.sp,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: Color(0xff006F94),
                      //                 letterSpacing: 1),
                      //           ),
                      //           SizedBox(
                      //             height: 3.w,
                      //           ),
                      //           Text(
                      //             "Orders On App",
                      //             style: TextStyle(
                      //                 fontSize: 26.sp,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: Color(0xff006F94),
                      //                 letterSpacing: 1),
                      //           ),
                      //           SizedBox(
                      //             height: 22.w,
                      //           ),
                      //           Container(
                      //             margin:
                      //             EdgeInsets.only(left: 34.w, right: 34.w),
                      //             child: Text(
                      //               "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                      //               style: TextStyle(
                      //                   fontSize: 15.sp,
                      //                   fontWeight: FontWeight.w500,
                      //                   color: Color(0xff263238)),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ),
                      //
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           Image.asset(
                      //             "assets/images/introfour.png",
                      //             height: 250.w,
                      //             width: 250.w,
                      //           ),
                      //           SizedBox(
                      //             height: 37.w,
                      //           ),
                      //           Text(
                      //             "Grow Your",
                      //             style: TextStyle(
                      //                 fontSize: 26.sp,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: Color(0xff006F94),
                      //                 letterSpacing: 1),
                      //           ),
                      //           SizedBox(
                      //             height: 3.w,
                      //           ),
                      //           Text(
                      //             "Shop Business",
                      //             style: TextStyle(
                      //                 fontSize: 26.sp,
                      //                 fontWeight: FontWeight.w700,
                      //                 color: Color(0xff006F94),
                      //                 letterSpacing: 1),
                      //           ),
                      //           SizedBox(
                      //             height: 22.w,
                      //           ),
                      //           Container(
                      //             margin:
                      //             EdgeInsets.only(left: 34.w, right: 34.w),
                      //             child: Text(
                      //               "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                      //               style: TextStyle(
                      //                   fontSize: 15.sp,
                      //                   fontWeight: FontWeight.w500,
                      //                   color: Color(0xff263238)),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ),
                      //
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: indicators(4,currentIndex)),
                      SizedBox(
                        height: 35.w,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 27.w,
                          ),
                          Expanded(
                            child: PrimaryButton(
                              color: Color(0xff4EEFC1),
                              onTap: () {},
                              textColor: Colors.black,
                              text: "Customer",
                            ),
                          ),
                          SizedBox(
                            width: 17.w,
                          ),
                          Expanded(
                            child: PrimaryButton(
                              color: Color(0xff4689EC),
                              onTap: () {},
                              textColor: Colors.white,
                              text: "Shop Owner",
                            ),
                          ),
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
