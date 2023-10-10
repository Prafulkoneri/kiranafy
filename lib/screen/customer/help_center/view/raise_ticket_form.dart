import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/help_center/controller/ticket_list_controller.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class RaiseTicketView extends StatefulWidget {
  const RaiseTicketView({super.key});

  @override
  State<RaiseTicketView> createState() => _RaiseTicketViewState();
}

class _RaiseTicketViewState extends State<RaiseTicketView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<GetTicketListController>();
    final watch = context.watch<GetTicketListController>();
    return
      SingleChildScrollView(
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
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0),
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
                    Divider(),
                    SizedBox(
                      height: 22.h,
                    ),
                    Text(
                      "Type",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: Color(0xff575574)),
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
                          color: Color(0xff575574)),
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
                          color: Color(0xff575574)),
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
                      color: Color(0xff4689EC),
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
                  decoration: BoxDecoration(
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
                    children: [
                      Expanded(
                        child: Text(
                          "${watch.errorMsgForRaiseTicket}",
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
