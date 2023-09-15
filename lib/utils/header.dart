import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderView extends StatelessWidget {
  final String? areaName;
  final String? cityName;
  const HeaderView({super.key, required this.cityName, required this.areaName});

  @override
  Widget build(BuildContext context) {
    final read = context.read<MainScreenController>();
    return Container(
      padding: EdgeInsets.only(left: 20.w, top: 40.h, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: const AssetImage(
              "assets/images/logo.png",
            ),
            fit: BoxFit.fill,
            width: 150.w,
            height: 50.w,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/location1.svg',
                width: 15.w,
                height: 19.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {
                  read.showMap(context, false);
                },
                child: Text(
                  "${areaName},${cityName}",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: SplashText1,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
