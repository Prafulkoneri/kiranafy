import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/near_shops/controller/all_shop_category_controller.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/stack_Loader.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class ShopCategoryFiltterView extends StatefulWidget {
  const ShopCategoryFiltterView({Key? key}) : super(key: key);

  @override
  _ShopCategoryFiltterViewState createState() =>
      _ShopCategoryFiltterViewState();
}

class _ShopCategoryFiltterViewState extends State<ShopCategoryFiltterView> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<AllCategoryShopController>();
    final read = context.read<AllCategoryShopController>();
    return Material(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      child: Container(
        // height: 326.h,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        // width: 390.w,
        child: StackLoader(
          showLoader: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shop Filter",
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            color: Black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/images/cross1.svg',
                        width: 25.w,
                        height: 25.h,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Divider(
                // height: 20,
                thickness: 1,
                indent: 19,
                endIndent: 19,
                color: grey1,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Area",
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            color: Black,
                            letterSpacing: .5,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    watch.areaId == ""
                        ? CDropDownField(
                            onChanged: (value) {
                              read.onAreaSelected(value);
                            },
                            items: watch.areaList
                                ?.map((item) => DropdownMenuItem<String>(
                                      value: item.id.toString(),
                                      child: Text(
                                        item.areaName ?? "",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          )
                        : CDropDownField(
                            value: watch.areaId,
                            onChanged: (value) {
                              read.onAreaSelected(value);
                            },
                            items: watch.areaList
                                ?.map((item) => DropdownMenuItem<String>(
                                      value: item.id.toString(),
                                      child: Text(
                                        item.areaName ?? "",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Rating",
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            color: Black,
                            letterSpacing: .5,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    watch.rating == ""
                        ? CDropDownField(
                            onChanged: (value) {
                              read.onRatingSelected(value);
                            },
                            items: [

                              DropdownMenuItem(
                                  value: "1",
                                  child: Row(
                                    children: [
                                      Text(
                                        "1",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFC000),
                                      )
                                    ],
                                  )),
                              DropdownMenuItem(
                                  value: "2",
                                  child: Row(
                                    children: [
                                      Text(
                                        "2",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFC000),
                                      )
                                    ],
                                  )),
                              DropdownMenuItem(
                                  value: "3",
                                  child: Row(
                                    children: [
                                      Text(
                                        "3",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFC000),
                                      )
                                    ],
                                  )),
                              DropdownMenuItem(
                                  value: "4",
                                  child: Row(
                                    children: [
                                      Text(
                                        "4",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFC000),
                                      )
                                    ],
                                  )),
                              DropdownMenuItem(
                                  value: "5",
                                  child: Row(
                                    children: [
                                      Text(
                                        "5",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFC000),
                                      )
                                    ],
                                  )),
                              DropdownMenuItem(
                                  value: "0",
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "All Rating",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )
                        : CDropDownField(
                            value: watch.rating,
                            onChanged: (value) {
                              read.onRatingSelected(value);
                            },
                            items: [

                              DropdownMenuItem(
                                  value: "1",
                                  child: Row(
                                    children: [
                                      Text(
                                        "1",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFC000),
                                      )
                                    ],
                                  )),
                              DropdownMenuItem(
                                  value: "2",
                                  child: Row(
                                    children: [
                                      Text(
                                        "2",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFC000),
                                      )
                                    ],
                                  )),
                              DropdownMenuItem(
                                  value: "3",
                                  child: Row(
                                    children: [
                                      Text(
                                        "3",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFC000),
                                      )
                                    ],
                                  )),
                              DropdownMenuItem(
                                  value: "4",
                                  child: Row(
                                    children: [
                                      Text(
                                        "4",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFC000),
                                      )
                                    ],
                                  )),
                              DropdownMenuItem(
                                  value: "5",
                                  child: Row(
                                    children: [
                                      Text(
                                        "5",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffFFC000),
                                      )
                                    ],
                                  )),
                              DropdownMenuItem(
                                  value: "0",
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "All Rating",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 24.w, right: 19.w),
                child: SizedBox(
                  width: 352.w, // <-- Your width
                  height: 35.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      // onPrimary: Colors.white,
                      // shadowColor: Colors.greenAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0)),
                      minimumSize: const Size(100, 40), //////// HERE
                    ),
                    // style: style,
                    onPressed: () {
                      read.clearFilter(
                        context,
                      );
                    },
                    child: Text(
                      'Clear Filter',
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            // color: SplashTex
                            letterSpacing: .5,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 20.w, top: 24.w, bottom: 20.w, right: 19.w),
                child: SizedBox(
                  width: 352.w, // <-- Your width
                  height: 35.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Button,
                      // onPrimary: Colors.white,
                      // shadowColor: Colors.greenAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0)),
                      minimumSize: const Size(100, 40), //////// HERE
                    ),
                    // style: style,
                    onPressed: () {
                      read.applyFilter(
                        context,
                      );
                    },
                    child: Text(
                      'Filter',
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            // color: SplashTex
                            letterSpacing: .5,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
