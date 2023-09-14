// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:local_supper_market/const/color.dart';
// import 'package:local_supper_market/screen/customer/account/controller/profile_controller.dart';
// import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
// import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
// import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/cms_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/s_account_screen_controller.dart';
// import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_cms_view.dart';
// import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
// import 'package:local_supper_market/widget/app_bar.dart';
// import 'package:provider/provider.dart';

// class CustomerFAQView extends StatefulWidget {
//   const CustomerFAQView({super.key});

//   @override
//   State<CustomerFAQView> createState() => _CustomerFAQViewState();
// }

// class _CustomerFAQViewState extends State<CustomerFAQView> {
//   @override
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       context.read<ProfileController>().initState(context);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final read = context.read<ProfileController>();
//     final watch = context.watch<ProfileController>();
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.w),
//         child: PrimaryAppBar(
//           title: "FAQ",
//           onBackBtnPressed: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => MainScreenView(
//                       index: 4, screenName: ProfileScreenView())),
//               (Route<dynamic> route) => false,
//             );
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Container(
//           padding: EdgeInsets.only(
//             left: 20,
//             right: 20,
//             top: 10.w,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 15,
//               ),
//               ListView.builder(
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   itemCount:
//                   // 2,
//                    watch.customerfaqdataList?.length ?? 0,
//                   itemBuilder: (context, index) {
//                     final element = watch.customerfaqdataList?[index];
//                     return Container(
//                       margin: EdgeInsets.only(bottom: 10.w),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(22),
//                         // color: watch.isFaqExpanded[index]
//                         //     ? Color(0xff44B8CA)
//                         //     : Colors.white,
//                       ),
//                       width: MediaQuery.of(context).size.width,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Theme(
//                             data: ThemeData(
//                               dividerColor: Colors.white,
//                             ),
//                             child: ExpansionTile(
//                               // key: Key(index.),
//                               // initiallyExpanded:
//                               //     // watch.isFaqExpanded[index] ? true : false,
//                               backgroundColor: Colors.transparent,
//                               onExpansionChanged: (value) {
//                                 // read.onChangeExpansion(value, index);
//                                 print(value);
//                               },
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_down_rounded,
//                                 // color: watch.isFaqExpanded[index]
//                                 //     ? Colors.white
//                                 //     : Colors.black,
//                               ),
//                               tilePadding: EdgeInsets.only(
//                                   left: 10, right: 10, bottom: 0),
//                               title: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Flexible(
//                                     child: Text(
//                                       "erwffrgew",
//                                       // "${element?.question}",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w700,
//                                         letterSpacing: 1,
//                                         fontSize: 13,
//                                         // color: watch.isFaqExpanded[index]
//                                         //     ? Colors.white
//                                         //     : Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               children: <Widget>[
//                                 Container(
//                                   width: ScreenUtil().screenWidth,
//                                   decoration: BoxDecoration(
//                                     color: Color.fromARGB(255, 214, 251, 255),
//                                     borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(18),
//                                       bottomRight: Radius.circular(18),
//                                     ),
//                                   ),
//                                   padding: EdgeInsets.only(
//                                       top: 10.w,
//                                       bottom: 20.w,
//                                       left: 13,
//                                       right: 13),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "gfgheryhjyurt",
//                                         // "${element?.answer}",
//                                         textAlign: TextAlign.start,
//                                         style: TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.w400),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/controller/profile_controller.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/cms_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/s_account_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_cms_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

class CustomerFAQView extends StatefulWidget {
  const CustomerFAQView({super.key});

  @override
  State<CustomerFAQView> createState() => _CustomerFAQViewState();
}

class _CustomerFAQViewState extends State<CustomerFAQView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileController>().getCustomerFAQData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<ProfileController>();
    final readMain = context.read<MainScreenController>();
    final watch = context.watch<ProfileController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "FAQ",
          onBackBtnPressed: () {
            readMain.onNavigation(4, ProfileScreenView(
              isRefreshed: false,
              // refresh: false,
            ), context);
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => MainScreenView(
            //           index: 4, screenName: ProfileScreenView(isRefreshed: false,))),
            //   (Route<dynamic> route) => false,
            // );
          },
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: watch.customerfaqdataList?.length ?? 0,
                        itemBuilder: (context, index) {
                          final element = watch.customerfaqdataList?[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: watch.isFaqExpanded[index]
                                  ? Color(0xff44B8CA)
                                  : Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Theme(
                                  data: ThemeData(
                                    dividerColor: Colors.white,
                                  ),
                                  child: ExpansionTile(
                                    key: Key(
                                        'builder ${watch.isFaqExpanded[index].toString()}'),
                                    initiallyExpanded:
                                        watch.isFaqExpanded[index]
                                            ? true
                                            : false,
                                    backgroundColor: Colors.transparent,
                                    onExpansionChanged: (value) {
                                      read.onChangeExpansion(value, index);
                                      print(value);
                                    },
                                    trailing: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: watch.isFaqExpanded[index]
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    tilePadding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 0),
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            // "erwffrgew",
                                            "${element?.question}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 1,
                                              fontSize: 13,
                                              color: watch.isFaqExpanded[index]
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil().screenWidth,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 214, 251, 255),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(18),
                                            bottomRight: Radius.circular(18),
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                            top: 10.w,
                                            bottom: 20.w,
                                            left: 13,
                                            right: 13),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              // "gfgheryhjyurt",
                                              "${element?.answer}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}
