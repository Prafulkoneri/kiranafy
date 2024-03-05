import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/payment_refund/controller/payment_refund_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/view/shop_order_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:provider/provider.dart';

class SPaymentRefundList extends StatefulWidget {
  final bool? isNavFromAccounts;
  const SPaymentRefundList({Key? key, this.isNavFromAccounts})
      : super(
          key: key,
        );

  @override
  _SPaymentRefundListState createState() => _SPaymentRefundListState();
}

class _SPaymentRefundListState extends State<SPaymentRefundList> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentRefundListController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<PaymentRefundListController>();
    final read = context.read<PaymentRefundListController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          isBackButtonEnabled: true,
          // widget.isNavFromAccounts == true ? true : false,
          onBackBtnPressed: () {
            readMainScreen.onNavigation(0, const ShopDashBoardView(
              refresh: true,
            ), context);
          },
          title: "Refunds",
          // isBackButtonEnabled: false,
        ),
      ),
      body: watch.isLoading
          ? const Loader()
          : WillPopScope(
        onWillPop: ()async{
          readMainScreen.onNavigation(0, const ShopDashBoardView(
            refresh: true,
          ), context);
          return false;
        },
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Refund Overview",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Black1),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10),
                              ],
                            ),
                            padding: EdgeInsets.only(
                                left: 10.w, top: 5.w, bottom: 5.w, right: 13.w),
                            child: Row(
                              children: [
                                Text(watch.date),
                                SizedBox(
                                  width: 8.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    read.onClear(context, "");
                                  },
                                  child: SvgPicture.asset(
                                    height: 12.h,
                                    'assets/images/Cross.svg',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                GestureDetector(
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
                                                onSurface:
                                                    Colors.black, // <-- SEE HERE
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: const Color(
                                                      0xff1767B1), // button text color
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1, 2023),
                                        lastDate: DateTime(2100),
                                      );
                                      if (pickedDate != null) {
                                        String date = DateFormat('dd-MM-yyy')
                                            .format(pickedDate ?? DateTime.now());
                                        read.onToDateSelected(context, date);
                                      }
                                    },
                                    child: SvgPicture.asset(
                                        "assets/icons/s_calendar_icon.svg")),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                read.onPendingList();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xff115B7A),
                                    borderRadius: BorderRadius.circular(5.w)),
                                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 12.w,
                                    ),
                                    Text(
                                      "Pending",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      // "",
                                      "${watch.paymentrefunddata?.pendingRefundOrdersCount}",
                                      // "₹12000",
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 12.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 22.w,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                read.onCompletedList();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xff39C19D),
                                    borderRadius: BorderRadius.circular(5.w)),
                                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 12.w,
                                    ),
                                    Text(
                                      "Completed",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      // "",
                                      "${watch.paymentrefunddata?.acceptRefundOrdersCount}",
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 12.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Refund List",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Black1),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),

                      ////////Pending//////
                      Visibility(
                        visible: watch.isPendingList,
                        child: watch.pendingOrdersList?.isNotEmpty == true
                            ? ListView.builder(
                                // padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
                                itemCount: watch.pendingOrdersList?.length ?? 0,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext, index) {
                                  final element = watch.pendingOrdersList?[index];
                                  return GestureDetector(
                                    onTap: () {
                                      readMainScreen.onNavigation(0, ShopOrderView(
                                        route: "paymentRefund",
                                        fromOrderStatus: false,
                                        selectedIndex: 0,
                                        orderId:
                                        element?.id.toString(),
                                      ), context);
                                      readMainScreen.hideBottomNavigationBar();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => ShopOrderView(
                                      //               fromOrderStatus: false,
                                      //               selectedIndex: 0,
                                      //               orderId:
                                      //                   element?.id.toString(),
                                      //             )));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(14.w),
                                      margin: EdgeInsets.only(bottom: 15.w),
                                      width: ScreenUtil().screenWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.w),
                                        color: Colors.white,
                                        border:
                                            Border.all(color: const Color(0xffEFEFEF)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                // "",
                                                "Order ID: ${element?.orderUniqueId}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15.sp,
                                                    color: const Color(0xff3A3A3A)),
                                              ),
                                              Text(
                                                // "135",
                                                "${element?.totalAmount}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 19.sp,
                                                    color: const Color(0xff39C19D)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.w,
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                // "12/2/23",
                                                "${element?.createdAt}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    color: const Color(0xffA3A3A3)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.w,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                // "Sham",
                                                "${element?.customerName}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    color: const Color(0xffA3A3A3)),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    element?.paymentMode == "cash"
                                                        ? "Cash"
                                                        : element?.paymentMode ==
                                                                "qr_code"
                                                            ? "QR Code"
                                                            : "UPI",
                                                    // "Upi",
                                                    // "${element?.paymentMode}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12.sp,
                                                        color: const Color(0xffA3A3A3)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Image.asset(
                                    "assets/images/empty_order.png",
                                    width: 150.w,
                                    height: 150.h,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "No Record Found",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          letterSpacing: .5,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      //////Completed////
                      Visibility(
                        visible: watch.isCompletedList,
                        child: watch.confirmedOrdersList?.isNotEmpty == true
                            ? ListView.builder(
                                // padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
                                itemCount:
                                    //  2,
                                    watch.confirmedOrdersList?.length ?? 0,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext, index) {
                                  final element =
                                      watch.confirmedOrdersList?[index];
                                  return GestureDetector(
                                    onTap: () {
                                      readMainScreen.onNavigation(0, ShopOrderView(
                                        route: "paymentRefund",
                                        fromOrderStatus: false,
                                        selectedIndex: 0,
                                        orderId:
                                        element?.id.toString(),
                                      ), context);
                                      readMainScreen.hideBottomNavigationBar();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => ShopOrderView(
                                      //               fromOrderStatus: false,
                                      //               selectedIndex: 0,
                                      //               orderId:
                                      //                   element?.id.toString(),
                                      //             )));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(14.w),
                                      margin: EdgeInsets.only(bottom: 15.w),
                                      width: ScreenUtil().screenWidth,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.w),
                                        color: Colors.white,
                                        border:
                                            Border.all(color: const Color(0xffEFEFEF)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                // "",
                                                "Order ID: ${element?.orderUniqueId}",

                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15.sp,
                                                    color: const Color(0xff3A3A3A)),
                                              ),
                                              Text(
                                                // "135",
                                                "${element?.customerRefundAmount}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 19.sp,
                                                    color: const Color(0xff39C19D)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.w,
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                // "12/2/23",
                                                "${element?.createdAt}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    color: const Color(0xffA3A3A3)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7.w,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                // "Sham",
                                                "${element?.customerName}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    color: const Color(0xffA3A3A3)),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    // "Upi",
                                                    element?.paymentMode == "cash"
                                                        ? "Cash"
                                                        : element?.paymentMode ==
                                                                "qr_code"
                                                            ? "QR Code"
                                                            : "UPI",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12.sp,
                                                        color: const Color(0xffA3A3A3)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Image.asset(
                                    "assets/images/empty_order.png",
                                    width: 150.w,
                                    height: 150.h,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "No Record Found",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black1,
                                          letterSpacing: .5,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                      )
                    ],
                  ),
                ),
              ),
          ),
    );
  }
}
