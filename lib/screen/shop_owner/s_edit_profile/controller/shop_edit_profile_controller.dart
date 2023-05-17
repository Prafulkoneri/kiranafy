import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_edit_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_edit_profile_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/repository/shop_update_profile_repo.dart';
import 'package:local_supper_market/utils/Utils.dart';
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
  List<ShopBannerImageData>? bannerImageList;

  String countryCode = "+91";

  Future<void> initState(
    context,
  ) async {
    await getShopEditProfileDetails(context);
  }

  /////start edit Profile/////////////////
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
        shopBannerImages: "",
      );

  Future<void> UpdateProfile(context) async {
    shopUpdateProfileRepo.UpdateProfile(shopUpdateProfileReqModel)
        .then((response) {
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
  ///
  ImagePicker picker = ImagePicker();
  late File imageFile1 = File("");
  late File imageFile2 = File("");
  late File imageFile3 = File("");

  openCamera(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      Navigator.pop(context);

      imageFile1 = File(pickedFile.path);
    }
  }
}
