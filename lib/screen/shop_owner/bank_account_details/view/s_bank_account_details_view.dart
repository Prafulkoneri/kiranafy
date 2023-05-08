import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:local_supper_market/const/color.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';

class ShopBankAccountDetailsView extends StatefulWidget {
  const ShopBankAccountDetailsView({super.key});

  @override
  State<ShopBankAccountDetailsView> createState() =>
      _ShopBankAccountDetailsViewState();
}

final TextEditingController controller = TextEditingController();
String initialCountry = 'IN';
PhoneNumber number = PhoneNumber(isoCode: 'IN');
String radioButtonItem = '';
String? dropdown;
final maxLines = 5;
final List<String> genderItems = [
  'Male',
  'Female',
];

String? selectedValue;
// Group Value fo
// r Radio Button.
int id = 1;

class _ShopBankAccountDetailsViewState
    extends State<ShopBankAccountDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.w),
        child: PrimaryAppBar(
          title: "Bank A/C Details",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Name of the Bank",
                    hintText: "Enter Name of the Bank",
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Account Holder Name",
                    hintText: "Enter Account Name",
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Account Number",
                    hintText: "Enter Account Number",
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  SDropDownField(
                    hint: "Select Type of Account",
                    titleHeader: "Type of Account",
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "IFSC Code",
                    hintText: "Enter IFSC Code",
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  PrimarySTextFormField(
                    titleHeader: "Bank Branch",
                    hintText: "Enter Bank Branch",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22.w,
            ),
          ],
        ),
      ),
    );
  }
}
