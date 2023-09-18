import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/delivery_address/view/add_address_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressListSheetView extends StatefulWidget {
  const AddressListSheetView({Key? key}) : super(key: key);

  @override
  _AddressListSheetViewState createState() => _AddressListSheetViewState();
}

class _AddressListSheetViewState extends State<AddressListSheetView> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<OrderSummaryController>();
    final read = context.read<OrderSummaryController>();
    final readMain = context.read<MainScreenController>();
    return Stack(
      clipBehavior: Clip.none,
      children: [
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
              children: [
                Row(
                  children: [
                    Text(
                      "Set Delivery Address",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff006F94)),
                    )
                  ],
                ),
                Divider(
                  color: Colors.black.withOpacity(0.16),
                ),
                SizedBox(
                  height: 15.w,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: watch.customerAddress?.length ?? 0,
                    itemBuilder: (BuildContext, index) {
                      final element = watch.customerAddress?[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${element?.deliveryAddressType.toString()}".capitalize(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17.sp,
                                color: Color(0xff040404)),
                          ),
                          SizedBox(
                            height: 13.sp,
                          ),
                          GestureDetector(
                            onTap: () {
                              read.onAddressSelected(
                                  element?.addressId.toString());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 11.w, vertical: 8.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        Color(0xff4689EC).withOpacity(0.55.w)),
                                borderRadius: BorderRadius.circular(5.w),
                              ),
                              margin: EdgeInsets.only(bottom: 20.w),
                              child: Row(
                                // crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  OrderSummaryRadioButton(
                                      value: element?.addressId.toString(),
                                      groupValue: watch.addressGroupValue,
                                      onChanged: (value) {
                                        read.onAddressSelected(value);
                                      }),
                                  SizedBox(
                                    width: 18.w,
                                  ),
                                  Flexible(
                                    child: Text(
                                      element?.address1 ?? "",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff3A3A3A)
                                              .withOpacity(0.63)),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      readMain.onNavigation(1,AddAddressView(
                                        isEditAdress: true,
                                        route: "orderAddress",
                                        shopId: watch
                                            .shopDetailData?.id
                                            .toString(),
                                        cartId: watch.cartId,
                                        addressId: element
                                            ?.addressId
                                            .toString(),
                                      ), context);
                                      // Navigator.pushAndRemoveUntil(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           MainScreenView(
                                      //               index: 4,
                                      //               screenName: AddAddressView(
                                      //                 isEditAdress: true,
                                      //                 route: "orderAddress",
                                      //                 shopId: watch
                                      //                     .shopDetailData?.id
                                      //                     .toString(),
                                      //                 cartId: watch.cartId,
                                      //                 addressId: element
                                      //                     ?.addressId
                                      //                     .toString(),
                                      //               ))),
                                      //   (Route<dynamic> route) => false,
                                      // );
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/edit_address.svg"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    })
              ],
            )),
      ],
    );
  }
}
