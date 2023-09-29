import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/controller/shop_coupons_list_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/view/s_add_coupons_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/view/s_coupons_view_details.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/controller/s_dashboard_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:provider/provider.dart';

class ShopCouponsView extends StatefulWidget {
  final bool? isRefresh;
  final bool? isNavFromDashBoard;

  const ShopCouponsView(
      {super.key, required this.isRefresh, required this.isNavFromDashBoard});

  @override
  State<ShopCouponsView> createState() => _ShopCouponsViewState();
}

class _ShopCouponsViewState extends State<ShopCouponsView> {
  // String? selectedValue;
  // final List<String> genderItems = [];
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SCouponsListController>()
          .initState(context, widget.isRefresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SCouponsListController>();
    final readMain = context.read<SMainScreenController>();
    final watch = context.watch<SCouponsListController>();
    final watchDashBoardScreen = context.read<SDashBoardController>();
    // final key = new GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
            isBackButtonEnabled:
                widget.isNavFromDashBoard == true ? false : true,
            onBackBtnPressed: () {

              readMain.onNavigation(4, SAccountScreenView(
                refresh: false,
              ), context);

            },
            title: "Coupon",
            action: SvgPicture.asset("assets/icons/addressadd.svg"),
            onActionTap: () {
              if (watchDashBoardScreen.specialBenifitlist
                  .contains("create_offer_coupons")) {
                if (widget.isNavFromDashBoard == true) {
                  readMain.onNavigation(3, SAddCouponsView(
                    isEditCoupon: false,
                    isNavFromDashboard: true,
                  ), context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => SMainScreenView(
                  //           index: 3,
                  //           screenName: SAddCouponsView(
                  //             isEditCoupon: false,
                  //             isNavFromDashboard: true,
                  //           ))),
                  //   (Route<dynamic> route) => false,
                  // );
                } else {
                  readMain.onNavigation(4, SAddCouponsView(
                    isEditCoupon: false,
                    isNavFromDashboard: false,
                  ), context);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => SMainScreenView(
                  //           index: 4,
                  //           screenName: SAddCouponsView(
                  //             isEditCoupon: false,
                  //             isNavFromDashboard: false,
                  //           ))),
                  //   (Route<dynamic> route) => false,
                  // );
                }
              } else {
                Utils.showPrimarySnackbar(
                    context, "Subscribe to Advanced Plan to use this feature!",
                    type: SnackType.error);
                return;
              }
            }),
      ),
      body: watch.isLoading
          ? const Loader()
          : WillPopScope(
        onWillPop: ()async{
          widget.isNavFromDashBoard == true? readMain.onNavigation(0,ShopDashBoardView(refresh: false), context):            readMain.onNavigation(4, SAccountScreenView(
            refresh: false,
          ), context);
          return false;
        },
            child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: watch.couponsListData?.isNotEmpty == true
                        ? Container(
                            // height: 125.h,
                            // width: 352.w,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: watch.couponsListData?.length ?? 0,
                                itemBuilder: (BuildContext, index) {
                                  final element = watch.couponsListData?[index];
                                  return Container(
                                    // decoration: BoxDecoration(color: Black),
                                    padding: EdgeInsets.only(
                                        left: 19.0.w, right: 19.w, top: 15.0.w),
                                    child: Stack(
                                      alignment: AlignmentDirectional.centerStart,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 12.h),
                                          child: Image.asset(
                                            'assets/images/Coupons.png',
                                            // height: 125.h, width: 352.w
                                            // fit: BoxFit.cover
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 35.h,
                                            bottom: 10.h,
                                          ),
                                          child: ClipRRect(
                                            // borderRadius: new BorderRadius.circular(40.0),
                                            child: Image.asset(
                                                'assets/images/couponslogo.png',
                                                height: 62.h,
                                                width: 37.w),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 80.h,
                                            bottom: 15.h,
                                          ),
                                          child: FDottedLine(
                                            color: Grey,
                                            height: 120.0,
                                            strokeWidth: 1.0,
                                            dottedLength: 10.0,
                                            space: 3.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 75.h,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 19.w, right: 10.w),
                                                child: Row(
                                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                                  // mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // SizedBox(
                                                    //   width: 0.w,
                                                    //   // height: 15.w,
                                                    // ),
                                                    Text(
                                                      "",
                                                      // " ${element?.couponToDate}",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Black,
                                                            letterSpacing: .5,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w700),
                                                      ),
                                                    ),
                                                    // SizedBox(
                                                    //   width: 40.w,
                                                    // ),
                                                    InkWell(
                                                      onTap: () {
                                                        read.viewCouponsDetail(
                                                            context, element?.id);
                                                        showModalBottomSheet(
                                                            backgroundColor:
                                                                Colors.white,
                                                            isScrollControlled:
                                                                true,
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            30),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            30))),
                                                            context: context,
                                                            builder: (context) {
                                                              // using a scaffold helps to more easily position the FAB
                                                              return SCouponsDetailView();
                                                            });
                                                      },
                                                      child: SvgPicture.asset(
                                                        'assets/images/logo1.svg',
                                                        width: 15.w,
                                                        height: 15.h,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 19.w,
                                                    ),
                                                    child: Text(
                                                      "Valid until ${element?.couponToDate}",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Black,
                                                            letterSpacing: .5,
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 18.0.h),
                                                    child: Text(
                                                        "${element?.couponDiscountPercentage} OFF",
                                                        style: GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: Black,
                                                              letterSpacing: .5,
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  Text(
                                                      "UPTO \u{20B9} ${element?.couponDiscountMaxAmount}",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Grey,
                                                            letterSpacing: .5,
                                                            fontSize: 10.sp,
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 17.w,
                                                  right: 17.w,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          elevation:
                                                              MaterialStateProperty
                                                                  .all(0),

                                                          // backgroundColor: ,
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                          shape:
                                                              MaterialStateProperty
                                                                  .all(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      SplashText),
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          read.copyCodeForCoupanList(
                                                              context,
                                                              element?.couponCode ??
                                                                  "");
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            SelectableText(
                                                              "${element?.couponCode}",
                                                              style: GoogleFonts
                                                                  .dmSans(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                        SplashText,
                                                                    letterSpacing:
                                                                        .5,
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ), // <-- Text
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            SvgPicture.asset(
                                                              'assets/images/svg2.svg',
                                                              width: 17.w,
                                                              height: 17.h,
                                                            ),
                                                          ],
                                                        ),
                                                        //
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              if (watchDashBoardScreen
                                                                  .specialBenifitlist
                                                                  .contains(
                                                                      "create_offer_coupons")) {
                                                                if (widget
                                                                        .isNavFromDashBoard ==
                                                                    true) {
                                                                  readMain.onNavigation(3, SAddCouponsView(
                                                                    isEditCoupon:
                                                                    true,
                                                                    couponId:
                                                                    element?.id.toString(),
                                                                    isNavFromDashboard:
                                                                    true,
                                                                  ), context);
                                                                  // Navigator
                                                                  //     .pushAndRemoveUntil(
                                                                  //   context,
                                                                  //   MaterialPageRoute(
                                                                  //       builder: (context) => SMainScreenView(
                                                                  //           index: 3,
                                                                  //           screenName: SAddCouponsView(
                                                                  //             isEditCoupon:
                                                                  //                 true,
                                                                  //             couponId:
                                                                  //                 element?.id.toString(),
                                                                  //             isNavFromDashboard:
                                                                  //                 true,
                                                                  //           ))),
                                                                  //   (Route<dynamic>
                                                                  //           route) =>
                                                                  //       false,
                                                                  // );
                                                                } else {
                                                                  readMain.onNavigation(3, SAddCouponsView(
                                                                    isEditCoupon:
                                                                    true,
                                                                    couponId:
                                                                    element?.id.toString(),
                                                                    isNavFromDashboard:
                                                                    false,
                                                                  ), context);
                                                                  // Navigator
                                                                  //     .pushAndRemoveUntil(
                                                                  //   context,
                                                                  //   MaterialPageRoute(
                                                                  //       builder: (context) => SMainScreenView(
                                                                  //           index: 4,
                                                                  //           screenName: SAddCouponsView(
                                                                  //             isEditCoupon:
                                                                  //                 true,
                                                                  //             couponId:
                                                                  //                 element?.id.toString(),
                                                                  //             isNavFromDashboard:
                                                                  //                 false,
                                                                  //           ))),
                                                                  //   (Route<dynamic>
                                                                  //           route) =>
                                                                  //       false,
                                                                  // );
                                                                }
                                                              } else {
                                                                Utils.showPrimarySnackbar(
                                                                    context,
                                                                    "Subscribe to Advanced Plan to use this feature!",
                                                                    type: SnackType
                                                                        .error);
                                                                return;
                                                              }
                                                            },
                                                            child: SvgPicture.asset(
                                                                "assets/icons/edit1.svg")),
                                                        SizedBox(
                                                          width: 12.w,
                                                        ),
                                                        Container(
                                                          width: 1.w,
                                                          height: 28.w,
                                                          color: grey11,
                                                        ),
                                                        SizedBox(
                                                          width: 12.w,
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              // read.deleteCoupons(
                                                              //     context,
                                                              //     index,
                                                              //     element?.id);
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Dialog(
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xffFFFFFF),
                                                                      // shape: ,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(10))),

                                                                      // scrollable: true,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            205.h,
                                                                        // width: 400.w,
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: <Widget>[
                                                                            Flexible(
                                                                              child:
                                                                                  Text(
                                                                                "Do you really want to delete coupon ? ",
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.dmSans(
                                                                                  textStyle: TextStyle(color: Color(0xff006F94), fontSize: 20.sp, fontWeight: FontWeight.w700),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height:
                                                                                  37.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 19.w,
                                                                                ),
                                                                                Expanded(
                                                                                  child: GestureDetector(
                                                                                    onTap: () async {
                                                                                      // Navigator.pop(context);
                                                                                      read.deleteCoupons(context, index, element?.id);
                                                                                    },
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 9.w, bottom: 9.w),
                                                                                      decoration: BoxDecoration(color: Color(0xff39C19D), borderRadius: BorderRadius.circular(8)),
                                                                                      child: Text(
                                                                                        "Yes",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: GoogleFonts.dmSans(
                                                                                          textStyle: TextStyle(
                                                                                              color: Colors.white,
                                                                                              // letterSpacing: .5,
                                                                                              fontSize: 20.sp,
                                                                                              fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10.w,
                                                                                ),
                                                                                Expanded(
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.only(left: 14.w, right: 15.w, top: 9.w, bottom: 9.w),
                                                                                      decoration: BoxDecoration(
                                                                                          color: Color(0xffEC7074),
                                                                                          // border: Border.all(width: 1, color: Black),
                                                                                          borderRadius: BorderRadius.circular(10)),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Text(
                                                                                            "No",
                                                                                            textAlign: TextAlign.center,
                                                                                            style: GoogleFonts.dmSans(
                                                                                              textStyle: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  // letterSpacing: .5,
                                                                                                  fontSize: 20.sp,
                                                                                                  fontWeight: FontWeight.w700),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10.w,
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                            },
                                                            child: SvgPicture.asset(
                                                                "assets/icons/delete1.svg"))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 25.h,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 150.h,
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
                  )),
                  SizedBox(
                    height: 80.h,
                  ),
                ],
              ),
          ),
    );
  }
}
