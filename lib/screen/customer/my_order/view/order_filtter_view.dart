import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/category/controller/product_as_per_category_controller.dart';
import 'package:local_supper_market/screen/customer/my_order/controller/my_orders_controller.dart';
import 'package:local_supper_market/screen/shop_owner/bank_account_details/view/s_bank_account_details_view.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class MyOrderFiltterView extends StatefulWidget {
  const MyOrderFiltterView({Key? key}) : super(key: key);

  @override
  _MyOrderFiltterViewState createState() => _MyOrderFiltterViewState();
}

class _MyOrderFiltterViewState extends State<MyOrderFiltterView> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<MyOrdersController>();
    final read = context.read<MyOrdersController>();
    return Material(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      child: Container(
        // height: 326.h,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        // width: 390.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Filter",
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                          color: Black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/images/cross1.svg',
                      width: 25.w,
                      height: 25.h,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Divider(
              // height: 20,
              thickness: 1,
              indent: 19,
              endIndent: 19,
              color: grey1,
            ),


           Container(
             padding: EdgeInsets.only(left: 20.w,right: 20.w),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
             Text(
                     "Shops",
                     style: GoogleFonts.dmSans(
                       textStyle: const TextStyle(
                           color: Black,
                           letterSpacing: .5,
                           fontSize: 16,
                           fontWeight: FontWeight.w500),
                     ),
                   ),
                 SizedBox(
                   height: 15.h,
                 ),
                watch.shopId==""?CDropDownField(
                   onChanged: (value){
                     read.onShopSelected(value);
                   },
                   items:watch.orderedShopsList?.map((item) => DropdownMenuItem<String>(
                     value: item.id.toString(),
                     child: Text(
                       item.shopName??"",
                       style:  TextStyle(
                         fontSize: 14.sp,
                       ),
                     ),
                   ))
                       .toList(),
                 ):
                CDropDownField(
                  value: watch.shopId,
                  onChanged: (value){
                    read.onShopSelected(value);
                  },
                  items:watch.orderedShopsList?.map((item) => DropdownMenuItem<String>(
                    value: item.id.toString(),
                    child: Text(
                      item.shopName??"",
                      style:  TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ))
                      .toList(),
                ),
                 SizedBox(
                   height: 20.h,
                 ),
                 Text(
                     "Status",
                     style: GoogleFonts.dmSans(
                       textStyle: const TextStyle(
                           color: Black,
                           letterSpacing: .5,
                           fontSize: 16,
                           fontWeight: FontWeight.w500),
                     ),
                   ),
                 SizedBox(
                   height: 15.h,
                 ),
                watch.orderStatus==""?CDropDownField(
                   onChanged: (value){
                     read.onStatusSelected(value);
                   },
                   items:[
                     DropdownMenuItem(value: "order_placed",child: Text("Pending",style: TextStyle(fontSize: 14.sp,),)),
                     DropdownMenuItem(value: "order_confirmed",child: Text("Confirmed",style: TextStyle(fontSize: 14.sp,),)),
                     DropdownMenuItem(value: "order_packing",child: Text("Packing",style: TextStyle(fontSize: 14.sp,),)),
                     DropdownMenuItem(value: "order_dispatched",child: Text("Dispatched",style: TextStyle(fontSize: 14.sp,),)),
                     DropdownMenuItem(value: "order_delivered",child: Text("Delivered",style: TextStyle(fontSize: 14.sp,),)),
                     DropdownMenuItem(value: "order_cancelled",child: Text("Cancelled",style: TextStyle(fontSize: 14.sp,),)),
                   ],
                 ):CDropDownField(
                  value: watch.orderStatus,
                  onChanged: (value){
                    read.onStatusSelected(value);
                  },
                  items:[
                    DropdownMenuItem(value: "order_placed",child: Text("Pending",style: TextStyle(fontSize: 14.sp,),)),
                    DropdownMenuItem(value: "order_confirmed",child: Text("Confirmed",style: TextStyle(fontSize: 14.sp,),)),
                    DropdownMenuItem(value: "order_packing",child: Text("Packing",style: TextStyle(fontSize: 14.sp,),)),
                    DropdownMenuItem(value: "order_dispatched",child: Text("Dispatched",style: TextStyle(fontSize: 14.sp,),)),
                    DropdownMenuItem(value: "order_delivered",child: Text("Delivered",style: TextStyle(fontSize: 14.sp,),)),
                    DropdownMenuItem(value: "order_cancelled",child: Text("Cancelled",style: TextStyle(fontSize: 14.sp,),)),
                  ],
                ),
               ],
             ),
           ),

            Padding(
              padding: EdgeInsets.only(
                  left: 20.w, top: 24.w, right: 19.w),
              child: SizedBox(
                width: 352.w, // <-- Your width
                height: 35.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    // onPrimary: Colors.white,
                    // shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    minimumSize: const Size(100, 40), //////// HERE
                  ),
                  // style: style,
                  onPressed: () {
                    read.clearFilter(context,);
                  },
                  child: Text(
                    'Clear Filter',
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                          // color: SplashTex
                          letterSpacing: .5,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.w, top: 24.w, bottom: 20.w, right: 19.w),
              child: SizedBox(
                width: 352.w, // <-- Your width
                height: 35.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Button,
                    // onPrimary: Colors.white,
                    // shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    minimumSize: const Size(100, 40), //////// HERE
                  ),
                  // style: style,
                  onPressed: () {
                    read.applyFilter(context,);
                  },
                  child: Text(
                    'Filter',
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                          // color: SplashTex
                          letterSpacing: .5,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
