import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/controller/s_customer_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/view/customer_detail_view.dart';

import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';

import 'package:provider/provider.dart';

class CustomerListView extends StatefulWidget {
  const CustomerListView({super.key});

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SCustpmerListController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SCustpmerListController>();
    final watch = context.watch<SCustpmerListController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "Customers",
          action: Padding(
            padding: EdgeInsets.only(
              right: 20.w,
            ),
            child: SvgPicture.asset("assets/images/filter.svg"),
          ),
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: watch.customerDetail?.length ?? 0,
              itemBuilder: (context, index) {
                final element = watch.customerDetail?[index];
                return Container(
                  margin: EdgeInsets.only(
                      left: 19.w, right: 19.0.w, bottom: 0.w, top: 20.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Color(0xffEFEFEF))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 15.w, right: 18.0.w, top: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Image.network(
                                  '${element?.customerProfileImagePath}',
                                  // 'assets/images/ReviewProfile.png',
                                  width: 60.w,
                                  height: 60.w,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 12.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${element?.customerName}',
                                        // 'Rahul Singh',
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.w,
                                      ),
                                      Text(
                                        "${element?.areaName}${element?.cityName}",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/s_fvrt.svg',
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  width: 32.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
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
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xffE8E8E8),
                        thickness: 1,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 15.w, right: 9.0.w, bottom: 8.w, top: 7.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  '0 Orders',
                                  style: TextStyle(
                                      color: Black,
                                      letterSpacing: .5,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SMainScreenView(
                                                index: 4,
                                                screenName: CustomerDetailView(
                                                    // fromDashBoard: false,
                                                    ),
                                              )),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  child: Text(
                                    'View Details',
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black,
                                          letterSpacing: .5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/s_forword.svg',
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
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
