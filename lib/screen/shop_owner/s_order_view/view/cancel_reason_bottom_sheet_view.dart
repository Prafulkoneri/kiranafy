import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/controller/s_customer_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/controller/shop_owner_order_view_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class cancelOrderFiltterView extends StatefulWidget {
  const cancelOrderFiltterView({super.key});

  @override
  State<cancelOrderFiltterView> createState() => _cancelOrderFiltterViewState();
}

class _cancelOrderFiltterViewState extends State<cancelOrderFiltterView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopOwnerOrderViewController>();
    final watch = context.watch<ShopOwnerOrderViewController>();
    return Stack(
      children: [
        SingleChildScrollView(
              child: Container(
                // height: 326.h,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                width: 390.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20.h,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reason",
                              style: TextStyle(
                                  color: Black1,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                "assets/icons/nav_close.svg",
                                // width: 5.h,
                                // height: 5.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Divider(
                      // height: 20,
                      thickness: 1,
                      indent: 19,
                      endIndent: 19,
                      color: grey1,
                    ),
                    ListView.builder(
                      itemCount: watch.cancelReasondata?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final element = watch.cancelReasondata?[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            top: 17.w,
                          ),
                          child: Row(
                            children: [
                              PrimaryCheckBox(
                                value: watch.isSelectedReason[index],
                                onChanged: (value) {
                                  read.onSelectReason(index, value);
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  "${element?.reason}",
                                  // "Product Not Available",
                                  style: TextStyle(
                                      color: Black1,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                      ),
                      child: Row(
                        children: [
                          PrimaryCheckBox(
                            value: watch.isOtherReasonSelected,
                            onChanged: (value) {
                              read.onOtherSelected(value);
                            },
                          ),
                          Text(
                            "Other",
                            style: TextStyle(
                                color: Black1,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.w, top: 24.w, bottom: 17.w, right: 19.w),
                      // padding: const EdgeInsets.all(8.0),
                      child: PrimarySTextFormField(
                        // controller: watch.termsAndConditionController,/
                        height: 150.w,
                        maxLines: 10,
                        // hintText: "Address",/
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.w, top: 24.w, bottom: 20.w, right: 19.w),
                      child: SizedBox(
                        width: 352.w, // <-- Your width
                        height: 35.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff39C19D),
                            // onPrimary: Colors.white,
                            // shadowColor: Colors.greenAccent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                            minimumSize: const Size(100, 40), //////// HERE
                          ),
                          // style: style,
                          onPressed: () {

                          },
                          child: Text(
                            'Submit',
                            style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                  // color: SplashTex
                                  letterSpacing: .5,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: watch.isCancelOrderErrorMsgVisible,
              child: Container(
                padding: EdgeInsets.only(
                    top: 15.w, bottom: 15.w, left: 10.w, right: 10.w),
                margin: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
                color: Colors.red,
                width: ScreenUtil().screenWidth,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Invalid Otp",
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            read.onCancelErrorMissageDismiss();
                          },
                          child: Text("Dismiss"),
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
    );

  }
}
