import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/view/s_category_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/controller/s_select_category_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SSelectCategoryView extends StatefulWidget {
  const SSelectCategoryView({Key? key}) : super(key: key);

  @override
  _SSelectCategoryViewState createState() => _SSelectCategoryViewState();
}

class _SSelectCategoryViewState extends State<SSelectCategoryView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SSelectCategoryController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SSelectCategoryController>();
    final read = context.read<SSelectCategoryController>();
    final watchMainScreen = context.watch<SMainScreenController>();
    final readMainScreen = context.watch<SMainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            readMainScreen.onNavigation(0, const SSCategoryListView(), context);
            // readMainScreen.showBottomNavigationBar();
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => SMainScreenView(
            //           index: 0, screenName: SSCategoryListView())),
            //   (Route<dynamic> route) => false,
            // );
          },
          title: "Select Categories",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () async {
            read.addCategory(context);
          },
        ),
      ),
      body: watch.isLoading
          ? const Loader()
          : WillPopScope(
        onWillPop: ()async{
          readMainScreen.onNavigation(0, const SSCategoryListView(), context);
          readMainScreen.showBottomNavigationBar();
          return false;
        },
            child: GridView.builder(
                padding: EdgeInsets.only(
                    left: 50.w, right: 50.w, top: 40.w, bottom: 90.w),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 115.w),
                itemCount: watch.categoriesList?.length,
                itemBuilder: (BuildContext context, int index) {
                  final element = watch.categoriesList?[index];
                  return GestureDetector(
                    onTap: () {
                      read.onCategorySelected(index, element?.id);
                    },
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                height: 60.w,
                                width: 80.w,
                                child: AppNetworkImages(
                                    imageUrl: "${element?.categoryImagePath}"),
                              ),
                              Positioned(
                                  right: 0.w,
                                  top: 0.w,
                                  child: GestureDetector(
                                    child: watch.selectedCategoryList[index]
                                        ? SvgPicture.asset(
                                            "assets/icons/category_select.svg")
                                        : Container(),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 5.w,
                          ),
                          Flexible(
                            child: Text(
                              "${element?.categoryName}",
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: Black1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
    );
  }
}
