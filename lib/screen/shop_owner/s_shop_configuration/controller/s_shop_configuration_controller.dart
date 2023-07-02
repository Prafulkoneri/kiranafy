import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/model/shop_configuration_edit_request_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/model/shop_configuration_response_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/repository/s_shop_configuration_edit_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/repository/s_shop_configuration_repo.dart';
import 'package:local_supper_market/utils/common_functions.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';

class SShopConfigurationController extends ChangeNotifier {
  ShopConfigurationRepo shopConfigRepo = ShopConfigurationRepo();
  EditConfigRepo shopEditConfigRepo = EditConfigRepo();
  TextEditingController upiIdController = TextEditingController();
  TextEditingController supportNumberController = TextEditingController();
  TextEditingController firstDeliveryController = TextEditingController();
  TextEditingController secondDeliveryController = TextEditingController();
  TextEditingController thirdDeliveryController = TextEditingController();
  TextEditingController fourthDeliveryController = TextEditingController();
  TextEditingController startShopTimeController = TextEditingController();
  TextEditingController endShopTimeController = TextEditingController();
  TextEditingController imageNameController = TextEditingController();
  // TextEditingController deliveryChargesOneController = TextEditingController();
  // TextEditingController deliveryChargesTwoController = TextEditingController();
  // TextEditingController deliveryChargesThreeController =
  //     TextEditingController();
  // TextEditingController deliveryChargesFourController = TextEditingController();

  bool isCustomerPickupSelected = false;
  bool ifFreePickupSelected = false;
  bool isDeliveryCustomerSelected = false;
  bool isDeliveryChargesSelected = false;
  bool isNineToTwelve = false;
  bool isTwelveToThree = false;
  bool isThreeToSix = false;
  bool isSixToNine = false;
  File fileImage = File("");
  String networkImage = "";
  String image = "";
  bool isLoading = true;
  bool isInitialConfiguration = true;

  Future<void> initState(context, initialConfiguration) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // supportNumberController.text = pref.getString("mobileNumber").toString();

    print(pref.getString("mobileNo").toString());
    supportNumberController.text = pref.getString("mobileNo").toString();

    await getShopConfiguration(
      context,
      initialConfiguration,
    );
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

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
      firstDeliveryController.clear();
      secondDeliveryController.clear();
      thirdDeliveryController.clear();
      fourthDeliveryController.clear();
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

  ////Image
  void openGallery1() async {
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

  ///

  ////// Shop Configuration start
  Future<void> getShopConfiguration(context, configuration) async {
    showLoader(true);
    isInitialConfiguration = configuration;
    print("successToken");
    SharedPreferences pref = await SharedPreferences.getInstance();
    supportNumberController.text = pref.getString("mobileNo").toString();
    shopConfigRepo
        .shopCongurationDetails(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = ShopConfigurationResponse.fromJson(
        jsonDecode(response.body),
      );

      if (response.statusCode == 200) {
        final data = result.data;

        supportNumberController.text = data?.shopOwnerSupportNumber ?? "";
        if (configuration) {
          print(pref.getString("mobileNo").toString());
          supportNumberController.text = pref.getString("mobileNo").toString();
        }
        // print(SupportNumberController);
        firstDeliveryController.text =
            data?.shopOwnerAmount1DeliveryCharges ?? "";
        secondDeliveryController.text =
            data?.shopOwnerAmount2DeliveryCharges ?? "";
        thirdDeliveryController.text =
            data?.shopOwnerAmount3DeliveryCharges ?? "";
        fourthDeliveryController.text =
            data?.shopOwnerAmount4DeliveryCharges ?? "";
        startShopTimeController.text = data?.shopOwnerShopOpeningTime ?? "";
        endShopTimeController.text = data?.shopOwnerShopCloseTime ?? "";
        upiIdController.text = result.upiid ?? "";
        networkImage = data?.shopOwnerPaymentQrCodeImagePath ?? "";

        ///Slot Selection
        if (data?.shopOwnerSlot9To12 == "active") {
          isNineToTwelve = true;
        }
        if (data?.shopOwnerSlot12To3 == "active") {
          isTwelveToThree = true;
        }
        if (data?.shopOwnerSlot3To6 == "active") {
          isThreeToSix = true;
        }
        if (data?.shopOwnerSlot6To9 == "active") {
          isSixToNine = true;
        }
        ////

        //////// Delivery type///////////
        if (data?.shopOwnerCustomerPickup == "active") {
          isCustomerPickupSelected = true;
        } else {
          isCustomerPickupSelected = false;
        }
        if (data?.shopOwnerDeliveryToCustomer == "active") {
          isDeliveryCustomerSelected = true;
        } else {
          isDeliveryCustomerSelected = false;
        }
        if (data?.shopOwnerDeliveryChargesFree == "active") {
          isDeliveryChargesSelected = false;
          ifFreePickupSelected = true;
        }
        if (data?.shopOwnerDeliveryChargesFree == "inactive") {
          isDeliveryChargesSelected = true;
          ifFreePickupSelected = false;
        }
        if (data?.shopOwnerDeliveryChargesFree == null) {
          isDeliveryChargesSelected = false;
          ifFreePickupSelected = false;
        }
        if (data?.shopOwnerDeliveryChargesFree == "") {
          isDeliveryChargesSelected = false;
          ifFreePickupSelected = false;
        }
        if (data?.shopOwnerDeliveryChargesFree == "null") {
          isDeliveryChargesSelected = false;
          ifFreePickupSelected = false;
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

  /////////////////////////
//  Edit//////

  Future uploadShopConfiguration(context) async {
    if (upiIdController.text == "") {
      Utils.showPrimarySnackbar(context, "UPI ID is empty",
          type: SnackType.error);
      return;
    }
    if (startShopTimeController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Shop Opening Time",
          type: SnackType.error);
      return;
    }
    if (endShopTimeController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Shop Closing Time",
          type: SnackType.error);
      return;
    }
    if (isDeliveryChargesSelected) {
      if (firstDeliveryController.text.isEmpty) {
        Utils.showPrimarySnackbar(context, "Please Select Delivery Charges ",
            type: SnackType.error);
        return;
      }
      if (firstDeliveryController.text == "0") {
        Utils.showPrimarySnackbar(context, "Delivery Charges can't be Zero ",
            type: SnackType.error);
        notifyListeners();
        return;
      }
    }

    /////////////////////
    if (endShopTimeController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Shop Closing Time",
          type: SnackType.error);
      return;
    }

    //////////////////
    // if (supportNumberController.text.length < 10) {
    //   Utils.showPrimarySnackbar(context, "Please Enter 10 digits",
    //       type: SnackType.error);
    //   return;
    // }
    if (supportNumberController.text.length < 10) {
      Utils.showPrimarySnackbar(context, "Please Enter Mobile Number",
          type: SnackType.error);
      notifyListeners();
      return;
    }
    if (!isCustomerPickupSelected && !isDeliveryCustomerSelected) {
      Utils.showPrimarySnackbar(context, "Select Any Delivery Type",
          type: SnackType.error);
      return;
    }
    if (!ifFreePickupSelected && !isDeliveryChargesSelected) {
      Utils.showPrimarySnackbar(context, "Select Any Delivery Charges",
          type: SnackType.error);
      return;
    }

    if (!isNineToTwelve && !isThreeToSix && !isTwelveToThree && !isSixToNine) {
      Utils.showPrimarySnackbar(context, "Select Any Slot",
          type: SnackType.error);
      return;
    }

    if (fileImage.path == "") {
      await editShopconfig(context);
    } else {
      await uploadImage(context);
    }
  }

  ShopConfigRequestModel get shopConfigRequestModel => ShopConfigRequestModel(
        shopOwnerAmount1DeliveryCharges: firstDeliveryController.text,
        shopOwnerAmount2DeliveryCharges: secondDeliveryController.text,
        shopOwnerAmount3DeliveryCharges: thirdDeliveryController.text,
        shopOwnerAmount4DeliveryCharges: fourthDeliveryController.text,
        shopOwnerCustomerPickup:
            isCustomerPickupSelected ? "active" : "inactive",
        shopOwnerDeliveryToCustomer:
            isDeliveryCustomerSelected ? "active" : "inactive",
        shopOwnerDeliveryChargesFree:
            isDeliveryChargesSelected ? "inactive" : "active",
        shopOwnerPaymentQrCodeImageName: '',
        shopOwnerPaymentQrCodeImagePath: '',
        shopOwnerShopCloseTime: endShopTimeController.text,
        shopOwnerShopOpeningTime: startShopTimeController.text,
        shopOwnerSlot12To3: isTwelveToThree ? "active" : "inactive",
        shopOwnerSlot3To6: isThreeToSix ? "active" : "inactive",
        shopOwnerSlot6To9: isSixToNine ? "active" : "inactive",
        shopOwnerSlot9To12: isNineToTwelve ? "active" : "inactive",
        shopOwnerSupportNumber: supportNumberController.text,
        shopOwnerUpiId: upiIdController.text,
      );

  Future editShopconfig(context) async {
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var a = await shopEditConfigRepo.EditShopconfig(
            shopConfigRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = ShopConfigurationRes.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        LoadingOverlay.of(context).hide();
        pref.setString("status", "loggedIn");
        if (isInitialConfiguration) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                      index: 0,
                      screenName: ShopDashBoardView(),
                    )),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                      index: 4,
                      screenName: SAccountScreenView(),
                    )),
            (Route<dynamic> route) => false,
          );
        }
        // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SMainScreenView(index: 4,screenName:SAccountScreenView(),)));

        Utils.showPrimarySnackbar(context, "Updated Successfully",
            type: SnackType.success);
        notifyListeners();
      } else {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
        return false;
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

  Future uploadImage(context) async {
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("successToken").toString();
    var uri = Uri.parse("${Endpoint.shopconfigurationedit}");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = "Bearer $token";
    request.fields['shop_owner_support_number'] = supportNumberController.text;
    request.fields['shop_owner_shop_opening_time'] =
        startShopTimeController.text;
    request.fields['shop_owner_shop_close_time'] = endShopTimeController.text;
    request.fields['shop_owner_amount_1_delivery_charges'] =
        firstDeliveryController.text;
    request.fields['shop_owner_amount_2_delivery_charges'] =
        secondDeliveryController.text;
    request.fields['shop_owner_amount_3_delivery_charges'] =
        thirdDeliveryController.text;
    request.fields['shop_owner_amount_4_delivery_charges'] =
        fourthDeliveryController.text;
    request.fields['shop_owner_customer_pickup'] =
        isCustomerPickupSelected ? "active" : "inactive";
    request.fields['shop_owner_delivery_to_customer'] =
        isDeliveryCustomerSelected ? "active" : "inactive";
    request.fields['shop_owner_delivery_charges_free'] =
        isDeliveryChargesSelected ? "inactive" : "active";
    request.fields['shop_owner_slot_9_to_12'] =
        isNineToTwelve ? "active" : "inactive";
    request.fields['shop_owner_slot_12_to_3'] =
        isTwelveToThree ? "active" : "inactive";
    request.fields['shop_owner_slot_3_to_6'] =
        isThreeToSix ? "active" : "inactive";
    request.fields['shop_owner_slot_6_to_9'] =
        isSixToNine ? "active" : "inactive";
    request.fields['shop_owner_upi_id'] = upiIdController.text;
    request.fields['shop_owner_upi_id'] = upiIdController.text;
    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    List<http.MultipartFile> newList = <http.MultipartFile>[];
    File imageFile = fileImage;
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = new http.MultipartFile(
        "shop_owner_payment_qr_code_image_path", stream, length,
        filename: basename(imageFile.path));
    newList.add(multipartFile);
    request.files.addAll(newList);
    print(request.fields);
    await request.send().then((response) {
      if (response.statusCode == 200) {
        print("sucesss");
        LoadingOverlay.of(context).hide();
        pref.setString("status", "loggedIn");
        Utils.showPrimarySnackbar(context, "Updated Successfully",
            type: SnackType.success);
        if (isInitialConfiguration) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                      index: 0,
                      screenName: ShopDashBoardView(),
                    )),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                      index: 4,
                      screenName: SAccountScreenView(),
                    )),
            (Route<dynamic> route) => false,
          );
        }
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
