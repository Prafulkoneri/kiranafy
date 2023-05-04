import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/controller/s_select_category_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SSelectCategoryView extends StatefulWidget {
  const SSelectCategoryView({Key? key}) : super(key: key);

  @override
  _SSelectCategoryViewState createState() => _SSelectCategoryViewState();
}

class _SSelectCategoryViewState extends State<SSelectCategoryView> {
  @override
  Widget build(BuildContext context) {
    final watch=context.watch<SSelectCategoryController>();
    final read=context.read<SSelectCategoryController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Select Categories",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: (){
            print("hello");
            read.onAppBarActionPressed(context);
          },
        ),
      ),
      body:    GridView.builder(
          padding: EdgeInsets.only(left: 50.w,right: 50.w,top: 40.w,bottom: 40.w),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 20,
              mainAxisExtent: 120),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){

              },
              child: Container(
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          child: Image.asset(
                              "assets/images/cold_drink.png"),
                          height: 60.w,
                          width: 80.w,
                        ),
                       index==0||index==3||index==8? Positioned(right: -5.w,top:-5.w,child: SvgPicture.asset("assets/icons/category_select.svg"))
:Container()
                      ],
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    Text(
                      "Cold Drinks\n& Juices",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: Black1),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
