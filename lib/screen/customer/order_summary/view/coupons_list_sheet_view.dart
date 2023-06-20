import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/textfield.dart';
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Get Promo Code",style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xff006F94),
                fontWeight: FontWeight.w700,

              ),),
              SizedBox(
                height: 11.w,
              ),
              Divider(),
              SizedBox(
                height: 15.w,
              ),
              ListView.builder(shrinkWrap: true,itemCount: watch.finalCouponList?.length,padding: EdgeInsets.zero,itemBuilder: (BuildContext,index){
               final element=watch.finalCouponList?[index];
                return GestureDetector(
                  onTap: (){
                    read.onOfferSelected(element?.id.toString(),context,element?.couponDiscountMaxAmount);
                  },
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 11.w, vertical: 14.w),
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
                                      read.onOfferSelected(element?.id.toString(),context,element?.couponDiscountMaxAmount);
                                    }),
                              ],
                            ),
                            SizedBox(
                              width: 18.w,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(element?.couponCode??"",
                                    style: TextStyle(
                                        fontSize: 15.43.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Text("${element?.couponTermsAndCondition}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,color: Color(0xff3A3A3A).withOpacity(0.63)),),
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
                        RichText(text:TextSpan(
                            children: [
                              TextSpan(text:"Customers need to but a",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Color(0xff3A3A3A).withOpacity(0.63))),
                              TextSpan(text: " View More",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Color(0xff006F94))),
                            ]
                        )),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
