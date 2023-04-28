import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/cart/view/cart_detail.dart';


import 'empty_cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          // Status bar color
          statusBarColor: kstatusbar,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        toolbarHeight: 65,
        // backgroundColor: kappbar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Shop Cart",
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
                color: Black,
                letterSpacing: .5,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700),
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: <Color>[
                  kstatusbar.withOpacity(0.55),
                  kstatusbar.withOpacity(0.98),
                ]),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 20.w,
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmptyCart()),
                );
              },
              child: SvgPicture.asset(
                'assets/images/delete.svg',
                width: 20.w,
                height: 18.h,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: SizedBox(
        // height: 154.h,
        child: Column(
          children: [
            ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (BuildContext, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, top: 20.w, right: 16.w),
                    child: Container(
                      height: 165.h,
                      width: 354.w,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15.w, top: 13.w),
                              child: Text(
                                "New Balaji Trading Company",
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
                                      "Bhairav Nagar, Vishrantwadi\nPune - 411015",
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
                            ),
                            Divider(
                              thickness: 1,
                              // indent: 10,
                              // endIndent: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 14.w, top: 6.w),
                              child: Text(
                                "4 Items",
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
                              padding: EdgeInsets.only(left: 14.w, right: 11.w),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "INR  132",
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
                                  SizedBox(
                                    height: 30.h,
                                    width: 120.w,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        // backgroundColor: ,
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: BorderSide(
                                              color: SplashText,
                                              // width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CartDetail()),
                                        );
                                      },
                                      child: Text(
                                        "Place Order",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: SplashText,
                                              // letterSpacing: .5,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),

                                      //
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                // child:
                ),
          ],
        ),
      ),
    );
  }
}
