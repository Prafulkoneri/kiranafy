import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/controller/all_shop_category_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/utils/header.dart';
import 'package:provider/provider.dart';

class AllNearCategoryShopsView extends StatefulWidget {
  final String? categoryId;
  final bool? refresh;
  const AllNearCategoryShopsView(
      {super.key, required this.categoryId, required this.refresh});

  @override
  State<AllNearCategoryShopsView> createState() =>
      _AllNearCategoryShopsViewState();
}

class _AllNearCategoryShopsViewState extends State<AllNearCategoryShopsView> {
  final TextEditingController _searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<AllCategoryShopController>()
          .initState(context, widget.categoryId, widget.refresh);
    });
    setPagination();
  }

  setPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("lets goo");
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<AllCategoryShopController>().onScrollMaxExtent(context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<AllCategoryShopController>();
    final read = context.read<AllCategoryShopController>();
    final watchMain = context.watch<MainScreenController>();
    return Scaffold(
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : WillPopScope(
              onWillPop: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreenView(
                            index: 0,
                            screenName: HomeScreenView(
                              refreshPage: false,
                            ),
                          )),
                  (Route<dynamic> route) => false,
                );

                return false;
              },
              child: SingleChildScrollView(
                  controller: scrollController,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderView(areaName:watchMain.areaName,cityName:watchMain.cityName,),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 19.0.w,
                            left: 19.0.w,
                            top: 13.h,
                          ),
                          child: SizedBox(
                            width: 351.w,
                            height: 36.h,
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: splashnone),
                                    borderRadius: BorderRadius.circular(8.w)),
                                hintText: 'Search your shop...',
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.w, left: 19.0.w, bottom: 15.w),
                          child: Text(
                            "Nearby Shops",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Black,
                                  // letterSpacing: .5,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
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
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreenView(
                                                    index: 1,
                                                    screenName: ShopProfileView(
                                                      shopId: element?.id
                                                          .toString(),
                                                      routeName:
                                                          "nearShopsCategory",
                                                      categoryId:
                                                          widget.categoryId,
                                                      refreshPage: true,
                                                    ))),
                                        (Route<dynamic> route) => false,
                                      );
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
                                                        Text(
                                                            "${element?.shopName}",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    color: Colors.white,
                                                                    // letterSpacing: .5,
                                                                    fontSize: 13.sp,
                                                                    fontWeight: FontWeight.w600))),
                                                        // ),
                                                        Text(
                                                            "${element?.areaName}",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    color: Colors.white,
                                                                    // letterSpacing: .5,
                                                                    fontSize: 12.sp,
                                                                    // height: 10,
                                                                    fontWeight: FontWeight.w400))),
                                                      ],
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                                                  Colors.black
                                                      .withOpacity(0.05),
                                                ],
                                              )),
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
                          // height: 400.h,
                          child: Stack(
                            children: [
                              ListView.builder(
                                  // scrollDirection: Axis.vertical,p
                                  physics: NeverScrollableScrollPhysics(),
                                  // physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: watch.allShops.length ?? 0,
                                  itemBuilder: (BuildContext, index) {
                                    final element = watch.allShops[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MainScreenView(
                                                      index: 1,
                                                      screenName:
                                                          ShopProfileView(
                                                        shopId: element?.id
                                                            .toString(),
                                                        routeName:
                                                            "nearShopsCategory",
                                                        categoryId:
                                                            widget.categoryId,
                                                        refreshPage: true,
                                                      ))),
                                          (Route<dynamic> route) => false,
                                        );
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
                                                      BorderRadius.circular(
                                                          15.w),
                                                  image: element
                                                              .shopBannerImagePath ==
                                                          ""
                                                      ? DecorationImage(
                                                          // scale: 1.0,
                                                          image: AssetImage(
                                                              'assets/images/nearshop2.png'),
                                                          fit: BoxFit.cover)
                                                      : DecorationImage(
                                                          // scale: 1.0,
                                                          image: NetworkImage(
                                                              '${element.shopBannerImagePath}'),
                                                          fit: BoxFit.cover)),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "${element.shopName}",
                                                                style: GoogleFonts.roboto(
                                                                    textStyle: TextStyle(
                                                                        color: Colors.white,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 15.sp,
                                                                        fontWeight: FontWeight.w600))),
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
                                                                    height:
                                                                        16.h),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              8.w),
                                                                  child: Text(
                                                                      "${element.areaName}, ${element.cityName}",
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
                                                              height: 21.49.h,
                                                              width: 49.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: yellow,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/images/star.svg",
                                                                    height:
                                                                        12.h,
                                                                    width: 12.w,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        4.3.w,
                                                                  ),
                                                                  Text(
                                                                    "0.0",
                                                                    style: GoogleFonts
                                                                        .dmSans(
                                                                      textStyle: TextStyle(
                                                                          color:
                                                                              Black,
                                                                          letterSpacing:
                                                                              .5,
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w400),
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
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13.w),
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      stops: [
                                                        0.1,
                                                        0.9,
                                                      ],
                                                      colors: [
                                                        Colors.white
                                                            .withOpacity(0),
                                                        Colors.black
                                                            .withOpacity(0.15),
                                                      ],
                                                    )),
                                              )),
                                          Positioned(
                                            right: 20.w,
                                            top: 10.w,
                                            child: InkWell(
                                              onTap: () {
                                                watch.favAllShop[index]
                                                    ? read.removeAllShopFavList(
                                                        context,
                                                        element.id,
                                                        index)
                                                    : read.updateAllShopFavList(
                                                        context,
                                                        element.id,
                                                        index);
                                              },
                                              child: watch.favAllShop[index]
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
                                  }),
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
                          height: 30.w,
                        ),
                      ])),
            ),
    );
  }
}
