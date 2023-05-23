import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PrimaryRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const PrimaryRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        child: Row(
          children: [
            _customRadioButton,
            // if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      height: 16.w,
      width: 16.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 1.w,
        ),
      ),
      child:Center(
        child: isSelected?Container(
          height: 9.14.w,
          width: 9.14.w,

          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle
          ),
        ):Container(),
      )
    );
  }
}

class SecondaryRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const SecondaryRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        child: Row(
          children: [
            _customRadioButton,
            // if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
        height: 16.w,
        width: 16.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(0xff03C9CC),
            width: 1.w,
          ),
        ),
        child:Center(
          child: isSelected?Container(
            height: 9.14.w,
            width: 9.14.w,

            decoration: BoxDecoration(
                color: Color(0xff03C9CC),
                shape: BoxShape.circle
            ),
          ):Container(),
        )
    );
  }
}
