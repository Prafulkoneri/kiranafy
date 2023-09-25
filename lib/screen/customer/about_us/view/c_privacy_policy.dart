import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:local_supper_market/screen/customer/about_us/controller/cms_controller.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class CustomerPrivacyPolicy extends StatefulWidget {
  const CustomerPrivacyPolicy({Key? key}) : super(key: key);

  @override
  _CustomerPrivacyPolicyState createState() => _CustomerPrivacyPolicyState();
}

class _CustomerPrivacyPolicyState extends State<CustomerPrivacyPolicy> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CmsController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<CmsController>();
    final watch = context.watch<CmsController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "Privacy Policy",
          onBackBtnPressed: () {
            readMain.onNavigation(
                4,
                const ProfileScreenView(
                  isRefreshed: false,
                  // refresh: false,
                ),
                context);
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
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : WillPopScope(
              onWillPop: () async {
                readMain.onNavigation(
                    4,
                    const ProfileScreenView(
                      isRefreshed: false,
                      // refresh: false,
                    ),
                    context);
                return false;
              },
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20, top: 20.w, bottom: 35.w),
                      child: HtmlWidget(
                        watch.privacyPolicy?.description ?? "",
                      ))),
            ),
    );
  }
}
