import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/cart/view/cart_detail_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/order_summary/controller/order_summary_controller.dart';
import 'package:local_supper_market/screen/customer/order_summary/view/address_list_sheet_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/view/coupons_list_sheet_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/view/expected_delivery_date_sheet_view.dart';
import 'package:local_supper_market/screen/customer/products/controller/product_view_controller.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen_view.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/favourite.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:local_supper_market/widget/stack_Loader.dart';
import 'package:local_supper_market/widget/text.dart';
import 'package:provider/provider.dart';
import '../order_products.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderSummaryView extends StatefulWidget {
  final String? shopId;
  final String? cartId;
  final bool? isRefresh;
  final String? route;

  const OrderSummaryView(
      {super.key,
      this.cartId,
      this.shopId,
      required this.isRefresh,
      required this.route});

  @override
  State<OrderSummaryView> createState() => _OrderSummaryViewState();
}

// enum Fruit { apple, banana }

class _OrderSummaryViewState extends State<OrderSummaryView> {
  String radioButtonItem = '';
  bool showAddressModalSheet = false;
  ScrollController scrollController = ScrollController();

  // Group Value for Radio Button.
  int id = 1;
  Razorpay razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccessCallback);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, paymentErrorCallback);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletCallback);
    print(widget.shopId);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<OrderSummaryController>().initState(
            context,
            widget.shopId,
            widget.cartId,
            widget.isRefresh,
            widget.route,
          );
      if (widget.route == "editAddress") {
        showModalBottomSheet(
            backgroundColor: Colors.white,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            context: context,
            builder: (context) {
              // using a scaffold helps to more easily position the FAB
              return const AddressListSheetView();
            });
      }
    });
    setPagination();
  }

  setPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          context.read<OrderSummaryController>().onScrollMaxExtent(context);
        });
      }
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {}

  void paymentSuccessCallback(PaymentSuccessResponse response) {
    debugPrint("Payment Success: ${response.paymentId}");
  }

  void paymentErrorCallback(PaymentFailureResponse response) {
    debugPrint("Payment Error: ${response.code} - ${response.message}");
  }

  void externalWalletCallback(ExternalWalletResponse response) {
    debugPrint("External Wallet: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<OrderSummaryController>();
    final read = context.read<OrderSummaryController>();
    final readMain = context.read<MainScreenController>();
    final readProductViewController = context.read<ProductViewController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "Order Summary",
          onBackBtnPressed: () {
            readMain.onNavigation(
                2,
                CartDetailView(
                  isRefresh: true,
                  shopId: watch.shopId,
                  cartId: watch.cartId,
                ),
                context);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => CartDetailView(
            //               isRefresh: true,
            //               shopId: watch.shopId,
            //               cartId: watch.cartId,
            //             )));
          },
        ),
      ),
      body: watch.isLoading
          ? const Loader()
          : WillPopScope(
              onWillPop: () async {
                readMain.onNavigation(
                    2,
                    CartDetailView(
                      isRefresh: true,
                      shopId: watch.shopId,
                      cartId: watch.cartId,
                    ),
                    context);
                return false;
              },
              child: StackLoader(
                showLoader: watch.isStackLoaderVisible,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          readMain.onNavigation(
                              1,
                              ShopProfileView(
                                refreshPage: true,
                                routeName: '',
                                shopId: watch.shopDetailData?.id.toString(),
                              ),
                              context);
                          readMain.showBottomNavigationBar();
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => MainScreenView(
                          //           index: 1,
                          //           screenName: ShopProfileView(
                          //             refreshPage: true,
                          //             routeName: '',
                          //             shopId: watch.shopDetailData?.id.toString(),
                          //           ))),
                          //   (Route<dynamic> route) => false,
                          // );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 20.w),
                                  child: OrderSummery(
                                    text: "${watch.shopDetailData?.shopName}",
                                  )),
                              Container(
                                // padding: EdgeInsets.all(3.w),
                                // height: 70.h,
                                // decoration: BoxDecoration(
                                //   border: Border(
                                //     // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                                //     bottom: BorderSide(width: 1, color: grey2),
                                //   ),
                                // ),

                                // color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        Container(
                                            width: 200.w,
                                            child: ShopAddress(
                                              text:
                                                  "${watch.shopDetailData?.shopAddress}\n${watch.shopDetailData?.cityName} - ${watch.shopDetailData?.shopPincode}",
                                            )
                                            //  Text(
                                            //   // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                            //   "${watch.shopDetailData?.shopAddress}\n${watch.shopDetailData?.cityName} - ${watch.shopDetailData?.shopPincode}",
                                            //   style: GoogleFonts.roboto(
                                            //     textStyle: TextStyle(
                                            //         color: Black,
                                            //         // letterSpacing: .5,
                                            //         fontSize: 13.sp,
                                            //         fontWeight: FontWeight.w400),
                                            //   ),
                                            // ),
                                            ),
                                      ],
                                    ),
                                    // Row(
                                    //   children: [
                                    //     // GestureDetector(
                                    //     //   onTap: () {
                                    //     //     read.launchPhone(
                                    //     // watch.shopDetailData
                                    //     //         ?.shopOwnerSupportNumber ??
                                    //     //     "",
                                    //     //         context);
                                    //     //   },
                                    //     //   child: SvgPicture.asset(
                                    //     //     'assets/images/call.svg',
                                    //     //     // width: 15.w,
                                    //     //     // height: 19.h,
                                    //     //   ),
                                    //     // ),
                                    //     InkWell(
                                    //       onTap: () {
                                    // read.launchPhone(
                                    //     watch.shopDetailData
                                    //             ?.shopOwnerSupportNumber ??
                                    //         "",
                                    //     context);
                                    //       },
                                    //       child: Container(
                                    //           padding: EdgeInsets.only(
                                    //               left: 13.w,
                                    //               right: 13.w,
                                    //               top: 14.w,
                                    //               bottom: 14.w),
                                    //           decoration: BoxDecoration(
                                    //             shape: BoxShape.circle,
                                    //             color: Color(0xff23AA49),
                                    //           ),
                                    //           child: SvgPicture.asset(
                                    //             "assets/icons/new_call.svg",
                                    //             // width: 26.w,
                                    //             // height: 14.h,
                                    //           )),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 13.w,
                                    //     ),
                                    //     InkWell(
                                    //       onTap: () {
                                    // watch.favAllShop
                                    //     ? read.removeAllShopFavList(
                                    //         context,
                                    //         watch.shopDetailData?.id)
                                    //     : read.updateAllShopFavList(
                                    //         context,
                                    //         watch.shopDetailData?.id);
                                    //       },
                                    //       child: watch.favAllShop
                                    //           ? SvgPicture.asset(
                                    //               "assets/icons/new_fvrt_selected.svg",
                                    //               // width: 26.w,
                                    //               // height: 14.h,
                                    //             )
                                    //           : SvgPicture.asset(
                                    //               "assets/icons/new_fvrt_not_selected.svg",
                                    //               // width: 26.w,
                                    //               // height: 14.h,
                                    //             ),
                                    //     )

                                    //   ],
                                    // ),
                                    FavouriteView(
                                      isFvrt: watch.favAllShop,
                                      onPhoneTap: () {
                                        read.launchPhone(
                                            watch.shopDetailData
                                                    ?.shopOwnerSupportNumber ??
                                                "",
                                            context);
                                      },
                                      onFvrtTap: () {
                                        watch.favAllShop
                                            ? read.removeAllShopFavList(context,
                                                watch.shopDetailData?.id)
                                            : read.updateAllShopFavList(context,
                                                watch.shopDetailData?.id);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        // height: 100,
                        color: grey2,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                      ),

                      SizedBox(
                        height: 10.w,
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 19.w, right: 77.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                watch.shopDeliveryTypes
                                            ?.shopOwnerDeliveryToCustomer ==
                                        "active"
                                    ? SecondaryRadioButton(
                                        value: "delivery_to",
                                        groupValue: watch.groupValue,
                                        // groupValue: watch.radioGroupValue,
                                        onChanged: (value) {
                                          read.onRadioButtonSelected(
                                              value, context);
                                        },
                                        leading: "")
                                    : InkWell(
                                        onTap: () {
                                          Utils.showPrimarySnackbar(context,
                                              "This shop provides only self- pickup option.",
                                              type: SnackType.error);
                                        },
                                        child: Container(
                                          height: 16.w,
                                          width: 16.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xff03C9CC),
                                              width: 1.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'Delivery To',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                watch.shopDeliveryTypes
                                            ?.shopOwnerCustomerPickup ==
                                        "active"
                                    ? SecondaryRadioButton(
                                        value: "self_pickup",
                                        groupValue: watch.groupValue,
                                        onChanged: (value) {
                                          read.onRadioButtonSelected(
                                              value, context);
                                        },
                                        leading: "")
                                    : InkWell(
                                        onTap: () {
                                          Utils.showPrimarySnackbar(context,
                                              "This shop provides only delivery option.",
                                              type: SnackType.error);
                                        },
                                        child: Container(
                                          height: 16.w,
                                          width: 16.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xff03C9CC),
                                              width: 1.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'Self Pickup',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            watch.groupValue == "self_pickup" ? false : true,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, top: 20.w, right: 19.w),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: watch.customerAddress?.length ?? 0,
                            itemBuilder: (context, index) {
                              final element = watch.customerAddress![index];
                              return GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      context: context,
                                      builder: (context) {
                                        // using a scaffold helps to more easily position the FAB
                                        return const AddressListSheetView();
                                      });
                                },
                                child: SizedBox(
                                  width: double.infinity,
                                  child: element.addressId ==
                                          int.parse(watch.addressGroupValue)
                                      ? Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                bottom: 15.w,
                                                left: 20.w,
                                                right: 20.w,
                                                top: 15.w),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/images/person.svg',
                                                          width: 11.w,
                                                          height: 15.h,
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Text(
                                                          "${element.customerName}",
                                                          // 'Rachel Green',
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            textStyle: TextStyle(
                                                                color: Black,
                                                                letterSpacing:
                                                                    .5,
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                        // SizedBox(
                                                        //   width: 11.w,
                                                        // ),
                                                      ],
                                                    ),
                                                    const Icon(Icons
                                                        .keyboard_arrow_down_outlined),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15.w,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/phone.svg',
                                                      width: 14.w,
                                                      height: 15.h,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(
                                                      '${element.mobileNo}',
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Black,
                                                            letterSpacing: .5,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15.w,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/location.svg',
                                                      color: SplashText1,
                                                      width: 17.w,
                                                      height: 17.h,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        maxLines: 3,
                                                        "${element.address1} \n${element.address2} ",
                                                        // "Nand Nivas Building floor 3 B-3,Lane No.13 Bhatrau Nivas Vishrantwadi Pune -411015.",
                                                        // textAlign: TextAlign.start,
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              // height: 1.5,
                                                              color: black,
                                                              // letterSpacing: .05,
                                                              // overflow: TextOverflow.ellipsis,
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                              );
                            },
                            // child:
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 19.w, top: 32.w),
                        child: Text(
                          "Delivery Date",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                // height: 1.5,
                                color: black,
                                // letterSpacing: .05,
                                // overflow: TextOverflow.ellipsis,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30))),
                              context: context,
                              builder: (context) {
                                // using a scaffold helps to more easily position the FAB
                                return const ExpectedDeliveryDateSheetView();
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 17.w, top: 8.w, bottom: 10.w),
                          margin: EdgeInsets.only(
                              left: 10.w, right: 17.w, top: 8.w, bottom: 10.w),
                          decoration: BoxDecoration(
                              border: Border.all(color: grey3),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            // height: 1.5,
                                            color: black,
                                            letterSpacing: .05,
                                            // overflow: TextOverflow.ellipsis,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    watch.expectedDateController.text != "" ||
                                            watch.slotGroupValue != ""
                                        ? Row(
                                            children: [
                                              Text(
                                                watch.expectedDateController
                                                    .text,
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      // height: 1.5,
                                                      color: black,
                                                      // letterSpacing: .05,
                                                      // overflow: TextOverflow.ellipsis,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/calender.svg',
                                                width: 12.w,
                                                height: 14.h,
                                              ),
                                            ],
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    watch.slotGroupValue ==
                                                "shop_owner_slot_9_to_12" ||
                                            watch.slotGroupValue ==
                                                "shop_owner_slot_12_to_3"
                                        ? "Delivery Slot:"
                                        : "Delivery Slot",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          // height: 1.5,
                                          color: black,
                                          letterSpacing: .05,
                                          // overflow: TextOverflow.ellipsis,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  watch.expectedDateController.text != "" ||
                                          watch.slotGroupValue != ""
                                      ? Row(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.end,
                                          // mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                watch.slotGroupValue ==
                                                        "shop_owner_slot_9_to_12"
                                                    ? "09:00 AM - 12:00 PM"
                                                    : watch.slotGroupValue ==
                                                            "shop_owner_slot_12_to_3"
                                                        ? "12:00 PM - 03:00 PM"
                                                        : watch.slotGroupValue ==
                                                                "shop_owner_slot_3_to_6"
                                                            ? "03:00 PM - 06:00 PM"
                                                            : watch.slotGroupValue ==
                                                                    "shop_owner_slot_6_to_9"
                                                                ? "06:00 PM - 09:00 PM"
                                                                : "No Slot Selected",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: black,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    backgroundColor: Colors
                                                        .white,
                                                    isScrollControlled: true,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        30),
                                                                topRight: Radius
                                                                    .circular(
                                                                        30))),
                                                    context: context,
                                                    builder: (context) {
                                                      // using a scaffold helps to more easily position the FAB
                                                      return const ExpectedDeliveryDateSheetView();
                                                    });
                                              },
                                              child: SvgPicture.asset(
                                                'assets/images/pencil.svg',
                                                width: 12.w,
                                                height: 14.h,
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 5.w,
                                            // ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // showModalBottomSheet(
                                                //     backgroundColor: Colors.white,
                                                //     isScrollControlled: true,
                                                //     shape:
                                                //         const RoundedRectangleBorder(
                                                //             borderRadius:
                                                //                 BorderRadius.only(
                                                //                     topLeft: Radius
                                                //                         .circular(
                                                //                             30),
                                                //                     topRight: Radius
                                                //                         .circular(
                                                //                             30))),
                                                //     context: context,
                                                //     builder: (context) {
                                                //       // using a scaffold helps to more easily position the FAB
                                                //       return ExpectedDeliveryDateSheetView();
                                                //     });
                                              },
                                              child: SvgPicture.asset(
                                                'assets/images/pencil.svg',
                                                width: 12.w,
                                                height: 14.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              )),
                              // SizedBox(width: 22.w),
                            ],
                          ),
                        ),
                      ),
                      ///////////////////////////////////
                      Container(
                        padding:
                            EdgeInsets.only(left: 19.w, top: 30.w, right: 19.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Available Coupon Code",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    // height: 1.5,
                                    color: black,
                                    letterSpacing: .05,
                                    // overflow: TextOverflow.ellipsis,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (watch.finalCouponList!.isEmpty) {
                                  Utils.showPrimarySnackbar(
                                      context, "No Coupons Found",
                                      type: SnackType.error);
                                  return;
                                }
                                showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    context: context,
                                    builder: (context) {
                                      // using a scaffold helps to more easily position the FAB
                                      return const CouponsListSheetView();
                                    });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 11.33.w, vertical: 7.w),
                                decoration: BoxDecoration(
                                    color: lightsky,
                                    borderRadius: BorderRadius.circular(10.w),
                                    border: Border.all(color: SplashText)),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Get Code",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.sp,
                                            color: SplashText),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 19.w, right: 19.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Coupon Code",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    // letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 11.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  height: 34.w,
                                  child: TextField(
                                    readOnly: true,
                                    onTap: () {
                                      if (watch.finalCouponList!.isEmpty) {
                                        Utils.showPrimarySnackbar(
                                            context, "No Coupons Found",
                                            type: SnackType.error);
                                        return;
                                      }
                                      showModalBottomSheet(
                                          backgroundColor: Colors.white,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight:
                                                      Radius.circular(30))),
                                          context: context,
                                          builder: (context) {
                                            // using a scaffold helps to more easily position the FAB
                                            return const CouponsListSheetView();
                                          });
                                      //Your code here
                                    },
                                    controller: watch.couponCodeController,
                                    decoration: InputDecoration(
                                      fillColor: grey4,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 30.w,
                                // ),
                                SizedBox(
                                  height: 32.h,
                                  width: 91.w,
                                  child: PrimaryButton(
                                    color: SplashText,

                                    onTap: () {
                                      read.removeCoupon(context, true);
                                    },
                                    child: Text(
                                      "Remove",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            // letterSpacing: .5,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),

                                    //
                                  ),
                                )
                              ],
                            ),
                            watch.couponCodeController.text != ""
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 10.w,
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: 'Congratulations, ',
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: SplashText,
                                                  // letterSpacing: .5,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                'Coupon Applied successfully.',
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: SplashText,
                                                  // letterSpacing: .5,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      watch.fullFillYourCravingsAdmin.isNotEmpty == true
                          ? Container(
                              // height: 203.h,
                              width: ScreenUtil().screenWidth,
                              color: Coupons,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 16.w, left: 18.w),
                                    child: Text(
                                      "Fulfil your cravings",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: SplashText,
                                            // letterSpacing: .5,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 15.w,
                                      bottom: 15.w,
                                    ),
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      scrollDirection: Axis.horizontal,
                                      // physics: BouncingScrollPhysics(),
                                      child: Stack(
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    watch.fullFillYourCravingsAdmin
                                                            .length ??
                                                        0, (index) {
                                                  final element = watch
                                                          .fullFillYourCravingsAdmin[
                                                      index];
                                                  return watch
                                                                  .fullFillYourCravingsAdmin[
                                                                      index]
                                                                  .mrpPrice !=
                                                              "" &&
                                                          int.parse(element
                                                                          .offerPrice ==
                                                                      ""
                                                                  ? "0"
                                                                  : element
                                                                          .offerPrice ??
                                                                      "0") <
                                                              int.parse(element
                                                                      .mrpPrice ??
                                                                  "0")
                                                      ? Row(
                                                          children: [
                                                            SizedBox(
                                                              width: index == 0
                                                                  ? 10
                                                                  : 2.w,
                                                            ),
                                                            element.weight ==
                                                                        "" &&
                                                                    element.offerPrice ==
                                                                        "" &&
                                                                    element.mrpPrice ==
                                                                        "" &&
                                                                    element.unit ==
                                                                        "" &&
                                                                    element.productUnitId ==
                                                                        null
                                                                ? Container()
                                                                : GestureDetector(
                                                                    onTap: () {
                                                                      readProductViewController.updateProductId(
                                                                          element
                                                                              .id
                                                                              .toString(),
                                                                          context,
                                                                          false);
                                                                      readMain.onNavigation(
                                                                          1,
                                                                          ProductScreenView(
                                                                              routeName: "",
                                                                              selectedUnitId: element.productUnitId.toString(),
                                                                              categoryId: element.categoryId.toString(),
                                                                              // categoryId: watch.categoryId,
                                                                              productId: element.id.toString(),
                                                                              shopId: element.shopId,
                                                                              productType: element.productType),
                                                                          context);
                                                                      readMain
                                                                          .showBottomNavigationBar();
                                                                      // Navigator
                                                                      //     .pushAndRemoveUntil(
                                                                      //   context,
                                                                      //   MaterialPageRoute(
                                                                      //       builder:
                                                                      //           (context) =>
                                                                      //               MainScreenView(
                                                                      //                 index: 1,
                                                                      //                 screenName: ProductScreenView(
                                                                      //                     routeName: "",
                                                                      //                     selectedUnitId: element?.productUnitId.toString(),
                                                                      //                     categoryId: element?.categoryId.toString(),
                                                                      //                     // categoryId: watch.categoryId,
                                                                      //                     productId: element?.id.toString(),
                                                                      //                     shopId: element?.shopId,
                                                                      //                     productType: element?.productType),
                                                                      //               )),
                                                                      //   (Route<dynamic>
                                                                      //           route) =>
                                                                      //       false,
                                                                      // );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration: const BoxDecoration(
                                                                          // color: Colors.white,
                                                                          // boxShadow: [
                                                                          //   BoxShadow(
                                                                          //       color: Colors.black
                                                                          //           .withOpacity(0.03.w),
                                                                          //       blurRadius: 5,
                                                                          //       spreadRadius: 0,
                                                                          //       offset: Offset(0, 3)),
                                                                          // ],
                                                                          ),
                                                                      child:
                                                                          Card(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.w)),
                                                                        elevation:
                                                                            0,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.w),
                                                                          ),
                                                                          width:
                                                                              145.w,
                                                                          padding: EdgeInsets.only(
                                                                              left: 19.w,
                                                                              top: 14.w,
                                                                              right: 12.w,
                                                                              bottom: 12.w),
                                                                          // width:
                                                                          //     130.w,
                                                                          // padding: EdgeInsets.only(
                                                                          //     left: 10.w,
                                                                          //     top: 10.w,
                                                                          //     right: 10.w,
                                                                          //     bottom: 10.w),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  element.discountPercentage != ""
                                                                                      ? Container(
                                                                                          width: 60.w,
                                                                                          height: 20.h,
                                                                                          decoration: BoxDecoration(color: lightgreen, borderRadius: BorderRadius.all(Radius.circular(5.w))),
                                                                                          child: Center(
                                                                                            child: Text("${element.discountPercentage} off",
                                                                                                // textAlign: TextAlign.center,
                                                                                                style: GoogleFonts.dmSans(
                                                                                                  textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                                                                )),
                                                                                          ),
                                                                                        )
                                                                                      : SizedBox(
                                                                                          width: 60.w,
                                                                                          height: 20.h,
                                                                                        ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.h,
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  element.productImagePath == ""
                                                                                      ? SizedBox(
                                                                                          height: 55.w,
                                                                                          width: 55.w,
                                                                                          child: Image.asset(
                                                                                            "assets/images/image_not_found.png",
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        )
                                                                                      : SizedBox(
                                                                                          height: 60.w,
                                                                                          width: 60.w,
                                                                                          child: Image.network(
                                                                                            "${element.productImagePath}",
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 3.w,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      "${element.productName}",
                                                                                      maxLines: 1,
                                                                                      style: GoogleFonts.roboto(
                                                                                        textStyle: TextStyle(
                                                                                          color: Black1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          // letterSpacing: .5,
                                                                                          fontSize: 16.sp,

                                                                                          fontWeight: FontWeight.w600,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 2.w,
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    "${element.weight} ${element.unit}",
                                                                                    style: GoogleFonts.roboto(
                                                                                      textStyle: TextStyle(
                                                                                          color: Black1,
                                                                                          // letterSpacing: .5,
                                                                                          fontSize: 12.sp,
                                                                                          fontWeight: FontWeight.w600),
                                                                                    ),
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      element.mrpPrice != "" ? Text('\u{20B9}${element.mrpPrice}', style: GoogleFonts.dmSans(textStyle: element.offerPrice != "" && element.offerPrice != element.mrpPrice ? TextStyle(decoration: TextDecoration.lineThrough, color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400) : TextStyle(color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400))) : const Text(""),
                                                                                      SizedBox(
                                                                                        width: 5.w,
                                                                                      ),
                                                                                      element.offerPrice != "" && element.offerPrice != element.mrpPrice
                                                                                          ? Text(
                                                                                              '\u{20B9}${element.offerPrice}',
                                                                                              style: GoogleFonts.dmSans(
                                                                                                textStyle: TextStyle(
                                                                                                    // decoration:
                                                                                                    // TextDecoration.lineThrough,
                                                                                                    color: Black,
                                                                                                    letterSpacing: .5,
                                                                                                    fontSize: 13.sp,
                                                                                                    fontWeight: FontWeight.w500),
                                                                                              ),
                                                                                            )
                                                                                          : const Text(""),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 2.w,
                                                                              ),
                                                                              Container(
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    // GestureDetector(
                                                                                    //   onTap: () {
                                                                                    //     read.addToCart(
                                                                                    //         element.productType,
                                                                                    //         element.productUnitId,
                                                                                    //         element.shopId,
                                                                                    //         context);
                                                                                    //     watch
                                                                                    //         .onOfferProductSelected(
                                                                                    //             index);
                                                                                    //   },
                                                                                    // child: watch.isAllOfferProductAdded[
                                                                                    //             index] ==
                                                                                    //         false
                                                                                    //       ? SvgPicture.asset(
                                                                                    //           'assets/images/add.svg',
                                                                                    //           // width: 15.w,
                                                                                    //           // height: 19.h,
                                                                                    //         )
                                                                                    //       : SvgPicture.asset(
                                                                                    //           "assets/icons/tick_green_bg.svg"),
                                                                                    // ),
                                                                                    SizedBox(
                                                                                      height: 50.w,
                                                                                    ),
                                                                                    watch.quantityAdminList[index] == 0
                                                                                        ? GestureDetector(
                                                                                            onTap: () {
                                                                                              read.addToCart(element.productType, element.productUnitId, element.shopId, index, context);
                                                                                            },
                                                                                            child: SvgPicture.asset(
                                                                                              'assets/images/add.svg',
                                                                                            ))
                                                                                        : Row(
                                                                                            children: [
                                                                                              GestureDetector(
                                                                                                onTap: () {
                                                                                                  if (watch.isQuanityBtnPressed) {
                                                                                                    return;
                                                                                                  }
                                                                                                  read.subtractAdminItemQuantity(context, element.cartItemId.toString(), index, element.productType, element.productUnitId);
                                                                                                },
                                                                                                child: SvgPicture.asset(
                                                                                                  'assets/icons/minus.svg',
                                                                                                  // width: 30.w,
                                                                                                  // height: 30.h,
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 12.w,
                                                                                              ),
                                                                                              Text(
                                                                                                "${watch.quantityAdminList[index]}",
                                                                                                style: GoogleFonts.dmSans(
                                                                                                  textStyle: TextStyle(
                                                                                                      // decoration:
                                                                                                      // TextDecoration.lineThrough,
                                                                                                      color: Black,
                                                                                                      // letterSpacing:
                                                                                                      //     .5,
                                                                                                      fontSize: 16.sp,
                                                                                                      fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 12.w,
                                                                                              ),
                                                                                              GestureDetector(
                                                                                                onTap: () {
                                                                                                  print(watch.isQuanityBtnPressed);
                                                                                                  // return;
                                                                                                  if (watch.isQuanityBtnPressed) {
                                                                                                    return;
                                                                                                  }
                                                                                                  print(element.productType);
                                                                                                  read.addAdminItemQuantity(context, element.cartItemId.toString(), element.productType, index);
                                                                                                },
                                                                                                child: SvgPicture.asset(
                                                                                                  'assets/images/add.svg',
                                                                                                  // width: 30.w,
                                                                                                  // height: 30.h,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              // element.addToCartCheck == "no"
                                                                              //     ? GestureDetector(
                                                                              //         onTap: () {
                                                                              //           read.addToCart(element.productType, element.productUnitId, element.shopId, context);
                                                                              //           // watch
                                                                              //           //     .onOfferSelected(
                                                                              //           //         index);
                                                                              //         },
                                                                              //         child: SvgPicture.asset(
                                                                              //           'assets/images/add.svg',
                                                                              //           // width: 15.w,
                                                                              //           // height: 19.h,
                                                                              //         ))
                                                                              //     : GestureDetector(
                                                                              //         onTap: () {
                                                                              //           read.removeFromCart(element.productType, element.productUnitId, element.shopId, context);
                                                                              //         },
                                                                              //         child: SvgPicture.asset("assets/icons/tick_green_bg.svg"),
                                                                              //       ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                          ],
                                                        )
                                                      : Container();
                                                }),
                                              ),
                                              ///////////////////////////Custome////////////////////////////
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    watch.fullFillYourCravingsCustom
                                                            .length ??
                                                        0, (index) {
                                                  final element = watch
                                                          .fullFillYourCravingsCustom[
                                                      index];
                                                  return watch
                                                                  .fullFillYourCravingsCustom[
                                                                      index]
                                                                  .mrpPrice !=
                                                              "" &&
                                                          int.parse(element
                                                                          .offerPrice ==
                                                                      ""
                                                                  ? "0"
                                                                  : element
                                                                          .offerPrice ??
                                                                      "0") <
                                                              int.parse(element
                                                                      .mrpPrice ??
                                                                  "0")
                                                      ? Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 2.w),
                                                            element.weight ==
                                                                        "" &&
                                                                    element.offerPrice ==
                                                                        "" &&
                                                                    element.mrpPrice ==
                                                                        "" &&
                                                                    element.unit ==
                                                                        "" &&
                                                                    element.productUnitId ==
                                                                        null
                                                                ? Container()
                                                                : GestureDetector(
                                                                    onTap: () {
                                                                      readProductViewController.updateProductId(
                                                                          element
                                                                              .id
                                                                              .toString(),
                                                                          context,
                                                                          false);
                                                                      readMain.onNavigation(
                                                                          1,
                                                                          ProductScreenView(
                                                                              routeName: "",
                                                                              selectedUnitId: element.productUnitId.toString(),
                                                                              categoryId: element.categoryId.toString(),
                                                                              // categoryId: watch.categoryId,
                                                                              productId: element.id.toString(),
                                                                              shopId: element.shopId,
                                                                              productType: element.productType),
                                                                          context);
                                                                      readMain
                                                                          .showBottomNavigationBar();
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          const BoxDecoration(),
                                                                      child:
                                                                          Card(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10.w)),
                                                                        elevation:
                                                                            0,
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.w),
                                                                          ),
                                                                          width:
                                                                              145.w,
                                                                          padding: EdgeInsets.only(
                                                                              left: 19.w,
                                                                              top: 14.w,
                                                                              right: 12.w,
                                                                              bottom: 12.w),
                                                                          // width:
                                                                          //     156.w,
                                                                          // padding: EdgeInsets.only(
                                                                          //     left: 19.w,
                                                                          //     top: 14.w,
                                                                          //     right: 12.w,
                                                                          //     bottom: 12.w),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [
                                                                                  element.discountPercentage != ""
                                                                                      ? Container(
                                                                                          width: 60.w,
                                                                                          height: 20.h,
                                                                                          decoration: BoxDecoration(color: lightgreen, borderRadius: BorderRadius.all(Radius.circular(5.w))),
                                                                                          child: Center(
                                                                                            child: Text("${element.discountPercentage} off",
                                                                                                // textAlign: TextAlign.center,
                                                                                                style: GoogleFonts.dmSans(
                                                                                                  textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                                                                )),
                                                                                          ),
                                                                                        )
                                                                                      : SizedBox(
                                                                                          width: 60.w,
                                                                                          height: 20.h,
                                                                                        ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.h,
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  element.productImagePath == ""
                                                                                      ? SizedBox(
                                                                                          height: 55.w,
                                                                                          width: 55.w,
                                                                                          child: Image.asset(
                                                                                            "assets/images/image_not_found.png",
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        )
                                                                                      : SizedBox(
                                                                                          height: 60.w,
                                                                                          width: 60.w,
                                                                                          child: Image.network(
                                                                                            "${element.productImagePath}",
                                                                                            fit: BoxFit.cover,
                                                                                          ),
                                                                                        ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 3.w,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      "${element.productName}",
                                                                                      maxLines: 1,
                                                                                      style: GoogleFonts.roboto(
                                                                                        textStyle: TextStyle(
                                                                                          color: Black1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          // letterSpacing: .5,
                                                                                          fontSize: 16.sp,

                                                                                          fontWeight: FontWeight.w600,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 2.w,
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    "${element.weight} ${element.unit}",
                                                                                    style: GoogleFonts.roboto(
                                                                                      textStyle: TextStyle(
                                                                                          color: Black1,
                                                                                          // letterSpacing: .5,
                                                                                          fontSize: 12.sp,
                                                                                          fontWeight: FontWeight.w600),
                                                                                    ),
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      element.mrpPrice != "" ? Text('\u{20B9}${element.mrpPrice}', style: GoogleFonts.dmSans(textStyle: element.offerPrice != "" && element.offerPrice != element.mrpPrice ? TextStyle(decoration: TextDecoration.lineThrough, color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400) : TextStyle(color: Black1, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w400))) : const Text(""),
                                                                                      SizedBox(
                                                                                        width: 5.w,
                                                                                      ),
                                                                                      element.offerPrice != "" && element.offerPrice != element.mrpPrice
                                                                                          ? Text(
                                                                                              '\u{20B9}${element.offerPrice}',
                                                                                              style: GoogleFonts.dmSans(
                                                                                                textStyle: TextStyle(
                                                                                                    // decoration:
                                                                                                    // TextDecoration.lineThrough,
                                                                                                    color: Black,
                                                                                                    letterSpacing: .5,
                                                                                                    fontSize: 13.sp,
                                                                                                    fontWeight: FontWeight.w500),
                                                                                              ),
                                                                                            )
                                                                                          : const Text(""),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 2.w,
                                                                              ),
                                                                              Container(
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    // GestureDetector(
                                                                                    //   onTap: () {
                                                                                    //     read.addToCart(
                                                                                    //         element.productType,
                                                                                    //         element.productUnitId,
                                                                                    //         element.shopId,
                                                                                    //         context);
                                                                                    //     watch
                                                                                    //         .onOfferProductSelected(
                                                                                    //             index);
                                                                                    //   },
                                                                                    // child: watch.isAllOfferProductAdded[
                                                                                    //             index] ==
                                                                                    //         false
                                                                                    //       ? SvgPicture.asset(
                                                                                    //           'assets/images/add.svg',
                                                                                    //           // width: 15.w,
                                                                                    //           // height: 19.h,
                                                                                    //         )
                                                                                    //       : SvgPicture.asset(
                                                                                    //           "assets/icons/tick_green_bg.svg"),
                                                                                    // ),
                                                                                    SizedBox(
                                                                                      height: 50.w,
                                                                                    ),
                                                                                    watch.quantityCustomeList[index] == 0
                                                                                        ? GestureDetector(
                                                                                            onTap: () {
                                                                                              read.addToCart(element.productType, element.productUnitId, element.shopId, index, context);
                                                                                            },
                                                                                            child: SvgPicture.asset(
                                                                                              'assets/images/add.svg',
                                                                                            ))
                                                                                        : Row(
                                                                                            children: [
                                                                                              GestureDetector(
                                                                                                onTap: () {
                                                                                                  if (watch.isQuanityBtnPressed) {
                                                                                                    return;
                                                                                                  }
                                                                                                  read.subtractCustomeItemQuantity(context, element.cartItemId.toString(), index, element.productType, element.productUnitId);
                                                                                                },
                                                                                                child: SvgPicture.asset(
                                                                                                  'assets/icons/minus.svg',
                                                                                                  // width: 30.w,
                                                                                                  // height: 30.h,
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 12.w,
                                                                                              ),
                                                                                              Text(
                                                                                                "${watch.quantityCustomeList[index]}",
                                                                                                style: GoogleFonts.dmSans(
                                                                                                  textStyle: TextStyle(
                                                                                                      // decoration:
                                                                                                      // TextDecoration.lineThrough,
                                                                                                      color: Black,
                                                                                                      // letterSpacing:
                                                                                                      //     .5,
                                                                                                      fontSize: 16.sp,
                                                                                                      fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 12.w,
                                                                                              ),
                                                                                              GestureDetector(
                                                                                                onTap: () {
                                                                                                  print(watch.isQuanityBtnPressed);
                                                                                                  // return;
                                                                                                  if (watch.isQuanityBtnPressed) {
                                                                                                    return;
                                                                                                  }
                                                                                                  print(element.productType);
                                                                                                  read.addCustomeItemQuantity(context, element.cartItemId.toString(), element.productType, index);
                                                                                                },
                                                                                                child: SvgPicture.asset(
                                                                                                  'assets/images/add.svg',
                                                                                                  // width: 30.w,
                                                                                                  // height: 30.h,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              // element.addToCartCheck == "no"
                                                                              //     ? GestureDetector(
                                                                              //         onTap: () {
                                                                              //           read.addToCart(element.productType, element.productUnitId, element.shopId, context);
                                                                              //           // watch
                                                                              //           //     .onOfferSelected(
                                                                              //           //         index);
                                                                              //         },
                                                                              //         child: SvgPicture.asset(
                                                                              //           'assets/images/add.svg',
                                                                              //           // width: 15.w,
                                                                              //           // height: 19.h,
                                                                              //         ))
                                                                              //     : GestureDetector(
                                                                              //         onTap: () {
                                                                              //           read.removeFromCart(element.productType, element.productUnitId, element.shopId, context);
                                                                              //         },
                                                                              //         child: SvgPicture.asset("assets/icons/tick_green_bg.svg"),
                                                                              //       ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                          ],
                                                        )
                                                      : Container();
                                                }),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            right: 15.w,
                                            bottom: 0.w,
                                            top: 0,
                                            child: Center(
                                              child: Visibility(
                                                visible:
                                                    watch.showPaginationLoader,
                                                child: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Center(
                                                    child: SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: SplashText,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product Details",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    // letterSpacing: .5,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Divider(
                              // height: 100,
                              color: grey2,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            const OrderProducts(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Text(
                                  "\u{20B9} ${watch.subTotal}",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: grey5,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Divider(
                              // height: 100,
                              color: grey2,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Discount',
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            // letterSpacing: .5,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    watch.couponCodeController.text != ""
                                        ? TextSpan(
                                            text:
                                                ' (${watch.couponCodeController.text}) ',
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: SplashText,
                                                  // letterSpacing: .5,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )
                                        : const TextSpan(text: ""),
                                  ]),
                                ),
                                Text(
                                  "- \u{20B9}  ${watch.couponDiscount}",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: grey5,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700),
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
                                Text(
                                  "Delivery Charges",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                watch.deliveryCharges == ""
                                    ? Text(
                                        "\u{20B9} 0",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: grey5,
                                              // letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    : Text(
                                        "\u{20B9} ${watch.groupValue == "self_pickup" ? watch.selfPickupDeliveryCharges : watch.deliveryCharges}",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: grey5,
                                              // letterSpacing: .5,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Divider(
                              // height: 100,
                              color: grey2,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Text(
                                  "\u{20B9} ${watch.groupValue == "self_pickup" ? watch.selfPickupTotalAmount : watch.totalAmount}",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            Divider(
                              // height: 100,
                              color: grey2,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            watch.totalDiscount == "0"
                                ? Container()
                                : Container(
                                    child: Text(
                                      "You will save \u{20B9} ${watch.totalDiscount}",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: SplashText,
                                            // letterSpacing: .5,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      SizedBox(
                        height: 51.h,
                        // width: 390.w,

                        child: PrimaryButton(
                          width: ScreenUtil().screenWidth,
                          color: SplashText,
                          onTap: () {
                            print('payment');
                            read.onConfirmOrder(context);
                            //
                          },

                          child: Text(
                            "Confirm",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: .5,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                          //
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

// ID
// rzp_test_eujqGBDGqouRnn
// KEY
// I51S83abxZQYDBry78LdLg2n
