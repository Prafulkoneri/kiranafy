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
import 'package:local_supper_market/screen/customer/auth/upload_documents.dart';

import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class ShopRegistration extends StatefulWidget {
  ShopRegistration({super.key});

  @override
  State<ShopRegistration> createState() => _ShopRegistrationState();
  // String dropdownValue = 'Dog';
}

class _ShopRegistrationState extends State<ShopRegistration> {
  String? dropdown;
  final maxLines = 5;
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    // var dropdownValue;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          // Status bar color
          statusBarColor: kstatusbar,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        toolbarHeight: 65,
        // backgroundColor: kappbar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Shop Registration",
          style: GoogleFonts.inter(
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
            bottom: Radius.circular(40),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration: InputDecoration(
                // fillColor: Colors.white,
                // filled: true,
                border: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                // labelText: 'Name',
                hintText: ' Shop Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                // fillColor: Colors.white,
                // filled: true,
                border: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                // labelText: 'Name',
                hintText: 'Owner Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                // fillColor: Colors.white,
                // filled: true,
                border: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                // labelText: 'Name',
                hintText: ' Mobile Number',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                // fillColor: Colors.white,
                // filled: true,
                border: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                // labelText: 'Name',
                hintText: 'Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 180,
                  child: DropdownButtonFormField2(
                    decoration: const InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(15),
                          ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Country',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: genderItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 60,
                      // padding: EdgeInsets.only(left: 20, right: 10),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: DropdownButtonFormField2(
                    decoration: const InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          // borderRadius: BorderRadius.circular(15),
                          ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'State',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: genderItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 60,
                      // padding: EdgeInsets.only(left: 20, right: 10),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField2(
              decoration: const InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(15),
                    ),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: const Text(
                'City',
                style: TextStyle(fontSize: 14),
              ),
              items: genderItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select gender.';
                }
                return null;
              },
              onChanged: (value) {
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                selectedValue = value.toString();
              },
              buttonStyleData: const ButtonStyleData(
                height: 60,
                padding: EdgeInsets.only(left: 20, right: 10),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              // width: 240, // <-- TextField width
              // height: 120,
              height: maxLines * 20.0,
              child: const TextField(
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  // fillColor: Colors.white,
                  // filled: true,
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  // labelText: 'Name',
                  hintText: 'Shop Name',
                  // isDense: true, // Added this
                  // contentPadding: EdgeInsets.only(bottom: 5)
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                // fillColor: Colors.white,
                // filled: true,
                border: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                // labelText: 'Name',
                hintText: 'Pincode',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton(
                child: RichText(
                  text: TextSpan(
                      text: "By continuing you agree to our\n",
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                            color: Black,
                            // letterSpacing: .5,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      children: [
                        TextSpan(
                          text: 'Term of Condition',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: SplashText1,
                                // letterSpacing: .5,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        TextSpan(
                          text: 'and',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: Black,
                                // letterSpacing: .5,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        TextSpan(
                          text: ' Privacy Policy',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: SplashText1,
                                // letterSpacing: .5,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
                ),
                onPressed: () {}),
            SizedBox(
              height: 5,
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
                      borderRadius: BorderRadius.circular(14.0)),
                  minimumSize: const Size(100, 40), //////// HERE
                ),
                // style: style,
                onPressed: () {
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
                                width: MediaQuery.of(context).size.width,
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
                                            BorderRadius.circular(14.0)),
                                    minimumSize:
                                        const Size(100, 40), //////// HERE
                                  ),
                                  // style: style,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DocumentsUpload()),
                                    );
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
                              Padding(
                                padding: EdgeInsets.only(left: 100.h),
                                child: Text(
                                  'Resend OTP',
                                  style: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        // color: SplashTex
                                        letterSpacing: .5,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'Next',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        color: Black,
                        letterSpacing: .5,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                // Text("data")
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Login",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: Custlogin,
                          letterSpacing: .5,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
