import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/controller/s_category_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/view/s_select_category_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

import '../../s_products/view/s_selected_products_view.dart';

class SSCategoryListView extends StatefulWidget {
  const SSCategoryListView({Key? key}) : super(key: key);

  @override
  _SSCategoryListViewState createState() => _SSCategoryListViewState();
}

class _SSCategoryListViewState extends State<SSCategoryListView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SCategoryListController>().initState(context);
    });
  }

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
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SMainScreenView(
                      index: 0, screenName: ShopDashBoardView())),
              (Route<dynamic> route) => false,
            );
          },
          title: "Categories",
          action: SvgPicture.asset("assets/icons/addressadd.svg"),
          onActionTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SMainScreenView(
                      index: 0, screenName: SSelectCategoryView())),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: RefreshIndicator(
                  onRefresh: () async {
                    // readMainScreen.onNavigation(
                    //     0, SSCategoryListView(), context);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.w,
                      ),
                      ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 19.w, vertical: 15.w),
                          itemCount: watch.selectedCategoriesList?.length ?? 0,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext, index) {
                            final element =
                                watch.selectedCategoriesList?[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SMainScreenView(
                                              index: 0,
                                              screenName: SSelectedProductView(
                                                  isRefresh: true,
                                                  categoryId: element
                                                      ?.categoryId
                                                      .toString()))),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black
                                                .withOpacity(0.03.w),
                                            blurRadius: 5,
                                            spreadRadius: 0,
                                            offset: Offset(5, 6)),
                                      ],
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.07)),
                                      borderRadius: BorderRadius.circular(7.w),
                                    ),
                                    padding: EdgeInsets.only(
                                        top: 15.w,
                                        bottom: 13.w,
                                        right: 20.w,
                                        left: 13.w),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 46.w,
                                          height: 46.w,
                                          // width: 55.w,
                                          // height: 40.h,
                                          child: AppNetworkImages(
                                              imageUrl:
                                                  "${element?.categoryImagePath}"),
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
                                                    "${element?.categoryName}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp,
                                                        color: Black1),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${element?.categoryCount} Products",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
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
                      SizedBox(
                        height: 65.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
