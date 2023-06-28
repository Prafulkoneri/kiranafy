import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/cms_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

class SAccountCmsPagesView extends StatefulWidget {
  const SAccountCmsPagesView({super.key});

  @override
  State<SAccountCmsPagesView> createState() => _SAccountCmsPagesViewState();
}

class _SAccountCmsPagesViewState extends State<SAccountCmsPagesView> {
  @override
  Widget build(BuildContext context) {
    // final read = context.read<ProfileController>();
    // final watch = context.watch<ProfileController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Accounts",
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                // read.onEditProfilePressed(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 27.w, right: 28.w),
                padding: EdgeInsets.only(bottom: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: underline),
                  ),
                  // color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      'assets/icons/about.svg',
                      // width: 14.w,
                      // height: 13.h,
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Text(
                      'About',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ////////////////////////

            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/faq.svg',
                    // width: 14.w,
                    // height: 13.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'FAQ',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            ///////////////////////
            GestureDetector(
              onTap: (){
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => SMainScreenView(
                //           index: 4,
                //           screenName: CmsView(
                //           ))),
                //       (Route<dynamic> route) => false,
                // );
              },
              child: Container(
                margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
                padding: EdgeInsets.only(bottom: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: underline),
                  ),
                  // color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      'assets/icons/privacy.svg',
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Text(
                      'Privacy Policy',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: underline),
                ),
                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/terms.svg',
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Terms & Conditions',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),

            /////////////////////

            GestureDetector(
              onTap: () {
                // read.myDeliveryAddressPressed(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
                padding: EdgeInsets.only(bottom: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: underline),
                  ),
                  // color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      'assets/icons/share.svg',
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    Text(
                      'Share App',
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 27.w, right: 28.w, top: 16.w),
              padding: EdgeInsets.only(bottom: 15.w),
              decoration: BoxDecoration(

                // color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    'Rate Us',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
