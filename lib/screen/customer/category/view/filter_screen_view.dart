import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/category/controller/product_as_per_category_controller.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
class FilterScreenView extends StatefulWidget {
  const FilterScreenView({Key? key}) : super(key: key);

  @override
  _FilterScreenViewState createState() => _FilterScreenViewState();
}

class _FilterScreenViewState extends State<FilterScreenView> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ProductCategoryController>();
    final read = context.read<ProductCategoryController>();
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
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
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
            Container(
              padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 15.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      PrimaryCheckBox(
                        value: watch.isOfferProductSelected,
                        onChanged: (value) {
                          read.onOfferProductFilterSelect(value);
                        },
                        textValue: "Offer Product",
                        textStyle: TextStyle(
                            color: Black,
                            letterSpacing: .5,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.w,
                  ),
                  Row(
                    children: [
                      FilterRadioButton(value: "1", groupValue: watch.groupValue, onChanged:(value){
                        read.onRadioBtnSelected(value);
                      }, leading: "adas"),
                   SizedBox(
                     width: 13.w,
                   ),
                    Text("Low to High Price",style: TextStyle(
                        color: Black,
                        letterSpacing: .5,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),)
                    ],
                  ),
                  SizedBox(
                    height: 30.w,
                  ),
                  Row(
                    children: [
                      FilterRadioButton(value: "2", groupValue: watch.groupValue, onChanged:(value){
                        read.onRadioBtnSelected(value);
                      }, leading: "adas"),
                      SizedBox(
                        width: 13.w,
                      ),
                      Text("High to Low Price",style: TextStyle(
                          color: Black,
                          letterSpacing: .5,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),)
                    ],
                  ),
                ],
              ),
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
                  onPressed: () {
read.getFilterProductList(context);
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
    );
  }
}