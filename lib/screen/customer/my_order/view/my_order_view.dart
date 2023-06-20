import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/delivery_view/view/delivery_view_pending.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';

import '../../cart/view/empty_cart_view.dart';

class MyOrderView extends StatelessWidget {
  const MyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreenView(
                      index: 1, screenName: ProfileScreenView())),
              (Route<dynamic> route) => false,
            );
          },
          title: "My Orders",
          action: InkWell(
            onTap: () {
              // showModalBottomSheet(
              //   isScrollControlled: true,
              //   shape: const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(30),
              //           topRight: Radius.circular(30))),
              //   context: context,
              //   builder: (BuildContext context) {
              //     return StatefulBuilder(builder: (context, setState) {
              //       return FilterScreenView();
              //     });
              //   },
              // );
            },
            child: SvgPicture.asset(
              'assets/images/filter.svg',
              width: 20.w,
              height: 18.h,
            ),
          ),
        ),
      ),
      // appBar: AppBar(
      //   elevation: 0,
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     systemNavigationBarIconBrightness: Brightness.dark,
      //     // Status bar color
      //     statusBarColor: kstatusbar,
      //     // Status bar brightness (optional)
      //     statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      //     statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      //   ),
      //   toolbarHeight: 65,
      //   // backgroundColor: kappbar,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: Text(
      //     "My Orders",
      //     style: GoogleFonts.dmSans(
      //       textStyle: TextStyle(
      //           color: Black,
      //           letterSpacing: .5,
      //           fontSize: 14.sp,
      //           fontWeight: FontWeight.w700),
      //     ),
      //   ),
      //   centerTitle: true,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(40),
      //     ),
      //   ),
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(40),
      //       gradient: LinearGradient(
      //           end: Alignment.topCenter,
      //           begin: Alignment.bottomCenter,
      //           colors: <Color>[
      //             kstatusbar.withOpacity(0.55),
      //             kstatusbar.withOpacity(0.98),
      //           ]),
      //     ),
      //   ),
      //   actions: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.only(
      //         right: 20.w,
      //       ),
      //       child: InkWell(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => const EmptyCartView()),
      //           );
      //         },
      //         child: SvgPicture.asset(
      //           'assets/images/filter.svg',
      //           width: 20.w,
      //           height: 18.h,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      // backgroundColor: backgroundColor,
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
                left: 20.w, right: 20.w, top: 19.w, bottom: 0.w),
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, top: 10.w, bottom: 10.w),
            // width: 352.w,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: grey6),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order ID - PAAC001",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black1,
                            // letterSpacing: .5,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
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
                                color: Yellow,
                                // width: 1,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderPendingView()),
                          );
                        },
                        child: Text(
                          "Pending",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Yellow,
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
                Text(
                  "Mar 10, 2023    9:15 am",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: lightblack,
                        // letterSpacing: .5,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Amount",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            // letterSpacing: .5,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      "Total Quantity",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs. 3,200",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: lightblack1,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      "25",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: lightblack1,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
