import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/controller/s_kyc_verrification_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class SKycVerificationView extends StatefulWidget {
  SKycVerificationView({super.key});

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
          preferredSize: Size.fromHeight(66.w),
          child: PrimaryAppBar(title: "KYC Verification Details"),
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
            Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
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
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            Expanded(
                              child: GestureDetector(
                                  onTap: () async {
                                    // read.pickFile();
                                    read.pickPDF();
                                  },
                                  child:
                                      // watch.fileName.isNotEmpty
                                      //     ?

                                      Container(
                                          height: 160.h,
                                          width: 160.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: kgrey, width: 0.3.w),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                              child: Text(
                                            watch.fileName ?? "",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: Black,
                                                  letterSpacing: .5,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )))
                                  //  Container(
                                  //     padding: EdgeInsets.only(
                                  //       top: 49.2,
                                  //       bottom: 13.w,
                                  //     ),

                                  //     // You can set width of container here
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.white,
                                  //       border: Border.all(
                                  //           color: kgrey, width: 0.3.w),
                                  //       borderRadius: BorderRadius.circular(8
                                  //           // topLeft: Radius.circular(15),
                                  //           // bottomLeft: Radius.circular(15),
                                  //           ),
                                  //     ),
                                  //     child: Column(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.end,
                                  //       children: [
                                  //         Container(
                                  //           child: PDFView(
                                  //             filePath: watch.pdfPath,
                                  //           ),
                                  //         ),
                                  //         SizedBox(
                                  //           height: 15.w,
                                  //         ),
                                  //         Column(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.end,
                                  //           children: [
                                  //             Text(
                                  //               "Upload\nPan Card",
                                  //               textAlign: TextAlign.center,
                                  //               style: GoogleFonts.dmSans(
                                  //                 textStyle: TextStyle(
                                  //                     color: kgrey,
                                  //                     letterSpacing: .5,
                                  //                     fontSize: 16,
                                  //                     fontWeight:
                                  //                         FontWeight.w400),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {},
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 49.2,
                                    bottom: 13.w,
                                  ),

                                  // You can set width of container here
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: kgrey, width: 0.3.w),
                                    borderRadius: BorderRadius.circular(8
                                        // topLeft: Radius.circular(15),
                                        // bottomLeft: Radius.circular(15),
                                        ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/images/imageupload.png",
                                          width: 31.33.w,
                                          height: 39.17.w,
                                          // width: 300,
                                          // height: 15,
                                          // fit: BoxFit.fill
                                        ),
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
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                          SizedBox(
                            height: 10.w,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: PrimarySTextFormField(
                                hintText: "Aadhar Card No.",
                                hintFontSize: 12.sp,
                              )),
                              SizedBox(
                                width: 20.w,
                              ),
                              // SizedBox(width: 18.w),
                              Expanded(
                                  child: PrimarySTextFormField(
                                hintText: "PAN Card No",
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
                                onTap: () async {},
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 49.2,
                                    bottom: 13.w,
                                  ),

                                  // You can set width of container here
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: kgrey, width: 0.3.w),
                                    borderRadius: BorderRadius.circular(8
                                        // topLeft: Radius.circular(15),
                                        // bottomLeft: Radius.circular(15),
                                        ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/images/imageupload.png",
                                          width: 31.33.w,
                                          height: 39.17.w,
                                          // width: 300,
                                          // height: 15,
                                          // fit: BoxFit.fill
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Upload\nShop Act",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: kgrey,
                                                  letterSpacing: .5,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Text(
                                            "(Optional)",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffB7B7B7)),
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
                                onTap: () async {},
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 49.2,
                                    bottom: 13.w,
                                  ),

                                  // You can set width of container here
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: kgrey, width: 0.3.w),
                                    borderRadius: BorderRadius.circular(8
                                        // topLeft: Radius.circular(15),
                                        // bottomLeft: Radius.circular(15),
                                        ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/images/imageupload.png",
                                          width: 31.33.w,
                                          height: 39.17.w,
                                          // width: 300,
                                          // height: 15,
                                          // fit: BoxFit.fill
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Upload\nGST Document",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: kgrey,
                                                  letterSpacing: .5,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.w,
                                          ),
                                          Text(
                                            "(Optional)",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffB7B7B7)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                          SizedBox(
                            height: 10.w,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: PrimarySTextFormField(
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
                                color: Color(0xff8C8C8C)),
                          ),
                        ]),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: PrimaryButton(
                      height: 45.w,
                      fontSize: 20.sp,
                      text: "Upload Documents",
                      color: Color(0xff4689EC),
                      onTap: () {
                        read.onUploadClicked(context);
                      }),
                ),
                SizedBox(
                  height: 20.w,
                ),
              ],
            ),
          ],
        ));
  }
}
