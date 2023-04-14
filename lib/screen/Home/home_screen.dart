import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/Home/nearby_shop.dart';
import 'package:local_supper_market/screen/Home/category.dart';
import 'package:local_supper_market/screen/Home/coupons.dart';
import 'package:local_supper_market/screen/Home/offers.dart';
import 'package:local_supper_market/screen/near_shops/all_near_shops.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();
  PageController? _pageController;

  List<String> images = [
    "assets/images/caurosal.png",
    "assets/images/caurosal.png",
    "assets/images/caurosal.png",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 1);
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: 12.h,
            // ),
            Padding(
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
                        // width: 15.w,
                        // height: 19.h,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "Vishrantwadi, Pune",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: SplashText1,
                              letterSpacing: .5,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                right: 19.0.w,
                left: 19.0.w,
                top: 13.h,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: splashnone),
                      borderRadius: BorderRadius.circular(8.w)),
                  hintText: 'Search your shop and products..',
                  hintStyle: TextStyle(
                      color: kgrey,
                      letterSpacing: .5,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),

                  // Add a clear button to the search bar

                  // Add a search icon or button to the search bar
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Black,
                      size: 25.h,
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
            SizedBox(
              height: 15.h,
            ),

            ////image
            SizedBox(
              // width: MediaQuery.of(context).size.width,
              height: 170.w,
              child: PageView.builder(
                  itemCount: images.length,
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
                    return Container(
                      child: Image.asset(
                        images[pagePosition],
                        height: 170.w,
                        // width: 340.w,
                        // scale: 0.5,
                        fit: BoxFit.fill,
                      ),
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

            ////

            Padding(
              padding: EdgeInsets.only(right: 19.0.w, top: 27.w, left: 19.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nearby Shops",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          letterSpacing: .5,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AllNearShops()),
                      );
                    },
                    child: Text(
                      "View All",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: SplashText,
                            letterSpacing: .5,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //
            HomeCarousal(),

            Padding(
              padding: EdgeInsets.only(right: 19.0.w, left: 19.0.w, top: 30.h),
              child: Text(
                "Shop By Category",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Black,
                      letterSpacing: .5,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),

            SizedBox(
              height: 15.h,
            ),
            ShopCategory(),
            SizedBox(
              height: 20.h,
            ),
            CouponsScreen(),

            OfferPage(),
            //
            Padding(
              padding: EdgeInsets.only(
                left: 19.w,
                right: 19.w,
                // top: 18.w,
                // bottom: 17.h,
              ),
              child: Image(
                image: AssetImage("assets/images/banner.png"),
                height: 163.h,
                width: 352.w,
              ),
            )
          ],
        ),
      ),
    );
  }
}
