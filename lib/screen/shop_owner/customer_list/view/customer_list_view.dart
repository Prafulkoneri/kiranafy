import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/controller/s_customer_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/view/customer_detail_view.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/view/customer_filter_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';

import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/network_image.dart';

import 'package:provider/provider.dart';

class CustomerListView extends StatefulWidget {
  final bool? isRefresh;

  const CustomerListView({super.key, required this.isRefresh});

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SCustomerListController>()
          .initState(context, widget.isRefresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SCustomerListController>();
    final watch = context.watch<SCustomerListController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SMainScreenView(
                      index: 4, screenName: SAccountScreenView())),
              (Route<dynamic> route) => false,
            );
          },
          title: "Customers",
          action: SvgPicture.asset("assets/images/filter.svg"),
          onActionTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              context: context,
              builder: (context) {
                return CustomerFilterView();
              },
            );
          },
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: watch.customerList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final element = watch.customerList?[index];
                        return Container(
                          margin: EdgeInsets.only(
                              left: 19.w,
                              right: 19.0.w,
                              bottom: 0.w,
                              top: 20.w),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        element?.customerProfileImagePath != ""
                                            ? Container(
                                                width: 60.w,
                                                height: 60.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color:
                                                            Color(0xff115B7A),
                                                        width: 2.w)),
                                                child: ClipOval(
                                                  child: AppNetworkImages(
                                                    height: 60.w,
                                                    width: 60.w,
                                                    imageUrl:
                                                        '${element?.customerProfileImagePath}',
                                                    fit: BoxFit.cover,
                                                    // 'assets/images/ReviewProfile.png',
                                                  ),
                                                ),
                                              )
                                            : Image.asset(
                                                'assets/images/ReviewProfile.png',
                                                width: 60.w,
                                                height: 60.h,
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
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.w,
                                              ),
                                              Text(
                                                "${element?.areaName}, ${element?.cityName}",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: Black,
                                                      letterSpacing: .5,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                        GestureDetector(
                                          onTap: () {
                                            read.launchPhone(
                                                element?.mobileNumber ?? "",
                                                context);
                                          },
                                          child: Container(
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
                                    left: 15.w,
                                    right: 9.0.w,
                                    bottom: 8.w,
                                    top: 7.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  builder: (context) =>
                                                      SMainScreenView(
                                                        index: 4,
                                                        screenName:
                                                            CustomerDetailView(
                                                          customerId: element
                                                              ?.id
                                                              .toString(),
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
            ),
    );
  }
}
