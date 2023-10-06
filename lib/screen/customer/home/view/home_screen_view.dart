import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/advertisement_form/view/ads_view.dart';
import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';
import 'package:local_supper_market/screen/customer/home/view/category.dart';
import 'package:local_supper_market/screen/customer/home/view/coupons.dart';
import 'package:local_supper_market/screen/customer/home/view/nearby_shop.dart';
import 'package:local_supper_market/screen/customer/home/view/offers.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_view.dart';
import 'package:local_supper_market/screen/on_boarding/view/on_boarding_screen_view.dart';
import 'package:local_supper_market/utils/header.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/text.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenView extends StatefulWidget {
  final bool? refreshPage;
  const HomeScreenView({super.key, required this.refreshPage});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  // This controller will store the value of the search bar

  // List<String> images = [
  //   "assets/images/caurosal.png",
  //   "assets/images/caurosal.png",
  //   "assets/images/caurosal.png",
  // ];

  int activePage = 0;
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
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<HomeScreenController>()
          .initState(context, widget.refreshPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeScreenController>();
    final mainScreenWatch = context.watch<MainScreenController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      body: watch.isLoading
          ? Loader()
          : WillPopScope(
              onWillPop: () async {
                SystemNavigator.pop();
                // It worked for me instead of above line
                //            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingScreenView()),);
                //       Navigator.pop(context);
                return false;
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderView(
                      cityName: mainScreenWatch.cityName,
                      areaName: mainScreenWatch.areaName,
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 19.0.w,
                        left: 19.0.w,
                      ),
                      child: SizedBox(
                        width: 351.w,
                        height: 36.h,
                        child: TextField(
                          onTap: () {
                            readMain.onNavigation(
                                1,
                                AllNearShopsView(
                                  isSearchFocus: true,
                                  refreshPage: true,
                                ),
                                context);
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MainScreenView(
                            //           index: 1,
                            //           screenName: AllNearShopsView(
                            //             isSearchFocus: true,
                            //             refreshPage: true,
                            //           ))),
                            //   (Route<dynamic> route) => false,
                            // );
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: splashnone),
                                borderRadius: BorderRadius.circular(8.w)),
                            hintText: 'Search your shops...',
                            hintStyle: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Grey,
                                    // letterSpacing: .5,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400)),

                            // Add a clear button to the search bar

                            // Add a search icon or button to the search bar
                            prefixIcon: IconButton(
                              icon: SvgPicture.asset(
                                'assets/images/search.svg',
                                width: 15.w,
                                height: 15.h,
                              ),
                              onPressed: () {
                                // Perform the search here
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ////image
                    watch.bannerData?.isNotEmpty == true
                        ? Container(
                            height: 160.h,
                            padding: EdgeInsets.only(left: 19.w),
                            child: PageView.builder(
                                itemCount: watch.bannerData?.length ?? 0,
                                physics: BouncingScrollPhysics(),
                                padEnds: false,
                                pageSnapping: true,
                                scrollDirection: Axis.horizontal,
                                allowImplicitScrolling: true,
                                // controller: watch.pageController,
                                onPageChanged: (page) {
                                  setState(() {
                                    activePage = page;
                                  });
                                },
                                itemBuilder: (context, pagePosition) {
                                  final element =
                                      watch.bannerData?[pagePosition];
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(right: 14.w),
                                    child: element?.bannerImagePath == ""
                                        ? Image.asset(
                                            "assets/images/caurosal.png",
                                            height: 170.w,
                                            // width: 340.w,
                                            // scale: 0.5,
                                            fit: BoxFit.cover,
                                          )
                                        : AppNetworkImages(
                                            imageUrl:
                                                element?.bannerImagePath ?? "",
                                            height: 170.w,
                                            // width: 340.w,
                                            // scale: 0.5,
                                            fit: BoxFit.cover,
                                          ),
                                    // margin: EdgeInsets.only(
                                    //     left: pagePosition == 0 ? 19.w : 0,
                                    //     // top: 15.w,
                                    //     right: pagePosition == int.parse(watch.bannerData?.length.toString()??"0") - 1
                                    //         ? 19.w
                                    //         : 10.w),
                                  );
                                }),
                          )
                        : Container(),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: indicators(
                            watch.bannerData?.length ?? 0, activePage)),
                    SizedBox(
                      height: 15.h,
                    ),
                    watch.nearByShopList?.isNotEmpty ?? false
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    right: 19.0.w, left: 19.0.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HomeSideHeading(
                                      text: 'Nearby Shops',
                                    ),
                                    // Text(
                                    //   "Nearby Shops",
                                    //   style: GoogleFonts.roboto(
                                    //     textStyle: TextStyle(
                                    //         color: DarkBlack,
                                    //         fontSize: 18.sp,
                                    //         fontWeight: FontWeight.w600),
                                    //   ),
                                    // ),
                                    InkWell(
                                      onTap: () {
                                        readMain.onNavigation(
                                            1,
                                            AllNearShopsView(
                                              isSearchFocus: false,
                                              refreshPage: true,
                                            ),
                                            context);
                                        // Navigator.pushAndRemoveUntil(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           MainScreenView(
                                        //               index: 1,
                                        //               screenName:
                                        //                   AllNearShopsView(
                                        //                 isSearchFocus: false,
                                        //                 refreshPage: true,
                                        //               ))),
                                        //   (Route<dynamic> route) => false,
                                        // );
                                      },
                                      child: Text(
                                        "View All",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: SplashText,
                                              // letterSpacing: .5,
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              //
                              HomeCarousal(),
                              SizedBox(
                                height: 30.h,
                              ),
                            ],
                          )
                        : Container(),
                    watch.categoryFirstList.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.only(
                              right: 19.0.w,
                              left: 19.0.w,
                            ),
                            child: HomeSideHeading(
                              text: 'Shop By Category',
                            ),
                          )
                        : Container(),
                    watch.categoryFirstList.isNotEmpty
                        ? SizedBox(
                            height: 15.h,
                          )
                        : Container(),
                    watch.categoryFirstList.isNotEmpty
                        ? ShopCategory()
                        : Container(),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    watch.couponData?.isNotEmpty == true
                        ? CouponsScreen()
                        : Container(
                            // height: 100,
                            // width: 500,
                            // color: Colors.black,
                            ),

                    // watch.hellotoffersdata?.isNotEmpty == true
                    //     ?
                    watch.hellotoffersdata?.isNotEmpty == true
                        ? OfferPage()
                        : Container(
                            // height: 100,
                            // width: 500,
                            // color: Colors.red,
                            ),
                    //
                    SizedBox(
                      height: 20.h,
                    ),

                    watch.placeAd.isNotEmpty == true
                        ? Container(
                            padding: EdgeInsets.only(
                              right: 19.0.w,
                              left: 19.0.w,
                            ),
                            width: ScreenUtil().screenWidth,
                            // height: 100.h,
                            child:
                                (watch.placeAd.toList()..shuffle()).first != ""
                                    ? AppNetworkImages(
                                        showShopImage: true,
                                        imageUrl: (watch.placeAd.toList()
                                              ..shuffle())
                                            .first,
                                        height: 163.h,
                                        width: 352.w,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        "assets/images/nearshop2.png",
                                        height: 170.w,
                                        // width: 340.w,
                                        // scale: 0.5,
                                        fit: BoxFit.cover,
                                      ))
                        : Container(
                            padding: EdgeInsets.only(
                              right: 19.0.w,
                              left: 19.0.w,
                            ),
                            width: ScreenUtil().screenWidth,
                            // height: 100.h,
                            child: Image.asset(
                              "assets/images/nearshop2.png",
                              height: 170.w,
                              // width: 340.w,
                              // scale: 0.5,
                              fit: BoxFit.cover,
                            )),

                    SizedBox(
                      height: 20.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            if (pref.getString("status") == "guestLoggedIn") {
                              Utils().showLoginDialog(
                                  context, "Please Login to continue");
                              return;
                            }
                            readMain.onNavigation(
                                0, CustomerAdsView(route: "home"), context);
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MainScreenView(
                            //           index: 0,
                            //           screenName: CustomerAdsView())),
                            //   (Route<dynamic> route) => false,
                            // );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff39C19D),
                                borderRadius: BorderRadius.circular(7.w)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 2.w),
                            child: Center(
                              child: Text(
                                "Place Your Ad",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100.h,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
