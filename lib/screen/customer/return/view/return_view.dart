import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/products/controller/product_view_controller.dart';
import 'package:local_supper_market/screen/customer/return/controller/return_view_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class CustomerProductReturnView extends StatefulWidget {
  final String? orderId;
  const CustomerProductReturnView({super.key, required this.orderId});

  @override
  State<CustomerProductReturnView> createState() =>
      _CustomerProductReturnViewState();
}

class _CustomerProductReturnViewState extends State<CustomerProductReturnView> {
  @override
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ReturnOrderController>().initState(context, widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ReturnOrderController>();
    final read = context.read<ReturnOrderController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            Navigator.pop(context);
          },
          title: "Product Return Request",
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(
                    left: 19.w, bottom: 17.w, top: 20.w, right: 19.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order ID: ${watch.orderDetails?.orderUniqueId}",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Black1),
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("${watch.orderDetails?.shopName}",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Black1),
                        )),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Order Amount - ",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Black1),
                                )),
                            Text("INR ${watch.orderDetails?.totalAmount}",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Black1),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Total Products ",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Black1),
                                )),
                            Text(" ${watch.orderDetails?.totalItems}",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Black1),
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xffEFEFEF),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: watch.returnproductlistdata
                              ?.orderProductDetails?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final element = watch
                            .returnproductlistdata?.orderProductDetails?[index];
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      PrimaryCheckBox(
                                        value:
                                            watch.isReturnProductSelected[index],
                                        onChanged: (value) {
                                          read.onSelectingProduct(
                                              index,
                                              value,
                                              element?.id.toString(),
                                              element?.productOfferPrice,
                                              element?.productQuantity
                                                  .toString());
                                        },
                                      ),
                                      AppNetworkImages(
                                        // '${element}',
                                        imageUrl: "${element?.productImagePath}",
                                        // images[pagePosition],
                                        width: 44.w,
                                        height: 44.w,
                                        // width: 102.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("${element?.productName}",
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: Black1),
                                                )),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  " ${element?.productWeight} ${element?.unit} x ",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: grey5,
                                                        // letterSpacing: .5,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Text(
                                                  "${element?.productQuantity}",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: grey5,
                                                        // letterSpacing: .5,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text("INR ${element?.productOfferPrice}",
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Black1),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        );
                      },
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xffEFEFEF),
                    ),
                    SizedBox(
                      height: 15.01.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${watch.selectedProductIdList.length} Products Return",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Black1),
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Refund Amount",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Black1),
                                )),
                            Text("INR ${watch.refundTotal}",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Black1),
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.99.h,
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xffEFEFEF),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reason",
                          style: TextStyle(
                              color: Color(0xff3A3A3A),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: watch.refundReasonDetails?.length ?? 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final element = watch.refundReasonDetails?[index];
                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PrimaryCheckBox(
                                      value: watch.isSelectedReason[index],
                                      onChanged: (value) {
                                        read.onSelectReason(
                                            index, value, element?.id);
                                      },
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${element?.reason}",
                                        // "Product no longer needed",
                                        // "${element?.reason}",
                                        style: TextStyle(
                                            color: Black1,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                )
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        PrimarySTextFormField(
                          controller: watch.descriptionController,
                          height: 150.w,
                          maxLines: 10,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        PrimaryButton(
                          onTap: () {
                            read.submitRefundProduct(context);
                          },
                          color: Color(0xff39C19D),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  letterSpacing: .5,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 100.h,
                    // )
                  ],
                ),
              ),
            ),
    );
  }
}
