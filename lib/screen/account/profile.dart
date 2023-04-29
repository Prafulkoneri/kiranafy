import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/screen/account/update_profile_view.dart';
import 'package:local_supper_market/screen/cart/view/cart_detail.dart';
import 'package:local_supper_market/screen/my_order/my_order.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Profile"),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 30.h,
              width: 120.w,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  // backgroundColor: ,
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: SplashText,
                        // width: 1,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdateProfileView()),
                  );
                },
                child: Text(
                  "Edit Peofile",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: SplashText,
                        // letterSpacing: .5,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                //
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 30.h,
              width: 120.w,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  // backgroundColor: ,
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: SplashText,
                        // width: 1,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyOrder()),
                  );
                },
                child: Text(
                  "My Orders",
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                        color: SplashText,
                        // letterSpacing: .5,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                //
              ),
            ),
          ],
        ),
      ),
    );
  }
}
