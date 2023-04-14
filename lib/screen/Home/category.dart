import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class ShopCategory extends StatefulWidget {
  const ShopCategory({super.key});

  @override
  State<ShopCategory> createState() => _ShopCategoryState();
}

class _ShopCategoryState extends State<ShopCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 224.h,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            children: [
              SizedBox(
                height: 100.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (BuildContext, index) {
                    return Row(
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
                                      BorderRadius.all(Radius.circular(20))),
                              height: 60.h,
                              width: 80.w,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/gridone.png',
                                  width: 68,
                                  height: 49,
                                ),
                              ),
                            ),
                            Text(
                              "Cold Drink\n & Juices",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    letterSpacing: .5,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   width: 10.w,
                        // )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              SizedBox(
                height: 100.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (BuildContext, index) {
                    return Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              // margin: EdgeInsets.only(right: 10.h),
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 19.w : 0,
                                  // top: 15.w,
                                  right: index == 7 ? 19.w : 5.w),
                              decoration: BoxDecoration(
                                  color: CategoryOne,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: 60.h,
                              width: 80.w,
                              child: Image.asset(
                                'assets/images/gridone.png',
                                width: 68,
                                height: 49,
                              ),
                            ),
                            Text(
                              "Cold Drink\n & Juices",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    letterSpacing: .5,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   width: 10.w,
                        // )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
