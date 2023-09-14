// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
// import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
//
// import '../../../../const/color.dart';
// import '../../../../widget/app_bar.dart';
// import 'package:provider/provider.dart';
//
// class CPriacyPolicyView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final readMain=context.read<MainScreenController>();
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.w),
//         child: PrimaryAppBar(
//           onBackBtnPressed: (){
//             // Navigator.pop(context);
//             // readMain.onNavigation(4, ProfileScreenView(
//             //   isRefreshed: false,
//             //   // refresh: false,
//             // ), context);
//           },
//           title: "Privacy Policy",
//           onActionTap: () {},
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(left: 19.w, right: 19.0.w, top: 20.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Massa odio turpis diam dui porta turpis.Fermentum dignissim proirn in nisl. Sit amet aliquam ullamcorper sed aliquam volutpat. Suscipit sem ullamcor",
//                 style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       color: Black,
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//               SizedBox(
//                 height: 18.w,
//               ),
//               Text(
//                 "per praesent fusce arcu placerat mi purus felis. Purus viverra ipsum tempor morbi tincidunt ullamcorper. Varius nisi facilisis ultrices neque lacinia aliquet aenean.",
//                 style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       color: Black,
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               SizedBox(
//                 height: 5.w,
//               ),
//               Text(
//                 "at. Eros id quam facilisi dolor. Viverra felis vivamus et eget tempus.",
//                 style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       color: Black,
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               SizedBox(
//                 height: 20.w,
//               ),
//               Text(
//                 "Risus eu hac sed elit velit accumsan. Tempor, ullamcorper nisi fermentum ipsum. Amet, lacinia tincidunt facilisis eget fringilla sed. Turpis dictumst ridiculus velit at sodales. Ornare enim tempus hendrerit.Turpis dictumst ridiculus velit at sodales. Ornare enim tempus hendrerit . ridiculus velit at sodales. Ornare enim tempus hendrerit",
//                 style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       color: Black,
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
