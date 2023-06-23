import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_sign_in_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/controller/shop_owner_order_view_controller.dart';

import 'package:provider/provider.dart';

class OrderDeliveryCodeView extends StatefulWidget {
  const OrderDeliveryCodeView({Key? key}) : super(key: key);

  @override
  _OrderDeliveryCodeViewState createState() => _OrderDeliveryCodeViewState();
}

class _OrderDeliveryCodeViewState extends State<OrderDeliveryCodeView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopOwnerOrderViewController>();
    final watch = context.watch<ShopOwnerOrderViewController>();
    return Stack(
      children: [
        Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.white),
          child: Material(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                // height: 335,
                child: Padding(
                  padding: EdgeInsets.all(25.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Code",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: Custlogin,
                              letterSpacing: .5,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      OtpTextField(
                        //  controller: otpController,
                        numberOfFields: 6,
                        borderColor: Color(0xFF512DA8),
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: false,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          print(code);
                          //handle validation or checks here
                        },
                        //runs when every textfield is filled
                        onSubmit: (String code) {
                          print(code);
                          read.onDeliveryCode(code);
                        }, // end onSubmit
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 400,
                        // <-- Your width
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Button,
                            // onPrimary: Colors.white,
                            // shadowColor: Colors.greenAccent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                            minimumSize: const Size(100, 40), //////// HERE
                          ),
                          // style: style,
                          onPressed: () {
                            read.shopOrderStatus(
                                context,
                                watch.orderDetails?.id.toString(),
                                "order_delivered",
                                "",
                                "",
                                watch.deliveryCode);
                            // read.onCodeVerification(context);
                          },
                          child: Text(
                            'Submit',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  // color: SplashTex
                                  letterSpacing: .5,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              )),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: watch.isDeliveryCodeError,
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
                        watch.deliveryCodeError,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            read.onCodeDismiss();
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
