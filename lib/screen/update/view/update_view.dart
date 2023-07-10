import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/buttons.dart';

class UpadteView extends StatefulWidget {
  const UpadteView({super.key});

  @override
  State<UpadteView> createState() => _UpadteViewState();
}

class _UpadteViewState extends State<UpadteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Red,
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffA9E7E5), Color(0xffFFFFFF)],
                  )),
                ),
              ),
            ],
          ),
          Positioned(
            child: Image.asset(
              "assets/images/update1.png",
              width: 367.w,
            ),
          ),
          Positioned(
              bottom: 0.w,
              right: 0.w,
              child: Container(
                width: ScreenUtil().screenWidth,
                padding: EdgeInsets.only(
                    left: 42.w, right: 34.w, top: 30.w, bottom: 59.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Dear User",
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            color: Black,
                            fontSize: 26,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      "For more features and a better\n user experience, Please upgrade this app",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            color: Black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 43.h,
                    ),
                    PrimaryButton(
                      width: 164.w,
                      borderRadius: 15,
                      color: Color(0xff4689EC),
                      onTap: () {},
                      textColor: Colors.white,
                      text: "UPDATE",
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
