import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/const/color.dart';

class DocumentsUpload extends StatefulWidget {
  DocumentsUpload({super.key});

  @override
  State<DocumentsUpload> createState() => _DocumentsUploadState();
  // String dropdownValue = 'Dog';
}

class _DocumentsUploadState extends State<DocumentsUpload> {
  @override
  Widget build(BuildContext context) {
    // var dropdownValue;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false, // hides default back button

          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: kstatusbar,
            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          toolbarHeight: 65,
          // backgroundColor: kappbar,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "KYC Verification Details",
            style: GoogleFonts.dmSans(
              textStyle: const TextStyle(
                  color: Black,
                  letterSpacing: .5,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  colors: <Color>[
                    kstatusbar.withOpacity(0.55),
                    kstatusbar.withOpacity(0.98),
                  ]),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Please provide all required details to\nregister your business with us",
                style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                      color: Black,
                      letterSpacing: .5,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 180,
                      width: 180,

                      // You can set width of container here
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kgrey),
                        borderRadius: BorderRadius.circular(8
                            // topLeft: Radius.circular(15),
                            // bottomLeft: Radius.circular(15),
                            ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf', 'doc'],
                              );
                              print(result?.files.first.name);
                              var fileName = result?.files.first.name ??
                                  "no file selected";
                            },
                            child: Image.asset(
                              "assets/images/imageupload.png",
                              scale: 3,
                              // width: 300,
                              // height: 15,
                              // fit: BoxFit.fill
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "    Upload\nADHAR Card",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: kgrey,
                                  letterSpacing: .5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 180,
                      width: 180,
                      // You can set width of container here
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kgrey),
                        borderRadius: BorderRadius.circular(8
                            // topLeft: Radius.circular(15),
                            // bottomLeft: Radius.circular(15),
                            ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf', 'doc'],
                              );
                              print(result?.files.first.name);
                              var fileName = result?.files.first.name ??
                                  "no file selected";
                            },
                            child: Image.asset(
                              "assets/images/imageupload.png",
                              scale: 3,
                              // width: 300,
                              // height: 15,
                              // fit: BoxFit.fill
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "  Upload\nPAN Card",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: kgrey,
                                  letterSpacing: .5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: 10.w,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 180,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,

                        border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: kgrey,
                            // width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8

                              // topLeft: Radius.circular(15),
                              // bottomLeft: Radius.circular(15),
                              ),
                        ),
                        // labelText: 'Name',
                        hintText: 'Aadhar Card No.',
                        hintStyle: TextStyle(
                            color: kgrey,
                            letterSpacing: .5,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  // SizedBox(width: 18.w),
                  SizedBox(
                    width: 180,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8
                              // topLeft: Radius.circular(15),
                              // bottomLeft: Radius.circular(15),
                              ),
                          // borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: kgrey,
                            // width: 1,
                          ),
                        ),
                        // labelText: 'Name',
                        hintText: 'PAN Card No.',
                        hintStyle: TextStyle(
                            color: kgrey,
                            letterSpacing: .5,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: AspectRatio(
                      aspectRatio: 0.61,
                      child: Image.asset(
                        'assets/images/splash2.png',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 340, left: 12, right: 12),
                    child: Container(
                      height: 300,
                      width: 400,
                      // You can set width of container here
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kgrey),
                        borderRadius: BorderRadius.circular(8
                            // topLeft: Radius.circular(15),
                            // bottomLeft: Radius.circular(15),
                            ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf', 'doc'],
                              );
                              print(result?.files.first.name);
                              var fileName = result?.files.first.name ??
                                  "no file selected";
                            },
                            child: Image.asset(
                              "assets/images/imageupload.png",
                              scale: 3,
                              // width: 300,
                              // height: 15,
                              // fit: BoxFit.fill
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Upload Shop Act Licence",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: kgrey,
                                  letterSpacing: .5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 90, right: 8, left: 8),
                    child: SizedBox(
                      width: 400, // <-- Your width
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
                        onPressed: () {},
                        child: Text(
                          'Upload Documents',
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
            )
          ]),
        ));
  }
}
