import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/custom_product_data_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_custom_product_data_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/s_custom_product_data_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/upload_custom_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/shop_custome_products_view.dart';
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
  TextEditingController productNameController=TextEditingController();
  String unit="";
  String value="";
  String mrp="";
  String offer="";
  String status="";

  List<TextEditingController> valueController=[TextEditingController()];
  List<TextEditingController> mrpController=[TextEditingController()];
  List<TextEditingController> offerController=[TextEditingController()];
  List<bool> switchValue = [true];
  List<XFile> imagefiles1 = [];
  List<XFile> imagefiles2 = [];
  List<XFile> imagefiles3 = [];
  List<String> unitList=[];
  UploadCustomProductRepo uploadCustomProductRepo=UploadCustomProductRepo();

  Future<void> initState(context, createCard,index) async {
    imagefiles1.clear();
    imagefiles2.clear();
    imagefiles3.clear();
    await getCustomProductData(context);
    cards.clear();
    unitList.clear();
    await onAddWidget(createCard,index);
    switchValue = List<bool>.filled(cards.length, true,growable: true);
  }

  UploadCustomProductReqModel get uploadCustomProductReqModel =>UploadCustomProductReqModel(
    categoryId: selectedCategory,
    brandId:brandId,
    taxId: taxId,
    productDescription: productDescriptionController.text,
    productName: productNameController.text,
    showUnderFullfillCravings: fullFillCravings?"yes":"no",
    showUnderRecommendedProduct: showUnderRecommendedProducts?"yes":"no",
    showUnderSeasonalProduct: showUnderSeasonalProducts?"yes":"no",
    totalRows: cards.length.toString(),
mrpPrice: mrp,
    offerPrice: offer,
    unitID: unit.toString(),
    weight: value,
    status:status
  );

  Future<void> uploadCustomProduct(context) async {
    await getValueData();
    await getMrpData();
    await getOfferData();
    await getSwitchValue();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await
    uploadCustomProductRepo
        .uploadCustomProduct(uploadCustomProductReqModel,pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
      UploadCustomProductResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>ShopCustomProductView(categoryId: )));
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


  void onBrandSelected(value){
    brandId=value;
    notifyListeners();
  }

  void onTax(value){
    taxId=value;
    notifyListeners();
  }

  getValueData(){
    String a = '';
    for (int i = 0; i < valueController.length; i++) {
      if(valueController[i].text!="") {
        a += "${valueController[i].text},";
      }
      }
    a = a.substring(0, a.length - 1);
    value=a;
   print(value);
notifyListeners();
  }

  onUnitDataSelect(value,index){
    unitList.removeAt(index);
    unitList.insert(index,value.toString());
    print("unitList${unitList}");
    notifyListeners();
  }

  getMrpData(){
    String a = '';
    for (int i = 0; i < mrpController.length; i++) {
      if(mrpController[i].text!="") {
        a += "${mrpController[i].text},";
      }
    }
    a = a.substring(0, a.length - 1);
    mrp=a;
    print(mrp);
    notifyListeners();
  }

  getOfferData(){
    String a = '';
    for (int i = 0; i < offerController.length; i++) {
      if(offerController[i].text!="") {
        a += "${offerController[i].text},";
      }
    }
    a = a.substring(0, a.length - 1);
    offer=a;
    print(offer);
    notifyListeners();
  }

  getUnitData(){
    String a = '';
    for (int i = 0; i < unitList.length; i++) {
      if(unitList[i]=="") {
        a += "${unitList[i]},";
      }
    }
    a = a.substring(0, a.length - 1);
    unit=a;
    notifyListeners();
  }

  getSwitchValue(){
    String a = '';
    for (int i = 0; i < switchValue.length; i++) {
      if(switchValue[i]) {
        a += "active,";
    }
      else{
        a += "inactive,";
      }
      }
    a = a.substring(0, a.length - 1);
    status=a;
    print(status);
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


  Future<void> onAddWidget(createdCard,index) async {

    cards.add(createdCard);
    valueController.add(TextEditingController());
    mrpController.add(TextEditingController());
    offerController.add(TextEditingController());

    unitList.add("");
    print("unitList${unitList}");
    switchValue.add(true);
    imagefiles1.add(XFile(""));
    imagefiles2.add(XFile(""));
    imagefiles3.add(XFile(""));

    notifyListeners();
  }

  Future<void> onRemoveWidget(index) async {

    cards.removeAt(index);
    valueController.remove(index);
    mrpController.remove(index);
    offerController.remove(index);
    switchValue.remove(index);
    imagefiles1.remove(index);
    imagefiles2.remove(index);
    imagefiles3.remove(index);
    notifyListeners();
  }



  void onToggleSwitch(value, index) {
    switchValue[index] = !switchValue[index];
    notifyListeners();
  }


}
