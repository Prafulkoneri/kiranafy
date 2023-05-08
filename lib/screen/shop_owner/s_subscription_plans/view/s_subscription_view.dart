import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/screen/customer/on_boarding/controller/on_boarding_controller.dart';
import 'package:local_supper_market/screen/customer/order_status/order_status.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/controller/s_subscription_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/view/s_subscription_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';

import 'package:local_supper_market/widget/buttons.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:local_supper_market/widget/checkbox.dart';
import 'package:local_supper_market/widget/radio_button.dart';
import 'package:provider/provider.dart';

class SSubscriptionScreenView extends StatefulWidget {
  const SSubscriptionScreenView({Key? key}) : super(key: key);

  @override
  _SSubscriptionScreenViewState createState() =>
      _SSubscriptionScreenViewState();
}

String? selectedValue;

String radioButtonItem = '';

bool _isChecked = true;
String _currText = '';

int id = 1;
bool _checkbox = false;

List<String> text = ["InduceSmile.com", "Flutter.io", "google.com"];

class _SSubscriptionScreenViewState extends State<SSubscriptionScreenView> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<SSubscriptionController>();
    final watch = context.watch<SSubscriptionController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Update Profile",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.topLeft,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0.w,
                  top: -25,
                  child: Image.asset(
                    "assets/images/splash1.png",
                    height: 235.w,
                    width: 361.w,
                  ),
                ),
                Positioned(
                  bottom: -80.w,
                  // top: 0,
                  right: 0.w,
                  child: Image.asset(
                    "assets/images/splash2.png",
                    height: 235.w,
                    width: 361.w,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 19.w, top: 15.w, right: 19.w),
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
                                      borderRadius: BorderRadius.circular(10.w)),
                                child:Column(
                                  children: [
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width:14.w,
                                        ),
                                        PrimaryRadioButton(value: true, groupValue:true, onChanged:(value){}, leading: "",),
                                        SizedBox(
                                          width:7.w,
                                        ),
                                        Text("Standard Plan",style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30.w,
                                    ),
                                    SizedBox(
                                      height: 22.w,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.w),
                                      child: Image.asset(
                                        'assets/images/subscription3.png',
                                        // width: 352.w,
                                        // height: 60.h,
                                      ),
                                    ),



                                  ],
                                ),
                                ),
                                Positioned(top: 35.w,left: 37.w,child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                        Text("INR 4000",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 28.sp),),

                                  SizedBox(
                                    height: 4.w,
                                  ),

                                    Container(
                                      width:ScreenUtil().screenWidth/1.23.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("1 Year Validity",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Colors.white),),
                                         Container(
                                          
                                           child: GestureDetector(
                                             onTap: (){
                                               showDialog(
                                                   context: context,
                                                   builder: (BuildContext
                                                   context) {
                                                     return Dialog(
                                                       child:
                                                       SingleChildScrollView(
                                                         child: Column(
                                                           children: [
                                                             Padding(
                                                               padding: EdgeInsets.only(
                                                                   top: 11
                                                                       .w,
                                                                   right: 14
                                                                       .w,
                                                                   left: 25
                                                                       .w),
                                                               child: Row(
                                                                 mainAxisAlignment:
                                                                 MainAxisAlignment
                                                                     .spaceBetween,
                                                                 children: [
                                                                   Text(
                                                                       "Advanced Plan - ₹6000",
                                                                       style:
                                                                       GoogleFonts.dmSans(
                                                                         textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                                                       )),
                                                                   InkWell(
                                                                     onTap:
                                                                         () {
                                                                       Navigator.pop(context);
                                                                     },
                                                                     child:
                                                                     SvgPicture.asset("assets/icons/pop_delete.svg"),
                                                                   )
                                                                 ],
                                                               ),
                                                             ),
                                                             Divider(),
                                                             Container(
                                                               padding:
                                                               EdgeInsets
                                                                   .only(
                                                                 left:
                                                                 23.w,
                                                                 right:
                                                                 16.w,
                                                               ),
                                                               height:
                                                               646.h,
                                                               // width: 362.w,
                                                               child: ListView
                                                                   .builder(
                                                                 itemCount:
                                                                 20,
                                                                 itemBuilder:
                                                                     (context,
                                                                     index) {
                                                                   return Column(
                                                                     children: <
                                                                         Widget>[
                                                                       Container(
                                                                         child: Row(
                                                                           crossAxisAlignment: CrossAxisAlignment.center,
                                                                           // mainAxisAlignment:
                                                                           //     MainAxisAlignment.center,
                                                                           children: [
                                                                             Icon(
                                                                               Icons.circle_rounded,
                                                                               size: 5.w,
                                                                             ),
                                                                             SizedBox(
                                                                               width: 10,
                                                                             ),
                                                                             Text(
                                                                               // softWrap: true,
                                                                               // maxLines: 3,//
                                                                               "Ready grocery item master",

                                                                               style: GoogleFonts.dmSans(
                                                                                 textStyle: TextStyle(
                                                                                     color: Black1,
                                                                                     height: 1.5,

                                                                                     // letterSpacing: .05,
                                                                                     // overflow: TextOverflow.ellipsis,
                                                                                     fontSize: 14.sp,
                                                                                     fontWeight: FontWeight.w400),
                                                                               ),
                                                                             ),
                                                                             Padding(
                                                                               padding: EdgeInsets.only(left: 32.w, right: 32.w),
                                                                               child: Container(
                                                                                 width: 1.w,
                                                                                 height: 35.w,
                                                                                 color: grey11,
                                                                               ),
                                                                             ),
                                                                             SvgPicture.asset("assets/icons/correct.svg")
                                                                           ],
                                                                         ),
                                                                       ),
                                                                     ],
                                                                   );
                                                                 },
                                                               ),
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                                     );
                                                   });
                                             },
                                             child:  Container(
                                               padding: EdgeInsets.symmetric(horizontal: 11.w,vertical: 4.w),
                                               decoration:  BoxDecoration(
                                                 borderRadius: BorderRadius.circular(7.w),
                                                 color:Color(0xff000000).withOpacity(0.35),
                                               ),
                                               child: Row(
                                                 // mainAxisAlignment:
                                                 //     MainAxisAlignment.start,
                                                 // mainAxisSize: MainAxisSize.min,
                                                 children: [
                                                   Text(
                                                     'View Benefits',
                                                     style:
                                                     GoogleFonts.dmSans(
                                                       textStyle: TextStyle(
                                                           color:
                                                           Colors.white,
                                                           // letterSpacing: .5,
                                                           fontSize: 12.sp,
                                                           fontWeight:
                                                           FontWeight
                                                               .w400),
                                                     ),
                                                   ), // <-- Text
                                                   SizedBox(width: 4.w),
                                                   SvgPicture.asset(
                                                       "assets/icons/forward1.svg"),
                                                 ],

                                               ),
                                             ),
                                           ),
                                         ),
                                         
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:22.w,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ],
                        ),
                      ),

                      //////////////////////// SubScription second///////////////////
                      Padding(
                        padding:
                        EdgeInsets.only(left: 19.w, top: 15.w, right: 19.w),
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
                                            Color(0xff4EC0FA).withOpacity(1),
                                            Color(0xff32DFAC).withOpacity(1),
                                          ]),

                                      // border: Border.all(width: 1, color: Black),
                                      borderRadius: BorderRadius.circular(10.w)),
                                  child:Column(
                                    children: [
                                      SizedBox(
                                        height: 10.w,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width:14.w,
                                          ),
                                          PrimaryRadioButton(value: true, groupValue:true, onChanged:(value){}, leading: "",),
                                          SizedBox(
                                            width:7.w,
                                          ),
                                          Text("Standard Plan",style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.w,
                                      ),
                                      SizedBox(
                                        height: 22.w,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.w),
                                        child: Image.asset(
                                          'assets/images/subscription2.png',
                                          // width: 352.w,
                                          // height: 60.h,
                                        ),
                                      ),



                                    ],
                                  ),
                                ),
                                Positioned(top: 35.w,left: 37.w,child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text("INR 4000",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 28.sp),),

                                    SizedBox(
                                      height: 4.w,
                                    ),

                                    Container(
                                      width:ScreenUtil().screenWidth/1.23.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("1 Year Validity",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Colors.white),),
                                          Container(

                                            child: GestureDetector(
                                              onTap: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) {
                                                      return Dialog(
                                                        child:
                                                        SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    top: 11
                                                                        .w,
                                                                    right: 14
                                                                        .w,
                                                                    left: 25
                                                                        .w),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        "Advanced Plan - ₹6000",
                                                                        style:
                                                                        GoogleFonts.dmSans(
                                                                          textStyle: TextStyle(color: Black, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                                                        )),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                      child:
                                                                      SvgPicture.asset("assets/icons/pop_delete.svg"),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Divider(),
                                                              Container(
                                                                padding:
                                                                EdgeInsets
                                                                    .only(
                                                                  left:
                                                                  23.w,
                                                                  right:
                                                                  16.w,
                                                                ),
                                                                height:
                                                                646.h,
                                                                // width: 362.w,
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                  20,
                                                                  itemBuilder:
                                                                      (context,
                                                                      index) {
                                                                    return Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Container(
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            // mainAxisAlignment:
                                                                            //     MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.circle_rounded,
                                                                                size: 5.w,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                // softWrap: true,
                                                                                // maxLines: 3,//
                                                                                "Ready grocery item master",

                                                                                style: GoogleFonts.dmSans(
                                                                                  textStyle: TextStyle(
                                                                                      color: Black1,
                                                                                      height: 1.5,

                                                                                      // letterSpacing: .05,
                                                                                      // overflow: TextOverflow.ellipsis,
                                                                                      fontSize: 14.sp,
                                                                                      fontWeight: FontWeight.w400),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsets.only(left: 32.w, right: 32.w),
                                                                                child: Container(
                                                                                  width: 1.w,
                                                                                  height: 35.w,
                                                                                  color: grey11,
                                                                                ),
                                                                              ),
                                                                              SvgPicture.asset("assets/icons/correct.svg")
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child:  Container(
                                                padding: EdgeInsets.symmetric(horizontal: 11.w,vertical: 4.w),
                                                decoration:  BoxDecoration(
                                                  borderRadius: BorderRadius.circular(7.w),
                                                  color:Color(0xff000000).withOpacity(0.35),
                                                ),
                                                child: Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.start,
                                                  // mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'View Benefits',
                                                      style:
                                                      GoogleFonts.dmSans(
                                                        textStyle: TextStyle(
                                                            color:
                                                            Colors.white,
                                                            // letterSpacing: .5,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                            FontWeight
                                                                .w400),
                                                      ),
                                                    ), // <-- Text
                                                    SizedBox(width: 4.w),
                                                    SvgPicture.asset(
                                                        "assets/icons/forward1.svg"),
                                                  ],

                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:22.w,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ],
                        ),
                      ),



                      Padding(
                        padding: EdgeInsets.only(
                          left: 19.w,
                          top: 30.w,
                        ),
                        child: Text(
                          'Add on Services:',
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Black,
                                // letterSpacing: .5,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 19.w,bottom: 22.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 17.w,
                            ),
                            Row(
                              children: [
                                PrimaryCheckBox(),
                                Text(
                                  'One time shop setup in the app',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 17.w,
                            ),
                            Row(
                              children: [
                                PrimaryCheckBox(),
                                Text(
                                  'Product price maintenance support',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 17.w,
                            ),
                            Row(
                              children: [
                                PrimaryCheckBox(),
                                Text(
                                  'Shop Digital Marketing',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 17.w,
                            ),
                            Row(
                              children: [
                                PrimaryCheckBox(),
                                Text(
                                  'Prime and catchy location on app',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black1,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          left: 19.w,
                        ),
                        child: Text(
                          "To know more about add-on services and pricing\n details, request for a call back.",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Black1,
                                // letterSpacing: .5,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 70.h,
            width: 390.w,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(SplashText),
              ),
              onPressed: () {
                read.onMakePaymentClicked(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "₹ 4,000",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: .5,
                                  fontSize: 23.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            "Extra 18% GST",
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  // letterSpacing: .5,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: PrimaryButton(
                            color: Colors.white,
                            height: 36.h,
                            width: 160.w,
                            onTap: () {
                              print("hello");
                              read.onMakePaymentClicked(context);
                            },
                            text: 'Make Payment',
                            textColor: SplashText1,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ],
              ),

              //
            ),
          ),
        ],
      ),
    );
  }
}

