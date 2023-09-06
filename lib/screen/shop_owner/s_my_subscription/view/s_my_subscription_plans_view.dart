import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/main.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/view/s_edit_profile_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/controller/subscription_history_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_my_subscription/view/benifits_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:http/http.dart' as http;
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/buttons.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import 'dart:io';

class SMySubscriptionView extends StatefulWidget {
  final String? screenName;
  const SMySubscriptionView({super.key, required this.screenName});

  @override
  State<SMySubscriptionView> createState() => _SMySubscriptionViewState();
}

class _SMySubscriptionViewState extends State<SMySubscriptionView> {
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SubscriptionHistoryController>().initState(context);
    });
    // print(context.read<SubscriptionHistoryController>().currentSubscriptionPlan);
  }

  String? file;
  String fileurl =
      "https://localsupermart.com/testing/storage/subscription_pdf_invoice/LSMSUBS000054-2023-08-0810:50:38.pdf";

  void download(String url) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: "/storage/emulated/0/Download",
        showNotification: true,
        openFileFromNotification: true,
        fileName: "file.pdf",
      ).then((value) {
        print("complated");
      });
    } else {
      setState(() {
        print("faild");
      });
      print('Permission Denied');
    }
  }

  downloadFile(String url, {filename}) async {
    var httpClient = http.Client();
    var request = new http.Request('GET', Uri.parse(url));
    var response = httpClient.send(request);
    String dir = (await getApplicationDocumentsDirectory()).path;

    List<List<int>> chunks = [];
    int downloaded = 0;

    response.asStream().listen((http.StreamedResponse r) {
      r.stream.listen((List<int> chunk) {
        // Display percentage of completion
        // debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');

        chunks.add(chunk);
        downloaded += chunk.length;
      }, onDone: () async {
        // Display percentage of completion
        // debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');

        // Save the file
        File file = new File('$dir/$filename');
        final Uint8List bytes = Uint8List(r.contentLength ?? 0);
        int offset = 0;
        for (List<int> chunk in chunks) {
          bytes.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }
        await file.writeAsBytes(bytes);
        return;
      });
    });
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  String path = "";

  void _setPath() async {
    Directory _path = await getApplicationDocumentsDirectory();
    String _localPath = _path.path + Platform.pathSeparator + 'Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    path = _localPath;
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<SubscriptionHistoryController>();
    final watch = context.watch<SubscriptionHistoryController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "My Subscription",
          onBackBtnPressed: () {
            widget.screenName == "accounts"
                ? Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SMainScreenView(
                              index: 4,
                              screenName: SAccountScreenView(
                                refresh: false,
                              ),
                            )),
                    (Route<dynamic> route) => false,
                  )
                : Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SMainScreenView(
                              index: 0,
                              screenName: ShopDashBoardView(
                                refresh: false,
                              ),
                            )),
                    (Route<dynamic> route) => false,
                  );
          },
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  // mainAxisAlignment: M,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    watch.currentSubscriptionPlan?.planName == "Standard Plan"
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: 18.w,
                                top: 15.w,
                                right: 19.w,
                                bottom: 20.w),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              clipBehavior: Clip.none,
                              children: <Widget>[
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Custlogin,
                                          gradient: LinearGradient(
                                              end: Alignment.topCenter,
                                              begin: Alignment.bottomCenter,
                                              colors: <Color>[
                                                yellow1.withOpacity(1),
                                                yellow2.withOpacity(1),
                                              ]),

                                          // border: Border.all(width: 1, color: Black),
                                          borderRadius:
                                              BorderRadius.circular(10.w)),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 19.w,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "My Current Subscription Plan",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        // letterSpacing: .5,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              SizedBox(
                                                height: 22.h,
                                                // width: 68.w,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all(0),
                                                    // backgroundColor: ,
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(LightGreen1),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        side: BorderSide(
                                                          color: DarkGreen1,
                                                          // width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Activated",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: DarkGreen1,
                                                          // letterSpacing: .5,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),

                                                  //
                                                ),
                                              ),
                                              SizedBox(
                                                width: 19.w,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 60.w,
                                          ),
                                          // SizedBox(
                                          //   height: 22.w,
                                          // ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                            child: Image.asset(
                                              'assets/images/subscription3.png',
                                              // width: 352.w,
                                              // height: 60.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 55.w,
                                        left: 17.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${watch.currentSubscriptionPlan?.planName}",
                                              // "Advanced Plan ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontSize: 28.sp),
                                            ),
                                            SizedBox(
                                              height: 6.w,
                                            ),
                                            Container(
                                              // width: ScreenUtil().screenWidth / 1.23.w,
                                              child: Text(
                                                "Expiry Date : ${watch.currentSubscriptionPlan?.subscriptionActiveTill}",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6.w,
                                            ),
                                            Text(
                                              "₹ ${watch.currentSubscriptionPlan?.paidAmount}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontSize: 28.sp),
                                            ),
                                            SizedBox(
                                              height: 40.w,
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                left: 18.w,
                                top: 15.w,
                                right: 19.w,
                                bottom: 20.w),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              clipBehavior: Clip.none,
                              children: <Widget>[
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Custlogin,
                                          gradient: LinearGradient(
                                              end: Alignment.topCenter,
                                              begin: Alignment.bottomCenter,
                                              colors: <Color>[
                                                Color(0xff4EC0FA)
                                                    .withOpacity(1),
                                                Color(0xff32DFAC)
                                                    .withOpacity(1),
                                              ]),

                                          // border: Border.all(width: 1, color: Black),
                                          borderRadius:
                                              BorderRadius.circular(10.w)),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 19.w,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "My Current Subscription Plan ",
                                                  style: GoogleFonts.dmSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        // letterSpacing: .5,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              SizedBox(
                                                height: 22.h,
                                                // width: 68.w,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all(0),
                                                    // backgroundColor: ,
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(LightGreen1),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        side: BorderSide(
                                                          color: DarkGreen1,
                                                          // width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: Text(
                                                    "Activated",
                                                    style: GoogleFonts.dmSans(
                                                      textStyle: TextStyle(
                                                          color: DarkGreen1,
                                                          // letterSpacing: .5,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),

                                                  //
                                                ),
                                              ),
                                              SizedBox(
                                                width: 19.w,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 50.w,
                                          ),
                                          // SizedBox(
                                          //   height: 22.w,
                                          // ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                            child: Image.asset(
                                              'assets/images/my_subscription_home.png',
                                              // width: 352.w,
                                              // height: 60.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 55.w,
                                        left: 17.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${watch.currentSubscriptionPlan?.planName}",
                                              // "Advanced Plan ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontSize: 28.sp),
                                            ),
                                            SizedBox(
                                              height: 6.w,
                                            ),
                                            Container(
                                              // width: ScreenUtil().screenWidth / 1.23.w,
                                              child: Text(
                                                "Expiry Date : ${watch.currentSubscriptionPlan?.subscriptionActiveTill}",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6.w,
                                            ),
                                            Text(
                                              "₹ ${watch.currentSubscriptionPlan?.paidAmount}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontSize: 28.sp),
                                            ),
                                            SizedBox(
                                              height: 20.w,
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 18.w, top: 15.w, right: 19.w),
                      child: Column(
                        children: [
                          Text(
                            "Benefits",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black1,
                                  // height: 1.5,

                                  // letterSpacing: .05,
                                  // overflow: TextOverflow.ellipsis,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.only(left: 0.w, top: 10.w, right: 34.w),
                        child: HtmlWidget(
                          watch.currentSubscriptionPlan?.planBenifits ?? "",
                          textStyle: TextStyle(
                              color: Black1,
                              // height: 1.5,
                              // letterSpacing: .05,
                              // overflow: TextOverflow.ellipsis,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                          // watch.?.description ?? "",
                        )

                        //  Column(
                        ),
                    SizedBox(
                      height: 19.h,
                    ),
                    ////////////////////////show more//////////////////

                    // Container(
                    //   // padding: EdgeInsets.all(100),
                    //   child: Column(
                    //     children: [
                    //       ExpandedTileList.builder(
                    //         itemCount: 1,
                    //         maxOpened: 1,
                    //         reverse: true,
                    //         itemBuilder: (context, index, controller) {
                    //           return ExpandedTile(
                    //             // title: Container(),
                    //             theme: const ExpandedTileThemeData(
                    //               headerColor: Colors.white,
                    //               headerRadius: 24.0,
                    //               headerPadding: EdgeInsets.all(24.0),
                    //               headerSplashColor: Colors.white,
                    //               contentBackgroundColor: Colors.white,
                    //               contentPadding: EdgeInsets.all(24.0),
                    //               contentRadius: 12.0,
                    //             ),
                    //             controller: index == 1
                    //                 ? controller.copyWith(isExpanded: true)
                    //                 : controller,
                    //             title: Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Text(
                    //                   "Show More",
                    //                   style: GoogleFonts.dmSans(
                    //                     textStyle: TextStyle(
                    //                         color: Grey,
                    //                         fontSize: 12.sp,
                    //                         fontWeight: FontWeight.w400),
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   width: 5.w,
                    //                 ),
                    //                 SvgPicture.asset("assets/icons/dropdown.svg")
                    //               ],
                    //             ),
                    //             onTap: () {
                    //               print(
                    //                 "heloo",
                    //               );
                    //             },
                    //             trailing: Container(),
                    //             content: Column(
                    //               children: [
                    //                 Container(
                    //                   padding: EdgeInsets.only(
                    //                       left: 12.w, top: 0.w, right: 18.w),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Row(
                    //                         children: [
                    //                           Icon(
                    //                             Icons.circle_rounded,
                    //                             size: 5.w,
                    //                           ),
                    //                           SizedBox(
                    //                             width: 10,
                    //                           ),
                    //                           Text(
                    //                             "Order management",
                    //                             textAlign: TextAlign.center,
                    //                             style: GoogleFonts.dmSans(
                    //                               textStyle: TextStyle(
                    //                                   color: Black1,
                    //                                   fontSize: 14.sp,
                    //                                   fontWeight: FontWeight.w400),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       Row(
                    //                         children: [
                    //                           SvgPicture.asset(
                    //                               "assets/icons/correct.svg")
                    //                         ],
                    //                       )
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 // TextButton(
                    //                 //   onPressed: () {
                    //                 //     controller.collapse();
                    //                 //   },
                    //                 //   child: Text("close it!"),
                    //                 // )
                    //               ],
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 30.h,
                    ),
                    // BenifitsView()

                    Container(
                      padding: EdgeInsets.only(left: 18.w, right: 18.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subscription History",
                            // textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black1,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          PrimaryButton(
                            height: 30.h,
                            width: 109.w,
                            // color: Colors.transparent,
                            color: Color(0xff4689EC),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SSubscriptionScreenView(
                                              loggedIn: true)));
                            },
                            textColor: Colors.white,
                            text: "New Plan",
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 19.w, right: 19.w, top: 11.w),
                      // margin: EdgeInsets.only(left: 15.w, right: 15.w,b top: 4.w),
                      child: Column(children: <Widget>[
                        Table(
                          // defaultColumnWidth: FixedColumnWidth(120.0),
                          border: TableBorder(
                              horizontalInside:
                                  BorderSide(color: Colors.white, width: 5)),
                          children: [
                            TableRow(children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10.w, //
                                    right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                color: Color(0xff4EEFC1),
                                child: Text(
                                  "Plan",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: SplashText1,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    // left: 15.w,//
                                    // right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                color: Color(0xff4EEFC1),
                                child: Text(
                                  "Duration",
                                  //  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: SplashText1,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    // left: 15.w,//
                                    // right: 27.w,
                                    bottom: 10.w,
                                    top: 8.w),
                                color: Color(0xff4EEFC1),
                                child: Text(
                                  "Expiry Date",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: SplashText1,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 0.w, //
                                      right: 0.w,
                                      bottom: 10.w,
                                      top: 8.w),
                                  color: Color(0xff4EEFC1),
                                  child: Center(
                                    child: Text(
                                      "Amount",
                                      style: TextStyle(
                                          color: SplashText1,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )),
                            ]),
                            /////////////////
                          ],
                        ),
                      ]),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 19.w, right: 19.w, top: 2.w),
                      // margin: EdgeInsets.only(left: 15.w, right: 15.w,b top: 4.w),
                      child: Column(children: <Widget>[
                        createTable(),
                      ]),
                    ),

                    SizedBox(
                      height: 100.w,
                    ),
                  ]),
            ),
    );
  }

  Widget createTable() {
    final watch = context.watch<SubscriptionHistoryController>();
    final read = context.watch<SubscriptionHistoryController>();
    List<TableRow> rows = [];
    int length = watch.subscriptionHistory?.length ?? 0;
    for (int i = 0; i < length; i++) {
      rows.add(TableRow(
          decoration: BoxDecoration(
            color: Color(0xffF2F2F2),
          ),
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: 9.w, //
                    right: 10.w,
                    bottom: 10.w,
                    top: 8.w),
                child: Column(children: [
                  Text(
                    watch.subscriptionHistory?[i].planName ?? "",
                    // overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ])),
            Container(
                padding: EdgeInsets.only(
                    // left: 15.w,//
                    right: 27.w,
                    bottom: 10.w,
                    top: 8.w),
                child: Column(children: [
                  Text(
                    watch.subscriptionHistory?[i].validity ?? "",
                    // overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ])),
            Container(
                padding: EdgeInsets.only(
                    // left: 15.w,//
                    right: 27.w,
                    bottom: 10.w,
                    top: 8.w),
                child: Column(children: [
                  Text(
                    watch.subscriptionHistory?[i].subscriptionActiveTill ?? "",
                    // overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                          color: Black1,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ])),
            Container(
                padding: EdgeInsets.only(
                    left: 0.w, //
                    // right: 27.w,
                    bottom: 10.w,
                    top: 8.w),
                color: Color(0xffF2F2F2),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '₹ ${watch.subscriptionHistory?[i].paidAmount ?? ""}',
                            // overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Black1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            // onTap: () {

                            // },
                            onTap: () async {
                              print("object");
                              read.subscriptionInvoice(
                                  context,
                                  watch.subscriptionHistory?[i].invoiceId
                                      .toString());

                              // Map<Permission, PermissionStatus> statuses =
                              //     await [
                              //   Permission.storage,
                              //   //add more permission to request here.
                              // ].request();
                              //
                              // // if (statuses[Permission.storage]!.isGranted) {
                              // var dir;
                              // if (Platform.isIOS) {
                              //   dir = await getApplicationDocumentsDirectory();
                              // } else {
                              //   dir = Directory('/storage/emulated/0/Download');
                              // }
                              //
                              // if (dir != null) {
                              //   String savename = "file.pdf";
                              //   String savePath = dir.path + "/$savename";
                              //   print(savePath);
                              //   //output:  /storage/emulated/0/Download/banner.png
                              //
                              //   try {
                              //     await Dio().download(fileurl, savePath,
                              //         onReceiveProgress: (received, total) {
                              //       if (total != -1) {
                              //         print((received / total * 100)
                              //                 .toStringAsFixed(0) +
                              //             "%");
                              //         //you can build progressbar feature too
                              //       }
                              //     });
                              //     print("File is saved to download folder.");
                              //   } on DioError catch (e) {
                              //     print(e.message);
                              //   }
                              // }
                              //
                              // print("No permission to read and write.");
                              //
                              //

                              // _showProgressNotification();
                              // Map<String, String> requestHeaders = {
                              //   // 'Authorization': 'Bearer ' + http.cookie,
                              // };
                              //
                              // final assetsDir = "/storage/emulated/0/Download";
                              // final taskId = await FlutterDownloader.enqueue(
                              //   url: fileurl,
                              //   savedDir: assetsDir,
                              //   fileName: file,
                              //   headers: requestHeaders,
                              //   showNotification:
                              //       true, // show download progress in status bar (for Android)
                              //   openFileFromNotification:
                              //       true, // click on notification to open downloaded file (for Android)
                              // );

                              // download(fileurl);
                            },
                            child: SvgPicture.asset(
                              'assets/icons/download.svg',
                              height: 18,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    ])),
          ]));
    }
    return Table(
      border: TableBorder(
          horizontalInside: BorderSide(color: Colors.white, width: 2.w)),
      children: rows,
    );
  }
}
