import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:provider/provider.dart';

class HomeCarousal extends StatefulWidget {
  const HomeCarousal({super.key});

  @override
  State<HomeCarousal> createState() => _HomeCarousalState();
}

class _HomeCarousalState extends State<HomeCarousal> {
  @override
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeScreenController>();
    final readMainScreen = context.watch<MainScreenController>();
    return watch.nearByShopList?.isNotEmpty ?? false
        ? WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: SizedBox(
              height: 120.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: watch.nearByShopList?.length ?? 0,
                  itemBuilder: (BuildContext, index) {
                    final element = watch.nearByShopList?[index];
                    return GestureDetector(
                      onTap: () {
                        readMainScreen.onNavigation(
                            1,
                            ShopProfileView(
                              shopId: element?.id.toString(),
                              routeName: "homeNearbyShop",
                              refreshPage: true,
                            ),
                            context);
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => MainScreenView(
                        //           index: 1,
                        //           screenName: ShopProfileView(
                        //             shopId: element?.id.toString(),
                        //             routeName: "homeNearbyShop",
                        //             refreshPage: true,
                        //           ))),
                        //   (Route<dynamic> route) => false,
                        // );
                      },
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 120.h,
                                width: 168.w,
                                margin: EdgeInsets.only(
                                    left: index == 0 ? 19.w : 0,
                                    right: index == 10 ? 19.w : 5.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.w),
                                  image: element?.shopBannerImagePath == ""
                                      ? const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/nearshop2.png"),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: NetworkImage(
                                              "${element?.shopBannerImagePath}"),
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 19.w : 0,
                                  right:
                                      index + 1 == watch.nearByShopList?.length
                                          ? 19.w
                                          : 5.w),
                              height: 120.h,
                              width: 168.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.w),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [
                                      0.1,
                                      0.9,
                                    ],
                                    colors: [
                                      Colors.white.withOpacity(0),
                                      Colors.black.withOpacity(0.3),
                                    ],
                                  )),
                              child: Container(
                                padding: EdgeInsets.all(10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("${element?.shopName}",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                // letterSpacing: .5,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600))),
                                    Text("${element?.areaName}",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                // letterSpacing: .5,
                                                fontSize: 12.sp,
                                                // height: 10,
                                                fontWeight: FontWeight.w400))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          )
        : Container();
  }
}
