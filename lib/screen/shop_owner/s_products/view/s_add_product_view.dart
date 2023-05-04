import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

bool _checkbox = false;

class _AddProductViewState extends State<AddProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.w),
          child: PrimaryAppBar(
            title: "Add Products",
            action: SvgPicture.asset("assets/icons/forward.svg"),
            onActionTap: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cold Drinks & Juices -  5",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                            color: Black1,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      side: MaterialStateBorderSide.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return BorderSide(width: 1, color: SplashText);
                          }
                          return BorderSide(width: 0, color: Grey);
                        },
                      ),
                      checkColor: Colors.white,
                      activeColor: SplashText,
                      value: _checkbox,
                      onChanged: (value) {
                        setState(() {
                          _checkbox = !_checkbox;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
