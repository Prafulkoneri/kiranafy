import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/model/shop_configuration_edit_request_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/model/shop_configuration_response_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/repository/s_shop_configuration_edit_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/repository/s_shop_configuration_repo.dart';
import 'package:local_supper_market/utils/common_functions.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SShopConfigurationController extends ChangeNotifier {
  ShopConfigurationRepo shopConfigRepo = ShopConfigurationRepo();
  EditConfigRepo shopEditConfigRepo = EditConfigRepo();
  TextEditingController UpiIdController = TextEditingController();
  TextEditingController SupportNumberController = TextEditingController();
  TextEditingController FirstDeliveryController = TextEditingController();
  TextEditingController SecondDeliveryController = TextEditingController();
  TextEditingController ThirdDeliveryController = TextEditingController();
  TextEditingController FourthDeliveryController = TextEditingController();
  TextEditingController StartShopTimeController = TextEditingController();
  TextEditingController EndShopTimeController = TextEditingController();
  TextEditingController ImageNameController = TextEditingController();

  bool isCustomerPickupSelected = false;
  bool ifFreePickupSelected = false;
  bool isDeliveryCustomerSelected = false;
  bool isDeliveryChargesSelected = false;
  bool isNineToTwelve = false;
  bool isTwelveToThree = false;
  bool isThreeToSix = false;
  bool isSixToNine = false;
  File fileImage1 = File("");
  String networkImage1 = "";
  String image1 = "";

  ///Delivery Type CheckBox
  void onCustomerPickupSelected() {
    isCustomerPickupSelected = !isCustomerPickupSelected;
    notifyListeners();
  }

  void onDeliveryCustomerSelected() {
    isDeliveryCustomerSelected = !isDeliveryCustomerSelected;
    notifyListeners();
  }

  void onFreePickUpSelected() {
    ifFreePickupSelected = !ifFreePickupSelected;
    if (isDeliveryChargesSelected) {
      isDeliveryChargesSelected = false;
    }
    notifyListeners();
  }

  void onDeliveryCharge() {
    isDeliveryChargesSelected = !isDeliveryChargesSelected;
    if (ifFreePickupSelected) {
      ifFreePickupSelected = false;
    }
    notifyListeners();
  }
  ////End

  //////slot selectection check box
  void onNineToTwelve() {
    isNineToTwelve = !isNineToTwelve;
    notifyListeners();
  }

  void onTwelveToThree() {
    isTwelveToThree = !isTwelveToThree;
    notifyListeners();
  }

  void onThreeToSix() {
    isThreeToSix = !isThreeToSix;
    notifyListeners();
  }

  void onSixToNine() {
    isSixToNine = !isSixToNine;
    notifyListeners();
  }

  ///////////////////

  Future<void> initState(
    context,
  ) async {
    await getShopConfiguration(context);
  }

  ////Image
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

  ///

  ////// Shop Configuration start
  Future<void> getShopConfiguration(context) async {
    print("successToken");
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopConfigRepo
        .shopCongurationDetails(pref.getString("successToken"))
        .then((response) {
      final result = ShopConfigurationResponse.fromJson(
        jsonDecode(response.body),
      );

      if (response.statusCode == 200) {
        final Data = result.data;

        print(
            "${Data}bnywhuvjicui4ywtvb8n98ymuirwmwc9033309b4mmvjmirjiytjweib");

        print("${response.body}");

        SupportNumberController.text = Data?.shopOwnerSupportNumber ?? "";
        // print(SupportNumberController);
        FirstDeliveryController.text =
            Data?.shopOwnerAmount1DeliveryCharges ?? "";
        SecondDeliveryController.text =
            Data?.shopOwnerAmount2DeliveryCharges ?? "";
        ThirdDeliveryController.text =
            Data?.shopOwnerAmount3DeliveryCharges ?? "";
        FourthDeliveryController.text =
            Data?.shopOwnerAmount4DeliveryCharges ?? "";
        StartShopTimeController.text = Data?.shopOwnerShopOpeningTime ?? "";
        EndShopTimeController.text = Data?.shopOwnerShopCloseTime ?? "";
        UpiIdController.text = result.upiid ?? "";

        ///Slot Selection
        if (Data?.shopOwnerSlot9To12 == "active") {
          isNineToTwelve = true;
        }
        if (Data?.shopOwnerSlot12To3 == "active") {
          isTwelveToThree = true;
        }
        if (Data?.shopOwnerSlot3To6 == "active") {
          isThreeToSix = true;
        }
        if (Data?.shopOwnerSlot6To9 == "active") {
          isSixToNine = true;
        }
        ////

        //////// Delivery type///////////
        if (Data?.shopOwnerCustomerPickup == "active") {
          isCustomerPickupSelected = true;
        }
        if (Data?.shopOwnerDeliveryToCustomer == "active") {
          isCustomerPickupSelected = true;
        }
        if (Data?.shopOwnerDeliveryChargesFree == "active") {
          isCustomerPickupSelected = true;
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
  /////////////////////////
//  Edit//////

  ShopConfigRequestModel get shopConfigRequestModel => ShopConfigRequestModel(
      shopOwnerAmount1DeliveryCharges: FirstDeliveryController.text,
      shopOwnerAmount2DeliveryCharges: SecondDeliveryController.text,
      shopOwnerAmount3DeliveryCharges: ThirdDeliveryController.text,
      shopOwnerAmount4DeliveryCharges: FourthDeliveryController.text,
      shopOwnerCustomerPickup: isCustomerPickupSelected ? "active" : "inactive",
      shopOwnerDeliveryToCustomer:
          isDeliveryCustomerSelected ? "active" : "inactive",
      shopOwnerDeliveryChargesFree:
          isDeliveryChargesSelected ? "active" : "inactive",
      shopOwnerPaymentQrCodeImageName: '',
      shopOwnerPaymentQrCodeImagePath: '',
      shopOwnerShopCloseTime: EndShopTimeController.text,
      shopOwnerShopOpeningTime: StartShopTimeController.text,
      shopOwnerSlot12To3: isTwelveToThree ? "active" : "inactive",
      shopOwnerSlot3To6: isThreeToSix ? "active" : "inactive",
      shopOwnerSlot6To9: isSixToNine ? "active" : "inactive",
      shopOwnerSlot9To12: isNineToTwelve ? "active" : "inactive",
      shopOwnerSupportNumber: SupportNumberController.text,
      shopOwnerUpiId: UpiIdController.text);

  Future<void> EditShopconfig(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    shopEditConfigRepo.EditShopconfig(
            shopConfigRequestModel, pref.getString("successToken"))
        .then((response) {
      print("uehcvcvcvcvcvcvcvcvcvcvcvcvcvcvcvcvcvcvcvqt");
      print(response.body);
      final result = ShopConfigurationRes.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        Utils.showPrimarySnackbar(context, "Updated Successfully",
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
}
