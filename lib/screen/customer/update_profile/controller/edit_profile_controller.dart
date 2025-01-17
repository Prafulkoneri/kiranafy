import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:local_supper_market/screen/customer/account/view/profile_screen_view.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/customer/update_profile/model/edit_profile_model.dart';
import 'package:local_supper_market/screen/customer/update_profile/model/update_profile_model.dart';
import 'package:local_supper_market/screen/customer/update_profile/repository/edit_profile_repo.dart';
import 'package:local_supper_market/screen/customer/update_profile/repository/update_profile_repo.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/pincode_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';

// import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/utils/common_functions.dart';
import 'package:provider/provider.dart';
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
  final TextEditingController stateSearchController = TextEditingController();
  final TextEditingController countrySearchController = TextEditingController();
  final TextEditingController citySearchController = TextEditingController();
  final TextEditingController areaSearchController = TextEditingController();
  List<StateData>? stateList;
  List<CityData>? cityList;
  List<AreaData>? areaList;
  int countryId = 0;
  int stateId = 0;
  int cityId = 0;
  int areaId = 0;
  String countryName = "";
  String stateName = "";
  String cityName = "";
  String areaName = "";
  int shopId = 0;
  List? pincodeList;
  String pincode = "";
  String radioGroupValue = "male";
  String countryCode = "+91";
  String countryAlternateCode = "+91";
  List<CountryData>? countryList;
  CustomerUpdateProfileRepo customerUpdateProfileRepo =
      CustomerUpdateProfileRepo();
  String image = "";
  File fileImage = File("");
  String networkImage = "";
  bool isLoading = true;
  bool showPincodeValueField = false;

  ////
  Future<void> initState(
    context,
  ) async {
    countryName = "";
    stateName = "";
    cityName = "";
    areaName = "";
    await getCountryList(context);
    await getCustomerProfileDetails(context);
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getCustomerProfileDetails(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    editCustomerProfileRepo
        .editCustomerProfileRepo(pref.getString("successToken"))
        .then((response) {
      final result = CustomerEditProfileDetails.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        final customerProfileDetails = result.customerProfileDetails;
        print(CustomerProfileDetails);
        log(response.body);
        nameController.text = customerProfileDetails?.customerName ?? "";
        mobilrController.text =
            customerProfileDetails?.customerMobileNumber.toString() ?? "";
        alernetMobileController.text =
            customerProfileDetails?.customerAlternateMobileNumber.toString() ??
                "";
        if (alernetMobileController.text == "null") {
          alernetMobileController.text = "";
        }
        addressController.text = customerProfileDetails?.customerAddress ?? "";
        dateOfBirthController.text =
            customerProfileDetails?.customerDateOfBirth ?? "";
        emailController.text = customerProfileDetails?.customerEmail ?? "";
        radioGroupValue = customerProfileDetails?.customerGender ?? "";
        networkImage = customerProfileDetails?.customerProfileImagePath ?? "";
        countryId = customerProfileDetails?.customerCountryId ?? 0;
        stateId = customerProfileDetails?.customerStateId ?? 0;
        cityId = customerProfileDetails?.customerCityId ?? 0;
        areaId = customerProfileDetails?.customerAreaId ?? 0;
        pincode = customerProfileDetails?.customerPincode.toString() ?? "";
        print("pincode");
        print(pincode);
        print("pincode");
        countryList = result.countries;
        stateList = result.state;
        cityList = result.city;
        areaList = result.area;
        pincodeList = result.pincode;
        countryName = countryList
                ?.where((element) =>
                    element.id?.toString().contains(countryId.toString()) ??
                    false)
                .toList()[0]
                .countryName ??
            "";
        stateName = stateList
                ?.where((element) =>
                    element.id?.toString().contains(stateId.toString()) ??
                    false)
                .toList()[0]
                .stateName ??
            "";
        cityName = cityList
                ?.where((element) =>
                    element.id?.toString().contains(cityId.toString()) ?? false)
                .toList()[0]
                .cityName ??
            "";
        areaName = areaList
                ?.where((element) =>
                    element.id?.toString().contains(areaId.toString()) ?? false)
                .toList()[0]
                .areaName ??
            "";
        if (pincodeList?.contains(pincode.toString()) == false) {
          pincode = "";
        }
        showLoader(false);
        notifyListeners();
      } else {
        showLoader(false);
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      showLoader(false);
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        showLoader(false);
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  void onRadioButtonSelected(value) {
    radioGroupValue = value;
    notifyListeners();
  }

////////////Country
  void onCountrySelected(value) async {
    countryName = value;
    countryId = countryList
            ?.where((element) => element.countryName?.contains(value) ?? false)
            .toList()[0]
            .id ??
        0;
    print("nhjvwuriuiwbytiuywi");
    stateName = "";
    cityName = "";
    areaName = "";
    print(countryId);
    notifyListeners();
  }

  Future<void> onStateSelected(value) async {
    stateName = value;
    stateId = stateList
            ?.where((element) => element.stateName?.contains(value) ?? false)
            .toList()[0]
            .id ??
        0;
    cityId = 0;
    cityName = "";
    areaName = "";
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
    cityName = value;
    cityId = cityList
            ?.where((element) => element.cityName?.contains(value) ?? false)
            .toList()[0]
            .id ??
        0;
    areaId = 0;
    areaName = "";
    notifyListeners();
  }

  GetAreaListReqModel get _areaListReqModel => GetAreaListReqModel(
        cityId: cityId.toString(),
      );

  Future<void> onAreaSelected(value) async {
    areaName = value;
    areaId = areaList
            ?.where((element) => element.areaName?.contains(value) ?? false)
            .toList()[0]
            .id ??
        0;
    pincode = "";
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
    pincode = "";
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

  void onDateSelected(date) {
    dateOfBirthController.text = date;
    notifyListeners();
  }

  Future<void> getCountryList(context) async {
    showLoader(true);
    registrationDataRepo.getCountryList(context).then((response) {
      print(response.statusCode);
      print(response.body);
      final result = GetCountryListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print(response.body);
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

  UpdateProfileDetailReqModel get updateProfileDetailReqModel =>
      UpdateProfileDetailReqModel(
        customerName: nameController.text,
        customerEmail: emailController.text,
        customerCountryCode: countryCode,
        customerMobileNumber: mobilrController.text,
        customerAlternateCountryCode: countryAlternateCode,
        customerAlternateMobileNumber: alernetMobileController.text,
        customerGender: radioGroupValue,
        customerDateOfBirth: dateOfBirthController.text,
        customerCountryId: countryId.toString(),
        customerCityId: cityId.toString(),
        customerStateId: stateId.toString(),
        customerAreaId: areaId.toString(),
        customerPincode: pincode,
        customerAddress: addressController.text,
      );

  Future<void> updateProfileDetail(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    customerUpdateProfileRepo
        .customerUpdateProfile(
            updateProfileDetailReqModel, pref.getString("successToken"))
        .then((response) {
      final result =
          UpdateProfileDetailResModel.fromJson(jsonDecode(response.body));
      print(response.body);
      if (response.statusCode == 200) {
        pref.setString("pincode", pincode);
        final read = Provider.of<MainScreenController>(context, listen: false);
        read.onNavigation(
            4,
            const ProfileScreenView(
              isRefreshed: true,
            ),
            context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           MainScreenView(index: 4, screenName: ProfileScreenView(isRefreshed: true,))),
        // (Route<dynamic> route) => false,
        // );
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
      networkImage = "";
      fileImage = File(pickedFile.path);
      final bytes = await compressFile(fileImage);

      image = base64Encode(bytes as List<int>);

      networkImage = "";
      fileImage = File(pickedFile.path);
    }

    notifyListeners();
  }

  Future<void> validateField(context) async {
    if (nameController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Name", type: SnackType.error);
      return;
    }
    if (mobilrController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Mobile No",
          type: SnackType.error);
      return;
    }
    if (alernetMobileController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter Mobile Number",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    if (emailController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Email Id",
          type: SnackType.error);
      return;
    }
    if (dateOfBirthController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Select Date of birth",
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
    if (fileImage.path == "") {
      await updateProfileDetail(context);
    } else {
      uploadImage(context);
    }
  }

  Future uploadImage(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("successToken").toString();
    var uri = Uri.parse(Endpoint.customerUpdateProfile);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = "Bearer $token";
    request.fields['customer_name'] = nameController.text;
    request.fields['customer_country_code'] = countryCode.toString();
    request.fields['customer_mobile_number'] = mobilrController.text;
    request.fields['customer_email'] = emailController.text;
    request.fields['customer_gender'] = radioGroupValue;
    request.fields['customer_date_of_birth'] = dateOfBirthController.text;
    request.fields['customer_country_id'] = countryId.toString();
    request.fields['customer_state_id'] = stateId.toString();
    request.fields['customer_city_id'] = cityId.toString();
    request.fields['customer_area_id'] = areaId.toString();
    request.fields['customer_pincode'] = pincode.toString();
    request.fields['customer_address'] = addressController.text;
    request.fields['customer_alternate_country_code'] = countryAlternateCode;
    request.fields['customer_alternate_mobile_number'] =
        alernetMobileController.text;
    List<http.MultipartFile> newList = <http.MultipartFile>[];
    File imageFile = fileImage;
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = http.MultipartFile(
        "customer_profile_image_path", stream, length,
        filename: basename(imageFile.path));
    newList.add(multipartFile);
    request.files.addAll(newList);
    await request.send().then((response) {
      if (response.statusCode == 200) {
        final read = Provider.of<MainScreenController>(context, listen: false);
        read.onNavigation(
            4,
            const ProfileScreenView(
              isRefreshed: true,
            ),
            context);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           MainScreenView(index: 4, screenName: ProfileScreenView(isRefreshed: true,))),
        //   (Route<dynamic> route) => false,
        // );
        print("sucesss");
        Utils.showPrimarySnackbar(context, "Updated Successfully",
            type: SnackType.success);
        print("Updated Successfully");
      } else {
        Utils.showPrimarySnackbar(context, "Error on uploading",
            type: SnackType.error);
        return;
      }
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    });
  }
}
