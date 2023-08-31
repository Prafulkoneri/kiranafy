import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/main.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/controller/s_subscription_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class SSubscriptionScreenView extends StatefulWidget {
  final bool? loggedIn;

  const SSubscriptionScreenView({Key? key, required this.loggedIn})
      : super(key: key);

  @override
  _SSubscriptionScreenViewState createState() =>
      _SSubscriptionScreenViewState();
}

// String? selectedValue;

// String radioButtonItem = '';

// bool _isChecked = true;
// String _currText = '';

// int id = 1;
// bool _checkbox = false;

// List<String> text = ["InduceSmile.com", "Flutter.io", "google.com"];

class _SSubscriptionScreenViewState extends State<SSubscriptionScreenView> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SSubscriptionController>().initState(context);
    });
    print(context.read<SSubscriptionController>().subscriptionData);
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SSubscriptionController>();
    final watch = context.watch<SSubscriptionController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          isBackButtonEnabled: widget.loggedIn == true ? true : false,
          // isBackButtonEnabled: false,
          onBackBtnPressed: () {
            Navigator.pop(context);
          },
          title: "Subscription Plans",
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
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.topLeft,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0.w,
                          top: -25,
                          child: Image.asset(
                            "assets/images/splash1.png",
                            height: 235.w,
                            width: 361.w,
                          ),
                        ),
                        Positioned(
                          bottom: -80.w,
                          // top: 0,
                          right: 0.w,
                          child: Image.asset(
                            "assets/images/splash2.png",
                            height: 235.w,
                            width: 361.w,
                          ),
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      watch.subscriptionData?.length ?? 0,
                                  itemBuilder: (BuildContext, index) {
                                    final element =
                                        watch.subscriptionData?[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 19.w, top: 15.w, right: 19.w),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        clipBehavior: Clip.none,
                                        children: <Widget>[
                                          Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Custlogin,
                                                    gradient: LinearGradient(
                                                        end:
                                                            Alignment.topCenter,
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          index.isEven
                                                              ? yellow1
                                                                  .withOpacity(
                                                                      1)
                                                              : Color(0xff4EC0FA)
                                                                  .withOpacity(
                                                                      1),
                                                          index.isEven
                                                              ? yellow2
                                                                  .withOpacity(
                                                                      1)
                                                              : Color(0xff32DFAC)
                                                                  .withOpacity(
                                                                      1),
                                                        ]),

                                                    // border: Border.all(width: 1, color: Black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.w)),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10.w,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 14.w,
                                                        ),
                                                        PrimaryRadioButton(
                                                          value:
                                                              watch.radioValue[
                                                                  index],
                                                          groupValue: watch
                                                              .radioGrpValue,
                                                          onChanged: (value) {
                                                            read.onRadioBtnChanged(
                                                                value,
                                                                element?.id,
                                                                element
                                                                    ?.subscriptionPrice);
                                                          },
                                                          leading: "",
                                                        ),
                                                        SizedBox(
                                                          width: 7.w,
                                                        ),
                                                        Text(
                                                          element?.planName ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 30.w,
                                                    ),
                                                    SizedBox(
                                                      height: 22.w,
                                                    ),
                                                    index.isEven
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.w),
                                                            child: Image.asset(
                                                              'assets/images/subscription3.png',
                                                              // width: 352.w,
                                                              // height: 60.h,
                                                            ),
                                                          )
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.w),
                                                            child: Image.asset(
                                                              'assets/images/subscription2.png',
                                                              // width: 352.w,
                                                              // height: 60.h,
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                  top: 35.w,
                                                  left: 37.w,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "\u{20B9} ${element?.subscriptionPrice}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontSize: 28.sp),
                                                      ),
                                                      SizedBox(
                                                        height: 4.w,
                                                      ),
                                                      Container(
                                                        width: ScreenUtil()
                                                                .screenWidth /
                                                            1.29.w,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${element?.validityNumbers} ${element?.validityIn} Validity",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Container(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Dialog(
                                                                          child:
                                                                              SingleChildScrollView(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(top: 11.w, right: 14.w, left: 25.w),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Text("${element?.planName}",
                                                                                              style: GoogleFonts.dmSans(
                                                                                                textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                                                                              )),
                                                                                          SizedBox(
                                                                                            width: 2.w,
                                                                                          ),
                                                                                          Text("-",
                                                                                              style: GoogleFonts.dmSans(
                                                                                                textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                                                                              )),
                                                                                          SizedBox(
                                                                                            width: 2.w,
                                                                                          ),
                                                                                          Text("\u{20B9} ${element?.subscriptionPrice}",
                                                                                              style: GoogleFonts.dmSans(
                                                                                                textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                                                                              )),
                                                                                        ],
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: SvgPicture.asset("assets/icons/pop_delete.svg"),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Divider(),
                                                                                Container(
                                                                                  padding: EdgeInsets.only(
                                                                                    // left: 23.w,
                                                                                    bottom: 11.6.w,
                                                                                    // right: 16.w,
                                                                                  ),
                                                                                  // height:
                                                                                  //     646.h,
                                                                                  // width: 362.w,
                                                                                  child: HtmlWidget(
                                                                                    element?.planBenifits ?? "",
                                                                                    textStyle: TextStyle(
                                                                                        color: Black1,
                                                                                        // height: 1.5,
                                                                                        // letterSpacing: .05,
                                                                                        // overflow: TextOverflow.ellipsis,
                                                                                        fontSize: 14.sp,
                                                                                        fontWeight: FontWeight.w400),
                                                                                    // watch.?.description ?? "",
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          11.w,
                                                                      vertical:
                                                                          4.w),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7.w),
                                                                    color: Color(
                                                                            0xff000000)
                                                                        .withOpacity(
                                                                            0.35),
                                                                  ),
                                                                  child: Row(
                                                                    // mainAxisAlignment:
                                                                    //     MainAxisAlignment.start,
                                                                    // mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Text(
                                                                        'View Benefits',
                                                                        style: GoogleFonts
                                                                            .dmSans(
                                                                          textStyle: TextStyle(
                                                                              color: Colors.white,
                                                                              // letterSpacing: .5,
                                                                              fontSize: 12.sp,
                                                                              fontWeight: FontWeight.w400),
                                                                        ),
                                                                      ), // <-- Text
                                                                      SizedBox(
                                                                          width:
                                                                              4.w),
                                                                      SvgPicture
                                                                          .asset(
                                                                              "assets/icons/forward1.svg"),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 22.w,
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 19.w,
                                  top: 30.w,
                                ),
                                child: Text(
                                  'Add on Services:',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        // letterSpacing: .5,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 17.w,
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: watch.addOnServicesList?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final element =
                                      watch.addOnServicesList?[index];
                                  return Container(
                                    padding: EdgeInsets.only(
                                      left: 19.w,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            PrimaryCheckBox(
                                              onChanged: (value) {
                                                read.onAddOnServicesSelected(
                                                    index, element?.id);
                                              },
                                              value:
                                                  watch.selectAddonServicesList[
                                                      index],
                                            ),
                                            Text(
                                              '${element?.addOnService}',
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black1,
                                                    // letterSpacing: .5,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 19.w, bottom: 20.w),
                                child: Text(
                                  "To know more about add-on services and pricing\ndetails, request for a call back.",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 19.w,
                                  // top: 30.w,
                                ),
                                child: Text(
                                  'Mode of Payment:',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        // letterSpacing: .5,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 19.w,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        PrimaryCheckBox(
                                          value: watch.isSelectedPaymentUpi,
                                          onChanged: (value) {
                                            read.onFavToShopSelected(value);
                                          },
                                        ),
                                        Text(
                                          'UPI ID - ',
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                // letterSpacing: .5,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SelectableText(
                                          'dhanashree203@oksbi ',
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                // letterSpacing: .5,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        PrimaryCheckBox(
                                            onChanged: (value) {
                                              read.onOrderedButNotFavSelected(
                                                  context);
                                            },
                                            value: watch.isQrCodeSeleted
                                            // watch.selectAddonServicesList[
                                            //     index],
                                            ),
                                        Text(
                                          'QR Code',
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                // letterSpacing: .5,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 31.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/new_qrcode.jpg",
                                    width: 200.w,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 19.w, right: 19.w),
                                    child: Text(
                                      'Payment Transaction ID ',
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            letterSpacing: .5,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 19.w, right: 19.w),
                                    // height: 48.h,
                                    // width: 352.w,
                                    child: PrimarySTextFormField(
                                      controller: watch.transactionIdController,
                                      hintText: "Enter Transaction ID",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 19.w, right: 19.w),
                                    child: Text(
                                      'Copy and paste your payment successful transaction details on above input box',
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: grey8,
                                            letterSpacing: .5,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 31.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                    width: 390.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(SplashText),
                      ),
                      onPressed: () {
                        read.buySubscriptionPlan(context, widget.loggedIn);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  watch.planAmount != ""
                                      ? Text(
                                          '\u{20B9} ${watch.planAmount}',
                                          // "₹ 4,000",

                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                // letterSpacing: .5,
                                                fontSize: 23.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      : Container(),
                                  // Text(
                                  //   "Extra 18% GST",
                                  //   style: GoogleFonts.dmSans(
                                  //     textStyle: TextStyle(
                                  //         color: Colors.white,
                                  //         // letterSpacing: .5,
                                  //         fontSize: 10.sp,
                                  //         fontWeight: FontWeight.w500),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Container(
                                child: PrimaryButton(
                                    color: Colors.white,
                                    height: 36.h,
                                    width: 160.w,
                                    onTap: () async {
                                      print("hello");
                                      await read.buySubscriptionPlan(
                                          context, widget.loggedIn);

                                      // readMainScreen.onNavigation(
                                      //     4, SShopConfigurationView(), context);
                                      // };
                                    },
                                    text: 'Make Payment',
                                    textColor: SplashText1,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),

                      //
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
