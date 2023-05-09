import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_registration_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';

import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class ShopRegistrationView extends StatefulWidget {
  ShopRegistrationView({super.key});

  @override
  State<ShopRegistrationView> createState() => _ShopRegistrationViewState();
// String dropdownValue = 'Dog';
}

class _ShopRegistrationViewState extends State<ShopRegistrationView> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopRegistrationController>();
    final watch = context.watch<ShopRegistrationController>();
    // var dropdownValue;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.w),
          child: PrimaryAppBar(title: "Shop Registration"),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -30.w,
              left: 0.w,
              child: Image.asset(
                "assets/images/splash1.png",
                height: 235.w,
                width: 361.w,
              ),
            ),
            Positioned(
              bottom: -25.w,
              right: 0.w,
              child: Image.asset(
                "assets/images/splash2.png",
                height: 235.w,
                width: 361.w,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 24.w, right: 24.w, top: 20.w, bottom: 20.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please provide all required details to\nregister your business with us",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: Black,
                              letterSpacing: .5,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      PrimarySTextFormField(
                        hintText: "Shop Name",
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      PrimarySTextFormField(
                        hintText: "Owner Name",
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      SDropDownField(
                        hint: "Shop Type",
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      // MobileNoTextFormField(
                      //   controller: watch.mobController,
                      //   enableOrder: true,
                      // ),
                      MobileNoTextFormField(controller: watch.mobController,enableOrder: true,),
                      SizedBox(
                        height: 18.w,
                      ),
                      PrimarySTextFormField(
                        hintText: "Email ID",
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: SDropDownField(
                            hint: "Country",
                          )),
                          SizedBox(
                            width: 13.w,
                          ),
                          Expanded(
                              child: SDropDownField(
                            hint: "State",
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      SDropDownField(
                        hint: "City",
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      Container(
                        child: PrimarySTextFormField(
                          height: 108.w,
                          maxLines: 5,
                          hintText: "Address",
                        ),
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      PrimarySTextFormField(
                        hintText: "Pincode",
                      ),
                      SizedBox(
                        height: 18.w,
                      ),
                      PrimarySTextFormField(
                        hintText: "UPI",
                      ),
                      SizedBox(
                        height: 3.w,
                      ),
                      Row(
                        children: [
                          Text(
                            "This UPI ID will be used for payment from customers.",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xff3A3A3A),
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 36.w,
                      ),
                      TextButton(
                          child: RichText(
                            text: TextSpan(
                                text: "By continuing you agree to our\n",
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: Black,
                                      height: 1.3.w,
                                      // letterSpacing: .5,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Term of Condition',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: SplashText1,
                                          // letterSpacing: .5,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' and',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: Black,
                                          // letterSpacing: .5,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Privacy Policy',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: SplashText1,
                                          // letterSpacing: .5,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ]),
                          ),
                          onPressed: () {}),
                      SizedBox(
                        height: 12.w,
                      ),
                      PrimaryButton(
                        fontSize: 20.sp,
                        height: 45.w,
                        text: "Next",
                        color: Color(0xff4689EC),
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                // height: 335,
                                child: Padding(
                                  padding: EdgeInsets.all(25.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Enter Verification Code",
                                        style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                              color: Custlogin,
                                              letterSpacing: .5,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.0.h),
                                        child: Text(
                                          "We have sent SMS to :\n046 XXX XX XX",
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                color: Black,
                                                letterSpacing: .5,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      OTPTextField(
                                        length: 5,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fieldWidth: 50,
                                        style: const TextStyle(fontSize: 17),
                                        textFieldAlignment:
                                            MainAxisAlignment.spaceAround,
                                        fieldStyle: FieldStyle.underline,
                                        onCompleted: (pin) {
                                          print("Completed: " + pin);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 400, // <-- Your width
                                        height: 60,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Button,
                                            // onPrimary: Colors.white,
                                            // shadowColor: Colors.greenAccent,
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        14.0)),
                                            minimumSize: const Size(
                                                100, 40), //////// HERE
                                          ),
                                          // style: style,
                                          onPressed: () {
                                            read.onOtpSubmitBtnPressed(context);
                                          },
                                          child: Text(
                                            'Submit',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                  // color: SplashTex
                                                  letterSpacing: .5,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Resend OTP',
                                            style: GoogleFonts.dmSans(
                                              textStyle: const TextStyle(
                                                  // color: SplashTex
                                                  letterSpacing: .5,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ]),
              ),
            ),
          ],
        ));
  }
}
