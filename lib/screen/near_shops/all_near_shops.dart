import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class AllNearShops extends StatefulWidget {
  const AllNearShops({super.key});

  @override
  State<AllNearShops> createState() => _AllNearShopsState();
}

class _AllNearShopsState extends State<AllNearShops> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 40.h, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: const AssetImage(
                        "assets/images/logo.png",
                      ),
                      fit: BoxFit.fill,
                      width: 150.w,
                      height: 50.w,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/location1.svg',
                          // width: 15.w,
                          // height: 19.h,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Vishrantwadi, Pune",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: SplashText1,
                                letterSpacing: .5,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 19.0.w,
                  left: 19.0.w,
                  top: 13.h,
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: splashnone),
                        borderRadius: BorderRadius.circular(8.w)),
                    hintText: 'Search your shop and products..',
                    hintStyle: TextStyle(
                        color: kgrey,
                        letterSpacing: .5,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Black,
                        size: 25.h,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 23.w, left: 19.0.w, bottom: 15.w),
                child: Text(
                  "Nearby Shops",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: Black,
                        letterSpacing: .5,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 120.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext, index) {
                      return Row(
                        children: [
                          Container(
                            height: 120.h,
                            width: 200.w,
                            margin: EdgeInsets.only(
                                left: index == 0 ? 19.w : 0,
                                right: index == 2 ? 19.w : 5.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.w),
                                image: DecorationImage(
                                    scale: 1.0,
                                    image: AssetImage(
                                        'assets/images/nearshop2.png'),
                                    fit: BoxFit.fill)),
                            child: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: SvgPicture.asset(
                                          "assets/images/favorite.svg",
                                          width: 26,
                                          height: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 62.h,
                                  ),
                                  Text("New Balaji Trading Co..",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600))),
                                  Text("Vishrantwadi, Pune",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: .5,
                                              fontSize: 12.sp,
                                              // height: 10,
                                              fontWeight: FontWeight.w400))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                // height: 400.h,
                child: ListView.builder(
                    // scrollDirection: Axis.vertical,p
                    physics: NeverScrollableScrollPhysics(),
                    // physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (BuildContext, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 19.w,
                            right: 12,
                            // top: 20.w,
                            bottom: 14.w),
                        child: Container(
                          height: 160.h,
                          width: 352.w,

                          // margin: EdgeInsets.only(
                          //     left: index == 0 ? 19.w : 0,
                          //     right: index == 2 ? 19.w : 5.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.w),
                              image: DecorationImage(
                                  // scale: 1.0,
                                  image:
                                      AssetImage('assets/images/nearshop2.png'),
                                  fit: BoxFit.fill)),
                          child: Padding(
                            padding: EdgeInsets.all(10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        "assets/images/favorite.svg",
                                        width: 26,
                                        height: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 92.h,
                                ),
                                Text("New Balaji Trading Co..",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: .5,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600))),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/location.svg",
                                      width: 12,
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: Text("Vishrantwadi, Pune",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: .5,
                                                  fontSize: 12.sp,
                                                  // height: 10,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                    ),
                                    // SizedBox(
                                    //   width: 130.w,
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 128.w),
                                      child: Container(
                                        height: 22.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          color: yellow,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/star.svg",
                                              height: 12.h,
                                              width: 12.w,
                                            ),
                                            SizedBox(
                                              width: 4.3.w,
                                            ),
                                            Text(
                                              "4.5",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black,
                                                    letterSpacing: .5,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ])));
  }
}
