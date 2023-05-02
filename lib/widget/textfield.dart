import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PrimaryTextFormField extends StatelessWidget {
  final String? titleHeader;
  final bool? readOnly;
  void Function(String)? onChanged;
  final LengthLimitingTextInputFormatter? lengthLimitingTextInputFormatter;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffix;

  PrimaryTextFormField(
      {Key? key,
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
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.7)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffEFEFEF),
                ),
                borderRadius: BorderRadius.circular(10.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffEFEFEF),
                ),
                borderRadius: BorderRadius.circular(10.w),
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

  const MobileNoTextFormField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initialCountry = 'IN';
    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    return Stack(
      children: [
        Positioned(
          bottom: 1,
          top: 1,
          left: 0,
          child: Container(
            // height: 200.h,
            width: 70.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7.w),
            ),
          ),
        ),
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
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                fillColor: Colors.white,
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
