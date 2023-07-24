import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/review/controller/customer_review_list_shop_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/widget/app_bar.dart';

import 'package:provider/provider.dart';

class CReviewScreenView extends StatefulWidget {
  final String? shopId;
  const CReviewScreenView({super.key, this.shopId});

  @override
  State<CReviewScreenView> createState() => _CReviewScreenViewState();
}

class _CReviewScreenViewState extends State<CReviewScreenView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerReviewListControler>().initState(
            context,
            widget.shopId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CustomerReviewListControler>();
    final read = context.read<CustomerReviewListControler>();
    final watchMain = context.watch<MainScreenController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Reviews",
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 15.w,
                top: 15.w,
              ),
              child: Text(
                "${watch.shopDetails?.shopName}",
                // "New Balaji Trading Company",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Black,
                      // letterSpacing: .5,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.w),
              height: 70.h,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: grey2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/location2.svg',
                        width: 23.w,
                        height: 28.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "${watch.shopDetails?.shopAddress}\n${watch.shopDetails?.cityName} - ${watch.shopDetails?.shopPincode}",

                        // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Black,
                              // letterSpacing: .5,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/call.svg',
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      SvgPicture.asset(
                        'assets/images/fvrt.svg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 19.w, right: 19.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("All Reviews",
                      style: TextStyle(
                          color: Black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800)),
                  SizedBox(
                    height: 10.h,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: watch.reviewList?.length ?? 0,
                    itemBuilder: (context, index) {
                      final element = watch.reviewList?[index];
                      return Column(
                        children: [
                          Container(
                            width: ScreenUtil().screenWidth,
                            padding: EdgeInsets.only(
                                left: 15.w,
                                right: 10.w,
                                top: 12.w,
                                bottom: 11.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xffE8E8E8)),
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.red,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "${element?.customerProfileImagePath}",
                                      // 'assets/images/ReviewProfile.png',
                                      width: 60.w,
                                      height: 60.w,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${element?.customerName}",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Black,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/ReviewStart.svg',
                                                      width: 14.w,
                                                      height: 14.h,
                                                    ),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    Text(
                                                      "${element?.ratings}",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Black,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              "${element?.cityName} ${element?.stateName}",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Color(0xff7C7C7C),
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            Text(
                                              "${element?.createdAt}",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Color(0xff7C7C7C),
                                                    fontSize: 11.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Divider(
                                  color: grey,
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "${element?.review}",
                                  // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Euismod sit ipsum neque pulvinar gravidamoles tie semper diam ac. Semper arcu ultricies. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Euismod sit ipsum neque pulvinar gravidamoles',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Color(0xff7C7C7C),
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
