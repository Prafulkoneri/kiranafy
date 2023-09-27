import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';

class AccountScreen extends StatelessWidget {
  final String text;

  AccountScreen({required this.text});

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
////////////

class UpdateProfile extends StatelessWidget {
  final String text;

  UpdateProfile({required this.text});

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

  HomeSideHeading({required this.text});

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
///////////

class NearByShops extends StatelessWidget {
  final String text;
  final double? fontSize;

  NearByShops({required this.text, this.fontSize});

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

  NearByShopslocation({required this.text});

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

  ShopDashBoard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Colors.white,
            // letterSpacing: .5,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

//////////////////DashBoard Side Heading//////////
class DashBoardSideHeading extends StatelessWidget {
  final String text;

  DashBoardSideHeading({required this.text});

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

  DashBoardCount({required this.text});

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

  DashBoardShopName({required this.text});

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

  ShopRating({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            color: Black,
            // letterSpacing: .5,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

/////////////////////ShopAddress///////////
class ShopAddress extends StatelessWidget {
  final String text;

  ShopAddress({required this.text});

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
