import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/controller/s_customer_detail_controller.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/view/customer_list_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_view/view/shop_order_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/network_image.dart';

import 'package:provider/provider.dart';

class CustomerDetailView extends StatefulWidget {
  final String? customerId;
  final String? screenName;

  const CustomerDetailView({super.key, this.customerId, this.screenName});

  @override
  State<CustomerDetailView> createState() => _CustomerDetailViewState();
}

class _CustomerDetailViewState extends State<CustomerDetailView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SCustomerDetailController>()
          .initState(context, widget.customerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SCustomerDetailController>();
    final watch = context.watch<SCustomerDetailController>();
    final readMain = context.read<SMainScreenController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "Customer Details",
          onBackBtnPressed: () {
            readMain.onNavigation(
                4,
                CustomerListView(isRefresh: false, fromPage: widget.screenName),
                context);
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => SMainScreenView(
            //             index: 4,
            //             screenName: CustomerListView(
            //                 isRefresh: false, fromPage: widget.screenName),
            //           )),
            //   (Route<dynamic> route) => false,
            // );
          },
        ),
      ),
      body: watch.isLoading
          ? const Loader()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 20.w, bottom: 15.w, left: 19.w, right: 19.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            watch.customerDetails?.customerProfileImagePath !=
                                    ""
                                ? Container(
                                    width: 80.w,
                                    height: 80.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: const Color(0xff115B7A),
                                            width: 2.w)),
                                    child: ClipOval(
                                      child: AppNetworkImages(
                                        height: 80.w,
                                        width: 80.w,
                                        imageUrl:
                                            '${watch.customerDetails?.customerProfileImagePath}',
                                        fit: BoxFit.cover,
                                        // 'assets/images/ReviewProfile.png',
                                      ),
                                    ),
                                  )
                                : Image.asset(
                                    'assets/images/profile_last.png',
                                    width: 80.w,
                                    height: 80.h,
                                  ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  watch.customerDetails?.customerName ?? "",
                                  style: TextStyle(
                                      color: black,
                                      // letterSpacing: .5,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/shop_location.svg',
                                      // width: 15.w,
                                      // height: 15.h,
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Text(
                                      '${watch.customerDetails?.areaName ?? ""}, ${watch.customerDetails?.cityName ?? ""}',
                                      style: TextStyle(
                                          color: black,
                                          letterSpacing: .5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/call_shop.svg',
                                      // width: 14.w,
                                      // height: 14.h,
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Text(
                                      watch.customerDetails?.mobileNumber ?? "",
                                      style: TextStyle(
                                          color: black,
                                          letterSpacing: .5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            read.launchPhone(
                                watch.customerDetails?.mobileNumber ?? "",
                                context);
                          },
                          child: Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: const BoxDecoration(
                                color: Color(0xff115B7A),
                                shape: BoxShape.circle),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/s_call1.svg',
                                height: 13.h,
                                width: 13.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 19.w, right: 19.w),
                    child: const Divider(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Orders",
                            style: TextStyle(
                                color: Black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: watch.customerOrderDetails?.length ?? 0,
                    itemBuilder: (context, index) {
                      final element = watch.customerOrderDetails?[index];
                      return GestureDetector(
                        onTap: () {
                          readMainScreen.onNavigation(
                              0,
                              ShopOrderView(
                                route: "customerDetails",
                                orderId: element?.id.toString(),
                                fromOrderStatus: true,
                                selectedIndex: 0,
                              ),
                              context);
                          readMainScreen.hideBottomNavigationBar();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(
                            left: 19.0,
                            right: 19.0,
                            bottom: 10,
                            top: 10.0,
                          ),
                          // padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffEFEFEF)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order ID - ${element?.orderUniqueId}',
                                    style: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        // backgroundColor: ,
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color:
                                              element?.orderStatus=="Refund" && element?.shopOwnerCancelledStatus=="NO" && element?.customerCancelledStatus=="NO"?const Color(0xff39C19D):
                                              element?.orderStatus=="Refund" && (element?.shopOwnerCancelledStatus=="YES" || element?.customerCancelledStatus=="YES")?Colors.red:
                                              element?.orderStatus ==
                                                      "Pending"
                                                  ? Yellow
                                                  : element?.orderStatus ==
                                                          "Delivered"
                                                      ? const Color(0xff39C19D)
                                                      : element?.orderStatus ==
                                                              "Confirmed"
                                                          ? const Color(0xff115B7A)
                                                          : element?.orderStatus ==
                                                                  "Cancelled"
                                                              ? Colors.red
                                                              : element?.orderStatus ==
                                                                      "Dispatched"
                                                                  ? Colors
                                                                      .orange
                                                                  : element?.orderStatus ==
                                                                          "Packing"
                                                                      ? Colors
                                                                          .brown
                                                                      : const Color(
                                                                          0xff39C19D),
                                              // width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           OrderDeliveryView(
                                        //               orderId: element?.id
                                        //                   .toString())),
                                        // );
                                      },
                                      child: Text(
                                        element?.orderStatus=="Refund" && element?.shopOwnerCancelledStatus=="NO" && element?.customerCancelledStatus=="NO"?"Delivered":
                                        element?.orderStatus=="Refund" && (element?.shopOwnerCancelledStatus=="YES" || element?.customerCancelledStatus=="YES")?"Cancelled":
                                        element?.orderStatus == "Refund"
                                            ? "Delivered"
                                            : element?.orderStatus ?? "",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color:

                                              element?.orderStatus=="Refund" && element?.shopOwnerCancelledStatus=="NO" && element?.customerCancelledStatus=="NO"?const Color(0xff39C19D):
                                              element?.orderStatus=="Refund" && (element?.shopOwnerCancelledStatus=="YES" || element?.customerCancelledStatus=="YES")?Colors.red:
                                              element?.orderStatus ==
                                                      "Pending"
                                                  ? Yellow
                                                  ///////
                                                  : element?.orderStatus ==
                                                          "Delivered"
                                                      ? const Color(0xff39C19D)
                                                      ///////
                                                      : element?.orderStatus ==
                                                              "Confirmed"
                                                          ? const Color(0xff115B7A)
                                                          /////////
                                                          : element?.orderStatus ==
                                                                  "Cancelled"
                                                              ? Colors.red
                                                              //////////////
                                                              : element?.orderStatus ==
                                                                      "Dispatched"
                                                                  ? Colors
                                                                      .orange
                                                                  : element?.orderStatus ==
                                                                          "Packing"
                                                                      ? Colors
                                                                          .brown
                                                                      : Colors
                                                                          .green,
                                              // letterSpacing: .5
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),

                                      //
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 10.h,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${element?.createdAt}',
                                    style: TextStyle(
                                        color: const Color(0xff5B5B5B),
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    'Total Quantity',
                                    style: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\u{20B9} ${element?.totalAmount}',
                                    style: TextStyle(
                                        color: const Color(0xff5B5B5B),
                                        letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  Text(
                                    '${element?.totalItems}',
                                    style: TextStyle(
                                        color: const Color(0xff5B5B5B),
                                        letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
