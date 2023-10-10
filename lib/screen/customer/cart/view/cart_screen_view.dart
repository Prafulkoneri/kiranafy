import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/cart/controller/cart_controller.dart';
import 'package:local_supper_market/screen/customer/home/view/home_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/near_shops/view/all_near_shops_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_detail_view.dart';

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
            // width: 20.w,
            // height: 18.h,
          ),
          onActionTap: () async {
            // await read.deleteShopCart(
            //   context,
            // );
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Color(0xffFFFFFF),
                    // shape: ,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),

                    // scrollable: true,
                    child: Container(
                      height: 205.h,
                      // width: 400.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Flexible(
                                child: Text(
                                  "Do you really want to Delete Your Cart ? ",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Color(0xff006F94),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 37.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 19.w,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    await read.deleteShopCart(
                                      context,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 24.w,
                                        right: 24.w,
                                        top: 9.w,
                                        bottom: 9.w),
                                    decoration: BoxDecoration(
                                        color: Color(0xff39C19D),
                                        borderRadius: BorderRadius.circular(8)),
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
                                    padding: EdgeInsets.only(
                                        left: 14.w,
                                        right: 15.w,
                                        top: 9.w,
                                        bottom: 9.w),
                                    decoration: BoxDecoration(
                                        color: Color(0xffEC7074),
                                        // border: Border.all(width: 1, color: Black),
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
        ),
      ),
      backgroundColor: backgroundColor,
      body: watch.isLoading
          ? Loader()
          : watch.cartList!.isEmpty
              ? WillPopScope(
                  onWillPop: () async {
                    readMain.onNavigation(
                        0,
                        HomeScreenView(
                          refreshPage: false,
                        ),
                        context);
                    return false;
                  },
                  child: Center(
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
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Looks like you have not added anything to your",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black1,
                                  // letterSpacing: .5,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          // SizedBox(
                          //   height: 5.h,
                          // ),
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
                          SizedBox(
                            height: 5.h,
                          ),
                          ElevatedButton(
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
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              if (pref.getString("status") == "guestLoggedIn") {
                                Utils().showLoginDialog(context,
                                    "Please Login to add product to favourite");
                                return;
                              }
                              readMain.onNavigation(
                                  1,
                                  AllNearShopsView(
                                    isSearchFocus: false,
                                    refreshPage: true,
                                  ),
                                  context);
                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => MainScreenView(
                              //           index: 2,
                              //           screenName: AllNearShopsView(
                              //             isSearchFocus: false,
                              //             refreshPage: true,
                              //           ))),
                              //   (Route<dynamic> route) => false,
                              // );
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
                        ],
                      ),
                    ),
                  ),
                )
              : WillPopScope(
                  onWillPop: () async {
                    readMain.onNavigation(
                        0,
                        HomeScreenView(
                          refreshPage: false,
                        ),
                        context);
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
                              return GestureDetector(
                                onTap: () {
                                  readMain.onNavigation(
                                      1,
                                      CartDetailView(
                                        isRefresh: true,
                                        cartId: element?.id.toString(),
                                        shopId: element?.shopId.toString(),
                                      ),
                                      context);
                                  readMain.hideBottomNavigationBar();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => CartDetailView(
                                  //             isRefresh: true,
                                  //             cartId: element?.id.toString(),
                                  //             shopId:
                                  //                 element?.shopId.toString(),
                                  //           )),
                                  // );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 20.w, top: 20.w, right: 16.w),
                                  // padding: ,
                                  // height: 165.h,
                                  // width: 354.w,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 15.w,
                                          right: 11.w,
                                          top: 13.w,
                                          bottom: 14.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
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
                                          SizedBox(
                                            height: 13.w,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/location2.svg',
                                                // width: 23.w,
                                                // height: 28.h,
                                              ),
                                              SizedBox(
                                                width: 8.52.w,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${element?.shopAddress}\n${element?.cityName} - ${element?.shopPincode}",
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
                                          SizedBox(
                                            height: 17.w,
                                          ),
                                          Divider(
                                            thickness: 1,
                                            // indent: 10,
                                            // endIndent: 10,
                                          ),
                                          SizedBox(
                                            height: 6.w,
                                          ),
                                          Text(
                                            "${element?.itemCount} Items",
                                            // "4 Items",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Black,
                                                  // letterSpacing: .5,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\u{20B9} ${element?.totalAmount}",
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      // height: 1.5,
                                                      color: black,
                                                      // letterSpacing: .05,
                                                      // overflow: TextOverflow.ellipsis,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  readMain.onNavigation(
                                                      1,
                                                      CartDetailView(
                                                        isRefresh: true,
                                                        cartId: element?.id
                                                            .toString(),
                                                        shopId: element?.shopId
                                                            .toString(),
                                                      ),
                                                      context);
                                                  readMain
                                                      .hideBottomNavigationBar();
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           CartDetailView(
                                                  //             isRefresh: true,
                                                  //             cartId: element
                                                  //                 ?.id
                                                  //                 .toString(),
                                                  //             shopId: element
                                                  //                 ?.shopId
                                                  //                 .toString(),
                                                  //           )),
                                                  // );
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
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16.sp,
                                                              color:
                                                                  SplashText),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            // child:
                            ),
                        SizedBox(
                          height: 30.w,
                        )
                      ],
                    ),
                  ),
                ),
    );
  }
}
