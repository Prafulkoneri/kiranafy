import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/advertisement_form/view/ads_view.dart';
import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/controller/all_shop_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/shop_filter_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/utils/header.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AllNearShopsView extends StatefulWidget {
  final bool? refreshPage;
  final bool? isSearchFocus;

  const AllNearShopsView(
      {super.key, required this.refreshPage, required this.isSearchFocus});

  @override
  State<AllNearShopsView> createState() => _AllNearShopsViewState();
}

class _AllNearShopsViewState extends State<AllNearShopsView> {
  // final TextEditingController _searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<AllShopController>().initState(context, widget.refreshPage);
    });
    setPagination();
  }

  setPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<AllShopController>().onScrollMaxExtent(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<AllShopController>();
    final read = context.read<AllShopController>();
    final watchHome = context.watch<HomeScreenController>();
    final watchMain = context.watch<MainScreenController>();
    final readMain = context.watch<MainScreenController>();

    return Scaffold(
      body: watch.isLoading
          ? Loader()
          : WillPopScope(
              onWillPop: () async {
                readMain.onNavigation(
                    0, HomeScreenView(refreshPage: false), context);
                // Navigator.of(context).popUntil(
                //     (route) => route.settings.name == "MainScreenView");
                return false;
              },
              child: SingleChildScrollView(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderView(
                          areaName: watchMain.areaName,
                          cityName: watchMain.cityName,
                        ),
                        SizedBox(
                          height: 12.w,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  // right: 19.0.w,
                                  left: 19.0.w,
                                  // top: 13.h,
                                ),
                                child: SizedBox(
                                  height: 36.h,
                                  child: TextField(
                                    onChanged: (value) {
                                      read.shopSearchList(context);
                                    },
                                    autofocus: widget.isSearchFocus ?? true,
                                    controller: watch.searchController,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: splashnone),
                                          borderRadius:
                                              BorderRadius.circular(8.w)),
                                      hintText: 'Search your shop.......',
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

                                      // border: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(15.w),
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return ShopFilterView();
                                    });
                                  },
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/images/filter.svg',
                                width: 20.w,
                                height: 18.h,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.w, left: 19.0.w, bottom: 15.w),
                          child: HomeSideHeading(
                            text: 'Nearby Shops',
                          ),
                        ),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(
                                    watch.nearByShop?.length ?? 0, (index) {
                                  print(watch.nearByShop?.length);
                                  final element = watch.nearByShop?[index];
                                  return GestureDetector(
                                    onTap: () {
                                      readMain.onNavigation(
                                          1,
                                          ShopProfileView(
                                              shopId: element?.id.toString(),
                                              refreshPage: true,
                                              routeName: "allNearShopView"),
                                          context);
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => MainScreenView(
                                      //           index: 1,
                                      //           screenName: ShopProfileView(
                                      //               shopId:
                                      //                   element?.id.toString(),
                                      //               refreshPage: true,
                                      //               routeName:
                                      //                   "allNearShopView"))),
                                      //   // (Route<dynamic> route) => false,
                                      // );
                                    },
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 120.h,
                                              width: 200.w,
                                              margin: EdgeInsets.only(
                                                  left: index == 0 ? 19.w : 0,
                                                  right: index ==
                                                          int.parse(
                                                                  "${watch.nearByShop?.length.toString()}") -
                                                              1
                                                      ? 19.w
                                                      : 5.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.w),
                                                  image: watch
                                                              .nearByShop?[
                                                                  index]
                                                              .shopBannerImagePath ==
                                                          ""
                                                      ? DecorationImage(
                                                          scale: 1.0,
                                                          image: AssetImage(
                                                              'assets/images/nearshop2.png'),
                                                          fit: BoxFit.fill)
                                                      : DecorationImage(
                                                          scale: 1.0,
                                                          image: NetworkImage(
                                                              "${element?.shopBannerImagePath}"),
                                                          fit: BoxFit.fill)),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                            child: Container(
                                          margin: EdgeInsets.only(
                                              left: index == 0 ? 19.w : 0,
                                              right: index ==
                                                      int.parse(
                                                              "${watch.nearByShop?.length.toString()}") -
                                                          1
                                                  ? 19.w
                                                  : 5.w),
                                          height: 120.h,
                                          width: 200.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13.w),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [
                                                  0.1,
                                                  0.9,
                                                ],
                                                colors: [
                                                  Colors.white.withOpacity(0),
                                                  Colors.black.withOpacity(0.3),
                                                ],
                                              )),
                                          child: Padding(
                                            padding: EdgeInsets.all(10.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(),
                                                Column(
                                                  children: [
                                                    NearByShops(
                                                      text:
                                                          '${element?.shopName}',
                                                    ),
                                                    NearByShopslocation(
                                                      text:
                                                          '${element?.areaName}',
                                                    ),
                                                  ],
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                        Positioned(
                                          right: 25.w,
                                          top: 8.w,
                                          child: InkWell(
                                            onTap: () {
                                              watch.favNearByShop[index]
                                                  ? read.removeNearByFavList(
                                                      context,
                                                      element?.id,
                                                      index)
                                                  : read.updateNearByFavList(
                                                      context,
                                                      element?.id,
                                                      index);
                                            },
                                            child: watch.favNearByShop[index]
                                                ? SvgPicture.asset(
                                                    "assets/icons/fav_selected.svg",
                                                    width: 26.w,
                                                    height: 14.h,
                                                  )
                                                : SvgPicture.asset(
                                                    "assets/images/favorite.svg",
                                                    width: 26.w,
                                                    height: 14.h,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }))),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          // height: 400.h,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  watch.allShops.isNotEmpty == true
                                      ? ListView.builder(
                                          padding: EdgeInsets.zero,

                                          // scrollDirection: Axis.vertical,p
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          // physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: watch.allShops.length ?? 0,
                                          itemBuilder: (BuildContext, index) {
                                            final element =
                                                watch.allShops[index];
                                            return GestureDetector(
                                              onTap: () {
                                                readMain.onNavigation(
                                                    1,
                                                    ShopProfileView(
                                                        shopId: element.id
                                                            .toString(),
                                                        refreshPage: true,
                                                        routeName:
                                                            "allNearShopView"),
                                                    context);
                                                // Navigator.pushAndRemoveUntil(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) => MainScreenView(
                                                //           index: 1,
                                                //           screenName: ShopProfileView(
                                                //               shopId: element.id
                                                //                   .toString(),
                                                //               refreshPage: true,
                                                //               routeName:
                                                //                   "allNearShopView"))),
                                                //   (Route<dynamic> route) => false,
                                                // );
                                              },
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 19.w,
                                                        right: 12,
                                                        // top: 20.w,
                                                        bottom: 14.w),
                                                    child: Container(
                                                      height: 160.h,
                                                      width: 352.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.w),
                                                          image: element
                                                                      .shopBannerImagePath ==
                                                                  ""
                                                              ? DecorationImage(
                                                                  // scale: 1.0,
                                                                  image: AssetImage(
                                                                      'assets/images/nearshop2.png'),
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : DecorationImage(
                                                                  // scale: 1.0,
                                                                  image: NetworkImage(
                                                                      '${element.shopBannerImagePath}'),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      left: 19.w,
                                                      right: 12.w,
                                                      child: Container(
                                                        // margin: EdgeInsets.only(
                                                        //     left: index == 0 ? 19.w : 0,
                                                        //     right: index == 2 ? 19.w : 5.w),
                                                        height: 160.h,
                                                        width: 352.w,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(13
                                                                            .w),
                                                                gradient:
                                                                    LinearGradient(
                                                                  begin: Alignment
                                                                      .topCenter,
                                                                  end: Alignment
                                                                      .bottomCenter,
                                                                  stops: [
                                                                    0.1,
                                                                    0.9,
                                                                  ],
                                                                  colors: [
                                                                    Colors.white
                                                                        .withOpacity(
                                                                            0),
                                                                    Colors.black
                                                                        .withOpacity(
                                                                            0.3),
                                                                  ],
                                                                )),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.h),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      NearByShops(
                                                                          text:
                                                                              '${element.shopName}',
                                                                          fontSize:
                                                                              15.sp),
                                                                      // Text(
                                                                      //     "${element.shopName}",
                                                                      //     style: GoogleFonts.roboto(
                                                                      //         textStyle: TextStyle(
                                                                      //             color: Colors.white,
                                                                      //             // letterSpacing: .5,
                                                                      //             fontSize: 15.sp,
                                                                      //             fontWeight: FontWeight.w600))),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          SvgPicture.asset(
                                                                              "assets/icons/location1.svg",
                                                                              width: 12.w,
                                                                              height: 16.h),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 8.w),
                                                                            child: Text("${element.areaName}, ${element.cityName}",
                                                                                style: GoogleFonts.roboto(
                                                                                    textStyle: TextStyle(
                                                                                        color: Colors.white,
                                                                                        letterSpacing: .5,
                                                                                        fontSize: 12.sp,
                                                                                        // height: 10,
                                                                                        fontWeight: FontWeight.w400))),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            21.49.h,
                                                                        width:
                                                                            49.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              yellow,
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(15)),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            SvgPicture.asset(
                                                                              "assets/images/star.svg",
                                                                              height: 12.h,
                                                                              width: 12.w,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 4.3.w,
                                                                            ),
                                                                            Text(
                                                                              // "${element.ratings}",
                                                                              // "${element.ratings ?? "0.0"}",
                                                                              // "0.0",
                                                                              double.parse(element.ratings.toString() ?? "0.0").toStringAsFixed(1),
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(color: Black, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                  Positioned(
                                                    right: 20.w,
                                                    top: 10.w,
                                                    child: InkWell(
                                                      onTap: () {
                                                        watch.favAllShop[index]
                                                            ? read
                                                                .removeAllShopFavList(
                                                                    context,
                                                                    element.id,
                                                                    index)
                                                            : read
                                                                .updateAllShopFavList(
                                                                    context,
                                                                    element.id,
                                                                    index);
                                                      },
                                                      child: watch
                                                              .favAllShop[index]
                                                          ? SvgPicture.asset(
                                                              "assets/icons/fav_selected.svg",
                                                              width: 26.w,
                                                              height: 14.h,
                                                            )
                                                          : SvgPicture.asset(
                                                              "assets/images/favorite.svg",
                                                              width: 26.w,
                                                              height: 14.h,
                                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })
                                      : Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/Shop not found.png",
                                                width: 150.w,
                                                height: 150.h,
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                "No Shops Found",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: Black1,
                                                      letterSpacing: .5,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  watchHome.customerplacead?.isNotEmpty == true
                                      ? GestureDetector(
                                          onTap: () async {
                                            log('${(watchHome.customerplacead?.toList()?..shuffle())?.first.advertisementUrl}');
                                            launchUrl(Uri.parse(
                                                    '${(watchHome.customerplacead?.toList()?..shuffle())?.first.advertisementUrl}'))
                                                .onError(
                                              (error, stackTrace) {
                                                print("Url is not valid!");
                                                return false;
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              right: 19.0.w,
                                              left: 19.0.w,
                                            ),
                                            width: ScreenUtil().screenWidth,

                                            // height: 100.h,
                                            child: (watchHome.customerplacead
                                                            ?.toList()
                                                          ?..shuffle())
                                                        ?.first
                                                        .shopBannerImagePath !=
                                                    ""
                                                ? AppNetworkImages(
                                                    imageUrl: (watchHome
                                                            .customerplacead
                                                            ?.toList()
                                                          ?..shuffle())
                                                        ?.first
                                                        .shopBannerImagePath,
                                                    showShopImage: true,
                                                    height: 163.h,
                                                    width: 352.w,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    "assets/images/nearshop2.png"),
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.only(
                                            right: 19.0.w,
                                            left: 19.0.w,
                                          ),
                                          width: ScreenUtil().screenWidth,
                                          height: 163.h,
                                          // height: 100.h,
                                          child: Image.asset(
                                            "assets/images/nearshop2.png",
                                            fit: BoxFit.fill,
                                            height: 163.h,
                                            width: ScreenUtil().screenWidth,
                                          ),
                                        ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          SharedPreferences pref =
                                              await SharedPreferences
                                                  .getInstance();
                                          if (pref.getString("status") ==
                                              "guestLoggedIn") {
                                            Utils().showLoginDialog(context,
                                                "Please Login to continue");
                                            return;
                                          }
                                          readMain.onNavigation(
                                              1,
                                              CustomerAdsView(
                                                  route: "allShops"),
                                              context);
                                          // Navigator.pushAndRemoveUntil(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           MainScreenView(
                                          //               index: 0,
                                          //               screenName:
                                          //                   CustomerAdsView())),
                                          //   (Route<dynamic> route) => false,
                                          // );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xff39C19D),
                                              borderRadius:
                                                  BorderRadius.circular(7.w)),
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
                                ],
                              ),
                              Positioned(
                                bottom: 50.w,
                                left: 0,
                                right: 0,
                                child: Visibility(
                                  visible: watch.showPaginationLoader,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: SplashText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100.w,
                        ),
                      ])),
            ),
    );
  }
}
