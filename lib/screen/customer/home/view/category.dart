import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_category_view.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class ShopCategory extends StatefulWidget {
  const ShopCategory({super.key});

  @override
  State<ShopCategory> createState() => _ShopCategoryState();
}

class _ShopCategoryState extends State<ShopCategory> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeScreenController>();
    final read = context.read<HomeScreenController>();
    final readMain = context.read<MainScreenController>();
    return SizedBox(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            watch.categoryFirstList.isNotEmpty
                ? SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: watch.categoryFirstList.length ?? 0,
                      itemBuilder: (BuildContext, index) {
                        final element = watch.categoryFirstList[index];
                        return GestureDetector(
                          onTap: () {
                            readMain.onNavigation(
                                1,
                                AllNearCategoryShopsView(
                                  categoryId: element.id.toString(),
                                  refresh: true,
                                ),
                                context);
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MainScreenView(
                            //           index: 1,
                            //           screenName: AllNearCategoryShopsView(
                            //             categoryId: element.id.toString(),
                            //             refresh: true,
                            //           ))),
                            //   (Route<dynamic> route) => false,
                            // );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 19.w : 0,
                                        // top: 15.w,
                                        right: index == 7 ? 19.w : 5.w),
                                    // margin: EdgeInsets.only(right: 10.h),
                                    decoration: BoxDecoration(
                                        color: CategoryOne,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 50.h,
                                    width: 70.w,
                                    child: Padding(
                                        padding: EdgeInsets.all(8.w),
                                        child: AppNetworkImages(
                                          imageUrl: element.categoryImagePath,
                                        )),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 19.w : 0,
                                        // top: 15.w,
                                        right: index == 7 ? 19.w : 5.w),
                                    alignment: Alignment.center,
                                    width: 70.w,
                                    child: Text(
                                      "${element.categoryName}",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            letterSpacing: .5,
                                            fontSize: 11.5.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container(),
            watch.categorySecondList.isNotEmpty
                ? SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: watch.categorySecondList.length ?? 0,
                      itemBuilder: (BuildContext, index) {
                        final element = watch.categorySecondList[index];
                        return GestureDetector(
                          onTap: () {
                            readMain.onNavigation(
                                1,
                                AllNearCategoryShopsView(
                                  categoryId: element.id.toString(),
                                  refresh: true,
                                ),
                                context);
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MainScreenView(
                            //           index: 1,
                            //           screenName: AllNearCategoryShopsView(
                            //             categoryId: element.id.toString(),
                            //             refresh: true,
                            //           ))),
                            //   (Route<dynamic> route) => false,
                            // );
                            // readMain.onBackPressed(
                            //     1,
                            //     AllNearCategoryShops(
                            //       categoryId: element.id.toString(),
                            //     ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 19.w : 0,
                                        // top: 15.w,
                                        right: index == 7 ? 19.w : 5.w),
                                    // margin: EdgeInsets.only(right: 10.h),
                                    decoration: BoxDecoration(
                                        color: CategoryOne,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    height: 50.h,
                                    width: 70.w,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.w),
                                      child: AppNetworkImages(
                                        imageUrl:
                                            element.categoryImagePath ?? "",
                                        width: 68.w,
                                        height: 49.w,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 19.w : 0,
                                        // top: 15.w,
                                        right: index == 7 ? 19.w : 5.w),
                                    alignment: Alignment.center,
                                    width: 70.w,
                                    child: Text(
                                      "${element.categoryName}",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            letterSpacing: .5,
                                            fontSize: 11.5.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   width: 10.w,
                              // )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
