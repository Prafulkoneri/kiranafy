import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/auth/upload_documents.dart';

class AllCoupons extends StatefulWidget {
  const AllCoupons({super.key});

  @override
  State<AllCoupons> createState() => _AllCouponsState();
}

class _AllCouponsState extends State<AllCoupons> {
  String? selectedValue;
  final List<String> genderItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          // Status bar color
          statusBarColor: kstatusbar,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        toolbarHeight: 65,
        // backgroundColor: kappbar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Offers & Coupons",
          style: GoogleFonts.dmSans(
            textStyle: const TextStyle(
                color: Black,
                letterSpacing: .5,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: <Color>[
                  kstatusbar.withOpacity(0.55),
                  kstatusbar.withOpacity(0.98),
                ]),
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                context: context,
                builder: (BuildContext context) {
                  return Material(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    child: Container(
                      // height: 326.h,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      width: 390.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20.h,
                            ),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Coupon Filter",
                                  style: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: 100.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                    'assets/images/cross1.svg',
                                    width: 25.w,
                                    height: 25.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Divider(
                            // height: 20,
                            thickness: 1,
                            indent: 19,
                            endIndent: 19,
                            color: grey1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, top: 17.w, bottom: 15.w),
                            child: Text(
                              "Shops",
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                    color: Black,
                                    letterSpacing: .5,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 18.w),
                            child: DropdownButtonFormField2(
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                // border: OutlineInputBorder(
                                //     // borderRadius: BorderRadius.circular(15),
                                //     ),
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              // hint: const Text(
                              //   'City',
                              //   style: TextStyle(fontSize: 14),
                              // ),
                              items: genderItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select shops.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                selectedValue = value.toString();
                              },
                              buttonStyleData: const ButtonStyleData(
                                height: 60,
                                padding: EdgeInsets.only(left: 20, right: 10),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, top: 20.w, bottom: 15.w),
                            child: Text(
                              "Category",
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                    color: Black,
                                    letterSpacing: .5,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 18.w),
                            child: DropdownButtonFormField2(
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              isExpanded: true,
                              // hint: const Text(
                              //   'City',
                              //   style: TextStyle(fontSize: 14),
                              // ),
                              items: genderItems
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select Category.';
                                }
                                return (value);
                              },
                              onChanged: (value) {
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                selectedValue = value.toString();
                              },
                              buttonStyleData: const ButtonStyleData(
                                height: 60,
                                padding: EdgeInsets.only(left: 20, right: 10),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w,
                                top: 24.w,
                                bottom: 20.w,
                                right: 19.w),
                            child: SizedBox(
                              width: 352.w, // <-- Your width
                              height: 35.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Button,
                                  // onPrimary: Colors.white,
                                  // shadowColor: Colors.greenAccent,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(14.0)),
                                  minimumSize:
                                      const Size(100, 40), //////// HERE
                                ),
                                // style: style,
                                onPressed: () {},
                                child: Text(
                                  'Filter',
                                  style: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        // color: SplashTex
                                        letterSpacing: .5,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: 20.w,
              ),
              child: SvgPicture.asset(
                'assets/images/filter.svg',
                width: 20.w,
                height: 18.h,
              ),
            ),
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.settings,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     // do something
          //   },
          // )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50.h,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? 19.w : 10.w,
                        top: 20.w,
                        right: index == 4 ? 19.w : 0.w),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // width: 95.w,
                          height: 25.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              // backgroundColor: ,
                              backgroundColor: MaterialStateProperty.all(
                                  index == 0 ? pink : Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color:
                                        index == 0 ? Colors.transparent : Grey,
                                    // width: 1,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  index == 0 ? "Today" : "Upto 80%",
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: index == 0 ? Colors.white : Grey,
                                        // letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                // <-- Text
                                index == 0
                                    ? SizedBox(
                                        width: 7.w,
                                      )
                                    : Container(),
                                index == 0
                                    ? SvgPicture.asset(
                                        'assets/images/Cross.svg',
                                        width: 7.w,
                                        height: 7.h,
                                      )
                                    : Container()
                              ],
                            ),

                            //
                          ),
                        ),

                        //
                      ],
                    ),
                  );
                }),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              // height: 125.h,
              // width: 352.w,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext, index) {
                    return Container(
                      // decoration: BoxDecoration(color: Black),
                      padding: EdgeInsets.only(
                          left: 19.0.w, right: 19.w, top: 15.0.w),
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: Image.asset(
                              'assets/images/Coupons.png',
                              // height: 125.h, width: 352.w
                              // fit: BoxFit.cover
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 35.h,
                              bottom: 10.h,
                            ),
                            child: ClipRRect(
                              // borderRadius: new BorderRadius.circular(40.0),
                              child: Image.asset(
                                  'assets/images/couponslogo.png',
                                  height: 62.h,
                                  width: 37.w),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 80.h,
                              bottom: 15.h,
                            ),
                            child: FDottedLine(
                              color: Grey,
                              height: 120.0,
                              strokeWidth: 1.0,
                              dottedLength: 10.0,
                              space: 3.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 75.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                      // height: 15.w,
                                    ),
                                    Text(
                                      "Hi Choice Supermarket",
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            letterSpacing: .5,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.white,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30))),
                                            context: context,
                                            builder: (context) {
                                              // using a scaffold helps to more easily position the FAB
                                              return CouponsBottomSheet();
                                            });
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/logo1.svg',
                                        width: 15.w,
                                        height: 15.h,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 19.w,
                                      ),
                                      child: Text(
                                        "Valid until 16 March 2023",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Black,
                                              letterSpacing: .5,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 18.0.h),
                                      child: Text("50% OFF",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Black,
                                                letterSpacing: .5,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text("UPTO ₹120",
                                        style: GoogleFonts.dmSans(
                                          textStyle: TextStyle(
                                              color: Grey,
                                              letterSpacing: .5,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 18.0.h,
                                  ),
                                  child: SizedBox(
                                    width: 115.w,
                                    height: 30.h,
                                    child: ElevatedButton(
                                      // style: ElevatedButton.styleFrom(
                                      //   //<-- SEE HERE
                                      //   side: BorderSide(
                                      //     width: 3.0,
                                      //   ),
                                      // ),
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),

                                        // backgroundColor: ,
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                width: 1, color: SplashText),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "OFF100",
                                            style: GoogleFonts.dmSans(
                                              textStyle: TextStyle(
                                                  color: SplashText,
                                                  letterSpacing: .5,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ), // <-- Text
                                          SizedBox(
                                            width: 19.w,
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/svg2.svg',
                                            width: 17.w,
                                            height: 17.h,
                                          ),
                                        ],
                                      ),

                                      //
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          )),
          SizedBox(
            height: 80.h,
          )
        ],
      ),
    );
  }

  Widget CouponsBottomSheet() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Container(
        // ,
        // ),
        Container(
          // height: MediaQuery.of(context).size.height * 0.50,
          height: 300.h,
          width: 390.w,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 13.w, top: 20.w),
                    child: Image.asset('assets/images/couponslogo.png',
                        height: 33.h, width: 21.w),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 18.0.h),
                        child: Text(
                          "Hi Choice Supermarket",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                color: Black,
                                letterSpacing: .5,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      Text(
                        "Valid until 16 March 2023",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              color: Black,
                              letterSpacing: .5,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 45.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("50% OFF",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Black,
                              letterSpacing: .5,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        )),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text("UPTO ₹120",
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyle(
                              color: Grey,
                              letterSpacing: .5,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0.w, bottom: 0.w),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 113.w,
                            height: 34.h,
                            child: ElevatedButton(
                              // style: ElevatedButton.styleFrom(
                              //   //<-- SEE HERE
                              //   side: BorderSide(
                              //     width: 3.0,
                              //   ),
                              // ),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),

                                // backgroundColor: ,
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side:
                                        BorderSide(width: 1, color: SplashText),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "OFF100",
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: SplashText,
                                          letterSpacing: .5,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ), // <-- Text
                                  SizedBox(
                                    width: 19.w,
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/svg2.svg',
                                    width: 17.w,
                                    height: 17.h,
                                  ),
                                ],
                              ),

                              //
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                // height: 20,
                thickness: 1,
                indent: 14,
                endIndent: 25.5,
                color: Grey,
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17.75.w, top: 8.w, bottom: 8.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/checked.svg',
                          width: 17.w,
                          height: 17.h,
                        ),
                        SizedBox(
                          width: 6.27,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                height: 1.5,
                                color: black,
                                letterSpacing: .5,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17.75.w, top: 8.w, right: 13.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/checked.svg',
                          width: 17.w,
                          height: 17.h,
                        ),
                        SizedBox(
                          width: 6.27,
                        ),
                        Flexible(
                          child: Text(
                            maxLines: 2,
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sit nunc, netus ac vulputate sed",
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  height: 1.5,
                                  color: black,
                                  letterSpacing: .05,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17.75.w, top: 8.w, bottom: 8.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/checked.svg',
                          width: 17.w,
                          height: 17.h,
                        ),
                        SizedBox(
                          width: 6.27,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: black,
                                height: 1.5,
                                letterSpacing: .5,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17.75.w, top: 8.w, bottom: 8.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/checked.svg',
                          width: 17.w,
                          height: 17.h,
                        ),
                        SizedBox(
                          width: 6.27,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: black,
                                height: 1.5,
                                letterSpacing: .5,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17.75.w, top: 8.w, right: 13.w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.w),
                          child: SvgPicture.asset(
                            'assets/images/checked.svg',
                            width: 17.w,
                            height: 17.h,
                          ),
                        ),
                        SizedBox(
                          width: 6.27,
                        ),
                        Flexible(
                          child: Text(
                            softWrap: true,
                            maxLines: 3,
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sit nunc, netus ac vulputate sed",
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: black,
                                  height: 1.5,

                                  // letterSpacing: .05,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        ///top icon
        Positioned(
            top: -60.w,
            left: 0.w,
            right: 0.w,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50.w,
                width: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/Cross.svg',
                    width: 15.w,
                    height: 15.h,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
