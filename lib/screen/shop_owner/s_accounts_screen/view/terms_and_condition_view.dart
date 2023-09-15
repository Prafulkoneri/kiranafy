import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:local_supper_market/screen/customer/about_us/controller/cms_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_cms_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TermsAndConditionView extends StatefulWidget {
  const TermsAndConditionView({Key? key}) : super(key: key);

  @override
  _TermsAndConditionViewState createState() => _TermsAndConditionViewState();
}

class _TermsAndConditionViewState extends State<TermsAndConditionView> {
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
          title: "Terms & Conditions",
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SMainScreenView(
                      index: 4, screenName: SAccountCmsPagesView())),
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
                watch.termsAndCondition?.description ?? "",
              ))),
    );
  }
}
