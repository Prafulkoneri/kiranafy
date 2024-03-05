import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/custom_product_data_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/edit_admin_custom_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_custom_product_data_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/edit_admin_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/s_custom_product_data_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/upload_custom_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class CustomProductController extends ChangeNotifier {
  SCustomProductDataRepo customProductDataRepo = SCustomProductDataRepo();
  EditAdminProductRepo editAdminProductRepo = EditAdminProductRepo();
  bool isLoading = true;
  CustomData? customdata;
  AdminData? adminData;
  String selectedCategory = "";
  List<CategoryData> categoryData = [];
  List<BrandData>? brandData;
  List<UnitData>? unitData;
  List<TaxData>? taxData;
  bool showUnderRecommendedProducts = false;
  bool showUnderSeasonalProducts = false;
  bool fullFillCravings = false;
  File productImage = File("");
  String brandId = "";
  String categoryId = "";
  String taxId = "";
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  UploadCustomProductRepo uploadCustomProductRepo = UploadCustomProductRepo();
  String productId = "";

  //for adminProduct
  bool isEditEnabled = false;

  Future<void> initState(context) async {
    productDescriptionController.clear();
    productNameController.clear();
    showUnderRecommendedProducts = false;
    showUnderSeasonalProducts = false;
    fullFillCravings = false;
    taxId="";
    brandId="";
    categoryId="";
    productImage=File("");
    selectedCategory="";
    await getCustomProductData(context);
    productImage = File("");
  }

  UploadCustomProductReqModel get uploadCustomProductReqModel =>
      UploadCustomProductReqModel(
        categoryId: selectedCategory,
        brandId: brandId,
        taxId: taxId,
        productId: productId,
        productDescription: productDescriptionController.text,
        productName: productNameController.text,
        showUnderFullfillCravings: fullFillCravings ? "yes" : "no",
        showUnderRecommendedProduct:
            showUnderRecommendedProducts ? "yes" : "no",
        showUnderSeasonalProduct: showUnderSeasonalProducts ? "yes" : "no",
      );

  Future<void> uploadCustomProduct(context) async {
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await uploadCustomProductRepo
        .uploadCustomProduct(
            uploadCustomProductReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          UploadCustomProductResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        LoadingOverlay.of(context).hide();
        final read=Provider.of<SMainScreenController>(context,listen: false);
        read.onNavigation(0, SSelectedProductView(
          isRefresh: true,
          categoryId: selectedCategory,
        ), context);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => SMainScreenView(
        //           index: 0,
        //           screenName: SSelectedProductView(
        //             isRefresh: true,
        //             categoryId: selectedCategory,
        //           ))),
        //   (Route<dynamic> route) => false,
        // );

        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        notifyListeners();
      }
      else if(response.statusCode == 401){
        Utils().logoutUser(context);
      }
      else {
        LoadingOverlay.of(context).hide();
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

  void onBrandSelected(value) {
    brandId = value;
    notifyListeners();
  }

  void onTax(value) {
    taxId = value;
    notifyListeners();
  }

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getCustomProductData(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    customProductDataRepo
        .customProductDataModel(pref.getString("successToken"))
        .then((response) {
      log(response.body);
      final result =
          CustomProductDataResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        customdata = result.data;
        categoryData = customdata?.categoryData ?? [];
        brandData = customdata?.brandData;
        taxData = customdata?.taxData;
        unitData = customdata?.unitData;
        isLoading = false;
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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

  void onCategorySelected(value) {
    selectedCategory = value;
    notifyListeners();
  }

  void onUnderRecommendedProductSelected(value) {
    showUnderRecommendedProducts = value;
    notifyListeners();
  }

  void onUnderSeasonalProductSelected(value) {
    showUnderSeasonalProducts = value;
    notifyListeners();
  }

  void onFullFillCraving(value) {
    fullFillCravings = value;
    notifyListeners();
  }

  void openProductImage() async {
    final ImagePicker imgpicker = ImagePicker();
    var pickedfiles = await imgpicker.pickImage(source: ImageSource.gallery);
    if (pickedfiles != null) {
      productImage = File(pickedfiles.path);
    }
    notifyListeners();
  }

  void validateCustomProuduct(context) {
    if (selectedCategory == "") {
      Utils.showPrimarySnackbar(context, "Select Category",
          type: SnackType.error);
      return;
    }
    if (productNameController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Product Name",
          type: SnackType.error);
      return;
    }
    if (brandId == "") {
      Utils.showPrimarySnackbar(context, "Select Brand", type: SnackType.error);
      return;
    }
    if (taxId == "") {
      Utils.showPrimarySnackbar(context, "Select Tax", type: SnackType.error);
      return;
    }
    if (productDescriptionController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Product Description",
          type: SnackType.error);
      return;
    }
    if (productImage.path == "") {
      Utils.showPrimarySnackbar(context, "Please select Product Feature Image",
          type: SnackType.error);
      return;
    }
    // if (productImage.path == "") {
    //   uploadCustomProduct(context);
    // } else {
    uploadImage(context);
    // }
  }

  Future uploadImage(context) async {
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("successToken").toString();
    var uri = Uri.parse(Endpoint.submitCustomProduct);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = "Bearer $token";
    request.fields['product_name'] = productNameController.text;
    request.fields['category_id'] = selectedCategory;
    request.fields['brand_id'] = brandId;
    request.fields['tax_id'] = taxId;
    request.fields['product_description'] = productDescriptionController.text;
    request.fields['show_under_seasonal_products'] =
        showUnderSeasonalProducts ? "yes" : "no";
    request.fields['show_under_recommanded_products'] =
        showUnderRecommendedProducts ? "yes" : "no";
    request.fields['show_under_fullfill_your_cravings'] =
        fullFillCravings ? "yes" : "no";
    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    List<http.MultipartFile> newList = <http.MultipartFile>[];
    File imageFile = productImage;
    var stream =
        http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = http.MultipartFile(
        "product_image_path", stream, length,
        filename: basename(imageFile.path));
    newList.add(multipartFile);
    request.files.addAll(newList);
    print(request.fields);
    await request.send().then((response)async {
      final respStr = await response.stream.bytesToString();
      print("respStr$respStr");
      var res=jsonDecode(respStr);
      print(res["status"]);
      if (response.statusCode == 200) {
        print("sucesss");
        if(res["status"]==200){
          LoadingOverlay.of(context).hide();
          Utils.showPrimarySnackbar(context, res["message"],
              type: SnackType.success);
          final read=Provider.of<SMainScreenController>(context,listen: false);
          read.onNavigation(0, SSelectedProductView(
            isRefresh: true,
            categoryId: selectedCategory,
          ), context);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SMainScreenView(
          //           index: 0,
          //           screenName: SSelectedProductView(
          //             isRefresh: true,
          //             categoryId: selectedCategory,
          //           ))),
          //       (Route<dynamic> route) => false,
          // );

        }
        else{
          LoadingOverlay.of(context).hide();
          Utils.showPrimarySnackbar(context,res["message"],
              type: SnackType.error);
        }

      } else {
        LoadingOverlay.of(context).hide();
        Utils.showPrimarySnackbar(context, res["message"],
            type: SnackType.error);
        return;
      }
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    });
  }

  String networkImage1 = "";
  File fileImage1 = File("");
  void openCameras(context) async {
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
      productImage = File(pickedFile.path);
    }

    notifyListeners();
    Navigator.of(context, rootNavigator: true).pop();
  }

  /////////////////////////////////
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
      productImage = File(pickedFile.path);
      // notifyListeners();
    }

    notifyListeners();
    // Navigator.pop(context);
  }
}
