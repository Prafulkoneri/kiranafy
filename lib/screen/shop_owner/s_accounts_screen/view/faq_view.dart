import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/cms_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/controller/s_account_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_cms_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:provider/provider.dart';

class ShopFAQView extends StatefulWidget {
  const ShopFAQView({super.key});

  @override
  State<ShopFAQView> createState() => _ShopFAQViewState();
}

class _ShopFAQViewState extends State<ShopFAQView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SAccountScreenController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SAccountScreenController>();
    final watch = context.watch<SAccountScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          title: "FAQ",
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
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: watch.faqdata?.length ?? 0,
                  itemBuilder: (context, index) {
                    final element = watch.faqdata?[index];
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(0.0, 0.0),
                            )
                          ]),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Theme(
                            data: ThemeData(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              trailing:
                                  //  Icon(
                                  //     Icons.keyboard_arrow_up_rounded,
                                  //     color: Color(0xff8b0e1a),
                                  //   )
                                  // :
                                  Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Color(0xff8b0e1a),
                              ),
                              tilePadding: EdgeInsets.only(left: 10, right: 10),
                              // onExpansionChanged: (value) {
                              //   // setState(() {
                              //   //   tileOneOpen = value;
                              //   // });
                              // },
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${element?.question}",
                                    // "What is order ?",
                                    style:
                                        // tileOneOpen
                                        //     ? TextStyle(
                                        //         fontSize: 16,
                                        //         fontFamily: 'whitneysemibold',
                                        //         color: Colors.black)
                                        // :
                                        TextStyle(
                                            fontSize: 18,
                                            // fontFamily: 'whitneymedium',
                                            color: Colors.black),
                                  ),
                                ],
                              ),
                              children: <Widget>[
                                Container(
                                  // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                                  height: 1,
                                  margin: EdgeInsets.only(top: 0, bottom: 0),
                                  width: MediaQuery.of(context).size.width,
                                  color: Color(0xffeeeeee),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${element?.answer}",
                                        textAlign: TextAlign.start,
                                        // "Order is placed for products which are in stock and readily available with us. Stock accuracy is upto 90% at Manek Ratna, we cannot commit 100% since there are multiple B2B customers placing orders at the same time on our portal for the same product which you desire to order.",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            // height: 1.2,
                                            // fontFamily: 'whitneymedium',
                                            fontWeight: FontWeight.w300),
                                      )
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
