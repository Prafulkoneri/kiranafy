// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';

// class AdvertisementForm extends StatefulWidget {
//   const AdvertisementForm({super.key});

//   @override
//   State<AdvertisementForm> createState() => _AdvertisementFormState();
// }

// class _AdvertisementFormState extends State<AdvertisementForm> {
//   String? gender; //no radio button will be selected

//   // final List<String> genderItems = [];
//   // bool checkedValue = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         systemOverlayStyle: SystemUiOverlayStyle(
//           systemNavigationBarIconBrightness: Brightness.dark,
//           // Status bar color
//           statusBarColor: kstatusbar,
//           // Status bar brightness (optional)
//           statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
//           statusBarBrightness: Brightness.dark, // For iOS (dark icons)
//         ),
//         toolbarHeight: 65,
//         // backgroundColor: kappbar,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           "Advertisement Request form",
//           style: GoogleFonts.dmSans(
//             textStyle: TextStyle(
//                 color: DarkBlack,
//                 // letterSpacing: .5,
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w700),
//           ),
//         ),
//         centerTitle: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(40),
//           ),
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(40),
//             gradient: LinearGradient(
//                 end: Alignment.topCenter,
//                 begin: Alignment.bottomCenter,
//                 colors: <Color>[
//                   kstatusbar.withOpacity(0.55),
//                   kstatusbar.withOpacity(0.98),
//                 ]),
//           ),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding:
//             EdgeInsets.only(top: 20.w, left: 19.w, right: 19.w, bottom: 22.w),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Name",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: Black1,
//                       // letterSpacing: .5,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               SizedBox(
//                 height: 48.h,
//                 width: 352.w,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     // border: OutlineInputBorder(
//                     //   borderRadius: BorderRadius.circular(10.0),
//                     // ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         width: 0,
//                         style: BorderStyle.none,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 1, color: Grey),
//                       borderRadius: BorderRadius.circular(10.0),

//                       //<-- SEE HERE
//                     ),
//                     filled: true,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Text(
//                 "Contact No",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: Black1,
//                       // letterSpacing: .5,/
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               SizedBox(
//                 height: 48.h,
//                 width: 352.w,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     // border: OutlineInputBorder(
//                     //   borderRadius: BorderRadius.circular(10.0),
//                     // ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         width: 0,
//                         style: BorderStyle.none,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 1, color: Grey),
//                       borderRadius: BorderRadius.circular(10.0),

//                       //<-- SEE HERE
//                     ),
//                     filled: true,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Text(
//                 "Your Shop Name",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: Black1,
//                       // letterSpacing: .5,//
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               SizedBox(
//                 height: 48.h,
//                 width: 352.w,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     // border: OutlineInputBorder(
//                     //   borderRadius: BorderRadius.circular(10.0),
//                     // ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         width: 0,
//                         style: BorderStyle.none,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 1, color: Grey),
//                       borderRadius: BorderRadius.circular(10.0),

//                       //<-- SEE HERE
//                     ),
//                     filled: true,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Text(
//                 "Plan for Start",
//                 style: GoogleFonts.dmSans(
//                   textStyle: const TextStyle(
//                       color: Black,
//                       // letterSpacing: .5,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               SizedBox(
//                 height: 48.h,
//                 width: 352.w,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     suffixIcon: Padding(
//                       padding:
//                           EdgeInsets.only(right: 16.w, top: 16.w, bottom: 16.w),
//                       child: SvgPicture.asset(
//                         'assets/icons/calendar1.svg',
//                         width: 20.w,
//                         height: 30.h,
//                       ),
//                     ),
//                     fillColor: Colors.white,
//                     // border: OutlineInputBorder(
//                     //   borderRadius: BorderRadius.circular(10.0),
//                     // ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         width: 0,
//                         style: BorderStyle.none,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 1, color: Grey),
//                       borderRadius: BorderRadius.circular(10.0),

//                       //<-- SEE HERE
//                     ),
//                     filled: true,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 30.w),
//                 child: Text(
//                   "Ads Plan",
//                   style: GoogleFonts.dmSans(
//                     textStyle: const TextStyle(
//                         color: Black,
//                         letterSpacing: .5,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//               Column(
//                 children: [
//                   RadioListTile(
//                     activeColor: SplashText,
//                     title: Text(
//                       "7 days",
//                       style: GoogleFonts.dmSans(
//                         textStyle: const TextStyle(
//                             color: Black,
//                             // letterSpacing: .5,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                     value: "7 days",
//                     groupValue: gender,
//                     onChanged: (value) {
//                       setState(() {
//                         gender = value.toString();
//                       });
//                     },
//                   ),
//                   RadioListTile(
//                     title: Text(
//                       "15 days",
//                       style: GoogleFonts.dmSans(
//                         textStyle: const TextStyle(
//                             color: Black,
//                             // letterSpacing: .5,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                     activeColor: SplashText,
//                     value: "15 days",
//                     groupValue: gender,
//                     onChanged: (value) {
//                       setState(() {
//                         gender = value.toString();
//                       });
//                     },
//                   ),
//                   RadioListTile(
//                     title: Text(
//                       "30 days",
//                       style: GoogleFonts.dmSans(
//                         textStyle: const TextStyle(
//                             color: Black,
//                             // letterSpacing: .5,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                     activeColor: SplashText,
//                     value: "30 days",
//                     groupValue: gender,
//                     onChanged: (value) {
//                       setState(() {
//                         gender = value.toString();
//                       });
//                     },
//                   ),
//                   RadioListTile(
//                     title: Text(
//                       "60 days",
//                       style: GoogleFonts.dmSans(
//                         textStyle: const TextStyle(
//                             color: Black,
//                             // letterSpacing: .5,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                     activeColor: SplashText,
//                     value: "60 days",
//                     groupValue: gender,
//                     onChanged: (value) {
//                       setState(() {
//                         gender = value.toString();
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
//                 child: Text(
//                   "Ads Content",
//                   style: GoogleFonts.dmSans(
//                     textStyle: TextStyle(
//                         color: Black1,
//                         // letterSpacing: .5,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
// SizedBox(
//   // height: 200.h,
//   child: TextField(
//     decoration: InputDecoration(
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(width: 1, color: Grey),
//         borderRadius: BorderRadius.circular(10.0),

//         //<-- SEE HERE
//       ),

//       contentPadding:
//           EdgeInsets.symmetric(vertical: 80.w), // <-- SEE HERE

//       fillColor: Colors.white,
//       // border: OutlineInputBorder(
//       //   borderRadius: BorderRadius.circular(10.0),
//       //   borderSide: BorderSide(width: 100, color: grey6
//       //       // style: BorderStyle.none,
//       //       ),
//       // ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: const BorderSide(
//           width: 0,
//           style: BorderStyle.none,
//         ),
//       ),
//       // enabledBorder: OutlineInputBorder(
//       //   borderSide:
//       //       BorderSide(width: 1, color: grey6), //<-- SEE HERE
//       //   borderRadius: BorderRadius.circular(10.0),
//       // ),
//       filled: true,
//     ),
//   ),
// ),
// Padding(
//   padding: EdgeInsets.only(top: 20.w),
//   child: SizedBox(
//     width: 343.w, // <-- Your width
//     height: 45.h,
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         primary: Button,
//         // onPrimary: Colors.white,
//         // shadowColor: Colors.greenAccent,
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14.0)),
//         minimumSize: const Size(100, 40), //////// HERE
//       ),
//       // style: style,
//       onPressed: () {},
//       child: Text(
//         'Submit',
//         style: GoogleFonts.dmSans(
//           textStyle: TextStyle(
//               color: Colors.white,
//               // letterSpacing: .5,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w700),
//         ),
//       ),
//     ),
//   ),
// ),
//               Padding(
//                 padding: EdgeInsets.only(top: 30.w),
//                 child: Text(
//                   "Note",
//                   style: GoogleFonts.dmSans(
//                     textStyle: TextStyle(
//                         color: Black1,
//                         // letterSpacing: .5,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 6.w),
//                 child: Row(
//                   // crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                         padding: EdgeInsets.only(bottom: 20.w),
//                         child: Icon(
//                           Icons.circle_rounded,
//                           size: 5.w,
//                         )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Flexible(
//                       child: Text(
//                         // softWrap: true,
//                         // maxLines: 3,//
//                         "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sit nunc, netus ac vulputate sed",
//                         textAlign: TextAlign.justify,
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: Black1,
//                               height: 1.5,

//                               // letterSpacing: .05,
//                               // overflow: TextOverflow.ellipsis,
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 6.w, top: 5.w),
//                 child: Row(
//                   children: [
//                     Padding(
//                         padding: EdgeInsets.only(bottom: 0.w),
//                         child: Icon(
//                           Icons.circle_rounded,
//                           size: 5.w,
//                         )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       "Lorem ipsum dolor sit amet, consectetur",
//                       style: GoogleFonts.dmSans(
//                         textStyle: TextStyle(
//                             height: 1.5,
//                             color: Black1,
//                             letterSpacing: .5,
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 6.w, top: 5.w),
//                 child: Row(
//                   children: [
//                     Padding(
//                         padding: EdgeInsets.only(bottom: 0.w),
//                         child: Icon(
//                           Icons.circle_rounded,
//                           size: 5.w,
//                         )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       "Lorem ipsum dolor sit amet, consectetur",
//                       style: GoogleFonts.dmSans(
//                         textStyle: TextStyle(
//                             height: 1.5,
//                             color: Black1,
//                             letterSpacing: .5,
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';

class AdvertisementForm extends StatefulWidget {
  const AdvertisementForm({super.key});

  @override
  State<AdvertisementForm> createState() => _AdvertisementFormState();
}

class _AdvertisementFormState extends State<AdvertisementForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(title: "Promotion Request form"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Promotion Subject",
                    // hintText: "Enter Name of the Bank",
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Plan for Start",
                    // hintText: "Delivery Charge",
                    suffix: Container(
                      padding: EdgeInsets.only(right: 17.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/shop_cal.svg",
                            // width: 5.h,
                            // height: 5.w,
                          ),
                        ],
                      ),
                    ),
                    // hintFontSize: 15.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
