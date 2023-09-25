import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/promotion_request/controller/promotion_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/stack_loader.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class shopPromotionRequestView extends StatefulWidget {
  const shopPromotionRequestView({super.key});

  @override
  State<shopPromotionRequestView> createState() =>
      _shopPromotionRequestViewState();
}

class _shopPromotionRequestViewState extends State<shopPromotionRequestView> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<shopPromotionController>();
    final read = context.read<shopPromotionController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            title: "Promotion Request form",
            onBackBtnPressed: () {
              readMainScreen.onNavigation(4, SAccountScreenView(
                refresh: false,
              ), context);

            },
          ),
        ),
        backgroundColor: Colors.white,
        body: StackLoader(
          showLoader: watch.isStackLoading,
          child: WillPopScope(
            onWillPop: ()async{
              readMainScreen.onNavigation(4, SAccountScreenView(
                refresh: false,
              ), context);
              return false;
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: ScreenUtil().screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: 19.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.w,
                        ),
                        PrimarySTextFormField(
                          controller: watch.promotionSubjectController,
                          titleHeader: "Promotion Subject",
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        PrimarySTextFormField(
                          controller: watch.planToStartController,
                          titleHeader: "Plan for Start",
                          readOnly: true,
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
                                      onSurface: Colors.black, // <-- SEE HERE
                                    ),
                                    textButtonTheme: TextButtonThemeData(
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
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              String date = DateFormat('dd-MM-yyy')
                                  .format(pickedDate ?? DateTime.now());
                              read.onToDateSelected(date);
                            }
                          },
                          suffix: GestureDetector(
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
                                        onSurface: Colors.black, // <-- SEE HERE
                                      ),
                                      textButtonTheme: TextButtonThemeData(
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
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                String date = DateFormat('dd-MM-yyy')
                                    .format(pickedDate ?? DateTime.now());
                                read.onToDateSelected(date);
                              }
                            },
                            child: Container(
                              width: 15.h,
                              height: 17.w,
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/icons/shop_cal.svg",
                                ),
                              ),
                            ),
                          ),
                          hintFontSize: 15.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Ads Plan",
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                                color: Black,
                                letterSpacing: .5,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            FilterRadioButton(
                                value: "7",
                                groupValue: read.groupValue,
                                onChanged: (value) {
                                  read.onRadioBtnToggled(value);
                                },
                                leading: ""),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '7 days',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        Row(
                          children: [
                            FilterRadioButton(
                                value: "15",
                                groupValue: read.groupValue,
                                onChanged: (value) {
                                  read.onRadioBtnToggled(value);
                                },
                                leading: ""),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '15 days',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        Row(
                          children: [
                            FilterRadioButton(
                                value: "30",
                                groupValue: read.groupValue,
                                onChanged: (value) {
                                  read.onRadioBtnToggled(value);
                                },
                                leading: ""),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '30 days',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        Row(
                          children: [
                            FilterRadioButton(
                                value: "60",
                                groupValue: read.groupValue,
                                onChanged: (value) {
                                  read.onRadioBtnToggled(value);
                                },
                                leading: ""),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '60 days',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 19.h,
                        ),
                        Text(
                          "Ads Content",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Black,
                                // letterSpacing: .5,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        PrimarySTextFormField(
                          controller: watch.adsContentController,
                          // controller: watch.termsAndConditionController,
                          height: 150.w,
                          maxLines: 10,
                          // hintText: "Address",/
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        PrimaryButton(
                            fontSize: 20.sp,
                            height: 50.w,
                            text: "Submit",
                            color: Color(0xff4689EC),
                            onTap: () {
                              watch.promotionRequestForm(context);
                            }),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Note",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(bottom: 20.w),
                                  child: Icon(
                                    Icons.circle_rounded,
                                    size: 5.w,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  // softWrap: true,
                                  // maxLines: 3,//
                                  "For pricing and further details,Local Supermart will contact you within 48 hours.",
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,

                                        // letterSpacing: .05,
                                        // overflow: TextOverflow.ellipsis,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              // For advertisement advance payment is required.
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(bottom: 0.w),
                                  child: Icon(
                                    Icons.circle_rounded,
                                    size: 5.w,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  "For advertisement advance payment is required.",
                                  // softWrap: true,
                                  // maxLines: 3,//
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,

                                        // letterSpacing: .05,
                                        // overflow: TextOverflow.ellipsis,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              // For advertisement advance payment is required.
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
