import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
import 'package:local_supper_market/utils/Utils.dart';

class ShopRegistrationController extends ChangeNotifier {
  TextEditingController mobController = TextEditingController();
  RegistrationDataRepo registrationDataRepo = RegistrationDataRepo();
  List<CountryData>? countryList;
  List<StateData>? stateList;
  String message = "";
  int countryId = 0;

  Future<void> initState(context) async {
    await getCountryList(context);
  }

  void onOtpSubmitBtnPressed(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SKycVerificationView()),
    );
  }

  Future<void> getCountryList(context) async {
    registrationDataRepo.getCountryList().then((response) {
      print(response.statusCode);
      print(response.body);
      final result =
      GetCountryListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");
        countryList = result.countryData;
        notifyListeners();
      }
      else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
          (Object e) {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e)
      {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  GetStateListReqModel get _stateListReqModel =>
      GetStateListReqModel(
        countryId: countryId.toString(),
      );

  Future<void> onCountrySelected(value) async {
    countryId = int.parse(value.toString());
    notifyListeners();
  }


  Future<void> getStateList(context) async {
    registrationDataRepo.getStateList(_stateListReqModel).then((response) {
      final result = GetStateListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        stateList = result.stateData;
        if(result.stateData!.isEmpty){
          Utils.showPrimarySnackbar(context,"No State Found",
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
        test: (Object e)
    {
      Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      return false;
    },
  );
}

  Future<void> onStateSelected(value) async {
    countryId = int.parse(value.toString());
    notifyListeners();
  }

  Future<void> getCityList(context) async {
    registrationDataRepo.getStateList(_stateListReqModel).then((response) {
      final result = GetStateListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        stateList = result.stateData;
        if(result.stateData!.isEmpty){
          Utils.showPrimarySnackbar(context,"No State Found",
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
      test: (Object e)
      {
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }
}
