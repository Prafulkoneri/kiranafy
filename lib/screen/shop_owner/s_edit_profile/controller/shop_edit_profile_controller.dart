import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_edit_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_edit_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_update_profile_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';
import 'package:local_supper_market/utils/common_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopEditProfileDetailController extends ChangeNotifier {
  ShopEditProfileRepo shopEditProfileRepo = ShopEditProfileRepo();
  UpdateProfileRepo shopUpdateProfileRepo = UpdateProfileRepo();
  TextEditingController ShopNameController = TextEditingController();
  TextEditingController OwnerNameController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController EmailIdController = TextEditingController();
  TextEditingController ShopAddressController = TextEditingController();
  TextEditingController PinCodeController = TextEditingController();
  String selectedCountryId = "";
  String selectedStateId = "";
  String selectedCityId = "";
  String selectedAreaId = "";
  List<CountryData>? countryDataList;
  List<StatedData>? stateDataList;
  List<CityData>? cityDataList;
  List<AreaData>? areaDataList;
  List<File> imageFileList = [];
  List<ShopBannerImageData>? bannerImageList;

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
        ShopNameController.text = shopDetails?.shopName ?? "";
        print(ShopNameController.text);
        OwnerNameController.text = shopDetails?.shopOwnerName ?? "";
        PhoneNumberController.text =
            shopDetails?.shopOwnerMobileNumber.toString() ?? "";
        countryCode = shopDetails?.shopOwnerCountryCode ?? "";
        EmailIdController.text = shopDetails?.shopOwnerEmail ?? "";
        ShopAddressController.text = shopDetails?.shopAddress ?? "";

        selectedCountryId = shopDetails?.selectedCountryId.toString() ?? "";
        selectedStateId = shopDetails?.selectedStateId.toString() ?? "";
        selectedCityId = shopDetails?.selectedCityId.toString() ?? "";
        selectedAreaId = shopDetails?.selectedAreaId.toString() ?? "";
        print(selectedAreaId);

        countryDataList = result.countries;
        cityDataList = result.cities;
        stateDataList = result.states;
        areaDataList = result.areas;
        PinCodeController.text = shopDetails?.shopPincode.toString() ?? "";
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
        shopName: ShopNameController.text,
        shopOwnerName: OwnerNameController.text,
        shopOwnerCountryCode: countryCode,
        selectedAreaId: (selectedAreaId),
        selectedCityId: (selectedCityId),
        selectedCountryId: (selectedCountryId),
        selectedStateId: (selectedStateId),
        shopAddress: ShopAddressController.text,
        shopOwnerEmail: EmailIdController.text,
        shopOwnerMobileNumber: (PhoneNumberController.text),
        shopPincode: (PinCodeController.text),
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

  /////End Update Profile/////////////////

  //////////////////Image Picker/////////////////////////////
}
