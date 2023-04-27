import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intellect_flutter/screens/chat_list/controllers/chat_list_controller.dart';

import 'package:intellect_flutter/screens/chat_list/views/chat_list_screen_view.dart';
import 'package:intellect_flutter/screens/dashboard/controllers/dash_board_controller.dart';
import 'package:intellect_flutter/screens/dashboard/views/dash_board_view.dart';
import 'package:intellect_flutter/screens/drawer/views/drawer.dart';
import 'package:intellect_flutter/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:intellect_flutter/screens/my_connect/views/my_connect_screen_view.dart';
import 'package:intellect_flutter/screens/profile/views/profile_screen_view.dart';
import 'package:intellect_flutter/screens/search/views/search_screen_view.dart';
import 'package:intellect_flutter/screens/student_forms/views/student_academic_details_view.dart';
import 'package:intellect_flutter/screens/view_all/views/view_all_screen_view.dart';
import 'package:intellect_flutter/widgets/app_header.dart';
import 'package:provider/provider.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  _MainScreenViewState createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final watchDashBoardController = context.watch<DashBoardController>();
    final readDashBoardController = context.read<DashBoardController>();
    final read = context.read<MainScreenController>();
    final watch = context.watch<MainScreenController>();
    return Scaffold(
      key: watchDashBoardController.scaffoldKey,
      drawer: DrawerScreenView(),
      extendBody: true,
      bottomNavigationBar: Container(
          height: 70.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.w),
                topLeft: Radius.circular(30.w)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 2),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
            child: BottomAppBar(
              child: Container(
                padding: EdgeInsets.only(left: 35.w, right: 35.w, top: 16.w),
                height: 70.w,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        read.onDashboardPressed();
                      },
                      child: watch.currentTab == 0
                          ? Column(
                              children: [
                                Container(
                                  height: 20.w,
                                  width: 21.w,
                                  child: SvgPicture.asset(
                                    "assets/icons/home.svg",
                                    color: Color(0xff1C2C51),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp,
                                      color: Color(0xff1C2C51)),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  height: 20.w,
                                  width: 21.w,
                                  child: SvgPicture.asset(
                                    "assets/icons/home.svg",
                                    color: Color(0xffABABAB),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp,
                                      color: Color(0xff1C2C51)),
                                )
                              ],
                            ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                          onTap: () {
                            read.onSearchPressed();
                          },
                          child: watch.currentTab == 1
                              ? Column(
                                  children: [
                                    Container(
                                      height: 20.w,
                                      width: 21.w,
                                      child: SvgPicture.asset(
                                        "assets/icons/search.svg",
                                        color: Color(0xff1C2C51),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.w,
                                    ),
                                    Text(
                                      "Search",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp,
                                          color: Color(0xff1C2C51)),
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height: 20.w,
                                      width: 21.w,
                                      child: SvgPicture.asset(
                                          "assets/icons/search.svg"),
                                    ),
                                    SizedBox(
                                      height: 5.w,
                                    ),
                                    Text(
                                      "Search",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp,
                                          color: Color(0xff1C2C51)),
                                    )
                                  ],
                                ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 50.w),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            read.onMyConnectPressed();
                          },
                          child: watch.currentTab == 2
                              ? Column(
                                  children: [
                                    Container(
                                      height: 20.w,
                                      width: 21.w,
                                      child: Image.asset(
                                        "assets/images/connect_bottom_nav.png",
                                        color: Color(0xff1C2C51),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.w,
                                    ),
                                    Text(
                                      "My Connects",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp,
                                          color: Color(0xff1C2C51)),
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height: 20.w,
                                      width: 21.w,
                                      child: Image.asset(
                                        "assets/images/connect_bottom_nav.png",
                                        color: Color(0xffABABAB),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.w,
                                    ),
                                    Text(
                                      "My Connects",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp,
                                          color: Color(0xff1C2C51)),
                                    )
                                  ],
                                ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        read.onProfilePressed();
                      },
                      child: watch.currentTab == 3
                          ? Column(
                              children: [
                                Container(
                                  height: 20.w,
                                  width: 21.w,
                                  child: SvgPicture.asset(
                                    "assets/icons/profile.svg",
                                    color: Color(0xff1C2C51),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp,
                                      color: Color(0xff1C2C51)),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  height: 20.w,
                                  width: 21.w,
                                  child: SvgPicture.asset(
                                      "assets/icons/profile.svg"),
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp),
                                )
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: () {
          read.onChatPressed();
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 60.w),
          height: 62.w,
          width: 62.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0,
                top: 40.w,
                left: 0,
                child: Container(
                  height: 62.w,
                  width: 62.w,
                  child: Image.asset(
                    "assets/images/fab_rectangle.png",
                  ),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom:-23.w,
                child: SvgPicture.asset("assets/icons/chat.svg"),
              ),
            ],
          ),
        ),
      ),
      body: PageStorage(
        bucket: watch.bucket,
        child: watch.currentScreen,
      ),
    );
  }
}
