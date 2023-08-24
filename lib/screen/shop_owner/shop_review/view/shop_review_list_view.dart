import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/review/controller/customer_review_list_shop_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/shop_review/controller/shop_review_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/network_image.dart';

import 'package:provider/provider.dart';

class ShopReviewScreenView extends StatefulWidget {
  final String? shopId;
  final bool? fromDashBoard;
  const ShopReviewScreenView(
      {super.key, this.shopId, required this.fromDashBoard});

  @override
  State<ShopReviewScreenView> createState() => _ShopReviewScreenViewState();
}

class _ShopReviewScreenViewState extends State<ShopReviewScreenView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SShopReviewListController>().initState(
            context,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SShopReviewListController>();
    final read = context.read<SShopReviewListController>();
    final watchMain = context.watch<SMainScreenController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SMainScreenView(
                      index: 0,
                      screenName: ShopDashBoardView(
                        refresh: true,
                      ))),
              (Route<dynamic> route) => false,
            );
          },
          title: "Reviews",
          onActionTap: () {},
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     left: 15.w,
                  //     top: 15.w,
                  //   ),
                  //   child: Text(
                  //     "${watch.shopDetails?.shopName}",
                  //     // "New Balaji Trading Company",
                  //     style: GoogleFonts.roboto(
                  //       textStyle: TextStyle(
                  //           color: Black,
                  //           // letterSpacing: .5,
                  //           fontSize: 18.sp,
                  //           fontWeight: FontWeight.w600),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.all(12.w),
                  //   height: 70.h,
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       bottom: BorderSide(width: 1, color: grey2),
                  //     ),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     // crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           SvgPicture.asset(
                  //             'assets/images/location2.svg',
                  //             width: 23.w,
                  //             height: 28.h,
                  //           ),
                  //           SizedBox(
                  //             width: 8.w,
                  //           ),
                  //           Container(
                  //             width: 200.w,
                  //             child: Text(
                  //               "${watch.shopDetails?.shopAddress}\n${watch.shopDetails?.cityName} - ${watch.shopDetails?.shopPincode}",

                  //               // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                  //               style: GoogleFonts.roboto(
                  //                 textStyle: TextStyle(
                  //                     color: Black,
                  //                     // letterSpacing: .5,
                  //                     fontSize: 13.sp,
                  //                     fontWeight: FontWeight.w400),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Row(
                  //         children: [
                  //           InkWell(
                  //             onTap: () {
                  //               read.launchPhone(
                  //                   watch.shopDetails?.shopOwnerSupportNumber ??
                  //                       "",
                  //                   context);
                  //             },
                  //             child: Container(
                  //                 padding: EdgeInsets.only(
                  //                     left: 13.w,
                  //                     right: 13.w,
                  //                     top: 14.w,
                  //                     bottom: 14.w),
                  //                 decoration: BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   color: Color(0xff23AA49),
                  //                 ),
                  //                 child: SvgPicture.asset(
                  //                   "assets/icons/new_call.svg",
                  //                   width: 26.w,
                  //                   height: 14.h,
                  //                 )),
                  //           ),
                  //           SizedBox(
                  //             width: 13.w,
                  //           ),
                  //           InkWell(
                  //             onTap: () {
                  //               watch.favAllShop
                  //                   ? read.removeAllShopFavList(
                  //                       context, watch.shopDetails?.id)
                  //                   : read.updateAllShopFavList(
                  //                       context, watch.shopDetails?.id);
                  //             },
                  //             child: Container(
                  //               padding: EdgeInsets.only(
                  //                   left: 13.w,
                  //                   right: 13.w,
                  //                   top: 14.w,
                  //                   bottom: 14.w),
                  //               decoration: BoxDecoration(
                  //                 shape: BoxShape.circle,
                  //                 color: Color(0xff4689EC),
                  //               ),
                  //               child: watch.favAllShop
                  //                   ? SvgPicture.asset(
                  //                       "assets/icons/fav_selected.svg",
                  //                       width: 26.w,
                  //                       height: 14.h,
                  //                     )
                  //                   : SvgPicture.asset(
                  //                       "assets/images/favorite.svg",
                  //                       width: 26.w,
                  //                       height: 14.h,
                  //                     ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15.h,
                  // ),
                  Container(
                    padding: EdgeInsets.only(left: 19.w, top: 10, right: 19.w),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          element?.customerProfileImagePath ==
                                                  ""
                                              ? Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          'assets/images/shop_image.png'),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: CachedNetworkImageProvider(
                                                            element?.customerProfileImagePath ??
                                                                "")),
                                                  ),
                                                ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5.w),
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
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Black,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
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
                                                            style: GoogleFonts
                                                                .dmSans(
                                                              textStyle: TextStyle(
                                                                  color: Black,
                                                                  fontSize:
                                                                      14.sp,
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
                                                          color:
                                                              Color(0xff7C7C7C),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${element?.createdAt}",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color:
                                                              Color(0xff7C7C7C),
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