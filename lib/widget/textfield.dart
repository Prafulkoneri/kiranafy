import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/services.dart';

class PrimaryCTextFormField extends StatelessWidget {
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
  final Color? borderColor;
  final void Function()? onTap;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextInputType? textInputType;

  PrimaryCTextFormField(
      {Key? key,
      this.onTap,
      this.textStyle,
      this.borderColor,
      this.maxLines,
      this.height,
      this.width,
      this.hintStyle,
      this.color,
      this.enableBorder,
      this.suffix,
      this.controller,
      this.titleHeader,
      this.readOnly,
      this.textInputType,
      this.onChanged,
      this.lengthLimitingTextInputFormatter,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleHeader != null
            ? Row(
                children: [
                  Text(
                    titleHeader ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),
                  ),
                ],
              )
            : Container(),
        titleHeader != null
            ? SizedBox(
                height: 10.w,
              )
            : Container(),
        Container(
          height: height ?? 48.w,
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            keyboardType: textInputType,
            style: textStyle,
            onTap: onTap,
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
              contentPadding: EdgeInsets.only(left: 10.w),
              hintStyle: hintStyle ??
                  TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB7B7B7)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.w,
                  color: borderColor ?? Color(0xffEFEFEF),
                ),
                borderRadius: BorderRadius.circular(5.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Color(0xffE0E0E0),
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
  final EdgeInsetsGeometry? padding;
  final TextInputType? textInputType;
  final void Function()? onTap;

  PrimarySTextFormField(
      {Key? key,
      this.color,
      this.onTap,
      this.padding,
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
      this.textInputType,
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
            onTap: onTap,
            maxLines: maxLines ?? 1,
            keyboardType: textInputType,
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
              contentPadding: padding ??
                  EdgeInsets.only(
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
  final void Function(CountryCode)? onCountryCodeChanged;
  final void Function(String)? onChanged;
  final String? initialSelection;
  final bool? readOnly;
  // final String? hint

  const MobileNoTextFormField({
    Key? key,
    this.enableOrder,
    this.readOnly,
    this.onChanged,
    this.initialSelection,
    required this.controller,
    this.onCountryCodeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initialCountry = 'IN';
    PhoneNumber number = PhoneNumber(isoCode: 'IN');
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              color: Colors.white,
              border: Border.all(
                  color: enableOrder ?? false
                      ? Color(0xffE0E0E0)
                      : Color(0xffEFEFEF))),
          child: CountryCodePicker(
            enabled: readOnly == true ? false : true,
            flagWidth: 20.w,
            flagDecoration: BoxDecoration(),
            padding: EdgeInsets.zero,
            onChanged: onCountryCodeChanged,
            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: 'IN',
            showFlagDialog: true,
            showFlag: true,
            showFlagMain: true,
            favorite: const ['+91'],
            textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xffB7B7B7)),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: PrimarySTextFormField(
            readOnly: readOnly,
            controller: controller,
            lengthLimitingTextInputFormatter:
                LengthLimitingTextInputFormatter(10),
            onChanged: onChanged,
            hintText: "Mobile Number",
            textInputType: TextInputType.number,
            padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 10.w),
          ),
        ),
      ],
    );
  }
}

class MobileNoController extends ChangeNotifier {
  String flagIcon = "";
  String countryCode = "+91";

  void onCountrySelected(code, icon) {
    countryCode = "+" + code;
    flagIcon = icon;
    notifyListeners();
  }
}
