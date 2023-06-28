import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/delivery_view/controller/customer_order_view_controller.dart';
import 'package:local_supper_market/screen/customer/delivery_view/view/order_product_list_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/order_payment/view/check_status_and_home_view.dart';
import 'package:local_supper_market/screen/customer/order_status/view/order_status_view.dart';
import 'package:local_supper_market/screen/customer/order_summary/order_products.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

class OrderDeliveryView extends StatefulWidget {
  final String? orderId;
  const OrderDeliveryView({
    super.key,
    this.orderId,
  });

  @override
  State<OrderDeliveryView> createState() => _OrderDeliveryViewState();
}

class _OrderDeliveryViewState extends State<OrderDeliveryView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerOrderViewController>().initState(
            context,
            widget.orderId.toString(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CustomerOrderViewController>();
    final read = context.read<CustomerOrderViewController>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            onBackBtnPressed: () {
              Navigator.pop(context);
            },
            title: "Order",
          ),
        ),
        body:watch.isLoading?Center(
          child: CircularProgressIndicator(),
        ):
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.w,
                ),
                Text("${watch.shopDetails?.shopName}",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Black1),
                    )),
                SizedBox(
                  height: 10.w,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/images/location2.svg',
                              width: 28.w,
                              height: 28.w,
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            Flexible(
                              child: Text(
                                // "",
                                "${watch.shopDetails?.shopAddress}\n${watch.shopDetails?.cityName} - ${watch.shopDetails?.shopPincode}",
                                // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      letterSpacing: .5,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              read.launchPhone(
                                  watch.shopDetails?.shopOwnerSupportNumber ??
                                      "",
                                  context);
                            },
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 13.w,
                                    right: 13.w,
                                    top: 14.w,
                                    bottom: 14.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff23AA49),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/new_call.svg",
                                  width: 26.w,
                                  height: 14.h,
                                )),
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          InkWell(
                            onTap: () {
                              watch.favAllShop
                                  ? read.removeAllShopFavList(
                                      context, watch.shopDetails?.id)
                                  : read.updateAllShopFavList(
                                      context, watch.shopDetails?.id);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 13.w,
                                  right: 13.w,
                                  top: 14.w,
                                  bottom: 14.w),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff4689EC),
                              ),
                              child:
                                  // watch.favAllShop
                                  //     ?
                                  //     SvgPicture.asset(
                                  //         "assets/icons/fav_selected.svg",
                                  //         width: 26.w,
                                  //         height: 14.h,
                                  //       )
                                  //     :
                                  SvgPicture.asset(
                                "assets/images/favorite.svg",
                                width: 26.w,
                                height: 14.h,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          Divider(thickness: 1, color: grey2),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 19.w, right: 17.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID: ${watch.orderDetails?.orderUniqueId}",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black,
                        letterSpacing: .5,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      // backgroundColor: ,
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: watch.orderDetails?.orderStatus == "Pending"
                                ? Yellow
                                : watch.orderDetails?.orderStatus == "Delivered"
                                    ? Color(0xff39C19D)
                                    : watch.orderDetails?.orderStatus ==
                                            "Confirmed"
                                        ? Color(0xff115B7A)
                                        : watch.orderDetails?.orderStatus ==
                                                "Cancelled"
                                            ? Colors.red
                                            : watch.orderDetails?.orderStatus ==
                                                    "Dispatched"
                                                ? Colors.orange
                                                : watch.orderDetails
                                                            ?.orderStatus ==
                                                        "Packing"
                                                    ? Colors.brown
                                                    : Colors.transparent,
                            // width: 1,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => OrderPendingView(
                      //           orderId: element?.id.toString())),
                      // );
                    },
                    child: Text(
                      watch.orderDetails?.orderStatus ?? "",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: watch.orderDetails?.orderStatus == "Pending"
                                ? Yellow
                                ///////
                                : watch.orderDetails?.orderStatus == "Delivered"
                                    ? Color(0xff39C19D)
                                    ///////
                                    : watch.orderDetails?.orderStatus ==
                                            "Confirmed"
                                        ? Color(0xff115B7A)
                                        /////////
                                        : watch.orderDetails?.orderStatus ==
                                                "Cancelled"
                                            ? Colors.red
                                            //////////////
                                            : watch.orderDetails?.orderStatus ==
                                                    "Dispatched"
                                                ? Colors.orange
                                                : watch.orderDetails
                                                            ?.orderStatus ==
                                                        "Packing"
                                                    ? Colors.brown
                                                    : Colors.transparent,
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
          ),

          Container(
            padding: EdgeInsets.only(
              left: 19.w,
            ),
            child: Text(
              "${watch.orderDetails?.createdAt}",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black,
                    // letterSpacing: .5,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          /////////////////////////////////////////////
          watch.orderDetails?.orderStatus == "Dispatched" ||
                  watch.orderDetails?.orderStatus == "Delivered"
              ? Container(
                  margin: EdgeInsets.only(
                      left: 20.w, right: 19.w, top: 17.w, bottom: 19.w),
                  padding: EdgeInsets.only(
                      left: 13.w, right: 16.w, top: 14.w, bottom: 15.w),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff39C19D),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Code",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              // letterSpacing: .5,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        "${watch.orderDetails?.deliveryCode}",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Color(0xff39C19D),
                              // letterSpacing: .5,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 20.h,
                ),

          Container(
            padding: EdgeInsets.only(
              left: 20.w,
            ),
            child: Text(
              "Delivery Address",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black,
                    // letterSpacing: .5,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: EdgeInsets.only(left: 19.w, right: 19.w),
            // height: 156.h,
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                // side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: EdgeInsets.only(
                    bottom: 20.w, left: 20.w, right: 15.w, top: 20.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              // "",
                              "${watch.deliveryAddressDetails?.customerName}",
                              // 'Rachel Green',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    letterSpacing: .5,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            // SizedBox(
                            //   width: 11.w,
                            // ),
                          ],
                        ),
                        SizedBox(
                          // height: 21.h,/
                          // width: 71.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              // backgroundColor: ,
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: lighrgreen,
                                    // width: 1,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "${watch.deliveryAddressDetails?.deliveryAddressType}",
                              // "${element.deliveryAddressType}",
                              // "Home",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: SplashText1,
                                    // letterSpacing: .5,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),

                            //
                          ),
                        ),
                      ],
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
                          "${watch.deliveryAddressDetails?.mobileNo}",
                          // '${element.mobileNo}',
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Black,
                                letterSpacing: .5,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            "${watch.deliveryAddressDetails?.address1}",
                            maxLines: 3,
                            // "${element.address1} \n${element.address2} ",
                            // "Nand Nivas Building floor 3 B-3,Lane No.13 Bhatrau Nivas Vishrantwadi Pune -411015.",
                            // textAlign: TextAlign.start,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  // height: 1.5,
                                  color: black,
                                  // letterSpacing: .05,
                                  // overflow: TextOverflow.ellipsis,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          watch.orderDetails?.orderStatus == "Dispatched" ||
                  watch.orderDetails?.orderStatus == "Delivered"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 19.w,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 12.w, right: 12.w, top: 9.w, bottom: 9.w),
                          decoration: BoxDecoration(
                              color: SplashText,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Reorder",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: .5,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 12.w, right: 12.w, top: 9.w, bottom: 9.w),
                        // height: 50.h,/
                        decoration: BoxDecoration(
                            color: Color(0xff115B7A),
                            // border: Border.all(width: 1, color: Black),
                            borderRadius: BorderRadius.circular(10)),

                        child: Text(
                          "Invoice",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                // letterSpacing: .5,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                )
              : Container(
                  height: 20.h,
                ),
          watch.orderDetails?.orderStatus == "Dispatched" ||
                  watch.orderDetails?.orderStatus == "Delivered"
              ? SizedBox(
                  height: 20.h,
                )
              : Container(),
          Container(
            padding: EdgeInsets.only(
              left: 19.w,
            ),
            child: Text(
              // maxLines: 3,
              "Expected Delivery Date & Slot",
              // textAlign: TextAlign.start,
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    // height: 1.5,
                    color: black,
                    // letterSpacing: .05,
                    // overflow: TextOverflow.ellipsis,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 19.w),
            child: Text(
              // maxLines: 3,
              "${watch.orderDetails?.deliveryDate}",
              // textAlign: TextAlign.start,
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    // height: 1.5,
                    color: SplashText,
                    // letterSpacing: .05,
                    // overflow: TextOverflow.ellipsis,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 19.w, right: 19.w),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  watch.orderDetails?.deliverySlot == "shop_owner_slot_9_to_12"
                      ? "9:00 AM - 12:00 PM"
                      : watch.orderDetails?.deliverySlot ==
                              "shop_owner_slot_12_to_3"
                          ? "12:00 PM - 3:00 PM"
                          : watch.orderDetails?.deliverySlot ==
                                  "shop_owner_slot_3_to_6"
                              ? "3:00 PM - 6:00 PM"
                              : watch.orderDetails?.deliverySlot ==
                                      "shop_owner_slot_6_to_9"
                                  ? "6:00 PM - 9:00 PM"
                                  : "",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  // height: 30.h,
                  width: 100.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      // backgroundColor: ,
                      backgroundColor: MaterialStateProperty.all(
                          SplashText.withOpacity(0.3)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: SplashText,
                            // width: 1,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>OrderStatusView(orderId: watch.orderId,)));

                    },
                    child: Text(
                      "Track Order",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            // letterSpacing: .5,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    //
                  ),
                ),
              ],
            ),
          ),
          //////////////
          Container(
            padding: EdgeInsets.only(left: 19.w, top: 10.w, right: 19.w),
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
                OrderProductsListView(),
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
                      "Rs ${watch.orderDetails?.subTotalAmount}",
                      //  ${watch.orderFinalTotals?.subTotal}",
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
                          text: 'Discount!!',
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        watch.couponDetails?.couponCode != "" &&
                                watch.couponDetails?.couponCode != null
                            ? TextSpan(
                                text: '  (${watch.couponDetails?.couponCode}) ',
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: SplashText,
                                      // letterSpacing: .5,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            : TextSpan(
                                text: "",
                              ),
                      ]),
                    ),
                    watch.orderDetails?.totalDiscount != ""
                        ? Text(
                            "Rs ${watch.orderDetails?.totalDiscount}",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: grey5,
                                  // letterSpacing: .5,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        : Text(
                            "Rs 0",
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
                    Text(
                      watch.orderDetails?.deliveryCharges == ""
                          ? "Rs. 0"
                          : "Rs.  ${watch.orderDetails?.deliveryCharges}",
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
                      "Rs. ${watch.orderDetails?.totalAmount} ",
                      // ${watch.orderFinalTotals?.total}",
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
                Container(
                  child: Text(
                    "You will save Rs. ${watch.orderDetails?.totalDiscount}",
                    //  ",
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
          //////////////////
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 19.w,
            ),
            child: Text(
              "Mode of Payment",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: Black,
                    // letterSpacing: .5,
                    fontSize: 20.sp,
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
            child: Text(
              "${watch.orderDetails?.paymentMode}",
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                    color: SplashText,
                    // letterSpacing: .5,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),

          watch.orderDetails?.transactionId != ""
              ? SizedBox(
                  height: 15.h,
                )
              : Container(),
          watch.orderDetails?.transactionId != ""
              ? Container(
                  padding: EdgeInsets.only(
                    left: 19.w,
                  ),
                  child: Text(
                    "Transaction ID : ${watch.orderDetails?.transactionId}",
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          // letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: 26.h,
          ),
          // Container(
          //   padding: EdgeInsets.only(
          //       left: 19.w, right: 19.w, top: 15.w, bottom: 15.w),
          //   // height: 111.h,
          //   width: ScreenUtil().screenWidth,
          //   color: lightblue,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     // mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             "Refund Amount",
          //             style: GoogleFonts.dmSans(
          //               textStyle: TextStyle(
          //                   color: Black,
          //                   // letterSpacing: .5,
          //                   fontSize: 18.sp,
          //                   fontWeight: FontWeight.w700),
          //             ),
          //           ),
          //           SizedBox(
          //             height: 22.h,
          //             // width: 126.w,
          //             child: ElevatedButton(
          //               style: ButtonStyle(
          //                 elevation: MaterialStateProperty.all(0),
          //                 // backgroundColor: ,
          //                 backgroundColor:
          //                     MaterialStateProperty.all(Colors.white),
          //                 shape: MaterialStateProperty.all(
          //                   RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                     side: BorderSide(
          //                       color: SplashText1,
          //                       // width: 1,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               onPressed: () {},
          //               child: Text(
          //                 "Payment Pending",
          //                 style: GoogleFonts.dmSans(
          //                   textStyle: TextStyle(
          //                       color: SplashText1,
          //                       // letterSpacing: .5,
          //                       fontSize: 12.sp,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ),

          //               //
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 13.w),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Text(
          //             "INR 3000",
          //             style: GoogleFonts.dmSans(
          //               textStyle: TextStyle(
          //                   color: Black,
          //                   // letterSpacing: .5,
          //                   fontSize: 18.sp,
          //                   fontWeight: FontWeight.w700),
          //             ),
          //           ),
          //           Text(
          //             "28 March 2023   11:34 am",
          //             style: GoogleFonts.dmSans(
          //               textStyle: TextStyle(
          //                   color: Black,
          //                   // letterSpacing: .5,
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.w400),
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 8.h,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           Text(
          //             "Transaction ID : 647393025546",
          //             style: GoogleFonts.dmSans(
          //               textStyle: TextStyle(
          //                   color: Black,
          //                   // letterSpacing: .5,
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.w400),
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // )
          // Container(
          //   padding: EdgeInsets.only(
          //       left: 19.w, right: 19.w, top: 25.w, bottom: 15.w),
          //   // height: 250.h,
          //   // width: 390.w,
          //   width: ScreenUtil().screenWidth,
          //   color: lightblue,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     // mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Text(
          //         "Refund Amount",
          //         style: GoogleFonts.dmSans(
          //           textStyle: TextStyle(
          //               color: Black,
          //               // letterSpacing: .5,
          //               fontSize: 18.sp,
          //               fontWeight: FontWeight.w700),
          //         ),
          //       ),
          //       // SizedBox(width: 10.w),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Text(
          //             "INR 3000",
          //             style: GoogleFonts.dmSans(
          //               textStyle: TextStyle(
          //                   color: Black,
          //                   // letterSpacing: .5,
          //                   fontSize: 18.sp,
          //                   fontWeight: FontWeight.w700),
          //             ),
          //           ),
          //           SizedBox(
          //             height: 22.h,
          //             // width: 126.w,
          //             child: ElevatedButton(
          //               style: ButtonStyle(
          //                 elevation: MaterialStateProperty.all(0),
          //                 // backgroundColor: ,
          //                 backgroundColor:
          //                     MaterialStateProperty.all(Colors.white),
          //                 shape: MaterialStateProperty.all(
          //                   RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                     side: BorderSide(
          //                       color: SplashText1,
          //                       // width: 1,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               onPressed: () {},
          //               child: Text(
          //                 "Payment Pending",
          //                 style: GoogleFonts.dmSans(
          //                   textStyle: TextStyle(
          //                       color: SplashText1,
          //                       // letterSpacing: .5,
          //                       fontSize: 12.sp,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ),

          //               //
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 20.h,
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           SizedBox(
          //             // height: 35.h,
          //             width: 155.w,
          //             child: ElevatedButton(
          //               style: ButtonStyle(
          //                 elevation: MaterialStateProperty.all(0),
          //                 // backgroundColor: ,
          //                 backgroundColor:
          //                     MaterialStateProperty.all(SplashText),
          //                 shape: MaterialStateProperty.all(
          //                   RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                     // side: BorderSide(
          //                     //   color: SplashText,
          //                     //   // width: 1,
          //                     // ),
          //                   ),
          //                 ),
          //               ),
          //               onPressed: () {},
          //               child: Text(
          //                 "Yes Received",
          //                 style: GoogleFonts.dmSans(
          //                   textStyle: TextStyle(
          //                       color: Colors.white,
          //                       // letterSpacing: .5,
          //                       fontSize: 16.sp,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ),

          //               //
          //             ),
          //           ),
          //           // SizedBox(
          //           //   width: 25.w,
          //           // ),
          //           SizedBox(
          //             // height: 35.h,
          //             width: 155.w,
          //             child: ElevatedButton(
          //               style: ButtonStyle(
          //                 elevation: MaterialStateProperty.all(0),
          //                 // backgroundColor: ,
          //                 backgroundColor: MaterialStateProperty.all(Red),
          //                 shape: MaterialStateProperty.all(
          //                   RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                     // side: BorderSide(
          //                     //   color: SplashText,
          //                     //   // width: 1,
          //                     // ),
          //                   ),
          //                 ),
          //               ),
          //               onPressed: () {},
          //               child: Text(
          //                 "Not Received",
          //                 style: GoogleFonts.dmSans(
          //                   textStyle: TextStyle(
          //                       color: Colors.white,
          //                       // letterSpacing: .5,
          //                       fontSize: 16.sp,
          //                       fontWeight: FontWeight.w500),
          //                 ),
          //               ),

          //               //
          //             ),
          //           ),
          //         ],
          //       ),
          //       SizedBox(
          //         height: 10.h,
          //       ),
          //       Text(
          //         "Note",
          //         style: GoogleFonts.dmSans(
          //           textStyle: const TextStyle(
          //               // color: SplashTex
          //               letterSpacing: .5,
          //               fontSize: 16,
          //               fontWeight: FontWeight.w500),
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.only(left: 5.w),
          //         child: Row(
          //           // crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Padding(
          //                 padding: EdgeInsets.only(bottom: 20.w),
          //                 child: Icon(
          //                   Icons.circle_rounded,
          //                   size: 5.w,
          //                 )),
          //             SizedBox(width: 10.w),
          //             Flexible(
          //               child: Text(
          //                 // softWrap: true,
          //                 // maxLines: 3,//
          //                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sit nunc, netus ac vulputate sed",
          //                 textAlign: TextAlign.justify,
          //                 style: GoogleFonts.dmSans(
          //                   textStyle: TextStyle(
          //                       color: black,
          //                       // height: 1.5,

          //                       // letterSpacing: .05,
          //                       // overflow: TextOverflow.ellipsis,
          //                       fontSize: 14.sp,
          //                       fontWeight: FontWeight.w400),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       // Row(
          //       //   children: [
          //       //     Icon(
          //       //       Icons.circle_rounded,
          //       //       size: 5.w,
          //       //     ),
          //       //     SizedBox(
          //       //       width: 10,
          //       //     ),
          //       //     Text(
          //       //       "Lorem ipsum dolor sit amet, consectetur",
          //       //       style: GoogleFonts.dmSans(
          //       //         textStyle: TextStyle(
          //       //             height: 1.5,
          //       //             color: black,
          //       //             letterSpacing: .5,
          //       //             fontSize: 14.sp,
          //       //             fontWeight: FontWeight.w400),
          //       //       ),
          //       //     )
          //       //   ],
          //       // ),
          //       // Row(
          //       //   children: [
          //       //     Padding(
          //       //         padding: EdgeInsets.only(bottom: 0.w),
          //       //         child: Icon(
          //       //           Icons.circle_rounded,
          //       //           size: 5.w,
          //       //         )),
          //       //     SizedBox(
          //       //       width: 10,
          //       //     ),
          //       //     Text(
          //       //       "Lorem ipsum dolor sit amet, consectetur",
          //       //       style: GoogleFonts.dmSans(
          //       //         textStyle: TextStyle(
          //       //             height: 1.5,
          //       //             color: black,
          //       //             letterSpacing: .5,
          //       //             fontSize: 14.sp,
          //       //             fontWeight: FontWeight.w400),
          //       //       ),
          //       //     )
          //       //   ],
          //       // ),
          //     ],
          //   ),
          // )
        ])));
  }
}
