import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/shop_owner_register_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/shop_owner_register_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
import 'package:local_supper_market/utils/utils.dart';

class ShopRegistrationController extends ChangeNotifier {
  RegistrationDataRepo registrationDataRepo = RegistrationDataRepo();
  ShopOwnerRegisterRepo shopOwnerRegisterRepo = ShopOwnerRegisterRepo();
  List<CountryData>? countryList;
  List<StateData>? stateList;
  List<CityData>? cityList;
  List<AreaData>? areaList;
  TextEditingController shopNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  String message = "";
  int countryId = 0;
  int stateId = 0;
  int cityId = 0;
  int areaId=0;
  int shopId=0;
  String countryCode="+91";
  String successToken="";

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

  GetStateListReqModel get _stateListReqModel => GetStateListReqModel(
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

  Future<void> onStateSelected(value) async {
    stateId = int.parse(value.toString());
    notifyListeners();
  }

  GetCityListReqModel get _cityListReqModel => GetCityListReqModel(
        stateId: stateId.toString(),
      );

  Future<void> getCityList(context) async {
    registrationDataRepo.getCityList(_cityListReqModel).then((response) {
      final result = GetCityListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        cityList = result.cityData;
        if (result.cityData!.isEmpty) {
          Utils.showPrimarySnackbar(context, "No City Found",
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

  Future<void> onCitySelected(value) async {
    cityId = int.parse(value.toString());
    notifyListeners();
  }

  GetAreaListReqModel get _areaListReqModel => GetAreaListReqModel(
        cityId: cityId.toString(),
      );

  Future<void> onAreaSelected(value) async {
    areaId = int.parse(value.toString());
    notifyListeners();
  }

  Future<void> onShopTypeSelected(value) async {
    shopId = int.parse(value.toString());
    notifyListeners();
  }

  Future<void> getAreaList(context) async {
    registrationDataRepo.getAreaList(_areaListReqModel).then((response) {
      final result = GetAreaListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        areaList = result.areaData;
        if (result.areaData!.isEmpty) {
          Utils.showPrimarySnackbar(context, "No Area Found",
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

  Future<void> validateField(context) async {
    if (shopNameController.text.isEmpty) {
      Utils.showPrimarySnackbar(context,"Enter Shop Name", type: SnackType.error);
      return;
    }
    if (ownerNameController.text.isEmpty) {
      Utils.showPrimarySnackbar(context,"Enter Owner Name", type: SnackType.error);
      return;
    }
    if(shopId==0){
      Utils.showPrimarySnackbar(context,"Select shop Type", type: SnackType.error);
      return;
    }
    if (emailIdController.text.isEmpty) {
      Utils.showPrimarySnackbar(context,"Enter Email Id", type: SnackType.error);
      return;
    }
    if(countryId==0){
      Utils.showPrimarySnackbar(context,"Select Country", type: SnackType.error);
      return;
    }
    if(stateId==0){
      Utils.showPrimarySnackbar(context,"Select State", type: SnackType.error);
      return;
    }
    if(cityId==0){
      Utils.showPrimarySnackbar(context,"Select City", type: SnackType.error);
      return;
    }
    if(areaId==0){
      Utils.showPrimarySnackbar(context,"Select Area", type: SnackType.error);
      return;
    }
    if (addressController.text.isEmpty) {
      Utils.showPrimarySnackbar(context,"Enter Address", type: SnackType.error);
      return;
    }
    if (pincodeController.text.isEmpty) {
      Utils.showPrimarySnackbar(context,"Enter Pincode", type: SnackType.error);
      return;
    }
    if (pincodeController.text.length<6) {
      Utils.showPrimarySnackbar(context,"Incorrect Pincode", type: SnackType.error);
      return;
    }

    if (upiController.text.isEmpty) {
      Utils.showPrimarySnackbar(context,"Enter Upi", type: SnackType.error);
      return;
    }
  }

  Future<void> onNextClicked(context)async{
    await validateField(context);
    await shopRegister(context);
  }

  ShopOwnerRegisterReqModel get shopOwnerRegisterReqModel=>ShopOwnerRegisterReqModel(
    shopName: shopNameController.text,
    shopOwnerName: ownerNameController.text,
    countryCode: "$countryCode",
    mobileNo: (mobController.text),
    email: emailIdController.text,
    shopType: stateId==1?"Retailer":"Wholesaler",
    countryId: countryId.toString(),
    stateId: stateId.toString(),
    cityId: cityId.toString(),
    areaId: areaId.toString(),
    shopAddress: addressController.text,
    shopPincode: (pincodeController.text),
    shopUpiId: upiController.text,
    fcmToken: "ghjklhvghjk"
  );

  Future<void> shopRegister(context)async{
    shopOwnerRegisterRepo.shopOwnerRegistration(shopOwnerRegisterReqModel).then((response){
      final result = ShopOwnerRegisterResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
     successToken=result.successToken?.token??"";
     notifyListeners();
     Navigator.push(context,MaterialPageRoute(builder: (context)=>SKycVerificationView()));
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