import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:local_supper_market/screen/customer/delivery_address/model/edit_address_model.dart';
import 'package:local_supper_market/screen/customer/delivery_address/repository/edit_address_repo.dart';

import 'package:local_supper_market/screen/customer/delivery_address/model/add_delivery_address_model.dart';
import 'package:local_supper_market/screen/customer/delivery_address/model/update_address_model.dart';
import 'package:local_supper_market/screen/customer/delivery_address/repository/add_delivery_address_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_address/repository/update_delivery_address_repo.dart';
import 'package:local_supper_market/screen/customer/delivery_address/view/my_delivery_address.dart';
import 'package:local_supper_market/screen/customer/main_screen/views/main_screen_view.dart';

import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/pincode_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddressController extends ChangeNotifier {
  String groupValue = "home";
  List<CountryData>? countryList;
  List<StateData>? stateList;
  List<CityData>? cityList;
  List<AreaData>? areaList;
  int countryId = 0;
  int stateId = 0;
  int cityId = 0;
  int areaId = 0;
  int shopId = 0;
  List? pincodeList;
  String pincode = "";
  bool showPincodeValueField = false;
  RegistrationDataRepo registrationDataRepo = RegistrationDataRepo();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController apartmentNameController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();

  EditAddressRepo editAddressRepo = EditAddressRepo();
  bool isLoading = true;
  String deliveryAddressId = "";
  String? countryCode = "+91";
  AddDeliverAddressRepo newAddDeliveryAddressRepo = AddDeliverAddressRepo();
  UpdateDeliveryAddressRepo updateDeliveryAddressRepo =
      UpdateDeliveryAddressRepo();
  bool isEditingAddress = false;
  Future<void> initState(context, editAddress, addressId) async {
    groupValue = "home";
    countryId = 0;
    stateId = 0;
    cityId = 0;
    areaId = 0;
    shopId = 0;
    nameController.clear();
    mobNoController.clear();

    apartmentNameController.clear();
    houseNoController.clear();
    streetController.clear();
    areaController.clear();
    landMarkController.clear();

    if (editAddress) {
      isEditingAddress = true;
      await getAddressDetails(context, addressId);
    } else {
      isEditingAddress = false;
      await getCountryList(context);
    }
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  void onRadioButtonSelected(value) {
    groupValue = value;
    notifyListeners();
  }

  void onCountrySelected(value) async {
    countryId = int.parse(value.toString());
    print("nhjvwuriuiwbytiuywi");
    print(countryId);
    notifyListeners();
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

  GetPincodeReqModel get _pincodeListReqModel => GetPincodeReqModel(
        areaId: areaId.toString(),
      );

  Future<void> getPinCodeList(context) async {
    registrationDataRepo.getPincodeList(_pincodeListReqModel).then((response) {
      final result = GetPincodeResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        pincodeList = result.pincodeData;
        print(pincodeList);

        if (pincodeList?.contains(pincode) ?? false) {
          showPincodeValueField = true;
        } else {
          showPincodeValueField = false;
        }
        if (result.pincodeData!.isEmpty) {
          pincodeList?.clear();
          Utils.showPrimarySnackbar(context, "No Pincode Found",
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

  Future<void> onPincodeSelected(value) async {
    pincode = value.toString();
    print("$pincode pincode");
    // print(object);
    notifyListeners();
  }

  Future<void> getCountryList(context) async {
    showLoader(true);
    registrationDataRepo.getCountryList(context).then((response) {
      print(response.statusCode);
      print(response.body);
      final result = GetCountryListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");
        countryList = result.countryData;
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

  ///////////State

  GetStateListReqModel get _stateListReqModel => GetStateListReqModel(
        countryId: countryId.toString(),
      );

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

  Future<void> validateField(context) async {
    if (nameController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Name", type: SnackType.error);
      return;
    }
    if (mobNoController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Mobile No",
          type: SnackType.error);
      return;
    }
    if (mobNoController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter 10 digits",
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
    if (pincode == "") {
      Utils.showPrimarySnackbar(context, "Select Pincode",
          type: SnackType.error);
      return;
    }
    if (apartmentNameController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Apartment Name",
          type: SnackType.error);
      return;
    }
    if (houseNoController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter House No",
          type: SnackType.error);
      return;
    }
    if (streetController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Street", type: SnackType.error);
      return;
    }
    if (areaController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Area Name",
          type: SnackType.error);
      return;
    }
    if (landMarkController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Landmark",
          type: SnackType.error);
      return;
    }
    if (isEditingAddress) {
      updateEditAddress(context);
    } else {
      addNewAddress(context);
    }
  }

  EditDeliveryAddressRequestModel get editDeliveryAddressRequestModel =>
      EditDeliveryAddressRequestModel(deliveryAddressId: deliveryAddressId);

  Future<void> getAddressDetails(context, addressId) async {
    deliveryAddressId = addressId;
    showLoader(true);
    await getCountryList(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    editAddressRepo
        .getAddressDetails(
            editDeliveryAddressRequestModel, pref.getString("successToken"))
        .then((response) {
      print("jjjjjjjjjj");
      log(response.body);
      print("jjjjjjjjjj");
      final result = EditDeliveryAddressResponseModel.fromJson(
        jsonDecode(response.body),
      );

      if (response.statusCode == 200) {
        final data = result.deliveryAddressDetails;
        print(data?.customerName);
        groupValue = data?.deliveryAddressType ?? "home";
        nameController.text = data?.customerName ?? "";
        mobNoController.text = data?.deliveryMobileNumber.toString() ?? "";
        apartmentNameController.text = data?.deliveryAppartmentName ?? "";
        houseNoController.text = data?.deliveryHouseNo ?? "";
        streetController.text = data?.deliveryStreet ?? "";
        areaController.text = data?.deliveryArea ?? "";
        landMarkController.text = data?.deliveryLandmark ?? "";
        countryId = data?.deliveryCountryId ?? 0;
        stateId = data?.deliveryStateId ?? 0;
        cityId = data?.deliveryCityId ?? 0;
        areaId = data?.deliveryAreaId ?? 0;
        pincode = data?.deliveryPincode.toString() ?? "";
        countryList = result.countries;
        stateList = result.states;
        cityList = result.cities;
        areaList = result.areas;
        pincodeList = result.pincodes;
        if (pincodeList?.contains(pincode.toString()) ?? false) {
          showPincodeValueField = true;
        } else {
          showPincodeValueField = false;
        }
        isLoading = false;
        notifyListeners();
      }
    });
  }

  AddAddressRequestModel get newAddDeliveryAddressReqModel =>
      AddAddressRequestModel(
          customerName: nameController.text,
          deliveryCountryCode: countryCode,
          deliveryMobileNumber: mobNoController.text,
          deliveryAppartmentName: apartmentNameController.text,
          deliveryHouseNo: houseNoController.text,
          deliveryStreet: streetController.text,
          deliveryArea: areaController.text,
          deliveryLandmark: landMarkController.text,
          deliveryCountryId: countryId.toString(),
          deliveryCityId: cityId.toString(),
          deliveryStateId: stateId.toString(),
          deliveryAreaId: areaId.toString(),
          deliveryAddressType: groupValue.toString(),
          deliveryPincode: pincode);

  Future<void> addNewAddress(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    newAddDeliveryAddressRepo
        .addDeliveryAdress(
            newAddDeliveryAddressReqModel, pref.getString("successToken"))
        .then((response) {
      final result =
          AddAddressResponseModel.fromJson(jsonDecode(response.body));
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreenView(
                  index: 4,
                  screenName: MyDeliveryAddressView(isRefresh: true))),
          (Route<dynamic> route) => false,
        );
        // pref.setString("pincode", pincode);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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

  UpdateDeliveryAddressReqModel get updateDeliveryAddressReqModel =>
      UpdateDeliveryAddressReqModel(
        customerName: nameController.text,
        deliveryCountryCode: countryCode,
        deliveryMobileNumber: mobNoController.text,
        deliveryAppartmentName: apartmentNameController.text,
        deliveryHouseNo: houseNoController.text,
        deliveryStreet: streetController.text,
        deliveryArea: areaController.text,
        deliveryLandmark: landMarkController.text,
        deliveryCountryId: countryId.toString(),
        deliveryCityId: cityId.toString(),
        deliveryStateId: stateId.toString(),
        deliveryAreaId: areaId.toString(),
        deliveryAddressType: groupValue.toString(),
        deliveryPincode: pincode,
        deliveryAddressId: deliveryAddressId,
      );

  Future<void> updateEditAddress(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    updateDeliveryAddressRepo
        .updateDeliveryAddress(
            updateDeliveryAddressReqModel, pref.getString("successToken"))
        .then((response) {
      final result =
          UpdateDeliveryAddressResModel.fromJson(jsonDecode(response.body));
      print(response.body);
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreenView(
                  index: 4,
                  screenName: MyDeliveryAddressView(isRefresh: true))),
          (Route<dynamic> route) => false,
        );
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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
