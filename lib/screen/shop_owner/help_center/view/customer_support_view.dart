import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/controller/view_ticket_controller.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/view/help_center_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class CustomerSupportView extends StatefulWidget {
  final String? ticketId;

  const CustomerSupportView({
    super.key,
    this.ticketId,
  });

  @override
  State<CustomerSupportView> createState() => _CustomerSupportViewState();
}

class _CustomerSupportViewState extends State<CustomerSupportView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ShopViewTicketController>().initState(
            context,
            widget.ticketId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ShopViewTicketController>();
    final read = context.read<ShopViewTicketController>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.w),
          child: PrimaryAppBar(
            onBackBtnPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => SMainScreenView(
                        index: 4, screenName: HelpCenterView())),
                (Route<dynamic> route) => false,
              );
            },
            title: "Help & Support",
          ),
        ),
        body: watch.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 19.w, top: 20.h, right: 19.w),
                        child: Column(
                          children: [
                            Container(
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
                                                    ' ${watch.ticketDetails?.ticketUniqueId}',
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
                                        "${watch.ticketDetails?.createdAt}",
                                        style: TextStyle(
                                            color: Black,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        watch.ticketDetails?.ticketStatus ?? "",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: watch.ticketDetails
                                                          ?.ticketStatus ==
                                                      "Pending"
                                                  ? Red
                                                  ///////
                                                  : watch.ticketDetails
                                                              ?.ticketStatus ==
                                                          "Ongoing"
                                                      ? Color(0xffFF961C)
                                                      ///////
                                                      : watch.ticketDetails
                                                                  ?.ticketStatus ==
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
                                    "${watch.ticketDetails?.subject}",
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
                                    "${watch.ticketDetails?.description}",
                                    style: TextStyle(
                                        color: Black,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            ListView.builder(
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: watch.ticketRepliesList?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final element = watch.ticketRepliesList?[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff44B8CA),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 19.w,
                                        bottom: 11.w,
                                        right: 13.w,
                                        top: 10.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: grey6,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            element?.profileImagePath == ""
                                                ? Container(
                                                    height: 37.w,
                                                    width: 37.w,
                                                    child: Image.asset(
                                                      "assets/images/profile_image.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Container(
                                                    height: 37.w,
                                                    width: 37.w,
                                                    child: AppNetworkImages(
                                                      imageUrl:
                                                          "${element?.profileImagePath}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // SizedBox(
                                                //   height: 6.h,
                                                // ),
                                                Text(
                                                  "${element?.name}",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${element?.createdAt}",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: Color(0xff319FB0),
                                          thickness: 1,
                                        ),
                                        Text(
                                          "${element?.remark}",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: PrimarySTextFormField(
                      controller: watch.remarkController,
                      height: 65.h,
                      maxLines: 5,
                      hintText: "Please text a message..",
                      hintFontSize: 13,
                      suffix: Padding(
                        padding: EdgeInsets.only(right: 14.w),
                        child: GestureDetector(
                            onTap: () {
                              read.ticketReply(context);
                            },
                            child: SvgPicture.asset("assets/icons/send.svg")),
                      ),
                      enableBorder: false,
                    ),
                  ),
                ],
              ));
  }
}
