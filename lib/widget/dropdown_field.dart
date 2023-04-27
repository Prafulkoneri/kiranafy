import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownField extends StatefulWidget {
  final String? hint;
  final Function(dynamic)? onChanged;
  final List<DropdownMenuItem>? items;
  final String? titleHeader;
  final String? value;

  const DropDownField(
      {Key? key,
      this.value,
      this.hint,
      this.onChanged,
      this.items,
      this.titleHeader})
      : super(key: key);

  @override
  _DropDownFieldState createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.titleHeader??"",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Color(0xff3A3A3A)),),
        SizedBox(
          height: 10.w,
        ),
        DropdownButtonFormField2(
          decoration: const InputDecoration(
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
              return 'Please select gender.';
            }
            return null;
          },
          onChanged: (value) {
            //Do something when changing the item if you want.
          },
          onSaved: (value) {
            selectedValue = value.toString();
          },
          buttonStyleData:  ButtonStyleData(
            height: 48.w,
            // padding: EdgeInsets.only(left: 20, right: 10),
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
      ],
    );
  }
}