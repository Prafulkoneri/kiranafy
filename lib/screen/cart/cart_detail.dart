import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/color.dart';
import '../order_summery/order_summery.dart';
import 'empty_cart.dart';

class CartDetail extends StatelessWidget {
  const CartDetail({super.key});

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
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          toolbarHeight: 65,
          // backgroundColor: kappbar,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Cart Details",
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  color: Black,
                  // letterSpacing: .5,
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
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, top: 20.w),
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
          SizedBox(
            height: 7.h,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.w, bottom: 15.w),
                child: SvgPicture.asset(
                  'assets/images/location2.svg',
                  // width: 15.w,
                  // height: 19.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.w, bottom: 10.w),
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
              Padding(
                padding: EdgeInsets.only(left: 35.h, right: 11.w, bottom: 12.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/call.svg',
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    SvgPicture.asset(
                      'assets/images/fvrt.svg',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(thickness: 1, color: grey2),
          SizedBox(
            height: 22.h,
            width: 126.w,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                // backgroundColor: ,
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: SplashText1,
                      // width: 1,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OrderSummery()),
                );
              },
              child: Text(
                "Place Order",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(
                      color: SplashText1,
                      // letterSpacing: .5,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),

              //
            ),
          ),
        ])));
  }
}
