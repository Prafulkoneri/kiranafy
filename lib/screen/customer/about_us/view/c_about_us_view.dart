// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_supper_market/screen/customer/about_us/controller/cms_controller.dart';
// import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
// import 'package:provider/provider.dart';

// import '../../../../const/color.dart';
// import '../../../../widget/app_bar.dart';

// class CAboutUsView extends StatefulWidget {
//   @override
//   State<CAboutUsView> createState() => _CAboutUsViewState();
// }

// class _CAboutUsViewState extends State<CAboutUsView> {
//   @override
//   Widget build(BuildContext context) {
//     final watch = context.watch<CmsController>();
//     final read = context.read<CmsController>();
//     final readMain = context.read<MainScreenController>();
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(66.w),
//         child: PrimaryAppBar(
//           title: "About Us",
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
//                 "Massa odio turpis diam dui porta turpis. Fermentum dignissim proirn in nisl. Sit amet aliquam ullamcorper sed aliquam volutpat. Suscipit sem ullamcor",
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
//               SizedBox(
//                 height: 40.w,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "2. Testmonial Review",
//                   style: GoogleFonts.poppins(
//                     textStyle: TextStyle(
//                         color: Black,
//                         fontSize: 13.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.w,
//               ),
//               Text(
//                 "Varius nisi facilisis ultrices neque lacinia aliquet aenean",
//                 style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       color: Black,
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               Text(
//                 "at. Eros id quam facilisi dolor. Viverra felis vivamus et\neget tempus.",
//                 style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       color: Black,
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               SizedBox(
//                 height: 40.w,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Container(
//                   child: Text(
//                     "3. Our working Process",
//                     style: GoogleFonts.poppins(
//                       textStyle: TextStyle(
//                           color: Black,
//                           fontSize: 13.sp,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.w,
//               ),
//               Text(
//                 "per praesent fusce arcu placerat mi purus felis. Purus viverra ipsum tempor morbi tincidunt ullamcorper. Varius nisi facilisis ultrices neque lacinia aliquet aenean",
//                 style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       color: Black,
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               Text(
//                 "at. Eros id quam facilisi dolor. Viverra felis vivamus et \neget tempus.",
//                 style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       color: Black,
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//               SizedBox(
//                 height: 20.w,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// import 'package:flutter_html/flutter_html.dart';
import 'package:local_supper_market/screen/customer/about_us/controller/cms_controller.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_cms_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class CAboutUsView extends StatefulWidget {
  const CAboutUsView({Key? key}) : super(key: key);

  @override
  _CAboutUsViewState createState() => _CAboutUsViewState();
}

class _CAboutUsViewState extends State<CAboutUsView> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CmsController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<CmsController>();
    final watch = context.watch<CmsController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "About Us",
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreenView(
                      index: 4, screenName: ProfileScreenView())),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
              padding: EdgeInsets.all(20.w),
              child: HtmlWidget(
                watch.aboutUs?.description ?? "",
              ))),
    );
  }
}
