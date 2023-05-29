import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/shop_profile/controller/shop_profile_controller.dart';
import 'package:provider/provider.dart';

class AllOfferProducts extends StatefulWidget {
  final String? shopId;
  const AllOfferProducts({super.key, required this.shopId});

  @override
  State<AllOfferProducts> createState() => _AllOfferProductsState();
}

class _AllOfferProductsState extends State<AllOfferProducts> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ShopProfileController>().initState(context, widget.shopId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ShopProfileController>();
    final read = context.read<ShopProfileController>();
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
            "Offer Product",
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
        body: Container(
          margin: EdgeInsets.only(left: 10.w, top: 20.w, right: 10.w),
          child: GridView.builder(
              itemCount: watch.allOfferProducts?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1.5 / 2),
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0),
              itemBuilder: (BuildContext, index) {
                final element = watch.allOfferProducts?[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 17.w, right: 12.w, top: 0, bottom: 0),
                    width: 156.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 0.w, top: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              element?.discountPercentage != ""
                                  ? Container(
                                      width: 60.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: lightgreen,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.w))),
                                      child: Center(
                                        child: Text(
                                            "${element?.discountPercentage} off",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: .5,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
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
                                    child: Image.network(
                                      "${element?.productImagePath}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ],
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
                        // SizedBox(
                        //   height: 2.w,
                        // ),
                        Container(
                          padding: EdgeInsets.only(right: 10.w, bottom: 0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  element?.mrpPrice != ""
                                      ? Text(
                                          '\u{20B9}${element?.mrpPrice}',
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Black1,
                                                letterSpacing: .5,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      : Text(""),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  element?.offerPrice != ""
                                      ? Text(
                                          "₹${element?.offerPrice ?? 0}",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Black1,
                                                // letterSpacing: .5,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
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
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
