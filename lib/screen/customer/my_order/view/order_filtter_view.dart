import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/customer/category/controller/product_as_per_category_controller.dart';
import 'package:local_supper_market/screen/shop_owner/bank_account_details/view/s_bank_account_details_view.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class MyOrderFiltterView extends StatefulWidget {
  const MyOrderFiltterView({Key? key}) : super(key: key);

  @override
  _MyOrderFiltterViewState createState() => _MyOrderFiltterViewState();
}

class _MyOrderFiltterViewState extends State<MyOrderFiltterView> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ProductCategoryController>();
    final read = context.read<ProductCategoryController>();
    return Material(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      child: Container(
        // height: 326.h,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        // width: 390.w,
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
                    "Order Filter",
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
              padding: EdgeInsets.only(
                left: 20.w,
              ),
              child: Text(
                "Shops",
                style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                      color: Black,
                      letterSpacing: .5,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            DropdownButtonFormField2(
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
              ),
              isExpanded: true,
              items: genderItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select shops.';
                }
                return null;
              },
              onChanged: (value) {
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                selectedValue = value.toString();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(left: 20, right: 10),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20.w,
              ),
              child: Text(
                "Status",
                style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                      color: Black,
                      letterSpacing: .5,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            DropdownButtonFormField2(
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
              ),
              isExpanded: true,
              items: genderItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select shops.';
                }
                return null;
              },
              onChanged: (value) {
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                selectedValue = value.toString();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(left: 20, right: 10),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.w, top: 24.w, bottom: 20.w, right: 19.w),
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
                        borderRadius: BorderRadius.circular(14.0)),
                    minimumSize: const Size(100, 40), //////// HERE
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
  }
}
