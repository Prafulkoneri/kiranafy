import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/notification/controller/notification_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/view/shop_order_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

class NotificationsScreenView extends StatefulWidget {
  const NotificationsScreenView({Key? key}) : super(key: key);

  @override
  _NotificationsScreenViewState createState() =>
      _NotificationsScreenViewState();
}

class _NotificationsScreenViewState extends State<NotificationsScreenView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ShopNoticationController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopNoticationController>();
    final watch = context.watch<ShopNoticationController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            onBackBtnPressed: () {
              Navigator.pop(context);
            },
            title: "Notifications",
            action: InkWell(
              onTap: () {
                // await read.sDeleteNotification(
                //   context,
                // );
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Color(0xffFFFFFF),
                        // shape: ,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),

                        // scrollable: true,
                        child: Container(
                          height: 205.h,
                          // width: 400.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  "Do you really want to All Notification ? ",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Color(0xff006F94),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700),
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
                                      onTap: () async {
                                        await read.sDeleteNotification(
                                          context,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 24.w,
                                            right: 24.w,
                                            top: 9.w,
                                            bottom: 9.w),
                                        decoration: BoxDecoration(
                                            color: Color(0xff39C19D),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                          "Yes",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                // letterSpacing: .5,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w700),
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
                                            color: Color(0xffEC7074),
                                            // border: Border.all(width: 1, color: Black),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            Text(
                                              "No",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    // letterSpacing: .5,
                                                    fontSize: 20.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                'assets/images/delete.svg',
                width: 20.w,
                height: 18.h,
              ),
            ),
          ),
        ),
        body: watch.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 19.w, horizontal: 19.w),
                shrinkWrap: true,
                itemCount: watch.notificationList?.length ?? 0,
                itemBuilder: (BuildContext, index) {
                  final element = watch.notificationList?[index];
                  return GestureDetector(
                    onTap: () {
                      if (element?.notificationType == "order") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShopOrderView(
                                  fromOrderStatus: true,
                                      selectedIndex: 0,
                                      orderId: element?.orderId.toString(),
                                    )));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          right: 16.w, left: 16.w, top: 19.w, bottom: 15.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 5,
                              offset: Offset(-.0, 5.0),
                              spreadRadius: 0),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 19.w),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                                "assets/icons/notification_bell_icon.svg"),
                            SizedBox(
                              width: 15.2.w,
                            ),
                            VerticalDivider(
                              color: Color(0xffEFEFEF),
                              thickness: 1,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${element?.title}",
                                    // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Facilisi semper egestas at cursus maecenas",
                                    style: TextStyle(
                                        fontSize: 11.5.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Black1),
                                  ),
                                  SizedBox(
                                    height: 18.w,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/calendar1.svg"),
                                      SizedBox(
                                        width: 8.87.w,
                                      ),
                                      Text(
                                        "${element?.createdAt}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp,
                                            color: Black1),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }));
  }
}
