import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class CFavouritesProductView extends StatefulWidget {
  const CFavouritesProductView({super.key});

  @override
  State<CFavouritesProductView> createState() => _CFavouritesProductViewState();
}

class _CFavouritesProductViewState extends State<CFavouritesProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding:
          EdgeInsets.only(left: 12.h, top: 20.w, right: 12.h, bottom: 15.w),
      child: SizedBox(
        // height: 156.h,
        // width: 2.w,
        child: GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemBuilder: (BuildContext, index) {
              return Card(
                // color: black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 17.h, top: 13.w, bottom: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Center(
                              child:
                                  Image.asset("assets/images/redlabel.png"))),
                      SizedBox(
                        height: 3.w,
                      ),
                      Text(
                        "Red Label",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black1,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Text(
                        "100g",
                        style: TextStyle(
                            color: Black1,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              '\u{20B9}${40}',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SvgPicture.asset(
                              'assets/icons/fvrt_products.svg',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Text(
                        "Maharaj Kirana Store",
                        style: TextStyle(
                            color: Black1,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    ));
  }
}
