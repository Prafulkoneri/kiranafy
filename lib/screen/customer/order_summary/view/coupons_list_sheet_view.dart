import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/stack_Loader.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponsListSheetView extends StatefulWidget {
  const CouponsListSheetView({Key? key}) : super(key: key);

  @override
  _CouponsListSheetViewState createState() => _CouponsListSheetViewState();
}

class _CouponsListSheetViewState extends State<CouponsListSheetView> {
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
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: StackLoader(
            showLoader: watch.isStackLoaderVisible,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Get Promo Code",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Color(0xff006F94),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      InkWell(
                        child: Icon(Icons.clear),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 11.w,
                  ),
                  Divider(),
                  SizedBox(
                    height: 15.w,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: watch.finalCouponList?.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext, index) {
                        final element = watch.finalCouponList?[index];
                        return GestureDetector(
                          onTap: () {
                            read.onOfferSelected(
                                element?.id.toString(),
                                context,
                                element?.couponDiscountMaxAmount,
                                element?.couponCode);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 11.w, vertical: 14.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff4689EC).withOpacity(0.55.w)),
                              borderRadius: BorderRadius.circular(5.w),
                            ),
                            margin: EdgeInsets.only(bottom: 20.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        OrderSummaryRadioButton(
                                            value: element?.id.toString(),
                                            groupValue: watch.offerGroupValue,
                                            onChanged: (value) {
                                              read.onOfferSelected(
                                                  element?.id.toString(),
                                                  context,
                                                  element
                                                      ?.couponDiscountMaxAmount,
                                                  element?.couponCode);
                                            }),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 18.w,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            element?.couponCode ?? "",
                                            style: TextStyle(
                                                fontSize: 15.43.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff3A3A3A)),
                                          ),
                                          SizedBox(
                                            height: 5.w,
                                          ),
                                          Text(
                                              "Get Up To ${double.parse(element?.couponDiscountPercentage.toString() ?? "0").round()}% OFF | Minimum Order of \u{20B9} ${element?.minOrderAmount}"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.w,
                                ),
                                Divider(),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Visibility(
                                  visible: !watch.viewMore[index],
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: " View More",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print("hello");
                                            read.onViewMoreClicked(index);
                                          },
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff006F94))),
                                  ])),
                                ),
                                Visibility(
                                  visible: watch.viewMore[index],
                                  child: Row(
                                    children: [
                                      SecondaryRadioButton(
                                          value: false,
                                          groupValue: "",
                                          onChanged: (value) {},
                                          innerColor: Colors.transparent,
                                          outerColor: Colors.transparent,
                                          backgroundColor: Colors.transparent),
                                      SizedBox(
                                        width: 18.w,
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${element?.couponTermsAndCondition ?? ""}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: Color(0xff3A3A3A)
                                                  .withOpacity(0.63)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
