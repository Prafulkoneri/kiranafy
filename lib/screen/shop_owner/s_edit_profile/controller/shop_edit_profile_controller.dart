import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/pincode_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_edit_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_edit_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_update_profile_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/utils/common_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
class ShopEditProfileDetailController extends ChangeNotifier {
  ShopEditProfileRepo shopEditProfileRepo = ShopEditProfileRepo();
  UpdateProfileRepo shopUpdateProfileRepo = UpdateProfileRepo();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  String selectedCountryId = "";
  String selectedStateId = "";
  String selectedCityId = "";
  String selectedAreaId = "";
  int selectedPincode = 0;
  List<CountryData>? countryDataList;
  List<StateData>? stateDataList;
  List<CityData>? cityDataList;
  List<AreaData>? areaDataList;
  List<File> imageFileList = [];
  List<ShopBannerImageData>? bannerImageList;
  RegistrationDataRepo registrationDataRepo = RegistrationDataRepo();
  String image1 = "";
  String image2 = "";
  String image3 = "";
  String image4 = "";
  File fileImage1 = File("");
  File fileImage2 = File("");
  File fileImage3 = File("");
  File fileImage4 = File("");
  String networkImage1 = "";
  String networkImage2 = "";
  String networkImage3 = "";
  String networkImage4 = "";
  String countryCode = "+91";
  List? pincodeList;
  bool showValuePincodeField = false;
  List images=[];
  Future<void> initState(
    context,
  ) async {
    print(fileImage1.path);
    await getShopEditProfileDetails(context);
  }

  /////start edit Profile/////////////////

  void openGallery1() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage1 = "";
      fileImage1 = File(pickedFile.path);
      final bytes = await compressFile(fileImage1);

      image1 = base64Encode(bytes as List<int>);

      networkImage1 = "";
      fileImage1 = File(pickedFile.path);
      images.add(fileImage1.path);
    }

    notifyListeners();
  }

  void openGallery2() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage2 = "";
      fileImage2 = File(pickedFile.path);
      images.add(fileImage2.path);
    }

    notifyListeners();
  }

  void openGallery3() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage3 = "";
      fileImage3 = File(pickedFile.path);
      images.add(fileImage3.path);
    }

    notifyListeners();
  }

  void openGallery4() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage4 = "";
      fileImage4 = File(pickedFile.path);
      images.add(fileImage4.path);
    }

    notifyListeners();
  }

  Future<void> getShopEditProfileDetails(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    shopEditProfileRepo
        .getShopEditProfileDetails(pref.getString("successToken"))
        .then((response) {
      final result = AccountDetailsResModel.fromJson(
        jsonDecode(response.body),
      );
      if (response.statusCode == 200) {
        final shopDetails = result.shopDetails;
        print(shopDetails);
        log("${response.body}");
        shopNameController.text = shopDetails?.shopName ?? "";
        print(shopNameController.text);
        ownerNameController.text = shopDetails?.shopOwnerName ?? "";
        phoneNumberController.text =
            shopDetails?.shopOwnerMobileNumber.toString() ?? "";
        countryCode = shopDetails?.shopOwnerCountryCode ?? "";
        emailIdController.text = shopDetails?.shopOwnerEmail ?? "";
        shopAddressController.text = shopDetails?.shopAddress ?? "";
        selectedPincode =
            int.parse(shopDetails?.shopPincode.toString() ?? "0") ?? 0;
        selectedCountryId = shopDetails?.selectedCountryId.toString() ?? "";
        selectedStateId = shopDetails?.selectedStateId.toString() ?? "";
        selectedCityId = shopDetails?.selectedCityId.toString() ?? "";
        selectedAreaId = shopDetails?.selectedAreaId.toString() ?? "";
        print(selectedAreaId);

        countryDataList = result.countries;
        cityDataList = result.cities;
        stateDataList = result.states;
        areaDataList = result.areas;
        pincodeList = result.pincode;
        if (pincodeList?.contains(selectedPincode.toString()) ?? false) {
          print("8789888");
          showValuePincodeField = true;
        } else {
          showValuePincodeField = false;
        }
        bannerImageList = result.shopBannerImages;
        if (bannerImageList!.isNotEmpty) {
          print(bannerImageList!.asMap().containsKey(0));
          if (bannerImageList!.asMap().containsKey(0)) {
            networkImage1 = bannerImageList?[0].shopBannerImagePath ?? "";
          }
          if (bannerImageList!.asMap().containsKey(1)) {
            networkImage2 = bannerImageList?[1].shopBannerImagePath ?? "";
          }
          if (bannerImageList!.asMap().containsKey(2)) {
            networkImage3 = bannerImageList?[2].shopBannerImagePath ?? "";
          }
          if (bannerImageList!.asMap().containsKey(3)) {
            networkImage4 = bannerImageList?[2].shopBannerImagePath ?? "";
          }
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

  /////End edit Profile/////////////////

  /////Start Update Profile/////////////////

  ShopUpdateProfileReqModel get shopUpdateProfileReqModel =>
      ShopUpdateProfileReqModel(
        shopName: shopNameController.text,
        shopOwnerName: ownerNameController.text,
        shopOwnerCountryCode: countryCode,
        selectedAreaId: (selectedAreaId),
        selectedCityId: (selectedCityId),
        selectedCountryId: (selectedCountryId),
        selectedStateId: (selectedStateId),
        shopAddress: shopAddressController.text,
        shopOwnerEmail: emailIdController.text,
        shopOwnerMobileNumber: (phoneNumberController.text),
        shopPincode: (selectedPincode.toString()),
        shopBannerImages: image1,
      );

  Future<void> UpdateProfile(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopUpdateProfileRepo.UpdateProfile(
            shopUpdateProfileReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          ShopUpdateProfileResModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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

  void onCountrySelected(value) async {
    selectedCountryId = value.toString();
    notifyListeners();
  }

  Future<void> onStateSelected(value) async {
    selectedStateId = value.toString();
    notifyListeners();
  }

  GetCityListReqModel get _cityListReqModel => GetCityListReqModel(
        stateId: selectedStateId.toString(),
      );

  Future<void> getCityList(context) async {
    registrationDataRepo.getCityList(_cityListReqModel).then((response) {
      final result = GetCityListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        cityDataList = result.cityData;
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
    selectedCityId = value.toString();
    notifyListeners();
  }

  GetAreaListReqModel get _areaListReqModel => GetAreaListReqModel(
        cityId: selectedCityId.toString(),
      );

  Future<void> onAreaSelected(value) async {
    selectedAreaId = value.toString();
    notifyListeners();
  }

  Future<void> getAreaList(context) async {
    registrationDataRepo.getAreaList(_areaListReqModel).then((response) {
      final result = GetAreaListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        areaDataList = result.areaData;
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
        areaId: selectedAreaId.toString(),
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
    selectedPincode = int.parse(value.toString());
    // print(object);
    notifyListeners();
  }

  Future<void> getCountryList(context) async {
    registrationDataRepo.getCountryList(context).then((response) {
      print(response.statusCode);
      print(response.body);
      final result = GetCountryListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("${response.body}");
        countryDataList = result.countryData;
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
        countryId: selectedCountryId.toString(),
      );

  Future<void> getStateList(context) async {
    registrationDataRepo.getStateList(_stateListReqModel).then((response) {
      final result = GetStateListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        stateDataList = result.stateData;
        if (result.stateData!.isEmpty) {
          stateDataList?.clear();
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
    if (phoneNumberController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Enter Mobile No",
          type: SnackType.error);
      return;
    }
    if (emailIdController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Email Id",
          type: SnackType.error);
      return;
    }
    if (selectedCountryId == "") {
      Utils.showPrimarySnackbar(context, "Select Country",
          type: SnackType.error);
      return;
    }
    if (selectedStateId == "") {
      Utils.showPrimarySnackbar(context, "Select State", type: SnackType.error);
      return;
    }
    if (selectedCityId == "") {
      Utils.showPrimarySnackbar(context, "Select City", type: SnackType.error);
      return;
    }
    if (selectedAreaId == "") {
      Utils.showPrimarySnackbar(context, "Select Area", type: SnackType.error);
      return;
    }
    if (shopAddressController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Address",
          type: SnackType.error);
      return;
    }
    if (selectedPincode == 0) {
      Utils.showPrimarySnackbar(context, "Select Pincode",
          type: SnackType.error);
      return;
    }
    if(fileImage1.path==""||fileImage2.path==""||fileImage3.path==""||fileImage4.path==""){
      await UpdateProfile(context);
    }
   else{
     await uploadImage(context);
    }
  }

  Future uploadImage(context) async {

    print(images);
    SharedPreferences pref=await SharedPreferences.getInstance();
    String token=pref.getString("successToken").toString();
    var uri = Uri.parse("${Endpoint.shopUpdateAccountDetails}");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers['Authorization'] ="Bearer $token";
    request.fields['shop_name'] = shopNameController.text;
    request.fields['shop_owner_name'] = ownerNameController.text;
    request.fields['shop_owner_country_code'] = countryCode;
    request.fields['shop_owner_mobile_number'] = phoneNumberController.text;
    request.fields['shop_owner_email'] = emailIdController.text;
    request.fields['shop_country_id'] = selectedCountryId;
    request.fields['shop_state_id'] = selectedStateId;
    request.fields['shop_area_id'] = selectedAreaId;
    request.fields['shop_address'] = shopAddressController.text;
    request.fields['shop_pincode'] =  selectedPincode.toString();
    request.fields['shop_city_id'] =  selectedCityId.toString();
    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    List<http.MultipartFile> newList =  <http.MultipartFile>[];
    for (int i = 0; i <images.length; i++) {
      File imageFile = File(images[i].toString());
      var stream =
      new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = new http.MultipartFile("shop_banner_image_path", stream, length,filename: basename(imageFile.path));
      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    print(newList);
    await request.send().then((response){

      if (response.statusCode == 200) {
        Utils.showPrimarySnackbar(context,"Updated Successfully",
            type: SnackType.success);
        print("Updated Successfully");
      } else {
        Utils.showPrimarySnackbar(context,"Error on uploading",
            type: SnackType.error);
      }
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    });
    return true;
  }

}
