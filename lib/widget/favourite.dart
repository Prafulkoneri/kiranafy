import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavouriteView extends StatefulWidget {
  final bool? isFvrt;
  final void Function()? onPhoneTap;
  final void Function()? onFvrtTap;
  const FavouriteView(
      {super.key,
      required this.isFvrt,
      required this.onPhoneTap,
      required this.onFvrtTap});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: widget.onPhoneTap,
          child: Container(
              padding: EdgeInsets.only(
                  left: 13.w, right: 13.w, top: 14.w, bottom: 14.w),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff23AA49),
              ),
              child: SvgPicture.asset(
                "assets/icons/new_call.svg",
              )),
        ),
        SizedBox(
          width: 13.w,
        ),
        InkWell(
          onTap: widget.onFvrtTap,
          child: widget.isFvrt == true
              ? SvgPicture.asset(
                  "assets/icons/new_fvrt_selected.svg",
                )
              : SvgPicture.asset(
                  "assets/icons/new_fvrt_not_selected.svg",
                ),
        )
      ],
    );
  }
}
