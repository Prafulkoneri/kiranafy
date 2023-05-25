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
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_view.dart';

import 'package:provider/provider.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();
  PageController? _pageController;

  List<String> images = [
    "assets/images/caurosal.png",
    "assets/images/caurosal.png",
    "assets/images/caurosal.png",
  ];

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
      context.read<HomeScreenController>().initState(context);
    });
    _pageController = PageController(viewportFraction: 0.9, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<HomeScreenController>();
    final watch = context.watch<HomeScreenController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 12.h,
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
                  controller: _searchController,
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

                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(15.w),
                    // ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            ////image
            SizedBox(
              height: 200.h,
              width: MediaQuery.of(context).size.width,
              child: ExpandablePageView.builder(
                  itemCount: watch.data?.length ?? 0,
                  physics: BouncingScrollPhysics(),
                  padEnds: false,
                  pageSnapping: true,
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page;
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    final element = watch.data?[pagePosition];
                    return Container(
                      child: Image.network(
                        "${element?.bannerImagePath}",
                        fit: BoxFit.fill,
                      ),
                      // Image.asset(
                      //   images[pagePosition],
                      //   height: 170.w,
                      //   // width: 340.w,
                      //   // scale: 0.5,
                      //   fit: BoxFit.fill,
                      // ),
                      margin: EdgeInsets.only(
                          left: pagePosition == 0 ? 19.w : 0,
                          // top: 15.w,
                          right:
                              pagePosition == images.length - 1 ? 19.w : 10.w),
                    );
                  }),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(images.length, activePage)),
            SizedBox(
              height: 15.h,
            ),
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
                      readMain.onBackPressed(0, AllNearShops());
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
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: watch.data?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final element = watch.data?[index];
                return Container(
                    padding: EdgeInsets.only(
                      right: 19.0.w,
                      left: 19.0.w,
                    ),
                    width: ScreenUtil().screenWidth,
                    // height: 100.h,
                    child: Image.network(
                      "${element?.bannerImagePath}",
                      fit: BoxFit.cover,
                    )
                    // Image(
                    //   image: AssetImage("assets/images/banner.png"),
                    //   height: 163.h,
                    //   width: 352.w,
                    // ),
                    );
              },
            ),
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
// child: Image.network(
// widget.items?[index]["image"],
// fit: BoxFit.cover,
// ),
// )
// ),
// ),
// ),