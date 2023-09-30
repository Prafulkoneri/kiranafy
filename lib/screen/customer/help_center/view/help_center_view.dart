import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/help_center/controller/ticket_list_controller.dart';
import 'package:local_supper_market/screen/customer/help_center/view/customer_support_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:provider/provider.dart';

class HelpCenterView extends StatefulWidget {
  const HelpCenterView({super.key});

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<GetTicketListController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<GetTicketListController>();
    final read = context.read<GetTicketListController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
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
            title: "Help & Support",
            action: SvgPicture.asset("assets/icons/addressadd.svg"),
            onActionTap: () {
              read.onOpenBottomSheet(context);
            },
          ),
        ),
        body:watch.isLoading? Loader()
        : watch.ticketList?.isNotEmpty == true
            ? WillPopScope(
          onWillPop: ()async{
            readMain.onNavigation(
                4,
                ProfileScreenView(
                  isRefreshed: false,
                  // refresh: false,
                ),
                context);
            return false;
          },
              child: Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 100.w),
                    itemCount: watch.ticketList?.length ?? 0,
                    itemBuilder: (context, index) {
                      final element = watch.ticketList?[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 19.w, right: 19.w),
                            // height: 156.h,
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                print("jfgvrhbhewuirhuiewruiyhwrme");
                                // Within the `FirstRoute` widget

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomerSupportView(
                                          ticketId: element?.id.toString())),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: 17.w,
                                    left: 17.w,
                                    right: 17.w,
                                    top: 14.w),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              text: "Ticket Id -",
                                              style: TextStyle(
                                                  color: Black,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w700),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      ' ${element?.ticketUniqueId}',
                                                  style: TextStyle(
                                                      color: Black,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ]),
                                        ),
                                        Text(
                                          "Status",
                                          style: TextStyle(
                                              color: Black,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${element?.createdAt}",
                                          style: TextStyle(
                                              color: Black,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        // Text(
                                        //   "${element?.ticketStatus}",
                                        //   style: TextStyle(
                                        //       color: Red,
                                        //       fontSize: 13.sp,
                                        //       fontWeight: FontWeight.w700),
                                        // ),
                                        Text(
                                          element?.ticketStatus ?? "",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: element?.ticketStatus ==
                                                        "Pending"
                                                    ? Red
                                                    ///////
                                                    : element?.ticketStatus ==
                                                            "Ongoing"
                                                        ? Color(0xffFF961C)
                                                        ///////
                                                        : element?.ticketStatus ==
                                                                "Closed"
                                                            ? Colors.green
                                                            /////////

                                                            : Colors.transparent,
                                                // letterSpacing: .5
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 9.h,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    Text(
                                      "Subject",
                                      style: TextStyle(
                                          color: Black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      "${element?.subject}",
                                      style: TextStyle(
                                          color: Black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 13.h,
                                    ),
                                    Text(
                                      "Remark",
                                      style: TextStyle(
                                          color: Black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "${element?.description}",
                                      style: TextStyle(
                                          color: Black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(right: 20.w),
                      child: Image.asset(
                        "assets/images/emptycart.png",
                        height: 151.h,
                        width: 151.w,
                      ),
                    ),
                    Text(
                      "No Records Found",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black1,
                            letterSpacing: .5,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
