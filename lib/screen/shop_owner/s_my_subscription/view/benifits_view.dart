// import 'package:flutter/material.dart';
// import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/const/color.dart';
// // import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

// class Example extends StatefulWidget {
//   @override
//   _ExampleState createState() => _ExampleState();
// }

// class _ExampleState extends State<Example> {
//   // Controller
//   late ExpandedTileController _controller;

//   void initState() {
//     // initialize controller
//     _controller = ExpandedTileController(isExpanded: true);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         // padding: EdgeInsets.all(100),
//         child: Column(
//           children: [
//             ExpandedTileList.builder(
//               itemCount: 1,
//               maxOpened: 1,
//               reverse: true,
//               itemBuilder: (context, index, controller) {
//                 return ExpandedTile(
//                   // title: Container(),
//                   theme: const ExpandedTileThemeData(
//                     headerRadius: 24.0,
//                     headerPadding: EdgeInsets.all(24.0),
//                     headerSplashColor: Colors.white,
//                     contentBackgroundColor: Colors.white,
//                     contentPadding: EdgeInsets.all(24.0),
//                     contentRadius: 12.0,
//                   ),
//                   controller: index == 1
//                       ? controller.copyWith(isExpanded: true)
//                       : controller,
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Show More",
//                         style: GoogleFonts.dmSans(
//                           textStyle: TextStyle(
//                               color: Grey,
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       SvgPicture.asset("assets/icons/dropdown.svg")
//                     ],
//                   ),
//                   onTap: () {
//                     print(
//                       "heloo",
//                     );
//                   },
//                   trailing: Container(),
//                   content: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.circle_rounded,
//                                 size: 5.w,
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 "Order management",
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.dmSans(
//                                   textStyle: TextStyle(
//                                       color: Black1,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.w400),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               SvgPicture.asset("assets/icons/correct.svg")
//                             ],
//                           )
//                         ],
//                       ),
//                       // TextButton(
//                       //   onPressed: () {
//                       //     controller.collapse();
//                       //   },
//                       //   child: Text("close it!"),
//                       // )
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
