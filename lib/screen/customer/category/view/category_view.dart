import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/category/controller/product_as_per_category_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:provider/provider.dart';
import '../../products/views/product_screen.dart';

class CategoryScreenView extends StatefulWidget {
  final String? shopId;
  final String? categoryId;

  const CategoryScreenView(
      {super.key, required this.categoryId, required this.shopId});

  @override
  State<CategoryScreenView> createState() => _CategoryScreenViewState();
}

class _CategoryScreenViewState extends State<CategoryScreenView> {
  final TextEditingController _searchController = TextEditingController();

  bool checkedValue = false;
  String? gender; //no radio button will be selected

  // final List<String> genderItems = [];
  void setThis(newValue) {
    setState(() {
      checkedValue = newValue;
    });
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProductCategoryController>()
          .initState(context, widget.shopId, widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ProductCategoryController>();
    final read = context.read<ProductCategoryController>();
    final readMain = context.read<MainScreenController>();
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
          onPressed: () {
            readMain.onBackPressed(0, ShopProfile(shopId: widget.shopId));
          },
        ),
        title: Text(
          "Category",
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
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                context: context,
                builder: (BuildContext context) {
                  return Material(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    child: Container(
                      // height: 326.h,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      width: 390.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20.h,
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Product Filter",
                                  style: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: 100.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/cross1.svg',
                                    width: 30.w,
                                    height: 30.h,
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
                          Column(
                            children: [
                              CheckboxListTile(
                                // checkColor:
                                //     Colors.yellowAccent, // color of tick Mark
                                activeColor: SplashText,

                                title: Text(
                                  "Offer Products",
                                  style: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                value: checkedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkedValue = newValue!;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),

                              // Divider(),
                              RadioListTile(
                                activeColor: SplashText,

                                //          fillColor:
                                // MaterialStateColor.resolveWith((states) => Button1),
                                title: Text(
                                  "Low to High Price",
                                  style: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                value: "Low to High Price",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                activeColor: SplashText,
                                title: Text(
                                  "High to Low Price",
                                  style: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                value: "High to Low Price",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w,
                                top: 24.w,
                                bottom: 20.w,
                                right: 19.w),
                            child: SizedBox(
                              width: 352.w, // <-- Your width
                              height: 35.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Button,
                                  // onPrimary: Colors.white,
                                  // shadowColor: Colors.greenAccent,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(14.0)),
                                  minimumSize:
                                      const Size(100, 40), //////// HERE
                                ),
                                // style: style,
                                onPressed: () {},
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
                  );
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: 20.w,
              ),
              child: SvgPicture.asset(
                'assets/images/filter.svg',
                width: 20.w,
                height: 18.h,
              ),
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 19.0.w,
                left: 19.0.w,
                top: 20.h,
              ),
              child: SizedBox(
                height: 36.h,
                width: 351.w,
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
                      onPressed: () {
                        // Perform the search here
                      },
                    ),

                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(15.w),
                    // ),
                  ),
                ),
              ),
            ),
            Container(
              height: 50.h,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: watch.allCategoryList?.length ?? 0,
                  itemBuilder: (BuildContext, index) {
                    final element = watch.allCategoryList?[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index == 0 ? 19.w : 10.w,
                          top: 20.w,
                          right: index ==
                                  int.parse(watch.allCategoryList?.length
                                              .toString() ??
                                          "0") -
                                      1
                              ? 19.w
                              : 0.w),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.h,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                // backgroundColor: ,
                                backgroundColor: MaterialStateProperty.all(
                                    element?.selectedCategory == "yes"
                                        ? SplashText
                                        : Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: element?.selectedCategory == "yes"
                                          ? Colors.transparent
                                          : Grey,
                                      // width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                read.getProductList(context, widget.shopId,
                                    element?.id.toString());
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    element?.categoryName ?? "",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color:
                                              element?.selectedCategory == "yes"
                                                  ? Colors.white
                                                  : Grey,
                                          // letterSpacing: .5,
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //
                        ],
                      ),
                    );
                  }),
            ),
            watch.isLoading
                ? Container(
                    padding: EdgeInsets.only(top: 200.w),
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      // height: 95.h,
                      // width: 352.w,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: watch.productList?.length ?? 0,
                          itemBuilder: (BuildContext, index) {
                            final element = watch.productList?[index];
                            return
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductScreenView()));
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 18.w,
                                              top: 8.w,
                                              right: 17.w),
                                          child: Container(
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    element?.productImagePath ==
                                                            ""
                                                        ? Image.asset(
                                                            'assets/images/sprite.png',
                                                            width: 39.w,
                                                            height: 92.h,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.network(
                                                            element?.productImagePath ??
                                                                "",
                                                            width: 80.w,
                                                            height: 80.h,
                                                            fit: BoxFit.cover,
                                                          ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20.0.w,
                                                                top: 12.w,
                                                                right: 13.w),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                    element?.productName ??
                                                                        "",
                                                                    style: GoogleFonts
                                                                        .dmSans(
                                                                      textStyle: TextStyle(
                                                                          color:
                                                                              Black1,
                                                                          letterSpacing:
                                                                              .5,
                                                                          fontSize: 16
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                element?.discountPercentage !=
                                                                        ""
                                                                    ? Container(
                                                                        width:
                                                                            60.w,
                                                                        height:
                                                                            20.h,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                lightgreen,
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(5.w))),
                                                                        child:
                                                                            Center(
                                                                          child: Text(
                                                                              "${element?.discountPercentage} off",
                                                                              // textAlign: TextAlign.center,
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(color: Colors.white, letterSpacing: .5, fontSize: 12.sp, fontWeight: FontWeight.w500),
                                                                              )),
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 6.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    "${element?.weight}${element?.unit}",
                                                                    // textAlign: TextAlign.center,
                                                                    style: GoogleFonts
                                                                        .dmSans(
                                                                      textStyle: TextStyle(
                                                                          color:
                                                                              Grey,
                                                                          letterSpacing:
                                                                              .5,
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    )),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 12
                                                                            .w),
                                                                    child: Row(
                                                                      // crossAxisAlignment:
                                                                      //     CrossAxisAlignment.start,
                                                                      // mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              '\u{20B9}${element?.mrpPrice}',
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(decoration: TextDecoration.lineThrough, color: Black, letterSpacing: .5, fontSize: 13.sp, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10.w,
                                                                            ),
                                                                            Text(
                                                                              '\u{20B9}${element?.offerPrice}',
                                                                              style: GoogleFonts.dmSans(
                                                                                textStyle: TextStyle(
                                                                                    // decoration:
                                                                                    // TextDecoration.lineThrough,
                                                                                    color: Black,
                                                                                    letterSpacing: .5,
                                                                                    fontSize: 13.sp,
                                                                                    fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/images/add.svg',
                                                                  // width: 30.w,
                                                                  // height: 30.h,
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 12.w,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            // decoration: BoxDecoration(
                                            //   // color: Colors.blueAccent,
                                            //   border: Border.all(width: 1, color: grey1),
                                            // ),
                                            // decoration: BoxDecoration(color: Black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          }),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}
