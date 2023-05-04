import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_product_controller.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:provider/provider.dart';

import '../../../../widget/app_bar.dart';

class ShopProductView extends StatefulWidget {
  const ShopProductView({super.key});

  @override
  State<ShopProductView> createState() => _ShopProductViewState();
}

final TextEditingController _searchController = TextEditingController();

class _ShopProductViewState extends State<ShopProductView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SAddProductsController>();
    final watch = context.watch<SAddProductsController>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.w),
          child: PrimaryAppBar(
            title: "Cold Drinks & Juices - 2",
            // action: SvgPicture.asset("assets/icons/forward.svg"),
            onActionTap: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              right: 19.0.w,
              left: 19.0.w,
              top: 20.h,
            ),
            child: Column(
              children: [
                Container(
                  // padding: EdgeInsets.only(
                  //   right: 19.0.w,
                  //   left: 19.0.w,
                  //   top: 13.h,
                  // ),
                  child: SizedBox(
                    width: 352.w,
                    height: 30.h,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        // filled: true,
                        enabledBorder: UnderlineInputBorder(
                          //<-- SEE HERE
                          borderSide: BorderSide(width: 1, color: grey12),
                        ),
                        hintText: 'Search Products',
                        hintStyle: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Grey,
                                // letterSpacing: .5,
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                        prefixIcon: IconButton(
                          icon: SvgPicture.asset(
                            'assets/icons/search.svg',
                            width: 20.w,
                            height: 20.h,
                          ),
                          onPressed: () {
                            // Perform the search here
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                          height: 40.h,
                          // width: 164.w,
                          color: Custlogin,
                          onTap: () {
                            read.onAddProduct(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/pluse.svg'),
                              SizedBox(
                                width: 11.w,
                              ),
                              Text(
                                "Custom Product",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: PrimaryButton(
                          height: 40.h,
                          width: 164.w,
                          color: Custlogin,
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/pluse.svg'),
                              SizedBox(
                                width: 11.w,
                              ),
                              Text(
                                "Add Product",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22.h,
                ),
                ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 21.w, bottom: 11.w, top: 13.w, right: 21.w),
                          // height: 200,
                          // width: 200,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.09),
                                    blurRadius: 5,
                                    offset: Offset(-.0, 5.0),
                                    spreadRadius: 0),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(width: 1, color: grey1)),
                          // decoration: BoxDecoration(

                          //     border: Border.all(width: 1, color: Black1)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            "assets/images/sprite.png"),
                                        height: 61.h,
                                        width: 60.w,
                                      ),
                                      Text(
                                        "Coca Cola",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black1,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Text("data"),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: grey6,
                                                offset: const Offset(
                                                  5.0,
                                                  5.0,
                                                ),
                                                blurRadius: 10.0,
                                                spreadRadius: 2.0,
                                              ), //BoxShadow
                                            ],
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: SvgPicture.asset(
                                            'assets/icons/e1.svg'),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: grey6,
                                                offset: const Offset(
                                                  5.0,
                                                  5.0,
                                                ),
                                                blurRadius: 10.0,
                                                spreadRadius: 2.0,
                                              ), //BoxShadow
                                            ],
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: SvgPicture.asset(
                                            'assets/icons/delete2.svg'),
                                      )
                                      // Text("data"),

                                      // SvgPicture.asset(
                                      //     'assets/icons/reddelete.svg'),
                                    ],
                                  )
                                ],
                              ),
                              Divider(),
                              Container(
                                padding:
                                    EdgeInsets.only(left: 11.w, right: 11.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Product Unit",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Offer price",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Text(
                                          "MRP",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 12.w,
                                    right: 20.w,
                                    top: 7.w,
                                    bottom: 8.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // color: Black1,
                                    border: Border.all(width: 1, color: grey6)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "200 ml",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "INR 30",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 18.w,
                                        ),
                                        Text(
                                          "40",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Black1,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 12.w,
                                    right: 20.w,
                                    top: 7.w,
                                    bottom: 8.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // color: Black1,
                                    border: Border.all(width: 1, color: grey6)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "200 ml",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "INR 30",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 18.w,
                                        ),
                                        Text(
                                          "40",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 12.w,
                                    right: 20.w,
                                    top: 7.w,
                                    bottom: 8.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // color: Black1,
                                    border: Border.all(width: 1, color: grey6)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "200 ml",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "INR 30",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 18.w,
                                        ),
                                        Text(
                                          "40",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 12.w,
                                    right: 20.w,
                                    top: 7.w,
                                    bottom: 8.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // color: Black1,
                                    border: Border.all(width: 1, color: grey6)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "200 ml",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "INR 30",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 18.w,
                                        ),
                                        Text(
                                          "40",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
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
                          height: 18.w,
                        ),
                      ],
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 21.w, bottom: 7.w, top: 6.w, right: 21.w),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.09),
                            blurRadius: 5,
                            offset: Offset(-.0, 5.0),
                            spreadRadius: 0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(width: 1, color: grey1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(
                            image: AssetImage("assets/images/sprite.png"),
                            height: 61.h,
                            width: 60.w,
                          ),
                          Text(
                            "Coca Cola",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black1,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text("data"),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: grey6,
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: SvgPicture.asset('assets/icons/e1.svg'),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: grey6,
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: SvgPicture.asset('assets/icons/delete2.svg'),
                          )
                          // Text("data"),

                          // SvgPicture.asset(
                          //     'assets/icons/reddelete.svg'),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
