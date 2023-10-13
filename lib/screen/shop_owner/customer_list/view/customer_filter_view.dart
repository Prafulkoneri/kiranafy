import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/controller/s_customer_list_controller.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:provider/provider.dart';

class CustomerFilterView extends StatefulWidget {
  const CustomerFilterView({super.key});

  @override
  State<CustomerFilterView> createState() => _CustomerFilterViewState();
}

class _CustomerFilterViewState extends State<CustomerFilterView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SCustomerListController>();
    final watch = context.watch<SCustomerListController>();
    return SingleChildScrollView(
      child: Container(
        // height: 326.h,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        width: 390.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Customer Filter",
                      style: TextStyle(
                          color: Black1,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/nav_close.svg",
                        // width: 5.h,
                        // height: 5.w,
                      ),
                    ),
                  ],
                ),
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
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                top: 17.w,
              ),
              child: Row(
                children: [
                  PrimaryCheckBox(
                    value: watch.isFavToShopSelected,
                    onChanged: (value) {
                      read.onFavToShopSelected(value);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Favourite To Shop",
                      style: TextStyle(
                          color: Black1,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 17.w,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
              ),
              child: Row(
                children: [
                  PrimaryCheckBox(
                    value: watch.isOrderedSelected,
                    onChanged: (value) {
                      read.onOrderedButNotFavSelected(value);
                    },
                  ),
                  Text(
                    // "Ordered But Not Favourite",
                    "Ordered Customers",
                    style: TextStyle(
                        color: Black1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
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
                    primary: Button,
                    // onPrimary: Colors.white,
                    // shadowColor: Colors.greenAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                    minimumSize: const Size(100, 40), //////// HERE
                  ),
                  // style: style,
                  onPressed: () {
                    read.getCustomerList(context, "filter");
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
