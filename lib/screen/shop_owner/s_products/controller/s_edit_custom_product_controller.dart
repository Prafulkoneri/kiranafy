import 'dart:developer';

import 'package:image_cropper/image_cropper.dart';
import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/view/offer_seasonal_recommanded.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/edit_custom_products_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/edit_custom_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/upload_edit_custom_product_repo.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/view/s_main_screen_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/custom_product_data_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/edit_custom_products_model.dart';

import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_custom_product_data_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/s_custom_product_data_repo.dart';

import 'package:local_supper_market/screen/shop_owner/s_products/repository/upload_custom_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_custom_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCustomProductController extends ChangeNotifier {
  SCustomProductDataRepo customProductDataRepo = SCustomProductDataRepo();
  EditCustomProductRepo editCustomProductRepo = EditCustomProductRepo();
  bool isLoading = true;
  CustomData? customdata;
  Data? customProductData;
  String selectedCategory = "1";
  List<CategoryData> categoryData = [];
  List<BrandData>? brandData;
  List<UnitData>? unitData;
  List<TaxData>? taxData;
  bool showUnderRecommendedProducts = false;
  bool showUnderSeasonalProducts = false;
  bool fullFillCravings = false;
  File productImage = File("");
  List<Widget> cards = [];
  String brandId = "";
  String categoryName = "";
  String brandName = "";
  String productName = "";
  String taxName = "";
  String taxId = "";
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  String unit = "";
  String unitCard = "";
  String value = "";
  String valueCard = "";
  String mrp = "";
  String mrpCard = "";
  String offer = "";
  String offerCard = "";
  String status = "";
  String statusCard = "";
  String categoryId = "";

  String productFeatureImage = "";

  UploadCustomProductRepo uploadCustomProductRepo = UploadCustomProductRepo();
  UploadEditCustomProductRepo uploadEditCustomProductRepo = UploadEditCustomProductRepo();
  String productId = "";

  //for adminProduct
  bool isEditEnabled = false;

  Future<void> initState(context, createCard, index, id, catId) async {
    await getCustomProductData(context);
    productId = id;
    categoryId = catId;
    await getCustomProductDetails(context);
    print(productId);
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
    editCustomProductRepo
        .getCustomProductDetails(
            editCustomProductsRequestModel, pref.getString("successToken"))
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

  EditCustomProductsRequestModel get editCustomProductsRequestModel =>
      EditCustomProductsRequestModel(
        product_id: productId,
      );

  Future getCustomProductDetails(context) async {
    print("hello");
    isEditEnabled = false;
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    editCustomProductRepo
        .getCustomProductDetails(
            editCustomProductsRequestModel, pref.getString("successToken"))
        .then((response) {
      print("9999999999999");
      log(response.body);
      print("9999999999999");
      final result =
          EditCustomProductsResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        customProductData = result.data;
        categoryData = customProductData?.categoryData ?? [];
        brandData = customProductData?.brandData;
        taxData = customProductData?.taxData;
        productNameController.text =
            customProductData?.productDetails?.productName.toString() ?? "";
        categoryId =
            customProductData?.productDetails?.categoryId.toString() ?? "";
        brandId = customProductData?.productDetails?.brandId.toString() ?? "";
        print("fjafsdf");
        print(brandId);

        taxId = customProductData?.productDetails?.taxId.toString() ?? "";
        print(taxId);
        showUnderRecommendedProducts =
            customProductData?.productDetails?.showUnderRecommandedProducts ==
                    "yes"
                ? true
                : false;
        showUnderSeasonalProducts =
            customProductData?.productDetails?.showUnderSeasonalProducts ==
                    "yes"
                ? true
                : false;
        fullFillCravings =
            customProductData?.productDetails?.showUnderFullfillYourCravings ==
                    "yes"
                ? true
                : false;
        productDescriptionController.text =
            customProductData?.productDetails?.productDescription.toString() ??
                "";
        productFeatureImage =
            customProductData?.productDetails?.productImagePath ?? "";
        showLoader(false);

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
  void openCameras(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
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
      productImage = File(croppedFile!.path);
    }

    notifyListeners();
    Navigator.of(context, rootNavigator: true).pop();
  }

  void openGallery(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: double.infinity,
      maxWidth: double.infinity,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
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
      productImage = File(croppedFile!.path);
    }

    notifyListeners();
    Navigator.of(context, rootNavigator: true).pop();
  }


  void openProductImage() async {
    final ImagePicker imgpicker = ImagePicker();
    var pickedfiles = await imgpicker.pickImage(source: ImageSource.gallery);
    if (pickedfiles != null) {
      productImage = File(pickedfiles.path);
    }
    print(productImage.path);
    notifyListeners();
  }

  UploadCustomProductReqModel get uploadCustomProductReqModel =>
      UploadCustomProductReqModel(
        showUnderFullfillCravings: fullFillCravings ? "yes" : "no",
        categoryId: categoryId,
        brandId: brandId,
        taxId: taxId,
        productId: productId,
        productDescription: productDescriptionController.text,
        productName: productNameController.text,
        showUnderRecommendedProduct:
            showUnderRecommendedProducts ? "yes" : "no",
        showUnderSeasonalProduct: showUnderSeasonalProducts ? "yes" : "no",
      );
  Future<void> uploadCustomProduct(
      context, isNavFromAccount, selectedIndex) async {
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await uploadEditCustomProductRepo
        .uploadEditCustomProduct(
            uploadCustomProductReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          UploadCustomProductResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if(result.status==200){
          if (isNavFromAccount) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                    index: 4,
                    screenName: ShopSeasonalRecommandedOfferProductsView(
                      selectedProduct: selectedIndex == 0
                          ? "recommended"
                          : selectedIndex == 1
                              ? "seasonal"
                              : "fullFill",
                      isRefresh: true,
                    ))),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                      index: 0,
                      screenName: SSelectedProductView(
                          categoryId: categoryId, isRefresh: true),
                    )),
            (Route<dynamic> route) => false,
          );
        }
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        LoadingOverlay.of(context).hide();
        notifyListeners();
        }else{
          LoadingOverlay.of(context).hide();
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
      } else {
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

  void validateCustomProuduct(context, isNavFromAccount, selectedIndex) {
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
      uploadCustomProduct(context, isNavFromAccount, selectedIndex);
    } else {
      uploadImage(context, isNavFromAccount);
    }
  }

  Future uploadImage(context, isNavFromAccount) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("successToken").toString();
    var uri = Uri.parse("${Endpoint.updateEditCustomProduct}");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = "Bearer $token";
    request.fields['product_id'] = productId;
    request.fields['show_under_fullfill_your_cravings'] =
        fullFillCravings ? "yes" : "no";
    request.fields['show_under_recommanded_products'] =
        showUnderRecommendedProducts ? "yes" : "no";
    request.fields['show_under_seasonal_products'] =
        showUnderSeasonalProducts ? "yes" : "no";
    request.fields["product_name"] = productNameController.text;
    request.fields["category_id"] = categoryId;
    request.fields["brand_id"] = brandId;
    request.fields["tax_id"] = taxId;

    request.fields["product_description"] = productDescriptionController.text;

    request.fields["product_description"] = productDescriptionController.text;
    request.fields["product_id"] = productId;

    print(request.fields);
    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    List<http.MultipartFile> newList = <http.MultipartFile>[];

    File imageFile = productImage;
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var multipartFile = new http.MultipartFile(
        "product_image_path", stream, length,
        filename: basename(imageFile.path));
    newList.add(multipartFile);
    request.files.addAll(newList);
    await request.send().then((response) async {
      final respStr = await response.stream.bytesToString();
      print("respStr${respStr}");

      if (response.statusCode == 200) {
        // var splitText = respStr.split(",");
        // print(splitText);
        // var splitText2=splitText[0].toString();
        // print(splitText2);
        // return;
        if (isNavFromAccount) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                    index: 4,
                    screenName: ShopSeasonalRecommandedOfferProductsView(
                      selectedProduct: "recommended",
                      isRefresh: true,
                    ))),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SMainScreenView(
                      index: 0,
                      screenName: SSelectedProductView(
                          categoryId: categoryId, isRefresh: true),
                    )),
            (Route<dynamic> route) => false,
          );
        }
        Utils.showPrimarySnackbar(context, "Updated Successfully",
            type: SnackType.success);
        print("Updated Successfully");
      } else {
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
