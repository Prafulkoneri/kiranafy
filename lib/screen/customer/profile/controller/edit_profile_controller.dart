import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/customer/account/model/profile_detail_cmodel.dart';
import 'package:local_supper_market/screen/customer/account/repository/c_profile_repo.dart';
import 'package:local_supper_market/screen/customer/account/repository/edit_profile_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_address/view/my_delivery_address.dart';
import 'package:local_supper_market/screen/customer/my_order/view/my_order_view.dart';
import 'package:local_supper_market/screen/customer/profile/model/update_profile_model.dart';
import 'package:local_supper_market/screen/customer/profile/repository/update_profile_repo.dart';
import 'package:local_supper_market/screen/customer/profile/view/update_profile_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileController extends ChangeNotifier {
  EditCustomerProfileRepo editCustomerProfileRepo = EditCustomerProfileRepo();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobilrController = TextEditingController();
  TextEditingController alernetMobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<void> initState(
    context,
  ) async {
    await getCustoerProfileDetails(context);
  }

  EditCustomerProfileRepo customerProfileRepo = EditCustomerProfileRepo(); ////;

  /////End Detail Profile

  Future<void> getCustoerProfileDetails(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    editCustomerProfileRepo
        .editCustomerProfileRepo(pref.getString("successToken"))
        .then((response) {
      final result = CustomerEditProfileDetails.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        final CustomerProfileDetails = result.customerProfileDetails;
        print(CustomerProfileDetails);
        log("${response.body}");
        nameController.text = CustomerProfileDetails?.customerName ?? "";
        mobilrController.text =
            CustomerProfileDetails?.customerMobileNumber.toString() ?? "";
        alernetMobileController.text =
            CustomerProfileDetails?.customerAlternateMobileNumber.toString() ??
                "";
        addressController.text = CustomerProfileDetails?.customerAddress ?? "";
        dateOfBirthController.text =
            CustomerProfileDetails?.customerDateOfBirth ?? "";
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
}
