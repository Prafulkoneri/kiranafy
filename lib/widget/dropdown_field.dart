import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CDropDownField extends StatefulWidget {
  final String? hint;
  final Function(dynamic)? onChanged;
  final List<DropdownMenuItem>? items;
  final String? titleHeader;
  final String? value;

  const CDropDownField(
      {Key? key,
      this.value,
      this.hint,
      this.onChanged,
      this.items,
      this.titleHeader})
      : super(key: key);

  @override
  _CDropDownFieldState createState() => _CDropDownFieldState();
}

class _CDropDownFieldState extends State<CDropDownField> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titleHeader ?? "",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Color(0xff3A3A3A)),
        ),
        SizedBox(
          height: 10.w,
        ),
        DropdownButtonFormField2(
          value: widget.value,
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            //Add isDense true and zero Padding.
            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
            isDense: true,
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffEFEFEF))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffEFEFEF))),
            //Add more decoration as you want here
            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
          ),
          isExpanded: true,
          hint: Text(
            widget.hint ?? "",
            style: TextStyle(fontSize: 14),
          ),
          items: widget.items,
          validator: (value) {
            if (value == null) {
              return 'Please select gender.';
            }
            return null;
          },
          onChanged:widget.onChanged,
          onSaved: (value) {
            selectedValue = value.toString();
          },
          buttonStyleData: ButtonStyleData(
            height: 48.w,
            // padding: EdgeInsets.only(left: 20, right: 10),
          ),
          iconStyleData:  IconStyleData(
            icon: Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Color(0xff3A3A3A),
              ),
            ),
            iconSize: 20,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}

class SDropDownField extends StatefulWidget {
  final String? hint;
  final Function(dynamic)? onChanged;
  final List<DropdownMenuItem>? items;
  final String? titleHeader;
  final String? value;
  final double? hintSize;
  final double? height;
  final EdgeInsets? iconPadding;

  const SDropDownField(
      {Key? key,
      this.value,
      this.iconPadding,
      this.height,
      this.hint,
      this.hintSize,
      this.onChanged,
      this.items,
      this.titleHeader})
      : super(key: key);

  @override
  _SDropDownFieldState createState() => _SDropDownFieldState();
}

class _SDropDownFieldState extends State<SDropDownField> {
  // final List<String> genderItems = [
  //   'Male',
  //   'Female',
  // ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.titleHeader != null
            ? Text(
                widget.titleHeader ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xff3A3A3A)),
              )
            : Container(),
        widget.titleHeader != null
            ? SizedBox(
                height: 10.w,
              )
            : Container(),
        Container(
          // height: 45.w,
          child: DropdownButtonFormField2(
            value: widget.value,
            isDense: true,
            decoration: InputDecoration(
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.w),
                  borderSide: BorderSide(color: Color(0xffEFEFEF))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.w),
                  borderSide: BorderSide(color: Color(0xffEFEFEF))),
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
            ),
            isExpanded: true,
            hint: Text(
              widget.hint ?? "",
              style: TextStyle(
                  fontSize: widget.hintSize ?? 16.sp,
                  color: Color(0xffB7B7B7),
                  fontWeight: FontWeight.w400),
            ),
            items: widget.items,
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: widget.onChanged,
            onSaved: (value) {
              selectedValue = value.toString();
            },
            buttonStyleData: ButtonStyleData(
              height: widget.height ?? 48.w,
              // padding: EdgeInsets.only(left: 20, right: 10),
            ),
            iconStyleData: IconStyleData(
              icon: Padding(
                padding: widget.iconPadding ?? EdgeInsets.only(right: 22.w),
                child: SvgPicture.asset("assets/icons/dropdown.svg"),
              ),
              // iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffE0E0E0)),
                borderRadius: BorderRadius.circular(5.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
