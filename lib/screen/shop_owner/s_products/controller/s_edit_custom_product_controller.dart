import 'dart:developer';

import 'package:local_supper_market/screen/shop_owner/s_products/model/edit_custom_products_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/edit_custom_product_repo.dart';
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

  List<TextEditingController> valueController = [TextEditingController()];
  List<TextEditingController> mrpController = [TextEditingController()];
  List<TextEditingController> offerController = [TextEditingController()];

  List<TextEditingController> valueCardController = [TextEditingController()];
  List<TextEditingController> mrpCardController = [TextEditingController()];
  List<TextEditingController> offerCardController = [TextEditingController()];

  List<bool> switchValue = [];
  List<bool> switchCardValue = [];
  List<XFile> imagefiles1 = [];
  List<XFile> imagefiles2 = [];
  List<XFile> imagefiles3 = [];
  List<String> unitList = [];
  int totalRows = 0;
  String productFeatureImage = "";

  UploadCustomProductRepo uploadCustomProductRepo = UploadCustomProductRepo();
  String productId = "";

  //for adminProduct
  bool isEditEnabled = false;

  Future<void> initState(context, createCard, index, id, catId) async {
    imagefiles1.clear();
    imagefiles2.clear();
    imagefiles3.clear();
    valueCardController.clear();
    mrpCardController.clear();
    offerCardController.clear();
    valueCardController.add(TextEditingController());
    mrpCardController.add(TextEditingController());
    offerCardController.add(TextEditingController());
    imagefiles1.add(XFile(""));
    imagefiles2.add(XFile(""));
    imagefiles3.add(XFile(""));
    await getCustomProductData(context);
    cards.clear();
    unitList.clear();
    productId = id;
    categoryId = catId;
    // await getCustomProductData(context);
    await getCustomProductDetails(context);
    print(productId);
    // await onAddWidget(createCard,index);
  }

  void onBrandSelected(value) {
    brandId = value;
    notifyListeners();
  }

  void onTax(value) {
    taxId = value;
    notifyListeners();
  }

  getValueData() {
    String a = '';
    for (int i = 0; i < valueController.length; i++) {
      if (valueController[i].text != "") {
        a += "${valueController[i].text},";
      }
    }
    a = a.substring(0, a.length - 1);
    value = a;
    print(value);
    notifyListeners();
  }

  getValueCardData() {
    String a = '';
    for (int i = 0; i < valueCardController.length; i++) {
      if (valueCardController[i].text != "") {
        a += ",${valueCardController[i].text},";
      }
    }
    if (a != "") {
      a = a.substring(0, a.length - 1);
      valueCard = a;
      print(valueCard);
    }
    notifyListeners();
  }

  onUnitDataSelect(value, index) {
    unitList.insert(index, value.toString());
    print("unitList${unitList}");
    notifyListeners();
  }

  getMrpData() {
    String a = '';
    for (int i = 0; i < mrpController.length; i++) {
      if (mrpController[i].text != "") {
        a += "${mrpController[i].text},";
      }
    }
    a = a.substring(0, a.length - 1);
    mrp = a;
    print(mrp);
    notifyListeners();
  }

  getMrpCardData() {
    String a = '';
    for (int i = 0; i < mrpCardController.length; i++) {
      if (mrpCardController[i].text != "") {
        a += ",${mrpCardController[i].text},";
      }
    }
    if (a != "") {
      a = a.substring(0, a.length - 1);
      mrpCard = a;
      print(mrpCard);
    }
    notifyListeners();
  }

  getOfferData() {
    String a = '';
    for (int i = 0; i < offerController.length; i++) {
      if (offerController[i].text != "") {
        a += "${offerController[i].text},";
      }
    }
    a = a.substring(0, a.length - 1);
    offer = a;
    print(offer);
    notifyListeners();
  }

  getOfferCardData() {
    String a = '';
    for (int i = 0; i < offerCardController.length; i++) {
      if (offerCardController[i].text != "") {
        a += ",${offerCardController[i].text},";
      }
    }
    if (a != "") {
      a = a.substring(0, a.length - 1);
      offerCard = a;
      print(offerCard);
    }
    notifyListeners();
  }

  getUnitData() {
    String a = '';
    for (int i = 0; i < unitList.length; i++) {
      if (unitList[i] != "") {
        a += "${unitList[i]},";
      }
    }
    a = a.substring(0, a.length - 1);
    unit = a;
    notifyListeners();
  }

  getSwitchValue() {
    String a = '';
    for (int i = 0; i < switchValue.length; i++) {
      if (mrpController[i].text != "") {
        if (switchValue[i]) {
          a += "active,";
        } else {
          a += "inactive,";
        }
      }
      // a = a.substring(0, a.length - 1);
      status = a;
      print(status);
      notifyListeners();
    }
  }

  getSwitchCardValue() {
    String a = '';
    for (int i = 0; i < switchCardValue.length; i++) {
      if (switchCardValue[i]) {
        a += "active,";
      } else {
        a += "inactive,";
      }

      print(a);
      if (a != "") {
        // a = a.substring(0, a.length - 1);
        statusCard = a;
      }
      print(statusCard);
      notifyListeners();
    }
  }

  showLoader(value){
    isLoading = value;
    notifyListeners();
  }

  Future<void> getCustomProductData(context) async {
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    customProductDataRepo
        .customProductDataModel(pref.getString("successToken"))
        .then((response) {
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

  void openProductImage() async {
    final ImagePicker imgpicker = ImagePicker();
    var pickedfiles = await imgpicker.pickImage(source: ImageSource.gallery);
    if (pickedfiles != null) {
      productImage = File(pickedfiles.path);
    }
    print(productImage.path);
    notifyListeners();
  }





  void onToggleSwitch(value, index) {
    switchValue[index] = !switchValue[index];
    notifyListeners();
  }

  void onToggleCardSwitch(value, index) {
    switchCardValue[index] = !switchCardValue[index];
    notifyListeners();
  }

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
        print(categoryId);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => SMainScreenView(
                    index: 0,
                    screenName: SSelectedProductView(categoryId: categoryId,isRefresh: true),
                  )),
          (Route<dynamic> route) => false,
        );
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
        LoadingOverlay.of(context).hide();
        notifyListeners();
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

  UploadCustomProductReqModel get uploadCustomProductReqModel =>
      UploadCustomProductReqModel(
        showUnderFullfillCravings: fullFillCravings ? "yes" : "no",
        categoryId: categoryId,
        brandId: brandId,
        taxId: taxId,
        productDescription: productDescriptionController.text,
        productName: productNameController.text,
        showUnderRecommendedProduct:
            showUnderRecommendedProducts ? "yes" : "no",
        showUnderSeasonalProduct: showUnderSeasonalProducts ? "yes" : "no",
      );

  Future uploadImage(context) async {


    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("successToken").toString();
    var uri = Uri.parse("${Endpoint.uploadAdminProduct}");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = "Bearer $token";
    request.fields['product_id'] = productId;
    request.fields['show_under_fullfill_your_cravings'] =
        fullFillCravings ? "yes" : "no";
    request.fields['show_under_recommanded_products'] =
        showUnderRecommendedProducts ? "yes" : "no";
    request.fields['show_under_seasonal_products'] =
        showUnderSeasonalProducts ? "yes" : "no";
    request.fields["product_name"] =productNameController.text;
    request.fields["category_id"] = categoryId;
    request.fields["brand_id"] = brandId;
    request.fields["tax_id"] = taxId;
    request.fields["product_description"] =productDescriptionController.text;
    print(request.fields);
    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    List<http.MultipartFile> newList = <http.MultipartFile>[];

    File imageFile = productImage;
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
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
