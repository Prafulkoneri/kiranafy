import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/bank_account_details/model/get_bank_account_model.dart';
import 'package:local_supper_market/screen/shop_owner/bank_account_details/model/update_account_detail.dart';
import 'package:local_supper_market/screen/shop_owner/bank_account_details/repository/get_bank_account_detail_repo.dart';
import 'package:local_supper_market/screen/shop_owner/bank_account_details/repository/update_add_bank_account_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SBankAccountController extends ChangeNotifier {
  bool isLoading = true;
  String accountType = "";
  BankDetailData? bankData;
  GetBankAccountDetailRepo getBankAccountDetailRepo =
      GetBankAccountDetailRepo();
  UpdateAddAccountDetailRepo upadteAddBankAccountDetailRepo =
      UpdateAddAccountDetailRepo();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController iFSCCodeController = TextEditingController();
  TextEditingController bankBranchController = TextEditingController();
  Future<void> initState(context) async {
    await getBankAccountDetails(context);
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getBankAccountDetails(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    getBankAccountDetailRepo
        .getBankDetail(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = GetBankDetailModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        bankData = result.bankData;
        bankNameController.text = bankData?.nameOfBank ?? "";
        accountHolderNameController.text = bankData?.accountHolderName ?? "";
        accountNumberController.text = bankData?.accountNumber ?? "";
        accountType = bankData?.typeOfAccount ?? "";
        iFSCCodeController.text = bankData?.ifscCode ?? "";
        bankBranchController.text = bankData?.bankBranch ?? "";

        // favouriteToShopsList =
        // orderedButNotFavouriteList =
        //     customerListData?.orderedButNotFavouriteList;

        showLoader(false);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  Future<void> onSelectAccountType(value) async {
    accountType = value;
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////////////
  BankAccountUpadateRequestModel get updateBankAccountDetailRequestModel =>
      BankAccountUpadateRequestModel(
          nameOfBank: bankNameController.text,
          accountHolderName: accountHolderNameController.text,
          accountNumber: accountNumberController.text,
          bankBranch: bankBranchController.text,
          ifscCode: iFSCCodeController.text,
          typeOfAccount: accountType.toLowerCase());

  Future<void> updateAccountDetails(context) async {
    if (bankNameController.text == "") {
      Utils.showPrimarySnackbar(context, "Please Enter Bank Name",
          type: SnackType.error);
      return;
    }
    if (accountHolderNameController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter  Account Holder Name",
          type: SnackType.error);
      return;
    }
    if (accountNumberController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Account Number",
          type: SnackType.error);
      return;
    }
    if (bankBranchController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Bank Branch",
          type: SnackType.error);
      return;
    }
    if (iFSCCodeController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter IFSC Code",
          type: SnackType.error);
      return;
    }

    if (accountType == "") {
      Utils.showPrimarySnackbar(context, "Select Account Type",
          type: SnackType.error);
      return;
    }
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    upadteAddBankAccountDetailRepo
        .upadteAccount(
            updateBankAccountDetailRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          BankAccountUpadateResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        // groupValue = "";
        // promotionSubjectController.clear();
        // planToStartController.clear();
        // adsContentController.clear();
        LoadingOverlay.of(context).hide();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => SMainScreenView(
                  index: 4,
                  screenName: SAccountScreenView(
                    refresh: true,
                  ))),
          (Route<dynamic> route) => false,
        );
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        print(response.body);

        notifyListeners();
      } else {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }
}
