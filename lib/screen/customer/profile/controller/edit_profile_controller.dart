import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:local_supper_market/screen/customer/profile/model/edit_profile_model.dart';
import 'package:local_supper_market/screen/customer/profile/model/update_profile_model.dart';

import 'package:local_supper_market/screen/customer/profile/repository/edit_profile_repo.dart';
import 'package:local_supper_market/screen/customer/profile/repository/update_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/pincode_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';

// import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/utils/common_functions.dart';
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
  String radioGroupValue="male";
  String countryCode="+91";
  String countryAlternateCode="+91";
  List<CountryData>? countryList;
  CustomerUpdateProfileRepo customerUpdateProfileRepo=CustomerUpdateProfileRepo();
  String image="";
  File fileImage=File("");
  String networkImage="";
  bool  isLoading=true;

  ////
  Future<void> initState(
    context,
  ) async {

    await getCustomerProfileDetails(context);

  }

  Future<void> getCustomerProfileDetails(context) async {
    isLoading=true;
    await getCountryList(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    editCustomerProfileRepo
        .editCustomerProfileRepo(
            pref.getString("successToken")
            )
        .then((response) {
      final result = CustomerEditProfileDetails.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        final customerProfileDetails = result.customerProfileDetails;
        print(CustomerProfileDetails);
        log("${response.body}");
        nameController.text = customerProfileDetails?.customerName ?? "";
        mobilrController.text =
            customerProfileDetails?.customerMobileNumber.toString() ?? "";
        alernetMobileController.text =
            customerProfileDetails?.customerAlternateMobileNumber.toString() ??
                "";
        if(alernetMobileController.text=="null"){
          alernetMobileController.text="";
        }
        addressController.text = customerProfileDetails?.customerAddress ?? "";
        dateOfBirthController.text =
            customerProfileDetails?.customerDateOfBirth ?? "";
         emailController.text=customerProfileDetails?.customerEmail??"";
         radioGroupValue=customerProfileDetails?.customerGender??"";
         networkImage=customerProfileDetails?.customerProfileImagePath??"";
         countryId=customerProfileDetails?.customerCountryId??0;
         stateId=customerProfileDetails?.customerStateId??0;
         cityId=customerProfileDetails?.customerCityId??0;
         areaId=customerProfileDetails?.customerAreaId??0;
         pincode=customerProfileDetails?.customerPincode.toString()??"";
         countryList=result.countries;
         stateList=result.state;
         cityList=result.city;
         areaList=result.area;
        pincodeList=result.pincode;
        isLoading=false;
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

  void onRadioButtonSelected(value){
    radioGroupValue=value;
    notifyListeners();
  }

////////////Country
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
        if (result.pincodeData!.isEmpty) {
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

  void onDateSelected(date) {
    dateOfBirthController.text = date;
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

  UpdateProfileDetailReqModel get updateProfileDetailReqModel=>UpdateProfileDetailReqModel(customerName: nameController.text, customerEmail: emailController.text, customerCountryCode:countryCode, customerMobileNumber: mobilrController.text, customerAlternateCountryCode: alernetMobileController.text, customerAlternateMobileNumber: countryAlternateCode, customerGender:radioGroupValue, customerDateOfBirth: dateOfBirthController.text, customerCountryId: countryId.toString(), customerCityId:cityId.toString(), customerStateId:stateId.toString(), customerAreaId: areaId.toString(), customerPincode: pincode, customerAddress: addressController.text,);

  Future<void> updateProfileDetail(context)async{
    SharedPreferences pref=await SharedPreferences.getInstance();

    customerUpdateProfileRepo.customerUpdateProfile(updateProfileDetailReqModel,pref.getString("successToken")).then((response) {
      final result = UpdateProfileDetailResModel.fromJson(jsonDecode(response.body));
      print(response.body);
      if (response.statusCode == 200) {
       pref.setString("pincode",pincode);
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

  void openGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {

      networkImage="";
      fileImage=File(pickedFile.path);
      final bytes = await compressFile(fileImage);

      image= base64Encode(bytes as List<int>);

      networkImage = "";
      fileImage = File(pickedFile.path);

    }

    notifyListeners();
  }


}
