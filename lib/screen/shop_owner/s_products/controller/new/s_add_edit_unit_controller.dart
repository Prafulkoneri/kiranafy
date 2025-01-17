import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/add_update_unit_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/edit_unit_product_category_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/new/add_update_unit_product_category_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/new/edit_unit_product_category_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/unit_detail_view.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/new_model/unit_list_to_create_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/new/unit_list_to_create_product_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddEditUnitController extends ChangeNotifier {
  bool isLoading = false;
  String productId = "";
  String producttype = "";
  List<UnitListData>? unitList;
  TextEditingController valueController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController offerPriceController = TextEditingController();
  bool switchValue = true;
  String networkImage1 = "";
  String networkImage2 = "";
  String networkImage3 = "";
  File fileImage1 = File("");
  File fileImage2 = File("");
  File fileImage3 = File("");
  String productUnitId = "";
  String unitId = "";
  String categoryId = "";
  ProductUnitDetails? data;

  UnitListToCreateProductRepo unitListToCreateProductRepo =
      UnitListToCreateProductRepo();
  EditUnitProductCategoryRepo editUnitProductCategoryRepo =
      EditUnitProductCategoryRepo();
  AddUpdateUnitProductCategoryRepo addUpdateUnitProductCategoryRepo =
      AddUpdateUnitProductCategoryRepo();
  Future<void> initState(context, pId, pUnitId, catId, pType, isEdit) async {
    productId = pId;
    productUnitId = pUnitId;
    categoryId = catId;
    producttype = pType;
    switchValue = true;
    unitId = "";
    valueController.clear();
    mrpController.clear();
    offerPriceController.clear();
    fileImage1 = File("");
    fileImage2 = File("");
    fileImage3 = File("");
    networkImage1 = "";
    networkImage2 = "";
    networkImage3 = "";
    if (isEdit) {
      await getData(context);
    } else {
      await getUnitList(context);
    }
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getUnitList(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // showLoader(true);
    unitListToCreateProductRepo
        .getUnitList(pref.getString("successToken"))
        .then((response) async {
      final result =
          UnitListtoCreateProductResModel.fromJson(jsonDecode(response.body));
      print("uiiiiiiiiiiiiiiiiiiiiiiiiiii");
      log(response.body);
      print("uiiiiiiiiiiiiiiiiiiiiiiiiiii");
      if (response.statusCode == 200) {
        unitList = result.unitlistproductdata?.unitData;
        // showLoader(false);/
        notifyListeners();
      } else if (response.statusCode == 401) {
        Utils().logoutUser(context);
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

  EditProductUnitCategoryRequestModel get editProductUnitCategoryRequestModel =>
      EditProductUnitCategoryRequestModel(
        productUnitId: productUnitId,
        productType: producttype,
      );

  EditCustomProductUnitCategoryRequestModel
      get editCustomProductUnitCategoryRequestModel =>
          EditCustomProductUnitCategoryRequestModel(
            productId: productId,
            productType: producttype,
            productUnitId: productUnitId,
          );

  Future<void> getData(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    showLoader(true);
    editUnitProductCategoryRepo
        .getEditUnit(
            editProductUnitCategoryRequestModel, pref.getString("successToken"))
        .then((response) async {
      final result =
          EditProductUnitCategoryResModel.fromJson(jsonDecode(response.body));
      print("uiiiiiiiiiiiiiiiiiiiiiiiiiii");
      log(response.body);
      print("uiiiiiiiiiiiiiiiiiiiiiiiiiii");
      if (response.statusCode == 200) {
        data = result.productUnitDetails;
        valueController.text = data?.weight ?? "";
        mrpController.text = data?.mrpPrice.toString() ?? "";
        offerPriceController.text = data?.offerPrice.toString() ?? "";
        switchValue = data?.status == "active" ? true : false;
        // switchValue = data?.status == "active";
        unitList = result.editunitdata?.units;
        networkImage1 = data?.unitBasedProductImage1Path ?? "";
        networkImage2 = data?.unitBasedProductImage2Path ?? "";
        networkImage3 = data?.unitBasedProductImage3Path ?? "";
        unitId = data?.unitId.toString() ?? "";
        showLoader(false);
        notifyListeners();
      } else if (response.statusCode == 401) {
        Utils().logoutUser(context);
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

  void onUnitSelect(value) {
    unitId = value;
    notifyListeners();
  }

  void openGallery1(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage1 = "";
      final CroppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
      );
      fileImage1 = File(CroppedFile!.path);
      // notifyListeners();
    }

    notifyListeners();
    // Navigator.pop(context);
  }

  void openGallery2(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage2 = "";
      final CroppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
      );
      fileImage2 = File(CroppedFile!.path);
    }
    notifyListeners();

    // Navigator.pop(context);
  }

  void openGallery3(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage3 = "";
      final CroppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
      );
      fileImage3 = File(CroppedFile!.path);
    }

    notifyListeners();
    // Navigator.pop(context);
  }

  void openCamera1(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage1 = "";
      final CroppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
      );
      fileImage1 = File(CroppedFile!.path);
    }

    notifyListeners();
    Navigator.of(context, rootNavigator: true).pop();
  }

  void openCamera2(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage2 = "";
      final CroppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
      );
      fileImage2 = File(CroppedFile!.path);
    }

    notifyListeners();
    Navigator.of(context, rootNavigator: true).pop();
  }

  void openCamera3(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      networkImage3 = "";
      final CroppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
      );
      fileImage3 = File(CroppedFile!.path);
    }
    notifyListeners();

    Navigator.of(context, rootNavigator: true).pop();
  }

  void onToggleSwitch(value) {
    switchValue = value;
    notifyListeners();
  }

  AddUpdateUnitProductCategoryRequestModel
      get addUpdateUnitProductCategoryRequestModel =>
          AddUpdateUnitProductCategoryRequestModel(
            productType: producttype,
            productUnitId: data?.particularUnitId.toString(),
            productId: productId,
            weight: valueController.text,
            status: switchValue ? "active" : "inactive",
            offerPrice: offerPriceController.text,
            mrpPrice: mrpController.text,
            actionType: "update",
            unitId: unitId,
            unitBasedProductImage1Path: "",
            unitBasedProductImage2Path: "",
            unitBasedProductImage3Path: "",
          );

  Future<void> updateEditUnitDetails(context) async {
    LoadingOverlay.of(context).show();
    if (valueController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Value", type: SnackType.error);
      return;
    }
    if (unitId == "") {
      Utils.showPrimarySnackbar(context, "Select a unit",
          type: SnackType.error);
      return;
    }
    if (mrpController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Mrp Price",
          type: SnackType.error);
      return;
    }
    if (int.parse(mrpController.text) < 1) {
      Utils.showPrimarySnackbar(context, "Mrp price cant be less than 1",
          type: SnackType.error);
      return;
    }
    if (offerPriceController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Offer Price",
          type: SnackType.error);
      return;
    }
    if (int.parse(offerPriceController.text) < 1) {
      Utils.showPrimarySnackbar(context, "Offer price cant be less than 1",
          type: SnackType.error);
      return;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    // showLoader(true);
    addUpdateUnitProductCategoryRepo
        .addUpdateUnitProductCategory(addUpdateUnitProductCategoryRequestModel,
            pref.getString("successToken"))
        .then((response) async {
      final result = AddUpdateUnitProductCategoryResModel.fromJson(
          jsonDecode(response.body));
      print("uiiiiiiiiiiiiiiiiiiiiiiiiiii");
      log(response.body);
      print("uiiiiiiiiiiiiiiiiiiiiiiiiiii");
      if (response.statusCode == 200) {
        LoadingOverlay.of(context).show();
        if (result.status == 200) {
          LoadingOverlay.of(context).hide();
          final read =
              Provider.of<SMainScreenController>(context, listen: false);
          read.onNavigation(
              0,
              UnitDetailView(
                refresh: true,
                categoryId: categoryId,
                productId: productId,
                productType: producttype,
              ),
              context);
        } else {
          LoadingOverlay.of(context).hide();
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }

        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => SMainScreenView(
        //           index: 0,
        //           screenName: UnitDetailView(refresh: true,categoryId: categoryId,productId: productId,productType: producttype,))),
        //       (Route<dynamic> route) => false,
        // );
        // Utils.showPrimarySnackbar(context, result.message,
        //     type: SnackType.success);
        // showLoader(false);
        notifyListeners();
      } else {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.error);
      }
    }).onError((error, stackTrace) {
      LoadingOverlay.of(context).hide();
      Utils.showPrimarySnackbar(context, error, type: SnackType.debugError);
    }).catchError(
      (Object e) {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
      },
      test: (Object e) {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, e, type: SnackType.debugError);
        return false;
      },
    );
  }

  Future addUnit(context, actionType) async {
    if (valueController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Value", type: SnackType.error);
      return;
    }
    if (unitId == "") {
      Utils.showPrimarySnackbar(context, "Select a unit",
          type: SnackType.error);
      return;
    }
    if (mrpController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Mrp Price",
          type: SnackType.error);
      return;
    }
    if (int.parse(mrpController.text) < 1) {
      Utils.showPrimarySnackbar(context, "Mrp price cant be less than 1",
          type: SnackType.error);
      return;
    }
    if (offerPriceController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Offer Price",
          type: SnackType.error);
      return;
    }
    if (int.parse(offerPriceController.text) < 1) {
      Utils.showPrimarySnackbar(context, "Offer price cant be less than 1",
          type: SnackType.error);
      return;
    }
    // if(networkImage1==""&&networkImage2==""&&networkImage3==""){
    //   if(fileImage1.path==""&&fileImage2.path==""&&fileImage3.path==""){
    //     Utils.showPrimarySnackbar(context, "Select atleast 1 image",
    //         type: SnackType.error);
    //     return;
    //   }
    // }
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("successToken").toString();
    var uri = Uri.parse(Endpoint.addUpadteUnitProductCategory);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = "Bearer $token";
    request.fields['action_type'] = actionType.toString();
    request.fields['product_id'] = productId;
    request.fields['unit_id'] = unitId;
    request.fields['weight'] = valueController.text;
    request.fields['mrp_price'] = mrpController.text;
    request.fields['offer_price'] = offerPriceController.text;
    request.fields['status'] = switchValue ? "active" : "inactive";
    request.fields['product_unit_id'] = data?.particularUnitId.toString() ?? "";
    request.fields['product_type'] = producttype;

    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    List<http.MultipartFile> newList = <http.MultipartFile>[];
    if (fileImage1.path != "") {
      File imageFile = fileImage1;
      var stream =
          http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
          "unit_based_product_image_1_path", stream, length,
          filename: basename(imageFile.path));
      newList.add(multipartFile);
    }
    if (fileImage2.path != "") {
      File imageFile = fileImage2;
      var stream =
          http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
          "unit_based_product_image_2_path", stream, length,
          filename: basename(imageFile.path));
      newList.add(multipartFile);
    }
    if (fileImage3.path != "") {
      File imageFile = fileImage3;
      var stream =
          http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile(
          "unit_based_product_image_3_path", stream, length,
          filename: basename(imageFile.path));
      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    print(request.fields);
    await request.send().then((response) {
      if (response.statusCode == 200) {
        LoadingOverlay.of(context).hide();
        final read = Provider.of<SMainScreenController>(context, listen: false);
        read.onNavigation(
            0,
            UnitDetailView(
              refresh: true,
              categoryId: categoryId,
              productId: productId,
              productType: producttype,
            ),
            context);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => SMainScreenView(
        //           index: 0,
        //           screenName: UnitDetailView(refresh: true,categoryId: categoryId,productId: productId,productType: producttype,))),
        //       (Route<dynamic> route) => false,
        // );
        Utils.showPrimarySnackbar(context, "Updated Successfully",
            type: SnackType.success);
        notifyListeners();
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
}
