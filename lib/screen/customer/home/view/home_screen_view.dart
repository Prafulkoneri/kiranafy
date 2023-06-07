import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';

import 'package:local_supper_market/screen/customer/home/view/category.dart';
import 'package:local_supper_market/screen/customer/home/view/coupons.dart';
import 'package:local_supper_market/screen/customer/home/view/nearby_shop.dart';
import 'package:local_supper_market/screen/customer/home/view/offers.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/controller/all_near_shop_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_view.dart';
import 'package:local_supper_market/widget/network_image.dart';

import 'package:provider/provider.dart';

class HomeScreenView extends StatefulWidget {
  final bool? refreshPage;
  const HomeScreenView({super.key,required this.refreshPage});

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
      context.read<HomeScreenController>().initState(context,widget.refreshPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeScreenController>();
    final NearByShopWatch=context.watch<AllNearShopsAsPerPincode>();
    return   Scaffold(
      body: watch.isLoading?Center(
        child: CircularProgressIndicator(),
      ): WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20.w, top: 40.h, right: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                            image: const AssetImage(
                              "assets/images/logo.png",
                            ),
                            fit: BoxFit.fill,
                            width: 150.w,
                            height: 50.w,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/location1.svg',
                                width: 15.w,
                                height: 19.h,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Vishrantwadi, Pune",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: SplashText1,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: splashnone),
                                borderRadius: BorderRadius.circular(8.w)),
                            hintText: 'Search your shop and products..',
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
                    Padding(
                      padding: EdgeInsets.only(left: 19.w),
                      child: ExpandablePageView.builder(
                          itemCount: watch.bannerData?.length??1,
                          physics: BouncingScrollPhysics(),
                          padEnds: false,
                          pageSnapping: true,
                          scrollDirection: Axis.horizontal,
                          allowImplicitScrolling: true,
                          controller: watch.pageController,
                          onPageChanged: (page) {
                            setState(() {
                              activePage = page;
                            });
                          },
                          itemBuilder: (context, pagePosition) {
                            final element=watch.bannerData?[pagePosition];
                            return     Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(right: 14.w),
                              child: element?.bannerImagePath==""?Image.asset(
                                "assets/images/caurosal.png",
                                height: 170.w,
                                // width: 340.w,
                                // scale: 0.5,
                                fit: BoxFit.cover,
                              ):AppNetworkImages(
                                imageUrl:
                                element?.bannerImagePath??"",
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
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: indicators(watch.bannerData?.length??0, activePage)),
                    SizedBox(
                      height: 15.h,
                    ),

                    NearByShopWatch.nearByShopList?.isNotEmpty??true?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 19.0.w, left: 19.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nearby Shops",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: DarkBlack,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => MainScreenView(index: 1,screenName:AllNearShopsView(refreshPage: true,))),
                                        (Route<dynamic> route) => false,
                                  );
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
                    ):Container(),

                    watch.categoryFirstList.isNotEmpty
                        ? Container(
                      padding: EdgeInsets.only(
                        right: 19.0.w,
                        left: 19.0.w,
                      ),
                      child: Text(
                        "Shop By Category",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: DarkBlack,
                              letterSpacing: .5,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                        : Container(),

                    watch.categoryFirstList.isNotEmpty
                        ? SizedBox(
                      height: 15.h,
                    )
                        : Container(),
                    watch.categoryFirstList.isNotEmpty ? ShopCategory() : Container(),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    CouponsScreen(),

                    OfferPage(),
                    //
                    SizedBox(
                      height: 10.h,
                    ),


                    // ListView.builder(
                    //   padding: EdgeInsets.zero,
                    //   itemCount: watch.data?.length ?? 0,
                    //   shrinkWrap: true,
                    //   itemBuilder: (context, index) {
                    //     final element = watch.data?[index];
                    //     return Container(
                    //         padding: EdgeInsets.only(
                    //           right: 19.0.w,
                    //           left: 19.0.w,
                    //         ),
                    //         width: ScreenUtil().screenWidth,
                    //         // height: 100.h,
                    //         child: AppNetworkImages(
                    //           "${element?.bannerImagePath}",
                    //           fit: BoxFit.cover,
                    //         )
                    //         // Image(
                    //         //   image: AssetImage("assets/images/banner.png"),
                    //         //   height: 163.h,
                    //         //   width: 352.w,
                    //         // ),
                    //         );
                    //   },
                    // ),


                    SizedBox(
                      height: 10.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff39C19D),
                                borderRadius: BorderRadius.circular(7.w)),
                            padding:
                            EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.w),
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

      )

    );

  }
}
// SingleChildScrollView(
// scrollDirection: Axis.horizontal,
// physics: BouncingScrollPhysics(),
// child: Row(
// children: List.generate(
// widget.items?.length ?? 0,
// (index) => Container(
// padding: EdgeInsets.only(
// left: 15,
// bottom: 10,
// right: index + 1 == widget.items?.length ? 20 : 0),
// child: AppNetworkImages(
// widget.items?[index]["image"],
// fit: BoxFit.cover,
// ),
// )
// ),
// ),
// ),