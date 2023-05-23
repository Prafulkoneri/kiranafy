import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/screen/customer/near_shops/controller/all_near_shop_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/shop_profile.dart';
import 'package:provider/provider.dart';
class HomeCarousal extends StatefulWidget {
  const HomeCarousal({super.key});

  @override
  State<HomeCarousal> createState() => _HomeCarousalState();
}

class _HomeCarousalState extends State<HomeCarousal> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<AllNearShopsAsPerPincode>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch=context.watch<AllNearShopsAsPerPincode>();
    final read=context.read<AllNearShopsAsPerPincode>();
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: watch.nearByShopList?.length??0,
          itemBuilder: (BuildContext, index) {
            final element=watch.nearByShopList?[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopProfile()),
                );
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
                            right: index == 2 ? 19.w : 5.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.w),
                          image: element?.shopBannerImagePath==""?DecorationImage(
                              image: AssetImage("assets/images/nearshop2.png"),
                              fit: BoxFit.fill):DecorationImage(
                              image: NetworkImage("${element?.shopBannerImagePath}"),
                              fit: BoxFit.fill),
                        ),
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
                    ],
                  ),
                  Positioned(
                      child: Container(
                    margin: EdgeInsets.only(
                        left: index == 0 ? 19.w : 0,
                        right: index == 2 ? 19.w : 5.w),
                    height: 120.h,
                    width: 168.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.w),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                            0.1,
                            0.9,
                          ],
                          colors: [
                            Colors.white.withOpacity(0),
                            Colors.black.withOpacity(0.05),
                          ],
                        )),
                  )),
                ],
              ),
            );
          }),
    );
  }
}
