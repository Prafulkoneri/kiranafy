import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
import 'package:local_supper_market/utils/utils.dart';

class ShopRegistrationController extends ChangeNotifier {

  RegistrationDataRepo registrationDataRepo = RegistrationDataRepo();
  List<CountryData>? countryList;
  List<StateData>? stateList;
  List<CityData>? cityList;
  List<AreaData>? areaList;
  TextEditingController shopNameController =TextEditingController();
  TextEditingController ownerNameController =TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController emailIdController =TextEditingController();
  TextEditingController addressController =TextEditingController();
  TextEditingController pincodeController =TextEditingController();
  TextEditingController upiController =TextEditingController();
  String message = "";
  int countryId = 0;
  int stateId = 0;
  int cityId = 0;

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
    stateId = int.parse(value.toString());
    notifyListeners();
  }

  GetCityListReqModel get _cityListReqModel =>
      GetCityListReqModel(
        stateId: stateId.toString(),
      );

  Future<void> getCityList(context) async {
    registrationDataRepo.getCityList(_cityListReqModel).then((response) {
      final result = GetCityListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        cityList = result.cityData;
        if(result.cityData!.isEmpty){
          Utils.showPrimarySnackbar(context,"No City Found",
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

  Future<void> onCitySelected(value) async {
    cityId = int.parse(value.toString());
    notifyListeners();
  }

  GetAreaListReqModel get _areaListReqModel =>
      GetAreaListReqModel(
        cityId: cityId.toString(),
      );

  Future<void> getAreaList(context) async {
    registrationDataRepo.getAreaList(_areaListReqModel).then((response) {
      final result = GetAreaListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        areaList = result.areaData;
        if(result.areaData!.isEmpty){
          Utils.showPrimarySnackbar(context,"No Area Found",
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

  Future<void> validateField()async{

  }


}
