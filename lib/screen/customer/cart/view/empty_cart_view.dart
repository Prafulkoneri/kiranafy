// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
//
// class EmptyCartView extends StatelessWidget {
//   const EmptyCartView({super.key});
//
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
//         toolbarHeight: 60,
//         // backgroundColor: kappbar,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           "Cart",
//           style: GoogleFonts.dmSans(
//             textStyle: TextStyle(
//                 color: Black,
//                 letterSpacing: .5,
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
//       backgroundColor: backgroundColor,
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.only(top: 120.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             // mainAxisAlignment: MainAxisAlignment.center,/
//             children: [
//               Image.asset(
//                 "assets/images/emptycart.png",
//                 height: 151.h,
//                 width: 151.w,
//               ),
//               Text(
//                 "Your Cart is Empty",
//                 style: GoogleFonts.dmSans(
//                   textStyle: TextStyle(
//                       color: Black1,
//                       letterSpacing: .5,
//                       fontSize: 18.sp,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: 20.w, right: 20.w, top: 15.w, bottom: 50.w),
//                 child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Looks like you have not added anything to your",
//                       style: GoogleFonts.dmSans(
//                         textStyle: TextStyle(
//                             color: Black1,
//                             letterSpacing: .5,
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                     Text(
//                       "cart. Go ahead explore top categories",
//                       style: GoogleFonts.dmSans(
//                         textStyle: TextStyle(
//                             color: Black1,
//                             letterSpacing: .5,
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: 160.w, // <-- Your width
//                 height: 45.h,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: SplashText,
//                     // onPrimary: Colors.white,
//                     // shadowColor: Colors.greenAccent,
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14.0)),
//                     minimumSize: const Size(100, 40), //////// HERE
//                   ),
//                   // style: style,
//                   onPressed: () {},
//                   child: Text(
//                     'Browse Products',
//                     style: GoogleFonts.dmSans(
//                       textStyle: const TextStyle(
//                           // color: SplashTex
//                           letterSpacing: .5,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
