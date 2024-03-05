import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/controller/s_kyc_verrification_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class SKycVerificationView extends StatefulWidget {
  const SKycVerificationView({super.key});

  @override
  @override
  State<SKycVerificationView> createState() => _SKycVerificationViewState();
// String dropdownValue = 'Dog';
}

class _SKycVerificationViewState extends State<SKycVerificationView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SKycVerificationController>();
    final watch = context.watch<SKycVerificationController>();
    // var dropdownValue;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            title: "KYC Verification Details",
            isBackButtonEnabled: false,
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SingleChildScrollView(
            child: Stack(
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Please provide all required details to\nregister your business with us",
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                                color: Black,
                                letterSpacing: .5,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                read.onChooseFile1();
                              },
                              child: Container(
                                height: 160.h,
                                width: 160.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: kgrey, width: 0.3.w),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: watch.fileImage1.path != ""
                                    ? Center(
                                        child: watch.image1Type == "pdf"
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/pdf_image.png",
                                                    width: 31.33.w,
                                                    height: 39.17.w,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(
                                                    height: 15.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        watch.fileName1,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: kgrey,
                                                              letterSpacing: .5,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            : Container(
                                                height: 160.h,
                                                width: 160.w,
                                                // height: 112.h,
                                                // width: 310.w,
                                                // width: ScreenUtil().screenWidth,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: grey6)),
                                                child: Image.file(
                                                  watch.fileImage1,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/imageupload.png",
                                            width: 31.33.w,
                                            height: 39.17.w,
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(
                                            height: 15.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Upload\nAadhar Card",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: kgrey,
                                                      letterSpacing: .5,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                read.onChooseFile2();
                              },
                              child: Container(
                                height: 160.h,
                                width: 160.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: kgrey, width: 0.3.w),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: watch.fileImage2.path != ""
                                    ? Center(
                                        child: watch.image2Type == "pdf"
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/pdf_image.png",
                                                    width: 31.33.w,
                                                    height: 39.17.w,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(
                                                    height: 15.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        watch.fileName2,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: kgrey,
                                                              letterSpacing: .5,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            : Container(
                                                height: 160.h,
                                                width: 160.w,
                                                // height: 112.h,
                                                // width: 310.w,
                                                // width: ScreenUtil().screenWidth,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: grey6)),
                                                child: Image.file(
                                                  watch.fileImage2,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/imageupload.png",
                                            width: 31.33.w,
                                            height: 39.17.w,
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(
                                            height: 15.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Upload\nPan Card",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: kgrey,
                                                      letterSpacing: .5,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 10.w,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: PrimarySTextFormField(
                              lengthLimitingTextInputFormatter:
                                  LengthLimitingTextInputFormatter(12),
                              textInputType: TextInputType.number,
                              controller: watch.adharCardController,
                              hintText: "Aadhar Card No.",
                              hintFontSize: 12.sp,
                            )),
                            SizedBox(
                              width: 20.w,
                            ),
                            // SizedBox(width: 18.w),
                            Expanded(
                                child: PrimarySTextFormField(
                              lengthLimitingTextInputFormatter:
                                  LengthLimitingTextInputFormatter(10),
                              controller: watch.panCardController,
                              hintText: "PAN Card No.",
                              hintFontSize: 12.sp,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                read.onChooseFile3();
                              },
                              child: Container(
                                height: 160.h,
                                width: 160.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: kgrey, width: 0.3.w),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: watch.fileImage3.path != ""
                                    ? Center(
                                        child: watch.image3Type == "pdf"
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/pdf_image.png",
                                                    width: 31.33.w,
                                                    height: 39.17.w,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(
                                                    height: 15.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        watch.fileName3,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: kgrey,
                                                              letterSpacing: .5,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            : Container(
                                                height: 160.h,
                                                width: 160.w,
                                                // height: 112.h,
                                                // width: 310.w,
                                                // width: ScreenUtil().screenWidth,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: grey6)),
                                                child: Image.file(
                                                  watch.fileImage3,
                                                  // fit: BoxFit.cover,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/imageupload.png",
                                            width: 31.33.w,
                                            height: 39.17.w,
                                          ),
                                          SizedBox(
                                            height: 15.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Upload \nShop Act\nDocument\n(Optional)",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: kgrey,
                                                      letterSpacing: .5,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                read.onChooseFile4();
                              },
                              child: Container(
                                height: 160.h,
                                width: 160.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: kgrey, width: 0.3.w),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: watch.fileImage4.path != ""
                                    ? Center(
                                        child: watch.image4Type == "pdf"
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/pdf_image.png",
                                                    width: 31.33.w,
                                                    height: 39.17.w,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(
                                                    height: 15.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        watch.fileName4,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.dmSans(
                                                          textStyle: TextStyle(
                                                              color: kgrey,
                                                              letterSpacing: .5,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            : Container(
                                                height: 160.h,
                                                width: 160.w,
                                                // height: 112.h,
                                                // width: 310.w,
                                                // width: ScreenUtil().screenWidth,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: grey6)),
                                                child: Image.file(
                                                  watch.fileImage4,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/imageupload.png",
                                            width: 31.33.w,
                                            height: 39.17.w,
                                          ),
                                          SizedBox(
                                            height: 15.w,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Upload\n GST Document\n(Optional)",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.dmSans(
                                                  textStyle: TextStyle(
                                                      color: kgrey,
                                                      letterSpacing: .5,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 10.w,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: PrimarySTextFormField(
                              lengthLimitingTextInputFormatter:
                                  LengthLimitingTextInputFormatter(15),
                              controller: watch.gstController,
                              hintFontSize: 12.sp,
                              hintText: "Enter GSTIN (Optional)",
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 3.w,
                        ),
                        Text(
                          "Accepted formats PDF/JPEG",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff8C8C8C)),
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: PrimaryButton(
                              height: 45.w,
                              // width: 45.w,
                              // fontSize: 20.sp,
                              text: "Upload Documents",
                              color: const Color(0xff4689EC),
                              onTap: () {
                                read.onUploadClicked(context);
                              }),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20.w,
                ),
              ],
            ),
          ),
        ));
  }
}
