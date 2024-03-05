import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/controller/ticket_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class SRaiseTicketView extends StatefulWidget {
  const SRaiseTicketView({super.key});

  @override
  State<SRaiseTicketView> createState() => _SRaiseTicketViewState();
}

class _SRaiseTicketViewState extends State<SRaiseTicketView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SGetTicketListController>();
    final watch = context.watch<SGetTicketListController>();
    final readMainScreen = context.read<SMainScreenController>();
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                margin: EdgeInsets.only(
                  left: 26.w,
                  right: 25.w,
                  top: 25.w,
                ),
                // height: MediaQuery.of(context).size.height * 0.50,
                // height: 563.h,
                // width: 390.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Raised New Ticket",
                      style: TextStyle(
                          color: Black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 22.h,
                    ),
                    Text(
                      "Type",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: const Color(0xff575574)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SDropDownField(
                      onChanged: (value) async {
                        await read.onTicketTypeSelected(value);
                      },
                      items: watch.ticketTypeData
                          ?.map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(
                          item.ticketType ?? "",
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      ))
                          .toList(),
                      // hint: "Shop Type",
                    ),

                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Subject",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: const Color(0xff575574)),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    PrimarySTextFormField(
                      controller: watch.subjectController,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: const Color(0xff575574)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PrimarySTextFormField(
                      controller: watch.descriptionController,
                      height: 130.w,
                      maxLines: 10,
                      // hintText: "Address",/
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    PrimaryButton(
                      fontSize: 20.sp,
                      height: 50.w,
                      text: "Submit",
                      color: const Color(0xff4689EC),
                      onTap: () {
                        read.createTicket(context);
                      },
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    // SizedBox(
                    //   height: 500.h,
                    // )
                  ],
                ),
              ),
            ],
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.only(
          //           bottom: MediaQuery.of(context).viewInsets.bottom),
          //       margin: EdgeInsets.only(
          //         left: 26.w,
          //         right: 25.w,
          //         top: 25.w,
          //       ),
          //       // height: MediaQuery.of(context).size.height * 0.50,
          //       // height: 563.h,
          //       // width: 390.w,/
          //       decoration: new BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: new BorderRadius.only(
          //           topLeft: const Radius.circular(25.0),
          //           topRight: const Radius.circular(25.0),
          //         ),
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Raised New Ticket",
          //             style: TextStyle(
          //                 color: Black,
          //                 fontSize: 20.sp,
          //                 fontWeight: FontWeight.w700),
          //           ),
          //           SizedBox(
          //             height: 20.h,
          //           ),
          //           Divider(),
          //           SizedBox(
          //             height: 22.h,
          //           ),
          //           Text(
          //             "Type",
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w700,
          //                 fontSize: 16.sp,
          //                 color: Color(0xff575574)),
          //           ),
          //           SizedBox(
          //             height: 15.h,
          //           ),
          //           SDropDownField(
          //             onChanged: (value) async {
          //               await read.onTicketTypeSelected(value);
          //             },
          //             items: watch.ticketTypeData
          //                 ?.map((item) => DropdownMenuItem<String>(
          //                       value: item.id.toString(),
          //                       child: Text(
          //                         item.ticketType ?? "",
          //                         style: TextStyle(
          //                           fontSize: 14.sp,
          //                         ),
          //                       ),
          //                     ))
          //                 .toList(),
          //             // hint: "Shop Type",
          //           ),
          //
          //           SizedBox(
          //             height: 15.h,
          //           ),
          //           Text(
          //             "Subject",
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w700,
          //                 fontSize: 16.sp,
          //                 color: Color(0xff575574)),
          //           ),
          //           SizedBox(
          //             height: 11.h,
          //           ),
          //           PrimarySTextFormField(
          //             controller: watch.subjectController,
          //           ),
          //           SizedBox(
          //             height: 26.h,
          //           ),
          //           Text(
          //             "Description",
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w700,
          //                 fontSize: 16.sp,
          //                 color: Color(0xff575574)),
          //           ),
          //           SizedBox(
          //             height: 10.h,
          //           ),
          //           PrimarySTextFormField(
          //             controller: watch.descriptionController,
          //             height: 150.w,
          //             maxLines: 10,
          //             // hintText: "Address",/
          //           ),
          //           SizedBox(
          //             height: 37.h,
          //           ),
          //           PrimaryButton(
          //             fontSize: 20.sp,
          //             height: 50.w,
          //             text: "Submit",
          //             color: Color(0xff4689EC),
          //             onTap: () {
          //               read.createTicket(context);
          //             },
          //           ),
          //           SizedBox(
          //             height: 37.h,
          //           ),
          //           // SizedBox(
          //           //   height: 500.h,
          //           // )
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

          ///top icon
          Positioned(
              top: -60.w,
              left: 0.w,
              right: 0.w,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50.w,
                  width: 50.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/Cross.svg',
                      width: 15.w,
                      height: 15.h,
                    ),
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Visibility(
                visible: watch.isTickedError,
                child: Container(
                  padding: EdgeInsets.only(
                      top: 15.w, bottom: 15.w, left: 10.w, right: 10.w),
                  margin:
                  EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
                  color: Colors.red,
                  width: ScreenUtil().screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          watch.errorMsgForRaiseTicket,
                          style:
                          TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              read.onTicketDissmis();
                            },
                            child: Text(
                              "Dismiss",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
