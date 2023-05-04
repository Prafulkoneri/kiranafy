import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/controller/s_product_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

bool _checkbox = false;

class _AddProductViewState extends State<AddProductView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SAddProductsController>();
    final watch = context.watch<SAddProductsController>();
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
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 28.w,
                  top: 20.w,
                  bottom: 20.w,
                ),
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

                    ///check Box
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

              ///Products Starts

              ListView.builder(
                  padding: EdgeInsets.only(
                    left: 19.w,
                    right: 19.w,
                  ),
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext, index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 21.w, top: 6, bottom: 7, right: 9.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.03.w),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                  offset: Offset(5, 6)),
                            ],
                            border: Border.all(
                                color: Colors.black.withOpacity(0.07)),
                            borderRadius: BorderRadius.circular(7.w),
                          ),
                          // padding: EdgeInsets.only(
                          //     top: 6.w, bottom: 7.w, right: 9.w, left: 21.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/sprite.png",
                                width: 28.w,
                                height: 61.h,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Coca Cola",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                              color: Black1),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    Text(
                                      "500ml, 250ml",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                          color: Grey),
                                    )
                                  ],
                                ),
                              ),
                              Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                side: MaterialStateBorderSide.resolveWith(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.selected)) {
                                      return BorderSide(
                                          width: 1, color: SplashText);
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
                        SizedBox(
                          height: 15.w,
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ));
  }
}
