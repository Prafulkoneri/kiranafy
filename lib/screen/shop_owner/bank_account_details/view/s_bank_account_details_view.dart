import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:local_supper_market/screen/shop_owner/bank_account_details/controller/get_bank_account_controll.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/widget/app_bar.dart';
import 'package:local_supper_market/widget/dropdown_field.dart';
import 'package:local_supper_market/widget/textfield.dart';
import 'package:provider/provider.dart';

class ShopBankAccountDetailsView extends StatefulWidget {
  const ShopBankAccountDetailsView({super.key});

  @override
  State<ShopBankAccountDetailsView> createState() =>
      _ShopBankAccountDetailsViewState();
}

class _ShopBankAccountDetailsViewState
    extends State<ShopBankAccountDetailsView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<SBankAccountController>().initState(
            context,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SBankAccountController>();
    final read = context.read<SBankAccountController>();
    final readMainScreen = context.read<SMainScreenController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.w),
        child: PrimaryAppBar(
          onBackBtnPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SMainScreenView(
                      index: 4,
                      screenName: SAccountScreenView(
                        refresh: false,
                      ))),
              (Route<dynamic> route) => false,
            );
          },
          title: "Bank A/C Details",
          action: SvgPicture.asset("assets/icons/forward.svg"),
          onActionTap: () async {
            await read.updateAccountDetails(context);
          },
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                          controller: watch.bankNameController,
                          titleHeader: "Name of the Bank",
                          hintText: "Enter Name of the Bank",
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        PrimarySTextFormField(
                          controller: watch.accountHolderNameController,
                          titleHeader: "Account Holder Name",
                          hintText: "Enter Account Name",
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        PrimarySTextFormField(
                          controller: watch.accountNumberController,
                          titleHeader: "Account Number",
                          hintText: "Enter Account Number",
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        // SDropDownField(
                        //   hint: "Select Type of Account",
                        //   titleHeader: "Type of Account",
                        // ),
                        watch.accountType == ""
                            ? SDropDownField(
                                titleHeader: "Type of Account",
                                onChanged: (value) {
                                  read.onSelectAccountType(value);
                                },
                                hint: "Select Type of Account",
                                items: [
                                  DropdownMenuItem(
                                    value: "current",
                                    child: Text(
                                      "Current",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "saving",
                                    child: Text(
                                      "Saving",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : SDropDownField(
                                value: watch.accountType,
                                titleHeader: "Type of Account",
                                onChanged: (value) {
                                  read.onSelectAccountType(value);
                                },
                                hint: "Select Type of Account",
                                items: [
                                  DropdownMenuItem(
                                    value: "current",
                                    child: Text(
                                      "Current",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "saving",
                                    child: Text(
                                      "Saving",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                        SizedBox(
                          height: 20.w,
                        ),
                        PrimarySTextFormField(
                          controller: watch.iFSCCodeController,
                          titleHeader: "IFSC Code",
                          hintText: "Enter IFSC Code",
                        ),
                        SizedBox(
                          height: 20.w,
                        ),
                        PrimarySTextFormField(
                          controller: watch.bankBranchController,
                          titleHeader: "Bank Branch",
                          hintText: "Enter Bank Branch",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                ],
              ),
            ),
    );
  }
}
