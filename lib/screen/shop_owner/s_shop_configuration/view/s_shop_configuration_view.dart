import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
class SShopConfigurationView extends StatefulWidget {
  const SShopConfigurationView({Key? key}) : super(key: key);

  @override
  _SShopConfigurationViewState createState() => _SShopConfigurationViewState();
}

class _SShopConfigurationViewState extends State<SShopConfigurationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Select Categories",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: (){

            // read.onAppBarActionPressed(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 19.w,right: 19.w,top: 26.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload Payment QR Code Image",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color:Black1),),
            SizedBox(
              height: 10.w,
            ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: (Color(0xffEFEFEF)))
                ),
                height: 142.w,
                width:ScreenUtil().screenWidth,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/upload.svg"),
                      SizedBox(
                        height: 6.w,
                      ),
                      Text('Upload QR Code',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.sp,color: Color(0xffB7B7B7)),),
                      SizedBox(
                        height: 20.w,
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.w,
              ),
              PrimarySTextFormField(
                hintText: "Type UPI ID",
                titleHeader: "UPI ID",
              ),
              SizedBox(
                height: 20.w,
              ),
              Container(
                width: 140.w,
                child: Text("Shop Timing",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Color(0xff3A3A3A)),),
              ),
              SizedBox(
                height: 10.w,
              ),
    Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 155.w,
          child: SDropDownField(
            hint: "Opening Time",
          ),
        ),
        Container(
          width: 155.w,
          child: SDropDownField(
            hint: "Closing Time",
          ),
        ),
      ],
    ),
              SizedBox(
                height: 20.w,
              ),
              PrimarySTextFormField(
                titleHeader: "Support Number",
                hintText: "Enter Support Number",
              ),
              SizedBox(
                height: 40.w,
              ),
              Text("Delivery Type",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.sp),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    side: MaterialStateBorderSide.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return BorderSide(
                              width: 1, color: SplashText);
                        }
                        return BorderSide(width: 0, color: Grey);
                      },
                    ),
                    checkColor: Colors.white,
                    activeColor: SplashText,
                    value: false,
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                  ),
                  Text(
                    'Customer Pickup',
                    style:  TextStyle(
                          color: Black1,
                          // letterSpacing: .5,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 30.w
                    ,
                  ),
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    side: MaterialStateBorderSide.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return BorderSide(
                              width: 1, color: SplashText);
                        }
                        return BorderSide(width: 0, color: Grey);
                      },
                    ),
                    checkColor: Colors.white,
                    activeColor: SplashText,
                    value: true,
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                  ),
                  
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.w),
                      child: Text(
                        'Deliver To Customer',
                        style:  TextStyle(
                            color: Black1,
                            // letterSpacing: .5,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 45.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 155.w,
                    child: Text("Order Amount",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),),
                  ),
                  Container(
                    width: 155.w,
                    child: Text("Delivery Charge",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),),
                  ),
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 155.w,
                    child: SDropDownField(
                      hint: "1 to 500",
                    ),
                  ),
                  Container(
                    width: 155.w,
                    child: SDropDownField(
                      hint: "Delivery Charge",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 17.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 155.w,
                    child: Text("Order Amount",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),),
                  ),
                  Container(
                    width: 155.w,
                    child: Text("Delivery Charge",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),),
                  ),
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 155.w,
                    child: SDropDownField(
                      hint: "500 to 1200",
                    ),
                  ),
                  Container(
                    width: 155.w,
                    child: SDropDownField(
                      hint: "Delivery Charge",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 17.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 155.w,
                    child: Text("Order Amount",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),),
                  ),
                  Container(
                    width: 155.w,
                    child: Text("Delivery Charge",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),),
                  ),
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 155.w,
                    child: SDropDownField(
                      hint: "1200 to 2500",
                    ),
                  ),
                  Container(
                    width: 155.w,
                    child: SDropDownField(
                      hint: "Delivery Charge",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 17.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 155.w,
                    child: Text("Order Amount",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),),
                  ),
                  Container(
                    width: 155.w,
                    child: Text("Delivery Charge",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: Color(0xff3A3A3A)),),
                  ),
                ],
              ),
              SizedBox(
                height: 10.w,
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 155.w,
                    child: SDropDownField(
                      hint: "2500 to 5000",
                    ),
                  ),
                  Container(
                    width: 155.w,
                    child: SDropDownField(
                      hint: "Delivery Charge",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 37.w,
              ),
              Text("Slot Selection",style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Color(0xff3A3A3A)),),
              SizedBox(
                height: 15.w,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    side: MaterialStateBorderSide.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return BorderSide(
                              width: 1, color: SplashText);
                        }
                        return BorderSide(width: 0, color: Grey);
                      },
                    ),
                    checkColor: Colors.white,
                    activeColor: SplashText,
                    value: false,
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                  ),
                  Text(
                    '9am to 12pm',
                    style:  TextStyle(
                        color: Black1,
                        // letterSpacing: .5,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    side: MaterialStateBorderSide.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return BorderSide(
                              width: 1, color: SplashText);
                        }
                        return BorderSide(width: 0, color: Grey);
                      },
                    ),
                    checkColor: Colors.white,
                    activeColor: SplashText,
                    value: true,
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                  ),

                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.w),
                      child: Text(
                        '3pm to 6pm',
                        style:  TextStyle(
                            color: Black1,
                            // letterSpacing: .5,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 12.w,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    side: MaterialStateBorderSide.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return BorderSide(
                              width: 1, color: SplashText);
                        }
                        return BorderSide(width: 0, color: Grey);
                      },
                    ),
                    checkColor: Colors.white,
                    activeColor: SplashText,
                    value: false,
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                  ),
                  Text(
                    '9am to 12pm',
                    style:  TextStyle(
                        color: Black1,
                        // letterSpacing: .5,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    side: MaterialStateBorderSide.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return BorderSide(
                              width: 1, color: SplashText);
                        }
                        return BorderSide(width: 0, color: Grey);
                      },
                    ),
                    checkColor: Colors.white,
                    activeColor: SplashText,
                    value: true,
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                  ),

                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.w),
                      child: Text(
                        '3pm to 6pm',
                        style:  TextStyle(
                            color: Black1,
                            // letterSpacing: .5,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 50.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
