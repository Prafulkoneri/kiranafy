import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';

class SSCategoryListView extends StatefulWidget {
  const SSCategoryListView({Key? key}) : super(key: key);

  @override
  _SSCategoryListViewState createState() => _SSCategoryListViewState();
}

class _SSCategoryListViewState extends State<SSCategoryListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(title: "Categories",action:SvgPicture.asset("assets/icons/addressadd.svg"),onActionTap: (){

        },),
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
                    Container(
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
                              SvgPicture.asset("assets/icons/arrow_right.svg"),
                            ],
                          ),
                        ],
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
