import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:local_supper_market/screen/customer/about_us/controller/cms_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_cms_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutScreenView extends StatefulWidget {
  const AboutScreenView({Key? key}) : super(key: key);

  @override
  _AboutScreenViewState createState() => _AboutScreenViewState();
}

class _AboutScreenViewState extends State<AboutScreenView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<CmsController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<CmsController>();
    final readMain = context.read<SMainScreenController>();
    final watch = context.watch<CmsController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "About Us",
          onBackBtnPressed: () {
            readMain.onNavigation(4, const SAccountCmsPagesView(), context);
            readMain.showBottomNavigationBar();
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => SMainScreenView(
            //           index: 4, screenName: SAccountCmsPagesView())),
            //   (Route<dynamic> route) => false,
            // );
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: ()async{
          readMain.onNavigation(4, const SAccountCmsPagesView(), context);
          readMain.showBottomNavigationBar();
          return false;
        },
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
                padding: EdgeInsets.all(20.w),
                child: HtmlWidget(
                  watch.aboutUs?.description ?? "",
                ))),
      ),
    );
  }
}
