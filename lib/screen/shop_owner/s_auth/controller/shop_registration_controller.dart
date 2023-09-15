import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_supper_market/main.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/pincode_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/shop_owner_register_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/shop_owner_register_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_kyc_verification/view/s_kyc_verification_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopRegistrationController extends ChangeNotifier {
  RegistrationDataRepo registrationDataRepo = RegistrationDataRepo();
  ShopOwnerRegisterRepo shopOwnerRegisterRepo = ShopOwnerRegisterRepo();
  List<CountryData>? countryList;
  List<StateData>? stateList;
  List<CityData>? cityList;
  List<AreaData>? areaList;
  List? pincodeList;
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
  int areaId = 0;
  int shopId = 0;
  String countryCode = "+91";
  String selectedCountryCode = "";
  String successToken = "";
  String pincode = "";

  Future<void> initState(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    mobController.text = pref.getString("mobileNo").toString();
    selectedCountryCode = pref.getString("countryCode").toString();
    await getCountryList(context);
    notifyListeners();
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
    LoadingOverlay.of(context).show();
    registrationDataRepo.getStateList(_stateListReqModel).then((response) {
      final result = GetStateListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        stateList = result.stateData;
        if (result.stateData!.isEmpty) {
          Utils.showPrimarySnackbar(context, "No State Found",
              type: SnackType.error);
        }
        LoadingOverlay.of(context).hide();
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
    cityId = 0;
    stateId = int.parse(value.toString());
    notifyListeners();
  }

  GetCityListReqModel get _cityListReqModel => GetCityListReqModel(
        stateId: stateId.toString(),
      );

  Future<void> getCityList(context) async {
    cityList?.clear();
    LoadingOverlay.of(context).show();
    registrationDataRepo.getCityList(_cityListReqModel).then((response) {
      final result = GetCityListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        cityList = result.cityData;
        if (result.cityData!.isEmpty) {
          Utils.showPrimarySnackbar(context, "No City Found",
              type: SnackType.error);
        }
        LoadingOverlay.of(context).hide();
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
    print(shopId);
    notifyListeners();
  }

  Future<void> getAreaList(context) async {
    LoadingOverlay.of(context).show();
    registrationDataRepo.getAreaList(_areaListReqModel).then((response) {
      final result = GetAreaListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        areaList = result.areaData;
        if (result.areaData!.isEmpty) {
          Utils.showPrimarySnackbar(context, "No Area Found",
              type: SnackType.error);
        }
        LoadingOverlay.of(context).hide();
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

  GetPincodeReqModel get _pincodeListReqModel => GetPincodeReqModel(
        areaId: areaId.toString(),
      );

  Future<void> getPinCodeList(context) async {
    LoadingOverlay.of(context).show();
    registrationDataRepo.getPincodeList(_pincodeListReqModel).then((response) {
      final result = GetPincodeResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        pincodeList = result.pincodeData;
        print(pincodeList);
        if (result.pincodeData!.isEmpty) {
          Utils.showPrimarySnackbar(context, "No Pincode Found",
              type: SnackType.error);
        }
        LoadingOverlay.of(context).hide();
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

  Future<void> onPincodeSelected(value) async {
    pincode = value.toString();
    print("$pincode pincode");
    // print(object);
    notifyListeners();
  }

  Future<void> validateField(context) async {
    if (shopNameController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Shop Name",
          type: SnackType.error);
      return;
    }
    if (ownerNameController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Owner Name",
          type: SnackType.error);
      return;
    }
    if (shopId == 0) {
      Utils.showPrimarySnackbar(context, "Select Shop Type",
          type: SnackType.error);
      return;
    }
    if (emailIdController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Email Id",
          type: SnackType.error);
      return;
    }
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(emailIdController.text.trim());
    print(emailValid);
    if (!emailValid) {
      Utils.showPrimarySnackbar(context, "Enter Email Id",
          type: SnackType.error);
      return;
    }
    if (countryId == 0) {
      Utils.showPrimarySnackbar(context, "Select Country",
          type: SnackType.error);
      return;
    }
    if (stateId == 0) {
      Utils.showPrimarySnackbar(context, "Select State", type: SnackType.error);
      return;
    }
    if (cityId == 0) {
      Utils.showPrimarySnackbar(context, "Select City", type: SnackType.error);
      return;
    }
    if (areaId == 0) {
      Utils.showPrimarySnackbar(context, "Select Area", type: SnackType.error);
      return;
    }
    if (addressController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Address",
          type: SnackType.error);
      return;
    }
    if (pincode == "") {
      Utils.showPrimarySnackbar(context, "Select Pincode",
          type: SnackType.error);
      return;
    }
    if (upiController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter UPI", type: SnackType.error);
      return;
    }

    await shopRegister(context);
  }

  Future<void> onNextClicked(context) async {
    await validateField(context);
  }

  ShopOwnerRegisterReqModel get shopOwnerRegisterReqModel =>
      ShopOwnerRegisterReqModel(
          shopName: shopNameController.text,
          shopOwnerName: ownerNameController.text,
          countryCode: "$countryCode",
          mobileNo: (mobController.text),
          email: emailIdController.text,
          shopType: shopId == 1 ? "Retailer" : "Wholesaler",
          countryId: countryId.toString(),
          stateId: stateId.toString(),
          cityId: cityId.toString(),
          areaId: areaId.toString(),
          shopAddress: addressController.text,
          shopPincode: pincode.toString(),
          shopUpiId: upiController.text,
          fcmToken: fcmToken);

  Future<void> shopRegister(context) async {
    LoadingOverlay.of(context).show();
    print("object");
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopOwnerRegisterRepo
        .shopOwnerRegistration(shopOwnerRegisterReqModel, context)
        .then((response) {
      print(response.body);
      final result =
          ShopOwnerRegisterResModel.fromJson(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        if (result.status == 200) {
          pref.setString("successToken", result.successToken?.token ?? "");
          print("4444444444444444444444444444444444444444");
          print(pref.getString("successToken"));
          print("4444444444444444444444444444444444444444");
          // return;
          // pref.setString("kycStatus", result.kycStatus.toString());
          pref.setString('status', 'shopRegistered');
          pref.setString('mobileNumber', mobController.text);
          // return;
          LoadingOverlay.of(context).hide();
          notifyListeners();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SKycVerificationView()));
        } else {
          LoadingOverlay.of(context).hide();
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
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
