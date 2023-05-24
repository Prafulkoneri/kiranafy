import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class AllSeasonalProducts extends StatefulWidget {
  const AllSeasonalProducts({super.key});

  @override
  State<AllSeasonalProducts> createState() => _AllSeasonalProductsState();
}

class _AllSeasonalProductsState extends State<AllSeasonalProducts> {
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
            "Seasonal Product",
            style: GoogleFonts.dmSans(
              textStyle: const TextStyle(
                  color: Black,
                  letterSpacing: .5,
                  fontSize: 14,
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
        ),
        body: Padding(
          padding:
              EdgeInsets.only(left: 12.h, top: 20.w, right: 12.h, bottom: 15.w),
          child: SizedBox(
            // height: 156.h,
            // width: 2.w,
            child: GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext, index) {
                  return Container(
                    height: 160.h,
                    child: Card(
                      // color: black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                                child: Image.asset(
                              "assets/images/mango.png",
                              height: 72.w,
                              width: 114.w,
                            )),
                            SizedBox(
                              height: 3.w,
                            ),
                            Text(
                              "Red Label",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    letterSpacing: .5,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            Text(
                              "100g",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    letterSpacing: .5,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\u{20B9}${40}',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        letterSpacing: .5,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: SvgPicture.asset(
                                    'assets/images/add.svg',
                                    // width: 15.w,
                                    // height: 19.h,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 20.h,
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ));
  }
}
