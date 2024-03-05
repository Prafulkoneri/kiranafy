import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double  rating;
  final RatingChangeCallback  onRatingChanged;
  final Color ? color;

  const StarRating({super.key, this.starCount = 5, this.rating = .0,required this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Widget icon;
    if (index >= rating) {
      icon = Padding(
        padding:  EdgeInsets.only(right: 9.77.w),
        child: SvgPicture.asset(
            "assets/icons/order_rating.svg"),
      );
    }
    // else if (index > rating - 1 && index < rating) {
    //   icon = new Icon(
    //     Icons.star_half,
    //     color: color ?? Theme.of(context).primaryColor,
    //   );
    // }
    else {
      icon =Padding(
       padding: EdgeInsets.only(right: 9.77.w),
        child: SvgPicture.asset(
            "assets/icons/order_rating.svg",color: Colors.yellow,),
      );
    }
    return InkResponse(
      onTap: onRatingChanged == null ? null : () {
        onRatingChanged(index + 1.0);
        },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: List.generate(starCount, (index) => buildStar(context, index)));
  }
}