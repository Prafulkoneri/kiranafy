import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../const/color.dart';
import '../../widget/app_bar.dart';

class aboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "About Us",
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              SizedBox(
                height: 18.w,
              ),
              Text(
                "Massa odio turpis diam dui porta turpis. Fermentum dignissim proirn in nisl. Sit amet aliquam ullamcorper sed aliquam volutpat. Suscipit sem ullamcor",
                style: TextStyle(
                    color: Black, fontSize: 14.sp, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 18.w,
              ),
              Text(
                "per praesent fusce arcu placerat mi purus felis. Purus viverra ipsum tempor morbi tincidunt ullamcorper. Varius nisi facilisis ultrices neque lacinia aliquet aenean.",
                style: TextStyle(
                    color: Black, fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5.w,
              ),
              Text(
                "at. Eros id quam facilisi dolor. Viverra felis vivamus et eget tempus.",
                style: TextStyle(
                    color: Black, fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20.w,
              ),
              Text(
                "Risus eu hac sed elit velit accumsan. Tempor, ullamcorper nisi fermentum ipsum. Amet, lacinia tincidunt facilisis eget fringilla sed. Turpis dictumst ridiculus velit at sodales. Ornare enim tempus hendrerit.Turpis dictumst ridiculus velit at sodales. Ornare enim tempus hendrerit . ridiculus velit at sodales. Ornare enim tempus hendrerit",
                style: TextStyle(
                    color: Black, fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40.w,
              ),
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "2. Testmonial Review",
                      style: TextStyle(
                          color: Black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(
                    height: 30.w,
                  ),
                  Row(
                    children: [
                      Text(
                        "Varius nisi facilisis ultrices neque lacinia aliquet\n aenean",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "at. Eros id quam facilisi dolor. Viverra felis vivamus et eget tempus.",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.w,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        "3. Our working Process",
                        style: TextStyle(
                            color: Black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.w,
                  ),
                  Text(
                    "per praesent fusce arcu placerat mi purus felis. Purus viverra ipsum tempor morbi tincidunt ullamcorper. Varius nisi facilisis ultrices neque lacinia aliquet aenean",
                  ),
                  Row(
                    children: [
                      Text(
                        "at. Eros id quam facilisi dolor. Viverra felis vivamus et eget tempus.",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
