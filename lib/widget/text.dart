import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

//////Start//////
class AccountScreen extends StatelessWidget {
  final String text;

  const AccountScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Black, fontSize: 14.sp, fontWeight: FontWeight.w400),
      ),
    );
  }
}
////////////End////////////

class UpdateProfile extends StatelessWidget {
  final String text;

  const UpdateProfile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: Black, fontSize: 14.sp, fontWeight: FontWeight.w500),
    );
  }
}

////////////

class HomeSideHeading extends StatelessWidget {
  final String text;

  const HomeSideHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
            color: DarkBlack,
            letterSpacing: .5,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
/////////////////////////////////////

class SettingScreen extends StatelessWidget {
  final String text;

  const SettingScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 18.sp, fontWeight: FontWeight.w400, color: Black1),
    );
  }
}

///////////

class NearByShops extends StatelessWidget {
  final String text;
  final double? fontSize;

  const NearByShops({super.key, required this.text, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.white,
                // letterSpacing: .5,
                fontSize: fontSize ?? 13.sp,
                fontWeight: FontWeight.w600)));
  }
}
//////////////////

class NearByShopslocation extends StatelessWidget {
  final String text;

  const NearByShopslocation({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400)));
  }
}

///////////////////////////////
////////////////////////////////ShopOwner////////////////////
class ShopDashBoard extends StatelessWidget {
  final String text;

  const ShopDashBoard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Colors.white,
            letterSpacing: .5,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

//////////////////DashBoard Side Heading//////////
class DashBoardSideHeading extends StatelessWidget {
  final String text;

  const DashBoardSideHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Black1,
            // letterSpacing: .5,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

//////////////////DashBoard Count//////////////
class DashBoardCount extends StatelessWidget {
  final String text;

  const DashBoardCount({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Colors.white,
            // letterSpacing: .5,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

//////////////////////////Shop Name/////////////
class DashBoardShopName extends StatelessWidget {
  final String text;

  const DashBoardShopName({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}

//////////////////Rating///////////////
class ShopRating extends StatelessWidget {
  final String text;

  const ShopRating({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Black,
            letterSpacing: .5,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

/////////////////////ShopAddress///////////
class ShopAddress extends StatelessWidget {
  final String text;

  const ShopAddress({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Black,
            // letterSpacing: .5,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
///////////////////////Customer Coupons//////////////

class CouponsOneText extends StatelessWidget {
  final String text;

  const CouponsOneText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Black, fontSize: 12.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}
////////////////////////////////////////

class CouponsTwoText extends StatelessWidget {
  final String text;

  const CouponsTwoText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Black,
            letterSpacing: .5,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
////////////////////////////////////////////////////////

class CouponsThreeText extends StatelessWidget {
  final String text;

  const CouponsThreeText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.dmSans(
          textStyle: TextStyle(
              color: Black,
              letterSpacing: .5,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700),
        ));
  }
}

////////////////////////////////////////////////////////
class CouponsFourText extends StatelessWidget {
  final String text;

  const CouponsFourText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.dmSans(
          textStyle: TextStyle(
              color: Grey,
              letterSpacing: .5,
              fontSize: 10.sp,
              fontWeight: FontWeight.w400),
        ));
  }
}

///////////////////////////////////////////////////////
class CouponsFiveText extends StatelessWidget {
  final String text;

  const CouponsFiveText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: SplashText,
            // letterSpacing:
            //     .5,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
///////////////////////////////////////////////////////

class CouponsTitleText extends StatelessWidget {
  final String text;

  const CouponsTitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
              color: Black,
              letterSpacing: .5,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ));
  }
}
//////////////////////////////////////////////////////////

class CouponsOff extends StatelessWidget {
  final String text;

  const CouponsOff({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Black,
            letterSpacing: .5,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

/////////////////////////////////////////////////////////
class CouponsUpto extends StatelessWidget {
  final String text;

  const CouponsUpto({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.dmSans(
          textStyle: TextStyle(
              color: Grey,
              letterSpacing: .5,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400),
        ));
  }
}
///////////////////////////////////////

class Couponsode extends StatelessWidget {
  final String text;

  const Couponsode({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w700, fontSize: 16.sp, color: SplashText),
    );
  }
}

///////////////////////////////////////////////////////pLACE YOUR ADD////////////////
class PlaceYourAdd extends StatelessWidget {
  final String text;

  const PlaceYourAdd({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500),
    );
  }
}

///////////////////////////////////////////////////
class UnitAndWeight extends StatelessWidget {
  final String text;

  const UnitAndWeight({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Grey,
            letterSpacing: .5,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

//////////////////////////////
class ProductName extends StatelessWidget {
  final String text;

  const ProductName({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Black,
            letterSpacing: .5,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

////////////////////////////////////////////////////////
class OfferPrice extends StatelessWidget {
  final String text;

  const OfferPrice({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.dmSans(
          textStyle: TextStyle(
              // decoration:
              // TextDecoration.lineThrough,
              color: Black,
              letterSpacing: .5,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500),
        ));
  }
}
///////////////////////////////////////////////////////////////

class OrderSummery extends StatelessWidget {
  final String text;

  const OrderSummery({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Black1,
            letterSpacing: .5,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
///////////////////////////////////////////////////////////

class CReview extends StatelessWidget {
  final String text;

  const CReview({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
          textStyle: TextStyle(
              color: Black, fontSize: 16.sp, fontWeight: FontWeight.w800)),
    );
  }
}
///////////////////////////////////////////////////////////

class CReviewone extends StatelessWidget {
  final String text;
  final double? fontSize;

  const CReviewone({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: grey5,
            //  fontSize: 12.sp,
            fontSize: fontSize ?? 12.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
///////////////////////////////
