import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/home/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';
import '../../near_shops/view/all_near_shops.dart';

class ShopCategory extends StatefulWidget {
  const ShopCategory({super.key});

  @override
  State<ShopCategory> createState() => _ShopCategoryState();
}

class _ShopCategoryState extends State<ShopCategory> {
  @override
  Widget build(BuildContext context) {
    final watch=context.watch<HomeScreenController>();
    final read=context.read<HomeScreenController>();
    return SizedBox(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: watch.categoryList?.length??0,
                itemBuilder: (BuildContext, index) {
                  final element=watch.categoryList?[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllNearShops()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 19.w : 0,
                                  // top: 15.w,
                                  right: index == 7 ? 19.w : 5.w),
                              // margin: EdgeInsets.only(right: 10.h),
                              decoration: BoxDecoration(
                                  color: CategoryOne,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              height: 50.h,
                              width: 70.w,
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Image.network(
                                  element?.categoryImagePath??"",
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
                                "${element?.categoryName}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      letterSpacing: .5,
                                      fontSize: 11.5.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        // SizedBox(
                        //   width: 10.w,
                        // )
                      ],
                    ),
                  );
                },
              ),
            ),
            // SizedBox(
            //   height: 100.h,
            //   child: ListView.builder(
            //     padding: EdgeInsets.zero,
            //     scrollDirection: Axis.horizontal,
            //     physics: NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount: 8,
            //     itemBuilder: (BuildContext, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => AllNearShops()));
            //         },
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Column(
            //               children: [
            //                 Container(
            //                   margin: EdgeInsets.only(
            //                       left: index == 0 ? 19.w : 0,
            //                       // top: 15.w,
            //                       right: index == 7 ? 19.w : 5.w),
            //                   // margin: EdgeInsets.only(right: 10.h),
            //                   decoration: BoxDecoration(
            //                       color: CategoryOne,
            //                       borderRadius:
            //                       BorderRadius.all(Radius.circular(10))),
            //                   height: 50.h,
            //                   width: 70.w,
            //                   child: Padding(
            //                     padding: EdgeInsets.all(8.w),
            //                     child: Image.asset(
            //                       'assets/images/gridone.png',
            //                       width: 68.w,
            //                       height: 49.w,
            //                     ),
            //                   ),
            //                 ),
            //                 Container(
            //                   margin: EdgeInsets.only(
            //                       left: index == 0 ? 19.w : 0,
            //                       // top: 15.w,
            //                       right: index == 7 ? 19.w : 5.w),
            //                   alignment: Alignment.center,
            //                   width: 70.w,
            //                   child: Text(
            //                     "Cold Drink\n & Juices",
            //                     textAlign: TextAlign.center,
            //                     style: GoogleFonts.dmSans(
            //                       textStyle: TextStyle(
            //                           color: Black,
            //                           letterSpacing: .5,
            //                           fontSize: 11.5.sp,
            //                           fontWeight: FontWeight.w500),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //             ),
            //             // SizedBox(
            //             //   width: 10.w,
            //             // )
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
