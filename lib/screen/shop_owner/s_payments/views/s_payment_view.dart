import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_payments/controller/payment_histaory_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/stack_loader.dart';
import 'package:provider/provider.dart';

class SPaymentsView extends StatefulWidget {
  final bool? isNavFromAccounts;
  const SPaymentsView({Key? key, required this.isNavFromAccounts})
      : super(
          key: key,
        );

  @override
  _SPaymentsViewState createState() => _SPaymentsViewState();
}

class _SPaymentsViewState extends State<SPaymentsView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentHistoryController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<PaymentHistoryController>();
    final read = context.read<PaymentHistoryController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            isBackButtonEnabled:
                widget.isNavFromAccounts == true ? true : false,
            onBackBtnPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => SMainScreenView(
                          index: 4,
                          screenName: SAccountScreenView(refresh: true),
                        )),
                (Route<dynamic> route) => false,
              );
            },
            title: "Payments",
            // isBackButtonEnabled: false,
          ),
        ),
        body: watch.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : StackLoader(
                showLoader: watch.isStackLoading,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                              "Payment Overview",
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
                                  left: 10.w,
                                  top: 5.w,
                                  bottom: 5.w,
                                  right: 13.w),
                              child: Row(
                                children: [
                                  Text("${watch.date}"),
                                  SizedBox(
                                    width: 12.w,
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
                                    width: 10.w,
                                  ),
                                  GestureDetector(
                                      onTap: () async {
                                        var pickedDate = await showDatePicker(
                                          builder: (BuildContext, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: Color(0xff1767B1),
                                                  // <-- SEE HERE
                                                  onPrimary: Colors.white,
                                                  // <-- SEE HERE
                                                  onSurface: Colors
                                                      .black, // <-- SEE HERE
                                                ),
                                                textButtonTheme:
                                                    TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                    primary: Color(
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
                                              .format(
                                                  pickedDate ?? DateTime.now());
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
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff115B7A),
                                    borderRadius: BorderRadius.circular(5.w)),
                                padding:
                                    EdgeInsets.only(left: 12.w, right: 12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 12.w,
                                    ),
                                    Text(
                                      "Current Month",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      "${watch.currentMonthCollection}",
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
                            SizedBox(
                              width: 22.w,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff39C19D),
                                    borderRadius: BorderRadius.circular(5.w)),
                                padding:
                                    EdgeInsets.only(left: 12.w, right: 12.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 12.w,
                                    ),
                                    Text(
                                      "Total Business",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 7.w,
                                    ),
                                    Text(
                                      "${watch.totalBusiness}",
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
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Overview",
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
                        watch.ordersList?.isNotEmpty ?? false
                            ? ListView.builder(
                                // padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
                                itemCount: watch.ordersList?.length ?? 0,
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext, index) {
                                  final element = watch.ordersList?[index];
                                  return Container(
                                    padding: EdgeInsets.all(14.w),
                                    margin: EdgeInsets.only(bottom: 15.w),
                                    width: ScreenUtil().screenWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.w),
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Color(0xffEFEFEF)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Order ID: ${element?.orderUniqueId}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15.sp,
                                                  color: Color(0xff3A3A3A)),
                                            ),
                                            Text(
                                              "${element?.totalAmount}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 19.sp,
                                                  color: Color(0xff39C19D)),
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
                                              "${element?.createdAt}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp,
                                                  color: Color(0xffA3A3A3)),
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
                                              "${element?.customerName}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp,
                                                  color: Color(0xffA3A3A3)),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${element?.paymentMode}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.sp,
                                                      color: Color(0xffA3A3A3)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
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
                              )
                      ],
                    ),
                  ),
                ),
              ));
  }
}
