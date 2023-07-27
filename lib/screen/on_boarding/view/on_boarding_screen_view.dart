import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/screen/on_boarding/controller/on_boarding_controller.dart';

import 'package:local_supper_market/widget/buttons.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:local_supper_market/widget/network_image.dart';
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
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  // left: 0.w,
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
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 45.w,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     GestureDetector(
                            //       onTap: () {
                            //         read.onSkipPressed(context);
                            //       },
                            //       child: Text(
                            //         "SKIP",
                            //         style: TextStyle(
                            //             fontSize: 14.sp,
                            //             fontWeight: FontWeight.w700,
                            //             color: SplashText1),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 25.w,
                            //     ),
                            //   ],
                            // ),
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
                            ExpandablePageView.builder(
                              // physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              controller: watch.pageController,
                              onPageChanged: (index) {
                                read.onPageChanged(index);
                              },
                              itemCount: watch.onBoardingData?.length ?? 0,
                              itemBuilder: (context, index) {
                                final element = watch.onBoardingData?[index];
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 20.w,
                                    ),
                                    AppNetworkImages(
                                      imageUrl:
                                          "${element?.splashScreenImagePath}",
                                      height: 250.w,
                                      width: 250.w,
                                    ),
                                    SizedBox(
                                      height: 15.w,
                                    ),
                                    Text(
                                      "${element?.title}",
                                      textAlign: TextAlign.center,
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
                                      margin: EdgeInsets.only(
                                          left: 34.w, right: 34.w),
                                      child: Text(
                                        "${element?.subTitle}",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff263238)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.w,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: indicators(watch.onBoardingData?.length,
                                  watch.currentIndex)),
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
                                    // read.onCustomerBtnPressed(context);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            backgroundColor: Color(0xffD9D9D9),
                                            // shape: ,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),

                                            // scrollable: true,
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 18.w,
                                                  right: 18.w,
                                                  top: 16.w,
                                                  bottom: 0.w),
                                              height: 127.h,
                                              width: 173.w,
                                              child: Column(
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      "This is pre - launch for \nShop Owner, app\nfor customers will be\nlaunched soon !",

                                                      // softWrap: true,
                                                      // maxLines: 3,//
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Black1,

                                                            // letterSpacing: .05,
                                                            // overflow:
                                                            //     TextOverflow
                                                            //         .ellipsis,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "Dismiss",
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Black1,

                                                              // letterSpacing: .05,
                                                              // overflow:
                                                              //     TextOverflow
                                                              //         .ellipsis,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          );
                                        });
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
                            height: 35.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
