import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/order_status/controller/track_order_status_controller.dart';
import 'package:local_supper_market/screen/customer/order_status/view/order_status_view.dart';
import 'package:provider/provider.dart';

class CheckOrderStatusView extends StatefulWidget {
  final String? orderId;
  const CheckOrderStatusView({super.key, this.orderId});

  @override
  State<CheckOrderStatusView> createState() => _CheckOrderStatusViewState();
}

class _CheckOrderStatusViewState extends State<CheckOrderStatusView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<TrackOrderStatusController>()
          .initState(context, widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<TrackOrderStatusController>();
    final read = context.read<TrackOrderStatusController>();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/check_order.png",
                height: 191.h,
                width: 292.w,
              ),
              SizedBox(
                height: 41.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Order Confirmed",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SvgPicture.asset("assets/icons/confirm.svg")
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Your order has been confirmed, please check\norder status.",
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Black1,
                      // letterSpacing: .5,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 23.w, right: 23.w),
                child: Container(
                  // margin: EdgeInsets.only(left: 79.w, right: 79.w),
                  width: 344.w, // <-- Your width
                  height: 45.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: SplashText,
                      // onPrimary: Colors.white,
                      // shadowColor: Colors.greenAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0)),
                      minimumSize: const Size(100, 40), //////// HERE
                    ),
                    // style: style,
                    // onPressed: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => OrderStatusView()),
                    //   );
                    // },
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderStatusView(
                                    orderId: watch.orderId,
                                  )));
                    },
                    child: Text(
                      'Check Order Status',
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            // color: SplashTex
                            // letterSpacing: .5,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainScreenView(
                            index: 0,
                            screenName: HomeScreenView(refreshPage: true))),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  'Back to Home',
                  style: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                        color: Color(0xff858585),
                        // color: SplashTex
                        // letterSpacing: .5,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
