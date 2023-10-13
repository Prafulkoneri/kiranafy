import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/controller/shop_sign_in_controller.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
// import 'package:telephony/telephony.dart';

class OtpShopBottomSheetView extends StatefulWidget {
  const OtpShopBottomSheetView({Key? key}) : super(key: key);

  @override
  _OtpShopBottomSheetViewState createState() => _OtpShopBottomSheetViewState();
}

class _OtpShopBottomSheetViewState extends State<OtpShopBottomSheetView> {
  // Telephony telephony = Telephony.instance;
  OtpFieldController otpboxshop = OtpFieldController();
  @override
  void initState() {
    // if(Platform.isAndroid) {
    //   telephony.listenIncomingSms(
    //     onNewMessage: (SmsMessage message) {
    //       print(message.address); // +977981******67, sender nubmer
    //       print(message.body); // Your OTP code is 34567
    //       print(message.date); // 1659690242000, timestamp
    //
    //       // get the message
    //       String sms = message.body.toString();
    //       print("44444444444444444444");
    //       print(sms);
    //       print("44444444444444444444");
    //       if (message.body!.contains('lsm-0001.firebaseapp.com')) {
    //         // verify SMS is sent for OTP with sender number
    //         String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');
    //         // prase code from the OTP sms
    //         otpboxshop.set(otpcode.split(""));
    //         // split otp code to list of number
    //         // and populate to otb boxes
    //         setState(() {
    //           print("object");
    //           otpboxshop.set(otpcode.split(""));
    //           // refresh UI
    //         });
    //       } else {
    //         print("Normal message.");
    //       }
    //     },
    //     listenInBackground: false,
    //   );
    // }
    super.initState();
  }
  // @override
  // void initState() {
  //   telephony.listenIncomingSms(
  //     onNewMessage: (SmsMessage message) {
  //       print(message.address); // +977981******67, sender nubmer
  //       print(message.body); // Your OTP code is 34567
  //       print(message.date); // 1659690242000, timestamp

  //       // get the message
  //       String sms = message.body.toString();

  //       if (message.body!.contains('yourFirebaseProjectName.firebaseapp.com')) {
  //         // verify SMS is sent for OTP with sender number
  //         String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');
  //         // prase code from the OTP sms
  //         otpboxshop.set(otpcode.split(""));
  //         // split otp code to list of number
  //         // and populate to otb boxes
  //         setState(() {
  //           // refresh UI
  //         });
  //       } else {
  //         print("Normal message.");
  //       }
  //     },
  //     listenInBackground: false,
  //   );

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final read = context.read<ShopSignInController>();
    final watch = context.watch<ShopSignInController>();
    return Stack(
      children: [
        Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.white),
          child: Material(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                // height: 335,
                child: Padding(
                  padding: EdgeInsets.all(25.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          "We have sent SMS to :\n ${watch.mobController.text.isNotEmpty ? watch.mobController.text.substring(0, 3) : ""} XXX XX XX",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: Black,
                                letterSpacing: .5,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      OTPTextField(
                        outlineBorderRadius: 10,
                        controller: otpboxshop,
                        length: 6,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 50,
                        style: TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.underline,
                        onChanged: (String code) {
                          print(code);
                          //handle validation or checks here
                        },
                        onCompleted: (String verificationCode) {
                          print(verificationCode);
                          read.onOtpEntered(verificationCode);
                        },
                      ),
                      // OTPTextField(
                      //   outlineBorderRadius: 10,
                      //   controller: otpbox,
                      //   length: 6,
                      //   width: MediaQuery.of(context).size.width,
                      //   fieldWidth: 50,
                      //   style: TextStyle(fontSize: 17),
                      //   textFieldAlignment: MainAxisAlignment.spaceAround,
                      //   fieldStyle: FieldStyle.underline,
                      //   onChanged: (String code) {
                      //     print(code);
                      //     //handle validation or checks here
                      //   },
                      //   onCompleted: (String verificationCode) {
                      //     print(verificationCode);
                      //     read.onOtpEntered(verificationCode);
                      //   },
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 400,
                        // <-- Your width
                        height: 60,
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
                            read.onCodeVerification(context);
                          },
                          child: Text(
                            'Submit',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  // color: SplashTex
                                  // letterSpacing: .5,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await read.onLoginClick(context);
                            },
                            child: Text(
                              'Resend OTP',
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                    // color: SplashTex
                                    // letterSpacing: .5,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: watch.isOtpErrorVisible,
              child: Container(
                padding: EdgeInsets.only(
                    top: 15.w, bottom: 15.w, left: 10.w, right: 10.w),
                margin: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
                color: Colors.red,
                width: ScreenUtil().screenWidth,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Invalid OTP",
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            read.onOtpDismiss();
                          },
                          child: Text(
                            "Dismiss",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            )),
      ],
    );
  }
}
