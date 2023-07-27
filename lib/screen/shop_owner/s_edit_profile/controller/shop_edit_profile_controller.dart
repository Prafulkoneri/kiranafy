import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/city_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/country_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/pincode_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/model/state_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_auth/repository/registration_data_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_edit_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_edit_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_update_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/utils/common_functions.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
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
  String imageId1 = "";
  String imageId2 = "";
  String imageId3 = "";
  String imageId4 = "";
  String countryCode = "+91";
  List? pincodeList;
  bool showValuePincodeField = false;
  bool showValueCityField = false;
  bool showValueAreaField = false;
  bool showValueStateField = false;
  List<File> images = [File(""),File(""),File(""),File("")];
  bool isLoading = true;
  String shopBannerSequence = "";
  List shopBannerSequenceList = ["0", "0", "0", "0"];
  List deletedIdList = ["0", "0", "0", "0"];
  String deletedIds = "";

  Future<void> initState(
    context,
  ) async {
    images=[File(""),File(""),File(""),File("")];
    networkImage1 = "";
    networkImage2 = "";
    networkImage3 = "";
    networkImage4 = "";
    shopBannerSequenceList = ["0", "0", "0", "0"];
    deletedIdList = ["0", "0", "0", "0"];
    fileImage1 = File("");
    fileImage2 = File("");
    fileImage3 = File("");
    fileImage4 = File("");
    await getShopEditProfileDetails(context);
  }

  /////start edit Profile/////////////////

  Future<void> getShopEditProfileDetails(context) async {
    showLoader(true);
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
        selectedPincode = int.parse(shopDetails?.shopPincode.toString() ?? "0") ?? 0;
        selectedCountryId = shopDetails?.selectedCountryId.toString() ?? "";
        selectedStateId = shopDetails?.selectedStateId.toString() ?? "";
        selectedCityId = shopDetails?.selectedCityId.toString() ?? "";
        selectedAreaId = shopDetails?.selectedAreaId.toString() ?? "";
        countryDataList = result.countries;
        cityDataList = result.cities;
        stateDataList = result.states;
        areaDataList = result.areas;
        pincodeList = result.pincode;

        var containState = stateDataList?.where((element) => element.id.toString() ==selectedStateId);
        if(containState?.isNotEmpty??false){
          showValueStateField=true;
        }
        else{
          showValueStateField=false;
        }
        var containArea = areaDataList?.where((element) => element.id.toString() ==selectedAreaId);
        if(containArea?.isNotEmpty??false){
          showValueAreaField=true;
        }
        else{
          showValueAreaField=false;
        }
        var containCity = cityDataList?.where((element) => element.id.toString() ==selectedCityId);
        if(containCity?.isNotEmpty??false){
          showValueCityField=true;
        }
        else{
          showValueCityField=false;
        }

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
            if (bannerImageList?[0].shopBannerSequence == 1) {
              networkImage1 = bannerImageList?[0].shopBannerImagePath ?? "";
              imageId1 = bannerImageList?[0].id.toString() ?? "";
            }
            if (bannerImageList?[0].shopBannerSequence == 2) {
              networkImage2 = bannerImageList?[0].shopBannerImagePath ?? "";
              imageId2 = bannerImageList?[0].id.toString() ?? "";
            }
            if (bannerImageList?[0].shopBannerSequence == 3) {
              networkImage3 = bannerImageList?[0].shopBannerImagePath ?? "";
              imageId3 = bannerImageList?[0].id.toString() ?? "";
            }
            if (bannerImageList?[0].shopBannerSequence == 4) {
              networkImage4 = bannerImageList?[0].shopBannerImagePath ?? "";
              imageId4 = bannerImageList?[0].id.toString() ?? "";
            }
          }

          if (bannerImageList!.asMap().containsKey(1)) {
            print("hello");
            if (bannerImageList?[1].shopBannerSequence == 1) {
              print("sequence 1");
              networkImage1 = bannerImageList?[1].shopBannerImagePath ?? "";
              imageId1 = bannerImageList?[1].id.toString() ?? "";
            }
            if (bannerImageList?[1].shopBannerSequence == 2) {
              print("sequence 2");
              networkImage2 = bannerImageList?[1].shopBannerImagePath ?? "";
              imageId2 = bannerImageList?[1].id.toString() ?? "";
            }
            if (bannerImageList?[1].shopBannerSequence == 3) {
              print("sequence 3");
              networkImage3 = bannerImageList?[1].shopBannerImagePath ?? "";
              imageId3 = bannerImageList?[1].id.toString() ?? "";
            }
            if (bannerImageList?[1].shopBannerSequence == 4) {
              print("sequence 4");
              networkImage4 = bannerImageList?[1].shopBannerImagePath ?? "";
              imageId4 = bannerImageList?[1].id.toString() ?? "";
            }
            // bannerNotToBeDeletedIdsList.removeAt(1);
            // bannerNotToBeDeletedIdsList.insert(1,bannerImageList?[1].id.toString());
          }

          if (bannerImageList!.asMap().containsKey(2)) {
            if (bannerImageList?[2].shopBannerSequence == 1) {
              networkImage1 = bannerImageList?[2].shopBannerImagePath ?? "";
              imageId1 = bannerImageList?[2].id.toString() ?? "";
            }
            if (bannerImageList?[2].shopBannerSequence == 2) {
              networkImage2 = bannerImageList?[2].shopBannerImagePath ?? "";
              imageId2 = bannerImageList?[2].id.toString() ?? "";
            }
            if (bannerImageList?[2].shopBannerSequence == 3) {
              networkImage3 = bannerImageList?[2].shopBannerImagePath ?? "";
              imageId3 = bannerImageList?[2].id.toString() ?? "";
            }
            if (bannerImageList?[2].shopBannerSequence == 4) {
              networkImage4 = bannerImageList?[2].shopBannerImagePath ?? "";
              imageId4 = bannerImageList?[2].id.toString() ?? "";
            }
            // bannerNotToBeDeletedIdsList.removeAt(2);
            // bannerNotToBeDeletedIdsList.insert(2,bannerImageList?[2].id.toString());
          }

          if (bannerImageList!.asMap().containsKey(3)) {
            if (bannerImageList?[3].shopBannerSequence == 1) {
              networkImage1 = bannerImageList?[3].shopBannerImagePath ?? "";
              imageId1 = bannerImageList?[3].id.toString() ?? "";
            }
            if (bannerImageList?[3].shopBannerSequence == 2) {
              networkImage2 = bannerImageList?[3].shopBannerImagePath ?? "";
              imageId2 = bannerImageList?[3].id.toString() ?? "";
            }
            if (bannerImageList?[3].shopBannerSequence == 3) {
              networkImage3 = bannerImageList?[3].shopBannerImagePath ?? "";
              imageId3 = bannerImageList?[3].id.toString() ?? "";
            }
            if (bannerImageList?[3].shopBannerSequence == 4) {
              networkImage4 = bannerImageList?[3].shopBannerImagePath ?? "";
              imageId4 = bannerImageList?[3].id.toString() ?? "";
            }
            // bannerNotToBeDeletedIdsList.removeAt(3);
            // bannerNotToBeDeletedIdsList.insert(3,bannerImageList?[3].id.toString());
          }
          print("dadasdsadsa");

          print("dadasdsadsa");
        }
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

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  void onBackPressed(context,fromDashBoard){
    if (fromDashBoard ?? true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SMainScreenView(index: 0, screenName: ShopDashBoardView(refresh: false,))),
            (Route<dynamic> route) => false,
      );
      return;
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => SMainScreenView(
                index: 4, screenName: SAccountScreenView(refresh: false,))),
            (Route<dynamic> route) => false,
      );
      return;
    }
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
        bannerNotToBeDeletedIds: "",
        shopBannerSequence: "",
      );

  Future<void> UpdateProfile(context) async {
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopUpdateProfileRepo.UpdateProfile(
            shopUpdateProfileReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          ShopUpdateProfileResModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        LoadingOverlay.of(context).hide();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SMainScreenView(index: 4, screenName: SAccountScreenView(refresh: true,))),
          (Route<dynamic> route) => false,
        );
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
    LoadingOverlay.of(context).show();
    registrationDataRepo.getCityList(_cityListReqModel).then((response) {
      final result = GetCityListResModel.fromJson(jsonDecode(response.body));
     print("cityResponse${response.body}");
      if (response.statusCode == 200) {

        cityDataList = result.cityData;
        var contain = cityDataList?.where((element) => element.id.toString() ==selectedCityId);
       if(contain?.isNotEmpty??false){
         showValueCityField=true;
       }
       else{
         showValueCityField=false;
       }
         // showValuePincodeField = true;

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
    LoadingOverlay.of(context).show();
    registrationDataRepo.getAreaList(_areaListReqModel).then((response) {
      final result = GetAreaListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        areaDataList = result.areaData;
        var contain = areaDataList?.where((element) => element.id.toString() ==selectedAreaId);
        if(contain?.isNotEmpty??false){
          showValueAreaField=true;
        }
        else{
          showValueAreaField=false;
        }
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
        areaId: selectedAreaId.toString(),
      );

  Future<void> getPinCodeList(context) async {
    LoadingOverlay.of(context).show();
    registrationDataRepo.getPincodeList(_pincodeListReqModel).then((response) {
      final result = GetPincodeResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        pincodeList = result.pincodeData;
        if (result.pincodeData!.isEmpty) {
          Utils.showPrimarySnackbar(context, "No Pincode Found",
              type: SnackType.error);
        }
        if (pincodeList?.contains(selectedPincode.toString()) ?? false) {
          print("8789888");
          showValuePincodeField = true;
        } else {
          showValuePincodeField = false;
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
    LoadingOverlay.of(context).show();
    registrationDataRepo.getStateList(_stateListReqModel).then((response) {
      final result = GetStateListResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        stateDataList = result.stateData;
        var contain = stateDataList?.where((element) => element.id.toString() ==selectedStateId);
        if(contain?.isNotEmpty??false){
          showValueStateField=true;
        }
        else{
          showValueStateField=false;
        }
        if (result.stateData!.isEmpty) {
          stateDataList?.clear();
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
    if (phoneNumberController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Mobile No",
          type: SnackType.error);
      return;
    }
    if (phoneNumberController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Enter 10 digits",
          type: SnackType.error);
      return;
    }
    if (emailIdController.text.isEmpty) {
      Utils.showPrimarySnackbar(context, "Enter Email Id",
          type: SnackType.error);
      return;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailIdController.text);
    print("asfsdfsfsdfsdfdfs");
    print(emailValid);
    if (!emailValid) {
      Utils.showPrimarySnackbar(context, "Email Id Invalid",
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
    print("22222222");
    print("fileImage1.path${fileImage1.path}");
    print("fileImage2.path${fileImage2.path}");
    print("fileImage3.path${fileImage3.path}");
    print("fileImage4.path${fileImage4.path}");
    print("22222222");
    if (fileImage1.path == ""&&fileImage2.path == ""&&fileImage3.path==""&&fileImage4.path=="") {
      await UpdateProfile(context);
    }
    else {
      shopBannerSequence = "";
      for (int i = 0; i < shopBannerSequenceList.length; i++) {
        if (shopBannerSequenceList[i] != "0") {
          shopBannerSequence += shopBannerSequenceList[i] + ",";
        }
      }
      shopBannerSequence =
          shopBannerSequence.substring(0, shopBannerSequence.length - 1);
      print("dfadfasdfaf");
      print(shopBannerSequence);
      print(deletedIdList);
      deletedIds = "";
      bool isDeletedIdAllZero = false;
      for (int i = 0; i < deletedIdList.length; i++) {
        if (deletedIdList[i] != "0") {
          deletedIds += deletedIdList[i] + ",";
        }
      }
      print("dadasdasdsad");
      print(deletedIds);
      if (deletedIds != "") {
        deletedIds = deletedIds.substring(0, deletedIds.length - 1);
      }
      print(deletedIds);

      await uploadImage(context);
    }
  }

  void openGallery1() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      if (networkImage1 != "") {
        deletedIdList.removeAt(0);
        deletedIdList.insert(0, imageId1);
      }
      networkImage1 = "";
      fileImage1 = File(pickedFile.path);
      images.removeAt(0);
        images.insert(0,fileImage1);

      shopBannerSequenceList.removeAt(0);
      shopBannerSequenceList.insert(0, "1");
    }
    print(deletedIdList);
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
      if (networkImage2 != "") {
        deletedIdList.removeAt(1);
        deletedIdList.insert(1, imageId2);
      }
      networkImage2 = "";
      fileImage2 = File(pickedFile.path);
        images.removeAt(1);
        images.insert(1,fileImage2);

      shopBannerSequenceList.removeAt(1);
      shopBannerSequenceList.insert(1, "2");
    }
    print(deletedIdList);
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
      if (networkImage3 != "") {
        deletedIdList.removeAt(2);
        deletedIdList.insert(2, imageId3);
      }
      networkImage3 = "";
      fileImage3 = File(pickedFile.path);

      images.removeAt(2);
        images.insert(2,fileImage3);

      shopBannerSequenceList.removeAt(2);
      shopBannerSequenceList.insert(2, "3");
    }
    print(deletedIdList);
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
      if (networkImage4 != "") {
        deletedIdList.removeAt(3);
        deletedIdList.insert(3, imageId4);
      }
      networkImage4 = "";
      fileImage4 = File(pickedFile.path);
      images.removeAt(3);
        images.insert(3,fileImage4);
      shopBannerSequenceList.removeAt(3);
      shopBannerSequenceList.insert(3, "4");
    }

    notifyListeners();
  }

  Future uploadImage(context) async {
    // LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("successToken").toString();
    var uri = Uri.parse("${Endpoint.shopUpdateAccountDetails}");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = "Bearer $token";
    request.fields['shop_name'] = shopNameController.text;
    request.fields['shop_owner_name'] = ownerNameController.text;
    request.fields['shop_owner_country_code'] = countryCode;
    request.fields['shop_owner_mobile_number'] = phoneNumberController.text;
    request.fields['shop_owner_email'] = emailIdController.text;
    request.fields['shop_country_id'] = selectedCountryId;
    request.fields['shop_state_id'] = selectedStateId;
    request.fields['shop_area_id'] = selectedAreaId;
    request.fields['shop_address'] = shopAddressController.text;
    request.fields['shop_pincode'] = selectedPincode.toString();
    request.fields['shop_city_id'] = selectedCityId.toString();
    request.fields['shop_banner_sequence'] = shopBannerSequence.toString();
    request.fields['delete_banners_ids'] = deletedIds;
    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    List<http.MultipartFile> newList = <http.MultipartFile>[];
    newList.clear();
    print("444444");
    print(images);
    print("444444");
    for (int i = 0; i < images.length; i++) {
      if(images[i].path!=""){
        File imageFile = images[i];
      print(imageFile);
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = new http.MultipartFile(
          "shop_banner_image_path[$i]", stream, length,
          filename: basename(imageFile.path));
      newList.add(multipartFile);
      }
    }

    request.files.addAll(newList);
    print("4234324324");
    print(request.fields);
    print(request.files);
    print("4234324324");
    await request.send().then((response) async {
      final respStr = await response.stream.bytesToString();
      print("fsfdsfsfdsfsf");
      print(respStr);
      print(response);
      print("fsfdsfsfdsfsf");
      if (response.statusCode == 200) {
        shopBannerSequenceList = ["0", "0", "0", "0"];
        LoadingOverlay.of(context).hide();
        fileImage1 = File("");
        fileImage2 = File("");
        fileImage3 = File("");
        fileImage4 = File("");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SMainScreenView(index: 4, screenName: SAccountScreenView(refresh: true,))),
          (Route<dynamic> route) => false,
        );
        Utils.showPrimarySnackbar(context, "Updated Successfully",
            type: SnackType.success);
        print("Updated Successfully");
      } else {
        LoadingOverlay.of(context).hide();
        fileImage1 = File("");
        fileImage2 = File("");
        fileImage3 = File("");
        fileImage4 = File("");
        Utils.showPrimarySnackbar(context, "Error on uploading",
            type: SnackType.error);
      }
      // response.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
    });
    return true;
  }
}
