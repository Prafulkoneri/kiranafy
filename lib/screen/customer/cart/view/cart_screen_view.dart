import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/cart/controller/cart_controller.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

import 'cart_detail_view.dart';
import 'empty_cart_view.dart';

class CartScreenView extends StatefulWidget {
  const CartScreenView({super.key});

  @override
  State<CartScreenView> createState() => _CartScreenViewState();
}

class _CartScreenViewState extends State<CartScreenView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CartListController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<CartListController>();
    final read = context.read<CartListController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          isBackButtonEnabled: false,
          title: "Shop Cart",
          action: SvgPicture.asset(
            'assets/images/delete.svg',
            width: 20.w,
            height: 18.h,
          ),
          onActionTap: () async {
            await read.deleteShopCart(
              context,
            );
          },
        ),
      ),
      backgroundColor: backgroundColor,
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : watch.cartList!.isEmpty?Center(
        child: Padding(
          padding: EdgeInsets.only(top: 120.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,/
            children: [
              Image.asset(
                "assets/images/emptycart.png",
                height: 151.h,
                width: 151.w,
              ),
              Text(
                "Your Cart is Empty",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: Black1,
                      letterSpacing: .5,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 15.w, bottom: 50.w),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Looks like you have not anything to your",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black1,
                            letterSpacing: .5,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      "cart. Go ahead explore top categories",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black1,
                            letterSpacing: .5,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 50.w),
              //   child: RichText(
              //     text: TextSpan(
              // text: 'Looks like you have not added anything to your,',
              // style: GoogleFonts.dmSans(
              //   textStyle: TextStyle(
              //       color: Black1,
              //       letterSpacing: .5,
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w400),
              // ),
              //       children: <TextSpan>[
              //         TextSpan(
              //           text: 'cart. Go ahead and explore top categories',
              //           style: GoogleFonts.dmSans(
              //             textStyle: TextStyle(
              //                 color: Black1,
              //                 letterSpacing: .5,
              //                 fontSize: 14.sp,
              //                 fontWeight: FontWeight.w400),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                width: 160.w, // <-- Your width
                height: 45.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: SplashText,
                    // onPrimary: Colors.white,
                    // shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    minimumSize: const Size(100, 40), //////// HERE
                  ),
                  // style: style,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreenView(
                              index: 0,
                              screenName: AllNearShopsView(
                                refreshPage: true,
                              ))),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Browse Products',
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        // color: SplashTex
                          letterSpacing: .5,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ):
      WillPopScope(
              onWillPop: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreenView(
                          index: 0,
                          screenName: HomeScreenView(
                            refreshPage: false,
                          ))),
                  (Route<dynamic> route) => false,
                );
                return false;
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: watch.cartList?.length ?? 0,
                        itemBuilder: (BuildContext, index) {
                          final element = watch.cartList?[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, top: 20.w, right: 16.w),
                            child: Container(
                              // padding: ,
                              // height: 165.h,
                              // width: 354.w,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.w, top: 13.w),
                                      child: Text(
                                        "${element?.shopName}",
                                        // "New Balaji Trading Company",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black1,
                                              letterSpacing: .5,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 12.w, top: 13.w, bottom: 17.w),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/location2.svg',
                                            width: 23.w,
                                            height: 28.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 8.w,
                                            ),
                                            child: Text(
                                              "${element?.shopAddress}\n ${element?.cityName} ${element?.shopPincode}",
                                              // "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black,
                                                    letterSpacing: .5,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      // indent: 10,
                                      // endIndent: 10,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 14.w, top: 6.w),
                                      child: Text(
                                        "${element?.itemCount} Items",
                                        // "4 Items",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 14.w, right: 11.w),
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "INR ${element?.totalAmount}",
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
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CartDetailView(
                                                          isRefresh: true,
                                                          cartId: element?.id
                                                              .toString(),
                                                          shopId: element
                                                              ?.shopId
                                                              .toString(),
                                                        )),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 11.33.w,
                                                  vertical: 7.w),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.w),
                                                  border: Border.all(
                                                      color: SplashText)),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Place Order",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                    SizedBox(
                                      height: 10.w,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        // child:
                        ),
                    SizedBox(
                      height: 100.w,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
