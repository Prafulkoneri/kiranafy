import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/main_screen/controllers/main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_accounts_screen/view/s_accounts_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_dashboard/view/s_dash_board_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/model/shop_configuration_edit_request_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/model/shop_configuration_response_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/model/shop_delivery_area_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/repository/s_shop_configuration_edit_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/repository/s_shop_configuration_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/repository/shop_delivery_area_repo.dart';
import 'package:local_supper_market/utils/common_functions.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';

class SShopConfigurationController extends ChangeNotifier {
  ShopConfigurationRepo shopConfigRepo = ShopConfigurationRepo();
  ShopDeliveryAreaRepo shopDeliveryAreaRepo = ShopDeliveryAreaRepo();
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
  TextEditingController minimumDeliveryAmountController =
      TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController deliveryAreasController = TextEditingController();
  TextEditingController areaSearchController = TextEditingController();
  // TextEditingController deliveryChargesTwoController = TextEditingController();
  // TextEditingController deliveryChargesThreeController =
  //     TextEditingController();
  // TextEditingController deliveryChargesFourController = TextEditingController();

  bool isCustomerPickupSelected = false;
  bool isOnlinePaymentSelected = false;
  bool isCODPaymentSelected = false;
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
  List<ShopDeliveryAreaData>? shopDeliveryAreaData;
  List<bool> selectedDeliveryAreaList = [];
  List selectedDeliveryAreaId = [];
  List selectedDeliveryAreaName = [];
  String selectedAreaId = "";
  List<AreaList>? areaList;
  List initialSelectedAreaId = [];

  Future<void> initState(context, initialConfiguration) async {
    upiIdController.clear();
    supportNumberController.clear();
    firstDeliveryController.clear();
    secondDeliveryController.clear();
    thirdDeliveryController.clear();
    fourthDeliveryController.clear();
    startShopTimeController.clear();
    endShopTimeController.clear();
    imageNameController.clear();
    isCustomerPickupSelected = false;
    isOnlinePaymentSelected = false;
    isCODPaymentSelected = false;
    ifFreePickupSelected = false;
    isDeliveryCustomerSelected = false;
    isDeliveryChargesSelected = false;
    isNineToTwelve = false;
    isTwelveToThree = false;
    isThreeToSix = false;
    isSixToNine = false;
    fileImage = File("");
    networkImage = "";
    image = "";
    isLoading = true;
    isInitialConfiguration = true;
    shopDeliveryAreaData?.clear();
    selectedDeliveryAreaList.clear();
    selectedDeliveryAreaId.clear();
    selectedDeliveryAreaName.clear();
    selectedAreaId = "";
    areaList?.clear();
    initialSelectedAreaId.clear();
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

  void onDeliveryAreaSubmit(context) {
    selectedAreaId = "";
    print(selectedDeliveryAreaName);
    // return;
    deliveryAreasController.clear();
    for (int i = 0; i < selectedDeliveryAreaName.length; i++) {
      deliveryAreasController.text += selectedDeliveryAreaName[i] + ", ";
    }
    for (int i = 0; i < selectedDeliveryAreaId.length; i++) {
      selectedAreaId += selectedDeliveryAreaId[i].toString() + ",";
    }
    selectedAreaId =
        selectedAreaId.toString().substring(0, selectedAreaId.length - 1);
    deliveryAreasController.text = deliveryAreasController.text
        .substring(0, deliveryAreasController.text.length - 2);

    Navigator.pop(context);
    notifyListeners();
  }

  ////////Mode of payment///
  void onOnlinePaymentSelected() {
    isOnlinePaymentSelected = !isOnlinePaymentSelected;
    notifyListeners();
  }

  void onCODPaymentSelected() {
    isCODPaymentSelected = !isCODPaymentSelected;
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
    selectedDeliveryAreaName.clear();
    selectedDeliveryAreaId.clear();
    deliveryAreasController.clear();
    selectedAreaId = "";
    showLoader(true);
    isInitialConfiguration = configuration;
    print("successToken");
    SharedPreferences pref = await SharedPreferences.getInstance();
    supportNumberController.text = pref.getString("mobileNo").toString();
    shopConfigRepo
        .shopCongurationDetails(pref.getString("successToken"))
        .then((response) async{
      log(response.body);
      final result = ShopConfigurationResponse.fromJson(
        jsonDecode(response.body),
      );

      if (response.statusCode == 200) {
        final data = result.data;
        initialSelectedAreaId = result.selectedDeliveryArea ?? [];
        // shopDeliveryAreaData = result.shopDeliveryAreaData;
        // selectedDeliveryAreaList = List<bool>.filled(
        //     shopDeliveryAreaData?.length ?? 0, false,
        //     growable: true);

        if (configuration) {
          print(pref.getString("mobileNo").toString());
          supportNumberController.text = pref.getString("mobileNo").toString();
        } else {
          supportNumberController.text = data?.shopOwnerSupportNumber ?? "";
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
        minimumDeliveryAmountController.text =
            data?.minimumOrderDeliveryAmount ?? "";
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
        if (data?.acceptedPaymentStatus == "cod_and_online") {
          isCODPaymentSelected = true;
          isOnlinePaymentSelected = true;
        }
        if (data?.acceptedPaymentStatus == "online") {
          isOnlinePaymentSelected = true;
          isCODPaymentSelected = false;
        }
        if (data?.acceptedPaymentStatus == "cod") {
          isCODPaymentSelected = true;
          isOnlinePaymentSelected = false;
        }

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
        await shopDeliveryArea(context);
        notifyListeners();
      }
      else if(response.statusCode == 401){
        Utils().logoutUser(context);
      }
      else {
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
    if (!isOnlinePaymentSelected && !isCODPaymentSelected) {
      Utils.showPrimarySnackbar(context, "Select Payment Mode",
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
    if (!isCustomerPickupSelected) {
      if (!ifFreePickupSelected && !isDeliveryChargesSelected) {
        Utils.showPrimarySnackbar(context, "Select Any Delivery Charges",
            type: SnackType.error);
        return;
      }
      if (minimumDeliveryAmountController.text == "") {
        Utils.showPrimarySnackbar(
            context, "Please Enter Minimum Delivery Order Value",
            type: SnackType.error);
        return;
      }
      ///////////////Delivery Type///////////

      ////////////////////

    }
    if (isCustomerPickupSelected&&isDeliveryCustomerSelected) {
      if (!ifFreePickupSelected && !isDeliveryChargesSelected) {
        Utils.showPrimarySnackbar(context, "Select Any Delivery Charges",
            type: SnackType.error);
        return;
      }
      if (minimumDeliveryAmountController.text == "") {
        Utils.showPrimarySnackbar(
            context, "Please Enter Minimum Delivery Order Value",
            type: SnackType.error);
        return;
      }
      ///////////////Delivery Type///////////

      ////////////////////

    }

    /////////////////////
    // if (endShopTimeController.text == "") {
    //   Utils.showPrimarySnackbar(context, "Enter Shop Closing Time",
    //       type: SnackType.error);
    //   return;
    // }
    //////////////////

    //////////////////
    if (deliveryAreasController.text == "") {
      Utils.showPrimarySnackbar(context, "Please Select Delivery Areas",
          type: SnackType.error);
      return;
    }
//////////////


    // if (!ifFreePickupSelected && !isDeliveryChargesSelected) {
    //   Utils.showPrimarySnackbar(context, "Select Any Delivery Charges",
    //       type: SnackType.error);
    //   return;
    // }

//////////////////////Minimum Order value/////////////


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
      shopOwnerCustomerPickup: isCustomerPickupSelected ? "active" : "inactive",
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
      minimumOrderDeliveryAmount: minimumDeliveryAmountController.text,
      areaId: selectedAreaId,
      acceptedPaymentStatus: isOnlinePaymentSelected && isCODPaymentSelected
          ? "cod_and_online"
          : isOnlinePaymentSelected
              ? "online "
              : isCODPaymentSelected
                  ? "cod"
                  : "");

  Future editShopconfig(context) async {
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var a = await shopEditConfigRepo.EditShopconfig(
            shopConfigRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result = ShopConfigurationRes.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        final read =Provider.of<SMainScreenController>(context,listen: false);
        LoadingOverlay.of(context).hide();
        pref.setString("status", "loggedIn");
        if (isInitialConfiguration) {

          // read.onNavigation(0,ShopDashBoardView(
          //   refresh: true,
          // ), context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                      index: 0,
                      screenName: ShopDashBoardView(
                        refresh: true,
                      ),
                    )),
            (Route<dynamic> route) => false,
          );
        } else {

          read.onNavigation(4,SAccountScreenView(
            refresh: true,
          ), context);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SMainScreenView(
          //             index: 4,
          //             screenName: SAccountScreenView(
          //               refresh: true,
          //             ),
          //           )),
          //   (Route<dynamic> route) => false,
          // );
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
    request.fields['area_id'] = selectedAreaId;
    request.fields['min_order_amount_for_delivery'] =
        minimumDeliveryAmountController.text;
    request.fields['accepted_payment_status'] =
        isOnlinePaymentSelected && isCODPaymentSelected
            ? "cod_and_online"
            : isOnlinePaymentSelected
                ? "online "
                : isCODPaymentSelected
                    ? "cod"
                    : "";
    // multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    List<http.MultipartFile> newList = <http.MultipartFile>[];
    print(fileImage);
    File imageFile = fileImage;
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = new http.MultipartFile(
        "shop_owner_payment_qr_code_image_path", stream, length,
        filename: basename(imageFile.path));
    newList.add(multipartFile);
    request.files.addAll(newList);
    print(request.fields);
    await request.send().then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        final read=Provider.of<SMainScreenController>(context,listen: false);
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
                  screenName: ShopDashBoardView(
                    refresh: true,
                  ),
                )),
                (Route<dynamic> route) => false,
          );
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SMainScreenView(
          //             index: 0,
          //             screenName: ShopDashBoardView(
          //               refresh: true,
          //             ),
          //           )),
          //   (Route<dynamic> route) => false,
          // );
        } else {
          read.onNavigation(4,SAccountScreenView(refresh: true), context);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SMainScreenView(
          //             index: 4,
          //             screenName: SAccountScreenView(refresh: true),
          //           )),
          //   (Route<dynamic> route) => false,
          // );
        }
      } else {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, "Error on uploading",
            type: SnackType.error);
        return;
      }
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    });
  }

  void onClearAreaSearch() {
    print("hello");
    areaSearchController.clear();
    shopDeliveryArea(context);
    notifyListeners();
  }

  void onSelectedDeliveryArea(index, id, name) {
    print(selectedDeliveryAreaName);
    selectedDeliveryAreaList[index] = !selectedDeliveryAreaList[index];
    if (selectedDeliveryAreaList[index]) {
      selectedDeliveryAreaId.removeWhere((item) => item == id);
      selectedDeliveryAreaId.insert(0, id);
      selectedDeliveryAreaName.removeWhere((item) => item == name);
      selectedDeliveryAreaName.insert(0, name);
    } else {
      selectedDeliveryAreaId.removeWhere((item) => item == id);
      selectedDeliveryAreaName.removeWhere((item) => item == name);
    }
    print(selectedDeliveryAreaId);
    print(selectedDeliveryAreaName);
    notifyListeners();
  }
 onAddDeliveryAreaTap(){
   areaSearchController.clear();
    notifyListeners();
 }

  List selectedCategoryId = [];
  List<bool> selectedCategoryList = [];
  /////////////////////////////////////////
  Future<void> shopDeliveryArea(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("successToken"));
    shopDeliveryAreaRepo
        .deliveryAreaRepo(pref.getString("successToken"), "")
        .then((response) {
      print(response.body);
      final result =
          ShopDeliveryAreaDataResModel.fromJson(jsonDecode(response.body));
      print("oooooooooooooooo");
      log(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        selectedAreaId = "";
        deliveryAreasController.clear();
        areaList = result.areaList;
        selectedDeliveryAreaList =
            List<bool>.filled(areaList?.length ?? 0, false, growable: true);
        int areaLength = areaList?.length ?? 0;
        if (initialSelectedAreaId.isNotEmpty) {
          selectedDeliveryAreaId = initialSelectedAreaId;
          List ids = [];
          List name = [];
          for (int i = 0; i < areaLength; i++) {
            ids.add(areaList?[i].id);
            name.add(areaList?[i].areaName);
          }
          print(selectedDeliveryAreaId);
          for (int i = 0; i < selectedDeliveryAreaId.length; i++) {
            selectedDeliveryAreaList[ids.indexOf(selectedDeliveryAreaId[i])] =
                true;
            selectedDeliveryAreaName.add(name[ids.indexOf(selectedDeliveryAreaId[i])]);
            deliveryAreasController.text +=
                name[ids.indexOf(selectedDeliveryAreaId[i])] + ", ";
          }
          deliveryAreasController.text = deliveryAreasController.text
              .substring(0, deliveryAreasController.text.length - 2);
          for (int i = 0; i < selectedDeliveryAreaId.length; i++) {
            selectedAreaId += selectedDeliveryAreaId[i].toString() + ",";
          }
          selectedAreaId =
              selectedAreaId.toString().substring(0, selectedAreaId.length - 1);
        } else {
          deliveryAreasController.clear();
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

  ////////////////////////////////SearchArea////////////////////

  Future<void> deliveryAreaSearch(context) async {
    print(areaSearchController);
    if (areaSearchController.text.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      print(pref.getString("successToken"));
      shopDeliveryAreaRepo
          .deliveryAreaRepo(
              pref.getString("successToken"), areaSearchController.text)
          .then((response) {
        log("response.body${response.body}");
        final result =
            ShopDeliveryAreaDataResModel.fromJson(jsonDecode(response.body));
        if (response.statusCode == 200) {
          areaList = result.areaList;
          print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
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
    } else {
      await shopDeliveryArea(context);
    }
  }
}
