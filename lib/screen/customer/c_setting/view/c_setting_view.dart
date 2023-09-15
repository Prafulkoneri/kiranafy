import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/c_setting/controller/c_setting_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

class CustomerSetting extends StatefulWidget {
  const CustomerSetting({super.key});

  @override
  State<CustomerSetting> createState() => _CustomerSettingState();
}

class _CustomerSettingState extends State<CustomerSetting> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerSettingController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CustomerSettingController>();
    final read = context.read<CustomerSettingController>();
    final readMain = context.read<MainScreenController>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "Settings",
          onBackBtnPressed: () {
            readMain.onNavigation(
                4,
                ProfileScreenView(
                  isRefreshed: false,
                  // refresh: false,
                ),
                context);
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => MainScreenView(
            //           index: 4,
            //           screenName: ProfileScreenView(
            //             isRefreshed: false,
            //               // refresh: false,
            //               ))),
            //   (Route<dynamic> route) => false,
            // );
          },
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.only(left: 19.w, top: 20.w, right: 19.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "App Notification",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Black1),
                      ),
                      CupertinoSwitch(
                        // This bool value toggles the switch.
                        value: watch.isAppNotificationEnable,
                        activeColor: DarkGreen,
                        onChanged: (bool? value) {
                          watch.changeSettings(context, value);
                          //  watch.shopNotification(context,"");
                          // This is called when the user toggles the switch.
                        },
                      ),
                    ],
                  ),
                  Text(
                    "Enable or disable the notifications coming up.",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Black1),
                  ),
                  SizedBox(
                    height: 41.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Delete Account",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: Black1),
                        ),
                        GestureDetector(
                          onTap: () {
                            // read.shopAccountDelete(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Color(0xffFFFFFF),
                                    // shape: ,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),

                                    // scrollable: true,
                                    child: Container(
                                      height: 205.h,
                                      // width: 400.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              "Do you really want to delete your account ? ",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Color(0xff006F94),
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 37.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 19.w,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    read.CustomerAccountDelete(
                                                        context);
                                                    //  read.shopAccountDelete(context);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 24.w,
                                                        right: 24.w,
                                                        top: 9.w,
                                                        bottom: 9.w),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff39C19D),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Text(
                                                      "Yes",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            // letterSpacing: .5,
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 14.w,
                                                        right: 15.w,
                                                        top: 9.w,
                                                        bottom: 9.w),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffEC7074),
                                                        // border: Border.all(width: 1, color: Black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "No",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            textStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    // letterSpacing: .5,
                                                                    fontSize:
                                                                        20.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: SvgPicture.asset(
                            "assets/icons/delete2.svg",
                            height: 20.h,
                            width: 18.w,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 31.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: Color(0xffE0E0E0),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "App Version - ${watch.appVersion}",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Black1),
                  ),
                ],
              ),
            ),
    );
  }
}
