import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/controller/s_shop_configuration_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class SShopConfigurationView extends StatefulWidget {
  final bool? initialShopConfigration;

  const SShopConfigurationView(
      {Key? key, required this.initialShopConfigration})
      : super(key: key);

  @override
  _SShopConfigurationViewState createState() => _SShopConfigurationViewState();
}

class _SShopConfigurationViewState extends State<SShopConfigurationView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<SShopConfigurationController>()
          .initState(context, widget.initialShopConfigration);
    });
  }

  onBackPressed() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SShopConfigurationController>();
    final read = context.read<SShopConfigurationController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          isBackButtonEnabled:
              widget.initialShopConfigration == true ? false : true,
          onBackBtnPressed: () {
            widget.initialShopConfigration == false
                ? Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SMainScreenView(
                            index: 0,
                            screenName: SAccountScreenView(
                              refresh: false,
                            ))),
                    (Route<dynamic> route) => false,
                  )
                : onBackPressed();
          },
          title: "Shop Configuration",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () async {
            var res = await read.uploadShopConfiguration(context);
            // readMainScreen.onBackPressed(4,SAccountScreenView());
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
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(left: 19.w, right: 19.w, top: 26.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upload Payment QR Code Image",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Black1),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: (Color(0xffEFEFEF)))),
                        width: ScreenUtil().screenWidth,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  read.openGallery1();
                                },
                                child: watch.networkImage != ""
                                    ? Container(
                                        width: ScreenUtil().screenWidth,
                                        height: 142.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1, color: grey6)),
                                        child: AppNetworkImages(
                                          imageUrl: watch.networkImage,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    : watch.fileImage.path != ""
                                        ? Container(
                                            width: ScreenUtil().screenWidth,
                                            height: 142.h,
                                            // width: ScreenUtil().screenWidth,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1, color: grey6)),
                                            child: Image.file(
                                              watch.fileImage,
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                        : Container(
                                            height: 142.h,
                                            child: Column(
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/icons/shop_config.svg"),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  'Upload QR Code',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14.sp,
                                                      color: Color(0xffB7B7B7)),
                                                ),
                                              ],
                                            ),
                                          ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      PrimarySTextFormField(
                        controller: watch.upiIdController,
                        hintText: "Type UPI ID",
                        titleHeader: "UPI ID",
                        hintFontSize: 15.sp,
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Text(
                        "Accepted Mode of Payments",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Color(0xff3A3A3A)),
                      ),
                      SizedBox(
                        height: 13.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onOnlinePaymentSelected();
                            },
                            value: watch.isOnlinePaymentSelected,
                          ),
                          Text(
                            'Online',
                            style: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onCODPaymentSelected();
                            },
                            value: watch.isCODPaymentSelected,
                          ),
                          Flexible(
                            child: Text(
                              'COD',
                              style: TextStyle(
                                  color: Black1,
                                  // letterSpacing: .5,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Container(
                        width: 140.w,
                        child: Text(
                          "Shop Timing",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Color(0xff3A3A3A)),
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // width: 155.w,
                            child: PrimarySTextFormField(
                              hintText: "Opening Time",
                              controller: watch.startShopTimeController,
                              // hint: "Opening Time",
                              // hintSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Expanded(
                            child: PrimarySTextFormField(
                              hintText: "Closing Time",
                              controller: watch.endShopTimeController,
                              // hint: "Closing Time",
                              // hintSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      PrimarySTextFormField(
                        lengthLimitingTextInputFormatter:
                            LengthLimitingTextInputFormatter(10),
//  keyboardType: TextInputType.number,
                        textInputType: TextInputType.number,
                        controller: watch.supportNumberController,
                        titleHeader: "Support Number",
                        hintText: "Enter Support Number",
                        hintFontSize: 15.sp,
                      ),
                      SizedBox(
                        height: 40.w,
                      ),
                      Text(
                        "Delivery Type",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14.sp),
                      ),
                      SizedBox(
                        height: 13.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onCustomerPickupSelected();
                            },
                            value: watch.isCustomerPickupSelected,
                          ),
                          Text(
                            'Customer Pickup',
                            style: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onDeliveryCustomerSelected();
                            },
                            value: watch.isDeliveryCustomerSelected,
                          ),
                          Flexible(
                            child: Text(
                              'Deliver To Customer',
                              style: TextStyle(
                                  color: Black1,
                                  // letterSpacing: .5,
                                  fontSize: 13.4.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.w,
                      ),
                      Row(
                        children: [
                          // PrimaryCheckBox(
                          //   onChanged: (value) {
                          //     read.onDeliveryCharge();
                          //   },
                          //   value: watch.isDeliveryChargesSelected,
                          // ),
                          Text(
                            'Delivery Charges',
                            style: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  PrimaryCheckBox(
                                    onChanged: (value) {
                                      read.onFreePickUpSelected();
                                    },
                                    value: watch.ifFreePickupSelected,
                                  ),
                                  Text(
                                    'Free',
                                    style: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        PrimaryCheckBox(
                                          onChanged: (value) {
                                            read.onDeliveryCharge();
                                          },
                                          value:
                                              watch.isDeliveryChargesSelected,
                                        ),
                                        Flexible(
                                          child: Text(
                                            'Delivery Charges Applicable',
                                            style: TextStyle(
                                                color: Black1,
                                                // letterSpacing: .5,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      // Row(
                      //   children: [

                      // PrimaryCheckBox(
                      //       onChanged: (value) {
                      //         read.onDeliveryCharge();
                      //       },
                      //       value: watch.isDeliveryChargesSelected,
                      //     ),
                      //     Text(
                      //       'Delivery Charges Free',
                      //       style: TextStyle(
                      //           color: Black1,
                      //           // letterSpacing: .5,
                      //           fontSize: 14.sp,
                      //           fontWeight: FontWeight.w400),
                      //     ),
                      //   ],
                      // ),
                      Visibility(
                        visible: watch.isDeliveryChargesSelected,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 45.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Order Amount",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                  child: Text(
                                    "Delivery Charge",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: PrimarySTextFormField(
                                    readOnly: true,
                                    hintText: "1 to 100", hintFontSize: 15.sp,
                                    // hint: "1 to 500",
                                    // hintSize: 15.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                  child: PrimarySTextFormField(
                                    textInputType: TextInputType.number,
                                    controller: watch.firstDeliveryController,
                                    hintText: "Delivery Charge",
                                    hintFontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 17.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Order Amount",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                  child: Text(
                                    "Delivery Charge",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: PrimarySTextFormField(
                                    readOnly: true,
                                    hintText: "100 to 500",
                                    hintFontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                  child: PrimarySTextFormField(
                                    controller: watch.secondDeliveryController,
                                    textInputType: TextInputType.number,
                                    hintText: "Delivery Charge",
                                    hintFontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 17.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Order Amount",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                  child: Text(
                                    "Delivery Charge",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: PrimarySTextFormField(
                                    readOnly: true,
                                    hintText: "500 to 1200",
                                    hintFontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                  child: PrimarySTextFormField(
                                    controller: watch.thirdDeliveryController,
                                    textInputType: TextInputType.number,
                                    hintText: "Delivery Charge",
                                    hintFontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 17.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Order Amount",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                  child: Text(
                                    "Delivery Charge",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        color: Color(0xff3A3A3A)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: PrimarySTextFormField(
                                    readOnly: true,
                                    hintText: "1200 to 3000",
                                    hintFontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                  child: PrimarySTextFormField(
                                    hintText: "Delivery Charge",
                                    controller: watch.fourthDeliveryController,
                                    textInputType: TextInputType.number,
                                    hintFontSize: 15.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      // Text(
                      //   "Minimum Order Value for Delivery to Customer",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 15.sp,
                      //       color: Color(0xff3A3A3A)),
                      // ),
                      // PrimarySTextFormField(
                      //   // readOnly: true,
                      //   hintText: "Rs. 200",
                      //   hintFontSize: 15.sp,
                      // ),
                      PrimarySTextFormField(
                        // controller: watch.upiIdController,
                        hintText: "Rs. 200",
                        titleHeader:
                            "Minimum Order Value for Delivery to Customer",
                        hintFontSize: 15.sp,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Areas (Pune)",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                                color: Color(0xff3A3A3A)),
                          ),
                          GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        backgroundColor: Color(0xffFFFFFF),
                                        // shape: ,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),

                                        // scrollable: true,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: ScreenUtil().screenWidth,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 18.0.w,
                                                      left: 18.0.w,
                                                      top: 27.h,
                                                    ),
                                                    child: SizedBox(
                                                      width: 351.w,
                                                      height: 36.h,
                                                      child: TextField(
                                                        // autofocus: true,
                                                        // controller:
                                                        //     watch.searchController,
                                                        decoration:
                                                            InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        width:
                                                                            1,
                                                                        color:
                                                                            splashnone),
                                                                    borderRadius:
                                                                        BorderRadius.circular(8
                                                                            .w)),
                                                                hintText:
                                                                    'Search ',
                                                                hintStyle: GoogleFonts.dmSans(
                                                                    textStyle: TextStyle(
                                                                        color: Grey,
                                                                        // letterSpacing: .5,
                                                                        fontSize: 11,
                                                                        fontWeight: FontWeight.w400)),

                                                                // Add a clear button to the search bar

                                                                // Add a search icon or button to the search bar
                                                                prefixIcon: IconButton(
                                                                  icon:
                                                                      SvgPicture
                                                                          .asset(
                                                                    'assets/images/search.svg',
                                                                    width: 15.w,
                                                                    height:
                                                                        15.h,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    // Perform the search here
                                                                  },
                                                                ),
                                                                suffixIcon: IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  icon:
                                                                      Container(
                                                                    height:
                                                                        20.w,
                                                                    width: 20.w,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.5)),
                                                                    child:
                                                                        Center(
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        'assets/images/Cross.svg',
                                                                        width:
                                                                            3.w,
                                                                        height:
                                                                            6.h,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: 18,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        PrimaryCheckBox(
                                                            // onChanged: (value) {
                                                            //   read.onSixToNine();
                                                            // },
                                                            // value: watch.isSixToNine,
                                                            ),
                                                        Flexible(
                                                          child: Text(
                                                            'Vishrantwadi',
                                                            style: TextStyle(
                                                                color: Black1,
                                                                // letterSpacing: .5,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 24.h,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 18.0,
                                                        bottom: 20,
                                                        right: 19.w),
                                                    child: PrimaryButton(
                                                        fontSize: 16.sp,
                                                        height: 34.w,
                                                        width: 274.w,
                                                        text: "Submit",
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Color(0xff39C19D),
                                                        onTap: () {
                                                          // watch.customerAdsForm(context);
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: SvgPicture.asset(
                                  "assets/icons/add_area.svg")),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      PrimarySTextFormField(
                        // readOnly: true,
                        hintText: "Vishrantwadi, Viman Nagar, Kharadi",
                        hintFontSize: 15.sp,
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      Text(
                        "Slot Selection",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Color(0xff3A3A3A)),
                      ),
                      SizedBox(
                        height: 15.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onNineToTwelve();
                            },
                            value: watch.isNineToTwelve,
                          ),
                          Text(
                            '9am to 12pm',
                            style: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 70.w,
                          ),
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onThreeToSix();
                            },
                            value: watch.isThreeToSix,
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(top: 0.w),
                              child: Text(
                                '3pm to 6pm',
                                style: TextStyle(
                                    color: Black1,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onTwelveToThree();
                            },
                            value: watch.isTwelveToThree,
                          ),
                          Text(
                            '12pm to 3pm',
                            style: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 70.w,
                          ),
                          PrimaryCheckBox(
                            onChanged: (value) {
                              read.onSixToNine();
                            },
                            value: watch.isSixToNine,
                          ),
                          Flexible(
                            child: Text(
                              '6pm to 9pm',
                              style: TextStyle(
                                  color: Black1,
                                  // letterSpacing: .5,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
