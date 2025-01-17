import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/controller/s_order_Status_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_cancelled_orders_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_confirmed_orders_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_delivered_order_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_in_process_orders_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_order_status/view/s_pending_orders_view.dart';
import 'package:local_supper_market/utils/inidcator.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:provider/provider.dart';

class SOrderStatusView extends StatefulWidget {
  final int? selectedIndex;
  final bool? isFromOrderView;
  const SOrderStatusView({Key? key, this.selectedIndex, this.isFromOrderView})
      : super(key: key);

  @override
  _SOrderStatusViewState createState() => _SOrderStatusViewState();
}

class _SOrderStatusViewState extends State<SOrderStatusView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      print("9999");
      context
          .read<SOrderStatusController>()
          .initState(context, widget.selectedIndex);

    });
    print("gudiyaaaaa");
    print(widget.selectedIndex);
    print(widget.isFromOrderView);
  }


  @override
  Widget build(BuildContext context) {
    final read = context.read<SOrderStatusController>();
    final watch = context.watch<SOrderStatusController>();
    final readMainScreen = context.read<SMainScreenController>();
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.w),
          child: PrimaryAppBar(
            title: "Orders",
            isBackButtonEnabled: false,
          ),
        ),
        body: watch.isLoading
            ? const Loader()
            : WillPopScope(
          onWillPop: ()async{
            print("hello");
            readMainScreen.onNavigation(0,const ShopDashBoardView(refresh: false), context);
            return false;
          },
              child: Column(
                  children: [
                    TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      // indicatorSize: TabBarIndicatorSize.tab,
                      // controller: tabController,
                      splashBorderRadius: BorderRadius.circular(20),
                      indicator:
                          CustomIndicator(color: Colors.transparent, radius: 0.w),
                      // indicatorWeight: 0.w,
                      // indicatorPadding: EdgeInsets.only(top: 10.w),
                      padding: EdgeInsets.only(top: 16.w),
                      labelPadding: EdgeInsets.only(bottom: 0.w),
                      tabs: <Widget>[
                        Tab(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "Pending",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: watch.selectedIndex == 0
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: const Color(0xff3A3A3A)),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                watch.selectedIndex == 0
                                    ? Container(
                                        height: 6.w,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff39C19D),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.w),
                                                topRight: Radius.circular(5.w))),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "Confirmed",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: watch.selectedIndex == 1
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: const Color(0xff3A3A3A)),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                watch.selectedIndex == 1
                                    ? Container(
                                        height: 6.w,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff39C19D),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.w),
                                                topRight: Radius.circular(5.w))),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "In Process",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: watch.selectedIndex == 2
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: const Color(0xff3A3A3A)),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                watch.selectedIndex == 2
                                    ? Container(
                                        height: 6.w,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff39C19D),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.w),
                                                topRight: Radius.circular(5.w))),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "Delivered",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: watch.selectedIndex == 3
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: const Color(0xff3A3A3A)),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                watch.selectedIndex == 3
                                    ? Container(
                                        height: 6.w,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff39C19D),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.w),
                                                topRight: Radius.circular(5.w))),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "Cancelled",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: watch.selectedIndex == 4
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                      color: const Color(0xff3A3A3A)),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                watch.selectedIndex == 4
                                    ? Container(
                                        height: 6.w,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff39C19D),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.w),
                                                topRight: Radius.circular(5.w))),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ],
                      onTap: (index) {
                        read.onTabClicked(index);
                      },
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          IndexedStack(
                            index: watch.selectedIndex,
                            children: <Widget>[
                              Visibility(
                                maintainState: true,
                                visible: watch.selectedIndex == 0,
                                child: const SPendingOrdersView(),
                              ),
                              Visibility(
                                maintainState: true,
                                visible: watch.selectedIndex == 1,
                                child: const SConfirmedOrdersView(),
                              ),
                              Visibility(
                                maintainState: true,
                                visible: watch.selectedIndex == 2,
                                child: const SInProcessOrderView(),
                              ),
                              Visibility(
                                maintainState: true,
                                visible: watch.selectedIndex == 3,
                                child: const SDeliveredOrderView(),
                              ),
                              Visibility(
                                maintainState: true,
                                visible: watch.selectedIndex == 4,
                                child: const SCancelledOrdersView(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
      ),
    );
  }
}
