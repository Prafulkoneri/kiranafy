import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class ProductScreenView extends StatefulWidget {
  const ProductScreenView({Key? key}) : super(key: key);

  @override
  _ProductScreenViewState createState() => _ProductScreenViewState();
}

class _ProductScreenViewState extends State<ProductScreenView> {
  List<String> images = [
    'assets/images/sprite.png',
    'assets/images/sprite.png',
    'assets/images/sprite.png',
  ];
  PageController? _pageController;
  int activePage = 0;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 1, initialPage: 1);
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return currentIndex == index
          ? Container(
              margin: EdgeInsets.only(left: 85.w),
              width: 16.w,
              height: 6.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: currentIndex == index ? indicator : Grey,
              ),
            )
          : Container(
              margin: EdgeInsets.only(left: 7.w),
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(color: Grey, shape: BoxShape.circle),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.w),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.20),
                      blurRadius: 8,
                      spreadRadius: 3),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 54.w,
                        ),
                        Text("New Balaji Trading Company",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Black1),
                            )),
                        SizedBox(
                          height: 10.w,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/location2.svg',
                                    width: 28.w,
                                    height: 28.w,
                                  ),
                                  SizedBox(
                                    width: 9.w,
                                  ),
                                  Text(
                                    "Bhairav Nagar, Vishrantwadi\nPune - 411015",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black,
                                          letterSpacing: .5,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/call.svg',
                                    // width: 15.w,
                                    // height: 19.h,
                                  ),
                                  SizedBox(
                                    width: 13.w,
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/fvrt.svg',
                                    // width: 15.w,
                                    // height: 19.h,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 17.w,
                  ),
                  Divider(
                    thickness: 1.w,
                    color: Color(0xffDADADA),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width,
                    height: 241.w,
                    child: PageView.builder(
                        itemCount: images.length,
                        physics: BouncingScrollPhysics(),
                        padEnds: false,
                        pageSnapping: true,
                        // controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            activePage = page;
                          });
                        },
                        itemBuilder: (context, pagePosition) {
                          return Container(
                            child: Image.asset(
                              images[pagePosition],
                              height: 241.w,
                              width: 102.w,
                            ),
                            margin: EdgeInsets.only(
                                left: pagePosition == 0 ? 19.w : 0,
                                // top: 15.w,
                                right: pagePosition == images.length - 1
                                    ? 19.w
                                    : 10.w),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(children: indicators(images.length, activePage)),
                      Row(
                        children: [
                          SvgPicture.asset("assets/products/share.svg"),
                          SizedBox(
                            width: 25.w,
                          ),
                          SvgPicture.asset("assets/products/favourite.svg"),
                          SizedBox(
                            width: 25.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.w,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sprite",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: Black1),
                      )),
                  SizedBox(
                    height: 9.w,
                  ),
                  Text(" Brand - Coca Cola",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                            color: SplashText),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 22.w,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 18.w),
                            decoration: BoxDecoration(
                                color: Color(0xffEAFFF1),
                                border: Border.all(color: Color(0xff69BB86)),
                                borderRadius: BorderRadius.circular(10.w)),
                            padding: EdgeInsets.symmetric(
                                vertical: 7.w, horizontal: 14.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("₹150",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Black1,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        )),
                                    Row(
                                      children: [
                                        Text("₹135.00",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18.sp,
                                                color: Black1,
                                              ),
                                            )),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xff37B4B8)
                                                  .withOpacity(0.6),
                                              border: Border.all(
                                                  color: Color(0xff69BB86),
                                                  width: 1.w)),
                                          padding: EdgeInsets.all(3.w),
                                          child: Text("10% off",
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Text("1L",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                                color: Color(0xff53B175),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xffE0E0E0),
                                          borderRadius:
                                              BorderRadius.circular(5.w)),
                                      height: 30.w,
                                      width: 30.w,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 20.w),
                                        child: Icon(Icons.minimize_sharp),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text(
                                      "1",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xffFF844C),
                                          borderRadius:
                                              BorderRadius.circular(5.w)),
                                      height: 30.w,
                                      width: 30.w,
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 12.w,
                    ),
                    Text("About Product ",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Black1),
                        )),
                    SizedBox(
                      height: 7.w,
                    ),
                    Divider(
                      thickness: 1.w,
                      color: Color(0xffE2E2E2).withOpacity(0.7),
                    ),
                    SizedBox(
                      height: 4.w,
                    ),
                    Text(
                        "Coffee is a beverage prepared from roasted coffee beans. Darkly coloured, bitter, and slightly acidic, coffee has a stimulating effect on humans, primarily due to its caffeine content. It has the highest sales in the world market for hot drinks.",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                              height: 1.6,
                              color: Black1),
                        )),
                    SizedBox(
                      height: 30.w,
                    ),
                    Text("Similar Products",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Black1),
                        )),
                    SizedBox(
                      height: 17.w,
                    ),
                    Container(
                      height: 185.w,
                      child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext, index) {
                            return Container(
                              width: 156.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.w),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 0,
                                        spreadRadius: 0.8),
                                  ]),
                              padding: EdgeInsets.only(
                                  top: 14.w,
                                  bottom: 12.w,
                                  left: 17.w,
                                  right: 12.w),
                              margin: EdgeInsets.only(left: 10.w),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 89.w,
                                      width: 89.w,
                                      child: Image.asset(
                                          "assets/images/redlabel.png"),
                                    ),
                                    SizedBox(
                                      height: 3.w,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Red Label",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.w,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "100g",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "₹40",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xffFF844C),
                                              borderRadius:
                                                  BorderRadius.circular(5.w)),
                                          height: 30.w,
                                          width: 30.w,
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 30.w,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
