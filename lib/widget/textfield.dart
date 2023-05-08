import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PrimaryCTextFormField extends StatelessWidget {
  final String? titleHeader;
  final bool? readOnly;
  void Function(String)? onChanged;
  final LengthLimitingTextInputFormatter? lengthLimitingTextInputFormatter;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffix;
  final Color? color;
  final bool? enableBorder;
  PrimaryCTextFormField(
      {Key? key,
      this.color,
      this.enableBorder,
      this.suffix,
      this.controller,
      this.titleHeader,
      this.readOnly,
      this.onChanged,
      this.lengthLimitingTextInputFormatter,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              titleHeader ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: Color(0xff3A3A3A)),
            ),
          ],
        ),
        SizedBox(
          height: 10.w,
        ),
        Container(
          height: 48.w,
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            readOnly: readOnly ?? false,
            onChanged: onChanged,
            inputFormatters: [
              lengthLimitingTextInputFormatter ??
                  LengthLimitingTextInputFormatter(1000),
            ],
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: suffix,
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              contentPadding: EdgeInsets.only(left: 10.w),
              hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffB7B7B7)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.w,
                  color: Color(0xffE0E0E0),
                ),
                borderRadius: BorderRadius.circular(5.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffE0E0E0),
                ),
                borderRadius: BorderRadius.circular(5.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PrimarySTextFormField extends StatelessWidget {
  final String? titleHeader;
  final bool? readOnly;
  final double? height;
  final double? width;
  final int? maxLines;
  void Function(String)? onChanged;
  final LengthLimitingTextInputFormatter? lengthLimitingTextInputFormatter;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffix;
  final Color? color;
  final bool? enableBorder;
  final double? hintFontSize;
  PrimarySTextFormField(
      {Key? key,
      this.color,
      this.height,
      this.width,
      this.hintFontSize,
      this.maxLines,
      this.enableBorder,
      this.suffix,
      this.controller,
      this.titleHeader,
      this.readOnly,
      this.onChanged,
      this.lengthLimitingTextInputFormatter,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            titleHeader != null
                ? Text(
                    titleHeader ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),
                  )
                : Container(),
          ],
        ),
        titleHeader != null
            ? SizedBox(
                height: 10.w,
              )
            : Container(),
        Container(
          height: height ?? 48.w,
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            maxLines: maxLines ?? 1,
            readOnly: readOnly ?? false,
            onChanged: onChanged,
            inputFormatters: [
              lengthLimitingTextInputFormatter ??
                  LengthLimitingTextInputFormatter(1000),
            ],
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: suffix,
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              contentPadding: EdgeInsets.only(
                  left: 10.w, top: maxLines != null ? 30.w : 0.w),
              hintStyle: TextStyle(
                  fontSize: hintFontSize ?? 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffB7B7B7)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.w,
                  color: enableBorder ?? false
                      ? Color(0xffE0E0E0)
                      : Color(0xffEFEFEF),
                ),
                borderRadius: BorderRadius.circular(5.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.w,
                  color: enableBorder ?? false
                      ? Color(0xffE0E0E0)
                      : Color(0xffEFEFEF),
                ),
                borderRadius: BorderRadius.circular(5.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SeconderySTextFormField extends StatelessWidget {
  final String? titleHeader;
  final bool? readOnly;
  final double? height;
  final int? maxLines;
  void Function(String)? onChanged;
  final LengthLimitingTextInputFormatter? lengthLimitingTextInputFormatter;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffix;
  final Color? color;
  final bool? enableBorder;
  final double? hintFontSize;
  SeconderySTextFormField(
      {Key? key,
      this.color,
      this.height,
      this.hintFontSize,
      this.maxLines,
      this.enableBorder,
      this.suffix,
      this.controller,
      this.titleHeader,
      this.readOnly,
      this.onChanged,
      this.lengthLimitingTextInputFormatter,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            titleHeader != null
                ? Text(
                    titleHeader ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),
                  )
                : Container(),
          ],
        ),
        titleHeader != null
            ? SizedBox(
                height: 10.w,
              )
            : Container(),
        Container(
          height: height ?? 48.w,
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            maxLines: maxLines ?? 1,
            readOnly: readOnly ?? false,
            onChanged: onChanged,
            inputFormatters: [
              lengthLimitingTextInputFormatter ??
                  LengthLimitingTextInputFormatter(1000),
            ],
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: suffix,
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              contentPadding: EdgeInsets.only(
                  left: 10.w, top: maxLines != null ? 30.w : 0.w),
              hintStyle: TextStyle(
                  fontSize: hintFontSize ?? 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffB7B7B7)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.w,
                  color: enableBorder ?? false
                      ? Color(0xffE0E0E0)
                      : Color(0xffEFEFEF),
                ),
                borderRadius: BorderRadius.circular(5.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.w,
                  color: enableBorder ?? false
                      ? Color(0xffE0E0E0)
                      : Color(0xffEFEFEF),
                ),
                borderRadius: BorderRadius.circular(5.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MobileNoTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enableOrder;

  const MobileNoTextFormField(
      {Key? key, this.enableOrder, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initialCountry = 'IN';
    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    return Stack(
      children: [
        // Positioned(
        //   bottom: 1,
        //   top: 1,
        //   left: 0,
        //   child: Center(
        //     child: Container(
        //       width: 70.h,
        //       decoration: BoxDecoration(
        //         // border: Border.all(
        //         //     color:
        //         //         enableOrder ?? false ? Color(0xffE0E0E0) : Colors.white),
        //       ),
        //     ),
        //   ),
        // ),
        Container(
          height: 48.w,
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              print(number.phoneNumber);
            },
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: const SelectorConfig(
                leadingPadding: 10,
                trailingSpace: false,
                // useEmoji: true,
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                // setSelectorButtonAsPrefixIcon: true,
                setSelectorButtonAsPrefixIcon: false),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            initialValue: number,
            textFieldController: controller,
            // formatInput: true,
            // fillColor: Colors.white,
            inputBorder: InputBorder.none,
            inputDecoration: InputDecoration(
                hintText: "Phone Number",
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffB7B7B7),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      width: 1.w,
                      color: enableOrder ?? false
                          ? Color(0xffE0E0E0)
                          : Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                fillColor: Colors.white,
                contentPadding: EdgeInsets.only(top: 10.w, left: 10.w),
                filled: true),
            // filled: true,
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            // inputBorder: OutlineInputBorder(),

            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
        )
      ],
    );
  }
}

class MobileNoFormField extends StatelessWidget {
  const MobileNoFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final read = context.read<MobileNoController>();
    final watch = context.watch<MobileNoController>();
    return Container(
      margin: EdgeInsets.only(right: 0.w),
      width: 101.w,
      child: InkWell(
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: true,
            onSelect: (Country country) {
              read.onCountrySelected(country.phoneCode, country.flagEmoji);
              print("flag :${country.flagEmoji}");
              print('Select country: ${country.displayName}');
            },
          );
        },
        child: Container(
          height: 30.w,
          child: Row(
            children: [
              SizedBox(
                width: 7.w,
              ),
              Text(
                watch.flagIcon,
                style: TextStyle(fontSize: 20.sp),
              ),
              Text("${watch.countryCode}"),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Color(0xff4D4D4D),
              ),
            ],
          ),
        ),
      ),

      // InternationalPhoneNumberInput(
      //   onInputChanged:(code){
      //   },
      //   onInputValidated: (bool value) {
      //     print(value);
      //   },
      //   selectorConfig: SelectorConfig(
      //     leadingPadding: 10.w,
      //     trailingSpace: false,
      //     useEmoji: false,
      //     showFlags: true,
      //     setSelectorButtonAsPrefixIcon: true,
      //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      //   ),
      //   ignoreBlank: false,
      //   autoValidateMode: AutovalidateMode.disabled,
      //   selectorTextStyle: TextStyle(color: Colors.black),
      //   initialValue: number,
      //   textFieldController: controller,
      //   formatInput: true,
      //   inputDecoration: InputDecoration(
      //     border: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.transparent),
      //     ),
      //     focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(
      //         color: Colors.transparent,
      //       ),
      //     ),
      //     enabledBorder: OutlineInputBorder(
      //       borderSide: BorderSide(
      //         color: Colors.transparent,
      //       ),
      //     ),
      //     contentPadding: EdgeInsets.zero,
      //   ),
      //   keyboardType: TextInputType.numberWithOptions(
      //       signed: true, decimal: true),
      //   inputBorder: OutlineInputBorder(),
      //   onSaved: (PhoneNumber number) {
      //     print('On Saved: $number');
      //   },
      // ),
    );
  }
}

class MobileNoController extends ChangeNotifier{
  String flagIcon = "";
  String countryCode = "+91";
  void onCountrySelected(code, icon) {
    countryCode = "+" + code;
    flagIcon = icon;
    notifyListeners();
  }
}

