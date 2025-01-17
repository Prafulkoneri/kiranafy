import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class ExpectedDeliveryDateSheetView extends StatefulWidget {
  const ExpectedDeliveryDateSheetView({Key? key}) : super(key: key);

  @override
  _ExpectedDeliveryDateSheetViewState createState() =>
      _ExpectedDeliveryDateSheetViewState();
}

class _ExpectedDeliveryDateSheetViewState
    extends State<ExpectedDeliveryDateSheetView> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<OrderSummaryController>();
    final read = context.read<OrderSummaryController>();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Container(
        // ,
        // ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 17.w),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 17.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expected Delivery Date",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff006F94)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 20.w,
                      width: 20.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/Cross.svg',
                          width: 8.w,
                          height: 8.h,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.w,
              ),
              PrimaryCTextFormField(
                borderColor: const Color(0xff4689EC).withOpacity(0.55.w),
                hintText: "Expected Delivery Date",
                readOnly: true,
                onTap: () async {
                  var pickedDate = await showDatePicker(
                    builder: (BuildContext, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xff1767B1),
                            // <-- SEE HERE
                            onPrimary: Colors.white,
                            // <-- SEE HERE
                            onSurface: Colors.black, // <-- SEE HERE
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xff1767B1), // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    String date = DateFormat('dd-MM-yyy')
                        .format(pickedDate ?? DateTime.now());
                    read.onExpectedDateSelected(date);
                  }
                },
                controller: watch.expectedDateController,
                suffix: SizedBox(
                  width: 15.h,
                  height: 17.w,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/expected_delivery_date.svg",
                    ),
                  ),
                ),
                textStyle: TextStyle(
                    color: Black1.withOpacity(0.63),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp),
                hintStyle: TextStyle(
                    color: Black1.withOpacity(0.63),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp),
              ),
              SizedBox(
                height: 16.w,
              ),
              Text(
                "Expected Delivery Slot",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff006F94)),
              ),
              SizedBox(
                height: 20.w,
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: watch.shopDeliverySlots?.length ?? 0,
                  itemBuilder: (BuildContext, index) {
                    return GestureDetector(
                      onTap: () {
                        watch.isSlotAvailable[index]?read.onDeliverySlotSelected(
                            watch.shopDeliverySlots?[index]):null;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 11.w, vertical: 8.w),
                        decoration: BoxDecoration(
                          color: watch.isSlotAvailable[index]?Colors.transparent:Colors.grey.withOpacity(0.3),
                          border: Border.all(
                              color: !watch.isSlotAvailable[index]?Colors.transparent:const Color(0xff4689EC).withOpacity(0.55.w)),
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        margin: EdgeInsets.only(bottom: 20.w),
                        child: Row(
                          children: [
                            !watch.isSlotAvailable[index]?Container(
                              height: 16.w,
                              width: 16.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                            ):
                            OrderSummaryRadioButton(
                                value: watch.shopDeliverySlots?[index],
                                groupValue: watch.slotGroupValue,
                                onChanged: (value) {
                                  read.onDeliverySlotSelected(value);
                                }),
                            SizedBox(
                              width: 18.w,
                            ),
                            Text(
                              watch.shopDeliverySlots?[index] ==
                                      "shop_owner_slot_9_to_12"
                                  ? "9 AM to 12 PM"
                                  : watch.shopDeliverySlots?[index] ==
                                          "shop_owner_slot_12_to_3"
                                      ? "12 PM to 3 PM"
                                      : watch.shopDeliverySlots?[index] ==
                                              "shop_owner_slot_3_to_6"
                                          ? "3 PM to 6 PM"
                                          : watch.shopDeliverySlots?[index] ==
                                                  "shop_owner_slot_6_to_9"
                                              ? "6 PM to 9 PM"
                                              : "",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff3A3A3A).withOpacity(0.63)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: watch.isExpectedDeliverySlotNotAvailable,
              child: Container(
                padding: EdgeInsets.only(
                    top: 15.w, bottom: 15.w, left: 10.w, right: 10.w),
                margin: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
                color: const Color(0xFFDC3545),
                width: ScreenUtil().screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        watch.deliverySlotErrorMsg,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            read.onDismiss();
                          },
                          child: const Text(
                            "Dismiss",
                            style: TextStyle(color: Colors.white),
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
            )),
      ],
    );
  }
}
