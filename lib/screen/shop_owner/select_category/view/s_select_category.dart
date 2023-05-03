import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Select Categories",
          action: SvgPicture.asset("assets/icons/forward.svg"),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.only(left: 50.w,right: 50.w,top: 40.w),
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30.0,
              childAspectRatio: 150.w/120.w,
              mainAxisSpacing: 30.w),
          itemBuilder: (BuildContext, index) {
            return  Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(right: 10.h),
                  decoration: BoxDecoration(
                      color: CategoryOne,
                      borderRadius:
                      BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Image.asset(
                      'assets/images/gridone.png',
                      width: 59.w,height: 39.w,
                    ),
                  ),
                ),
                SizedBox(
                  height: 9.w,
                ),
                Text("Cold Drinks & Juices",style:  TextStyle(
                    color: Black,
                    letterSpacing: .5,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w500),),
              ],
            );
          }),
    );
  }
}
