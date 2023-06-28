import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:local_supper_market/screen/customer/about_us/controller/cms_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_cms_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class CmsView extends StatefulWidget {
  const CmsView({Key? key}) : super(key: key);

  @override
  _CmsViewState createState() => _CmsViewState();
}

class _CmsViewState extends State<CmsView> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<CmsController>()
          .initState(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final read = context.read<CmsController>();
    final watch = context.watch<CmsController>();
    return Scaffold(
   appBar:   PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Accounts",
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
      body: Html(data:watch.raw

      ),
    );
  }
}
