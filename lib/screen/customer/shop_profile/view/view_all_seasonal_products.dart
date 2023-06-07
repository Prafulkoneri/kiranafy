// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';

// class AllSeasonalProducts extends StatefulWidget {
//   const AllSeasonalProducts({super.key});

//   @override
//   State<AllSeasonalProducts> createState() => _AllSeasonalProductsState();
// }

// class _AllSeasonalProductsState extends State<AllSeasonalProducts> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           systemOverlayStyle: SystemUiOverlayStyle(
//             systemNavigationBarIconBrightness: Brightness.dark,
//             // Status bar color
//             statusBarColor: kstatusbar,
//             // Status bar brightness (optional)
//             statusBarIconBrightness:
//                 Brightness.dark, // For Android (dark icons)
//             statusBarBrightness: Brightness.dark, // For iOS (dark icons)
//           ),
//           toolbarHeight: 65,
//           // backgroundColor: kappbar,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           title: Text(
//             "Seasonal Product",
//             style: GoogleFonts.dmSans(
//               textStyle: const TextStyle(
//                   color: Black,
//                   letterSpacing: .5,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700),
//             ),
//           ),
//           centerTitle: true,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(40),
//             ),
//           ),
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(40),
//               gradient: LinearGradient(
//                   end: Alignment.topCenter,
//                   begin: Alignment.bottomCenter,
//                   colors: <Color>[
//                     kstatusbar.withOpacity(0.55),
//                     kstatusbar.withOpacity(0.98),
//                   ]),
//             ),
//           ),
//         ),
//         body: Padding(
//           padding:
//               EdgeInsets.only(left: 12.h, top: 20.w, right: 12.h, bottom: 15.w),
//           child: SizedBox(
//             // height: 156.h,
//             // width: 2.w,
//             child: GridView.builder(
//                 itemCount: 10,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 4.0,
//                     mainAxisSpacing: 4.0),
//                 itemBuilder: (BuildContext, index) {
//                   return Container(
//                     height: 160.h,
//                     child: Card(
//                       // color: black,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 17.w),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Card(
//                                 child: Image.asset(
//                               "assets/images/mango.png",
//                               height: 72.w,
//                               width: 114.w,
//                             )),
//                             SizedBox(
//                               height: 3.w,
//                             ),
//                             Text(
//                               "Red Label",
//                               style: GoogleFonts.dmSans(
//                                 textStyle: TextStyle(
//                                     color: Black1,
//                                     letterSpacing: .5,
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                             // SizedBox(
//                             //   height: 2.h,
//                             // ),
//                             Text(
//                               "100g",
//                               style: GoogleFonts.dmSans(
//                                 textStyle: TextStyle(
//                                     color: Black1,
//                                     letterSpacing: .5,
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               // crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   '\u{20B9}${40}',
//                                   style: GoogleFonts.dmSans(
//                                     textStyle: TextStyle(
//                                         color: Black1,
//                                         letterSpacing: .5,
//                                         fontSize: 12.sp,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 10.w),
//                                   child: SvgPicture.asset(
//                                     'assets/images/add.svg',
//                                     // width: 15.w,
//                                     // height: 19.h,
//                                   ),
//                                 ),
//                                 // SizedBox(
//                                 //   height: 20.h,
//                                 // )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/customer/products/views/product_screen.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/all_seasonal_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
import 'package:local_supper_market/screen/customer/shop_profile/view/shop_profile_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/network_image.dart';
import 'package:provider/provider.dart';

class AllSeasonalProducts extends StatefulWidget {
  final String? shopId;
  const AllSeasonalProducts({super.key, required this.shopId});

  @override
  State<AllSeasonalProducts> createState() => _AllSeasonalProductsState();
}

class _AllSeasonalProductsState extends State<AllSeasonalProducts> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<ShopAllSeasonalController>()
          .initState(context, widget.shopId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ShopAllSeasonalController>();
    final read = context.read<ShopAllSeasonalController>();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.w),
          child: PrimaryAppBar(
            onBackBtnPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => MainScreenView(
                        index: 1,
                        screenName: ShopProfileView(
                          shopId: widget.shopId.toString(),
                          routeName: "viewAllSeasonalProduct",
                          refreshPage: false,
                        ))),
                (Route<dynamic> route) => false,
              );
            },
            title: "Seasonal Products",
          ),
        ),
        body: watch.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: SizedBox(
                  // height: 156.h,
                  // width: 2.w,
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          left: 10.w, top: 20.w, right: 10.w, bottom: 100.w),
                      itemCount: watch.seasonalProduct?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (1.5.w / 1.8.w),
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0),
                      itemBuilder: (BuildContext, index) {
                        final element = watch.seasonalProduct?[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreenView(
                                        index: 1,
                                        screenName: ProductScreenView(
                                            categoryId:
                                                element?.categoryId.toString(),
                                            // categoryId: watch.categoryId,
                                            productId: element?.id.toString(),
                                            shopId: widget.shopId,
                                            productType: element?.productType),
                                      )),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 17.w,
                                right: 12.w,
                              ),
                              width: 156.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 0.w, top: 10.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        element?.discountPercentage != ""
                                            ? Container(
                                                width: 60.w,
                                                height: 20.h,
                                                decoration: BoxDecoration(
                                                    color: lightgreen,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.w))),
                                                child: Center(
                                                  child: Text(
                                                      "${element?.discountPercentage} off",
                                                      style: GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color: Colors.white,
                                                            letterSpacing: .5,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                ),
                                              )
                                            : Container(
                                                width: 60.w,
                                                height: 20.h,
                                              ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      element?.productImagePath == ""
                                          ? Container(
                                              height: 68.w,
                                              width: 68.w,
                                              child: Image.asset(
                                                "assets/images/profile_image.png",
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Container(
                                              height: 68.w,
                                              width: 68.w,
                                              child: AppNetworkImages(
                                              imageUrl:"${element?.productImagePath}",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${element?.productName}",
                                          maxLines: 1,
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              color: Black1,
                                              overflow: TextOverflow.ellipsis,
                                              // letterSpacing: .5,
                                              fontSize: 16.sp,

                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.w,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${element?.weight}${element?.unit}",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Black1,
                                              // letterSpacing: .5,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.w,
                                  ),
                                  Container(
                                    // padding: EdgeInsets.only(right: 0.w, bottom: 0.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            element?.mrpPrice != ""
                                                ? Text(
                                                    '\u{20B9}${element?.mrpPrice}',
                                                    style: GoogleFonts.dmSans(
                                                        textStyle: element?.offerPrice !=
                                                                    "" &&
                                                                element?.offerPrice !=
                                                                    element
                                                                        ?.mrpPrice
                                                            ? TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                color: Black1,
                                                                letterSpacing:
                                                                    .5,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)
                                                            : TextStyle(
                                                                color: Black1,
                                                                letterSpacing:
                                                                    .5,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)))
                                                : Text(""),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            element?.offerPrice != "" &&
                                                    element?.offerPrice !=
                                                        element?.mrpPrice
                                                ? Text(
                                                    '\u{20B9}${element?.offerPrice}',
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          // decoration:
                                                          // TextDecoration.lineThrough,
                                                          color: Black,
                                                          letterSpacing: .5,
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  )
                                                : Text(""),
                                          ],
                                        ),
                                        SvgPicture.asset(
                                          'assets/images/add.svg',
                                          // width: 15.w,
                                          // height: 19.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.w,
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
