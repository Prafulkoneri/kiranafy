import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/customer/profile/model/edit_profile_model.dart';

import 'package:local_supper_market/screen/customer/profile/repository/edit_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';

// import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shop_owner/s_auth/model/country_model.dart';

class UpdateProfileController extends ChangeNotifier {
  EditCustomerProfileRepo editCustomerProfileRepo = EditCustomerProfileRepo();
  RegistrationDataRepo registrationDataRepo = RegistrationDataRepo();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobilrController = TextEditingController();
  TextEditingController alernetMobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  int countryId = 0;
  int stateId = 0;
  List<CountryData>? countryList;
  List<StateData>? stateList;
  ////
  Future<void> initState(
    context,
  ) async {
    await getCustoerProfileDetails(context);
    await getCountryList(context);
    await getStateList(context);
  }

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

////////////Country
  Future<void> onCountrySelected(value) async {
    countryId = int.parse(value.toString());
    // print("nhjvwuriuiwbytiuywi");
    print(countryId);
    notifyListeners();
  }

  Future<void> getCountryList(context) async {
    registrationDataRepo.getCountryList(context).then((response) {
      print(response.statusCode);
      print(response.body);
      final result = GetCountryListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");
        countryList = result.countryData;
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

  ///////////State

  Future<void> onStateSelected(value) async {
    stateId = int.parse(value.toString());
    notifyListeners();
  }

  GetStateListReqModel get _stateListReqModel => GetStateListReqModel(
        countryId: countryId.toString(),
      );
  Future<void> getStateList(context) async {
    registrationDataRepo.getStateList(_stateListReqModel).then((response) {
      final result = GetStateListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        stateList = result.stateData;
        print("${stateList},uiyjjjjbwvymhbwnhhmwyhmbvhmwhvbh");
        if (result.stateData!.isEmpty) {
          Utils.showPrimarySnackbar(context, "No State Found",
              type: SnackType.error);
        }
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
  //////////City
}
