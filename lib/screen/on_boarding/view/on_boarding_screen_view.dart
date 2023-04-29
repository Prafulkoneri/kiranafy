import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/screen/auth/view/customer_sign_in_view.dart';
import 'package:local_supper_market/screen/on_boarding/controller/on_boarding_controller.dart';

import 'package:local_supper_market/widget/buttons.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:provider/provider.dart';

class OnBoardingScreenView extends StatefulWidget {
  const OnBoardingScreenView({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenViewState createState() => _OnBoardingScreenViewState();
}

class _OnBoardingScreenViewState extends State<OnBoardingScreenView> {
  List<Widget> indicators(imagesLength, currentIndex) {
    final read = context.read<OnBoardingController>();
    final watch = context.watch<OnBoardingController>();
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 7.86.w,
        height: 7.86.w,
        decoration: BoxDecoration(
            color: currentIndex == index ? indicator : Grey,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<OnBoardingController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<OnBoardingController>();
    final watch = context.watch<OnBoardingController>();
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
                        height: 45.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                           read.onSkipPressed(context);
                            },
                            child: Text(
                              "SKIP",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: SplashText1),
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7.w,
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
                      ExpandablePageView(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: watch.pageController,
                        onPageChanged: (index) {
                          read.onPageChanged(index);
                        },
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 20.w,
                              ),
                              Image.asset(
                                "assets/images/introone.png",
                                height: 262.w,
                                width: 262.w,
                              ),
                              SizedBox(
                                height: 15.w,
                              ),
                              Text(
                                "We Are Open",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff006F94),
                                    letterSpacing: 0.5),
                              ),
                              SizedBox(
                                height: 3.w,
                              ),
                              Text(
                                "On Online",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff006F94),
                                    letterSpacing: 0.5),
                              ),
                              SizedBox(
                                height: 22.w,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: 34.w, right: 34.w),
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff263238)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 25.w,
                              ),
                              Image.asset(
                                "assets/images/introtwo.png",
                                height: 232.w,
                                width: 304.96.w,
                              ),
                              SizedBox(
                                height: 40.w,
                              ),
                              Text(
                                "You Can Find",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff006F94),
                                    letterSpacing: 0.8),
                              ),
                              SizedBox(
                                height: 3.w,
                              ),
                              Text(
                                "Local Location",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff006F94),
                                    letterSpacing: 0.8),
                              ),
                              SizedBox(
                                height: 22.w,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: 34.w, right: 34.w),
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff263238)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 69.w,
                              ),
                              Image.asset(
                                "assets/images/introthree.png",
                                height: 185.w,
                                width: 285.7.w,
                              ),
                              SizedBox(
                                height: 43.w,
                              ),
                              Text(
                                "Maintain",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff006F94),
                                    letterSpacing: 0.5),
                              ),
                              SizedBox(
                                height: 3.w,
                              ),
                              Text(
                                "Orders On App",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff006F94),
                                    letterSpacing: 0.5),
                              ),
                              SizedBox(
                                height: 22.w,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: 34.w, right: 34.w),
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff263238)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 10.w,
                              ),
                              Image.asset(
                                "assets/images/introfour.png",
                                height: 250.w,
                                width: 250.w,
                              ),
                              SizedBox(
                                height: 37.w,
                              ),
                              Text(
                                "Grow Your",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff006F94),
                                    letterSpacing: 0.5),
                              ),
                              SizedBox(
                                height: 3.w,
                              ),
                              Text(
                                "Shop Business",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff006F94),
                                    letterSpacing: 0.5),
                              ),
                              SizedBox(
                                height: 22.w,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(left: 34.w, right: 34.w),
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed eiusmod tempor.",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff263238)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                          children: indicators(4, watch.currentIndex)),
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
                              onTap: () {
  read.onCustomerBtnPressed(context);
                              },
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
                              onTap: () {
                           read.onShopOwnerBtnPressed(context);
                              },
                              textColor: Colors.white,
                              text: "Shop Owner",
                            ),
                          ),
                          SizedBox(
                            width: 27.w,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.w,
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
