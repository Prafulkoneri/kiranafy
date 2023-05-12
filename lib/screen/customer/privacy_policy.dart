import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/color.dart';
import '../../widget/app_bar.dart';

 void main() {
  runApp(privacyPolicy());
}

class privacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Privacy Policy",
          onActionTap: () {},
        ),
      ),
        body:  SingleChildScrollView(
          

           child: Container(
             width: ScreenUtil().screenWidth,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
            children: [
              SizedBox(
                height: 18.w,
              ),
         
               Text(
              "Massa odio turpis diam dui porta turpis. Fermentum dignissim proin in nisl. Sit amet aliquam ullamcorper sed aliquam volutpat. Suscipit sem ullamcor \n\n\n per praesent fusce arcu placerat mi purus felis. Purus viverra ipsum tempor morbi tincidunt ullamcorper. Varius nisi facilisis ultrices neque lacinia aliquet aenean \nat. Eros id quam facilisi dolor. Viverra felis vivamus et eget tempus.\n\n\nRisus eu hac sed elit velit accumsan. Tempor, ullamcorper nisi fermentum ipsum. Amet, lacinia tincidunt facilisis eget fringilla sed. Turpis dictumst ridiculus velit at sodales. Ornare enim tempus hendrerit.Turpis dictumst ridiculus velit at sodales. Ornare enim tempus hendrerit . Ridiculus velit at sodales. Ornare enim tempus hendrerit",
            style: TextStyle(
                                 color: Black,
                                 fontSize: 14.sp,
                                 ),
            
            ),
        
         SizedBox(
                height: 18.w,
              ),
            ],
             
          ),
     
        ),
        ),
    );
  }
}