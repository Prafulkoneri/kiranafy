import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/custom_product_data_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_custom_product_data_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/s_custom_product_data_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomProductController extends ChangeNotifier {
  SCustomProductDataRepo customProductDataRepo = SCustomProductDataRepo();
  bool isLoading = true;
  Data? data;
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
  String brandId="";
  String taxId="";
  TextEditingController productDescriptionController=TextEditingController();

  List<bool> switchValue = [true];
  List<XFile> imagefiles1 = [];
  List<XFile> imagefiles2 = [];
  List<XFile> imagefiles3 = [];

  Future<void> initState(context, createCard) async {
    cards.clear();
    imagefiles1.clear();
    imagefiles2.clear();
    imagefiles3.clear();
    await getCustomProductData(context);
    await onAddWidget(createCard);
    switchValue = List<bool>.filled(cards.length, true,growable: true);
  }

  UploadCustomProductReqModel get uploadCustomProductReqModel =>UploadCustomProductReqModel(
    categoryId: selectedCategory,
    brandId:brandId,
    taxId: taxId,
    productDescription: productDescriptionController.text,
  );

  void onBrandSelected(value){
    brandId=value;
    notifyListeners();
  }

  void onTax(value){
    taxId=value;
    notifyListeners();
  }

  Future<void> getCustomProductData(context) async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    customProductDataRepo
        .customProductDataModel(pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
          CustomProductDataResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        data = result.data;
        categoryData = data?.categoryData ?? [];
        brandData = data?.brandData;
        taxData = data?.taxData;
        unitData = data?.unitData;
        isLoading = false;
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
    notifyListeners();
  }

  void openGallery1(index) async {
    final ImagePicker imgpicker = ImagePicker();
    var pickedfiles = await imgpicker.pickImage(source: ImageSource.gallery);
    if (pickedfiles != null) {
      imagefiles1.removeAt(index);

      imagefiles1.insert(index, pickedfiles);
      print(imagefiles1[index].path);

      }
    notifyListeners();
  }

  void openGallery2(index) async {
    final ImagePicker imgpicker = ImagePicker();
    var pickedfiles = await imgpicker.pickImage(source: ImageSource.gallery);
    if (pickedfiles != null) {
        imagefiles2.removeAt(index);

      imagefiles2.insert(index,pickedfiles);
        print(imagefiles2[index].path);

    }
    notifyListeners();
  }

  void openGallery3(index) async {
    final ImagePicker imgpicker = ImagePicker();
    var pickedfiles = await imgpicker.pickImage(source: ImageSource.gallery);
    if (pickedfiles != null) {
        imagefiles3.removeAt(index);
      imagefiles3.insert(index, pickedfiles);
      print(imagefiles3);

    }
    notifyListeners();
  }


  Future<void> onAddWidget(createdCard) async {
    cards.add(createdCard);
    switchValue.add(true);
    imagefiles1.add(XFile(""));
    imagefiles2.add(XFile(""));
    imagefiles3.add(XFile(""));
    notifyListeners();
  }

  void onToggleSwitch(value, index) {
    switchValue[index] = !switchValue[index];
    notifyListeners();
  }

}
