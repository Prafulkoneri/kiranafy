import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';

class NotificationsScreenView extends StatefulWidget {
  const NotificationsScreenView({Key? key}) : super(key: key);

  @override
  _NotificationsScreenViewState createState() =>
      _NotificationsScreenViewState();
}

class _NotificationsScreenViewState extends State<NotificationsScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.w),
          child: PrimaryAppBar(
              title: "Notifications",
              action: SvgPicture.asset("assets/icons/delete.svg")),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 19.w, horizontal: 19.w),
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (BuildContext, index) {
              return Container(
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
                          children: [
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Facilisi semper egestas at cursus maecenas",
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
                                SvgPicture.asset("assets/icons/calendar1.svg"),
                                SizedBox(
                                  width: 8.87.w,
                                ),
                                Text(
                                  "12 march 2023",
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
              );
            }));
  }
}
