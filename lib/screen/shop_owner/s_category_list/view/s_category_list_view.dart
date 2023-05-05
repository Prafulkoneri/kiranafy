import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/controller/s_category_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

import '../../s_products/view/s_products_view.dart';

class SSCategoryListView extends StatefulWidget {
  const SSCategoryListView({Key? key}) : super(key: key);

  @override
  _SSCategoryListViewState createState() => _SSCategoryListViewState();
}

class _SSCategoryListViewState extends State<SSCategoryListView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SCategoryListController>();
    final watch = context.watch<SCategoryListController>();
    final watchMainScreen = context.watch<SMainScreenController>();
    final readMainScreen = context.watch<SMainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Categories",
          action: SvgPicture.asset("assets/icons/addressadd.svg"),
          onActionTap: () {
            readMainScreen.onCategoryAddPressed();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5.w,
          ),
          ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 15.w),
              itemCount: 5,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        read.onProductSelect(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.03.w),
                                blurRadius: 5,
                                spreadRadius: 0,
                                offset: Offset(5, 6)),
                          ],
                          border:
                              Border.all(color: Colors.black.withOpacity(0.07)),
                          borderRadius: BorderRadius.circular(7.w),
                        ),
                        padding: EdgeInsets.only(
                            top: 16.w, bottom: 16.w, right: 20.w, left: 11.w),
                        child: Row(
                          children: [
                            Container(
                              width: 55.w,
                              height: 40.w,
                              child: Image.asset("assets/images/gridone.png"),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Cold Drinks & Juices",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: Black1),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "20 Products",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp,
                                            color: Black1),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/icons/arrow_right.svg"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.w,
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
