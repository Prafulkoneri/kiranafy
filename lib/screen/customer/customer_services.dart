import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/widget/app_bar.dart';

import '../../const/color.dart';
import '../../const/color.dart';
import '../../const/color.dart';
import '../../widget/dropdown_field.dart';
import '../../widget/textfield.dart';

class customerSupport extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String radioButtonItem = '';
  String? dropdown;
  final maxLines = 5;
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;
  // Group Value fo
  // r Radio Button.
  int id = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Customer Support",
          action: SvgPicture.asset("assets/icons/add_address.svg"),
          onActionTap: () {},
        ),
      ),
      // body: const Center(
      //   child: Text('Flutter Demo'),
      // ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: ScreenUtil().screenWidth,
                    padding:
                        EdgeInsets.only(left: 19.w, right: 19.w, top: 20.w),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: grey6,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 5,
                              offset: Offset(-.0, 5.0),
                              spreadRadius: 0),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.w,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 10.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      'Ticket Id-',
                                      style: TextStyle(
                                          color: Black,
                                          letterSpacing: .5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      'PAG122E551',
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            letterSpacing: .5,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Status',
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            letterSpacing: .5,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      'Sep 30, 2021 2:15 AM',
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: Black,
                                            letterSpacing: .5,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Ongoing',
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: orange,
                                            letterSpacing: .5,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: grey,
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  'Subject',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing.',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  'Remark',
                                  style: GoogleFonts.dmSans(
                                    textStyle: TextStyle(
                                        color: Black,
                                        letterSpacing: .5,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet.',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
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
                  Container(
                    width: ScreenUtil().screenWidth,
                    padding:
                        EdgeInsets.only(left: 19.w, right: 19.w, top: 30.w),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff44B8CA), Color(0xff2E2E2)],
                        ),
                        border: Border.all(
                          color: grey6,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child:
                                      Image.asset('assets/images/profile.png'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Johnson Doe',
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Black,
                                          letterSpacing: .5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 70,
                            ),
                            child: Text(
                              '12 Jan 2021',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
                                    letterSpacing: .5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Divider(
                              color: gradient,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, right: 20.w, bottom: 10.w),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet.',
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: Black,
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
                ],
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 16.w, top: 16.w, bottom: 16.w),
                child: SvgPicture.asset(
                  'assets/icons/send_button.svg',
                  width: 40.w,
                  height: 30.h,
                ),
              ),
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Grey),
                //<-- SEE HERE
              ),
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
