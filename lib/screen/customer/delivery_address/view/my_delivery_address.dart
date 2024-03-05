import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/delivery_address/controller/delivery_address_controller.dart';
import 'package:local_supper_market/screen/customer/delivery_address/view/add_address_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/loader.dart';
import 'package:provider/provider.dart';

class MyDeliveryAddressView extends StatefulWidget {
  final bool? isRefresh;
  const MyDeliveryAddressView({super.key, required this.isRefresh});

  @override
  State<MyDeliveryAddressView> createState() => _MyDeliveryAddressViewState();
}

class _MyDeliveryAddressViewState extends State<MyDeliveryAddressView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<DeliveryAddressController>()
          .initState(context, widget.isRefresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<DeliveryAddressController>();
    final read = context.read<DeliveryAddressController>();
    final readMain = context.read<MainScreenController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            readMain.onNavigation(
                4,
                const ProfileScreenView(
                  isRefreshed: false,
                ),
                context);
          },
          title: "My Addresses",
          action: SvgPicture.asset("assets/icons/addressadd.svg"),
          onActionTap: () {
            readMain.onNavigation(
                4,
                const AddAddressView(
                  route: "addressView",
                  isEditAdress: false,
                ),
                context);

            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => MainScreenView(
            //           index: 4,
            //           screenName: AddAddressView(
            //             route: "addressView",
            //             isEditAdress: false,
            //           ))),
            //   (Route<dynamic> route) => false,
            // );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const AddAddressView(
            //             route: "addressView",
            //             isEditAdress: false,
            //           )),
            // );
          },
          // action: ,
        ),
      ),
      backgroundColor: backgroundColor,
      body: watch.isLoading
          ? const Loader()
          : WillPopScope(
              onWillPop: () async {
                readMain.onNavigation(
                    4,
                    const ProfileScreenView(
                      isRefreshed: false,
                    ),
                    context);
                return false;
              },
              child: watch.deliveryAddressList?.isNotEmpty == true
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          // SizedBox(
                          //   height: 100.h,
                          // ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: watch.deliveryAddressList?.length ?? 0,
                            itemBuilder: (BuildContext, index) {
                              final element = watch.deliveryAddressList?[index];
                              return Container(
                                margin: EdgeInsets.only(
                                    left: 19.w, right: 19.w, top: 20.w),
                                padding: EdgeInsets.only(
                                    left: 20.w,
                                    top: 20.w,
                                    bottom: 11.w,
                                    right: 19.w),
                                // decoration: BoxDecoration(
                                // border: Border.all(
                                //   color: grey6,
                                //   width: 1,
                                // ),
                                //   borderRadius: BorderRadius.circular(12),
                                // ),
                                decoration: BoxDecoration(
                                  color: grey6,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: grey6,
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.09),
                                        blurRadius: 5,
                                        offset: const Offset(-.0, 5.0),
                                        spreadRadius: 0),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/person.svg',
                                              width: 11.w,
                                              height: 15.h,
                                            ),
                                            SizedBox(
                                              width: 11.w,
                                            ),
                                            Text(
                                              "${element?.customerName}",
                                              // 'Rachel Green',
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black,
                                                    letterSpacing: .5,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 21.h,
                                          width: 71.w,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              // backgroundColor: ,
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      grey4),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  side: BorderSide(
                                                    color: lighrgreen,
                                                    // width: 1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "${element?.deliveryAddressType}"
                                                  .capitalize(),
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: SplashText1,
                                                    // letterSpacing: .5,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),

                                            //
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 22.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/phone.svg',
                                          width: 14.w,
                                          height: 15.h,
                                        ),
                                        SizedBox(width: 9.w),
                                        Text(
                                          "${element?.deliveryCountryCode}"
                                          "  ${element?.deliveryMobileNumber}",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black,
                                                letterSpacing: .5,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 19.h,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/location.svg',
                                          color: SplashText1,
                                          width: 17.w,
                                          height: 17.h,
                                        ),
                                        SizedBox(
                                          width: 11.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            maxLines: 4,
                                            "${element?.address1}"
                                            " ${element?.address2}",
                                            // "Nand Nivas Building floor 3 B-3,Lane No.13 Bhatrau Nivas Vishrantwadi Pune -411015.",
                                            // textAlign: TextAlign.start,
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  // height: 1.5,
                                                  color: black,
                                                  // letterSpacing: .05,
                                                  // overflow: TextOverflow.ellipsis,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 18.w,
                                    ),
                                    Divider(
                                      color: grey11,
                                      thickness: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            PrimaryCheckBox(
                                              onChanged: (value) {
                                                read.markDefaultAddress(
                                                    context,
                                                    element?.id.toString(),
                                                    index);
                                              },
                                              value:
                                                  watch.defaultSelectedAddress[
                                                      index],
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Text(
                                              'Default',
                                              style: GoogleFonts.dmSans(
                                                textStyle: TextStyle(
                                                    color: Black,
                                                    // letterSpacing: .5,
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  print("hello");
                                                  readMain.onNavigation(
                                                      4,
                                                      AddAddressView(
                                                        route: "addressView",
                                                        isEditAdress: true,
                                                        addressId: element?.id
                                                            .toString(),
                                                      ),
                                                      context);
                                                  // Navigator.pushAndRemoveUntil(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           MainScreenView(
                                                  //               index: 4,
                                                  //               screenName:
                                                  //                   AddAddressView(
                                                  //                 route: "addressView",
                                                  //                 isEditAdress: true,
                                                  //                 addressId: element?.id
                                                  //                     .toString(),
                                                  //               ))),
                                                  //   (Route<dynamic> route) => false,
                                                  // );
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/icons/edit1.svg")),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            Container(
                                              width: 1.w,
                                              height: 28.w,
                                              color: grey11,
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  read.deleteAddress(context,
                                                      index, element?.id);
                                                },
                                                child: SvgPicture.asset(
                                                    "assets/icons/delete1.svg"))
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 100.h,
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/emptycart.png",
                            height: 151.h,
                            width: 151.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 15.w,
                                bottom: 50.w),
                            child: Text(
                              "Looks like you don't add any delivery address",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black1,
                                    letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
    );
  }
}
