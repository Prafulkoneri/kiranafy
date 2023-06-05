
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
import 'package:local_supper_market/screen/shop_owner/s_products/model/edit_admin_custom_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_admin_product_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/upload_custom_product_data_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/edit_admin_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/s_custom_product_data_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/upload_admin_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/repository/upload_custom_product_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_custom_products_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/view/s_selected_products_view.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAdminProductController extends ChangeNotifier {
  SCustomProductDataRepo customProductDataRepo = SCustomProductDataRepo();
  EditAdminProductRepo editAdminProductRepo = EditAdminProductRepo();
  bool isLoading = true;
  CustomData ? customdata;
  AdminData ? adminData;
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
  String categoryName="";
  String brandName="";
  String productName="";
  String taxName="";
  String taxId="";
  List<ProductUnitDetail>? productUnitDetail;
  TextEditingController productDescriptionController=TextEditingController();
  TextEditingController productNameController=TextEditingController();
  String unit="";
  String unitCard="";
  String value="";
  String valueCard="";
  String mrp="";
  String mrpCard="";
  String offer="";
  String offerCard="";
  String status="";
  String statusCard="";
  String categoryId="";

  List<TextEditingController> valueController=[TextEditingController()];
  List<TextEditingController> mrpController=[TextEditingController()];
  List<TextEditingController> offerController=[TextEditingController()];

  List<TextEditingController> valueCardController=[TextEditingController()];
  List<TextEditingController> mrpCardController=[TextEditingController()];
  List<TextEditingController> offerCardController=[TextEditingController()];

  List<bool> switchValue = [];
  List<bool> switchCardValue = [];
  List<XFile> imagefiles1 = [];
  List<XFile> imagefiles2 = [];
  List<XFile> imagefiles3 = [];
  List<String> unitList=[];
  int totalRows=0;
  String productFeatureImage="";

  UploadAdminProductRepo uploadAdminProductRepo=UploadAdminProductRepo();
  String productId="";

  //for adminProduct
  bool isEditEnabled=false;

  Future<void> initState(context, createCard,index,id,catId) async {
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
    productId=id;
    categoryId=catId;
    print(productId);
    // await onAddWidget(createCard,index);

    await getAdminProductData(context);
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

  getValueCardData(){
    String a = '';
    for (int i = 0; i < valueCardController.length; i++) {
      if(valueCardController[i].text!="") {
        a += ",${valueCardController[i].text},";
      }
    }
    if(a!="") {
      a = a.substring(0, a.length - 1);
      valueCard = a;
      print(valueCard);
    }
    notifyListeners();
  }

  onUnitDataSelect(value,index){
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

  getMrpCardData(){
    String a = '';
    for (int i = 0; i < mrpCardController.length; i++) {
      if(mrpCardController[i].text!="") {
        a += ",${mrpCardController[i].text},";
      }
    }
    if(a!="") {
      a = a.substring(0, a.length - 1);
      mrpCard = a;
      print(mrpCard);
    }
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

  getOfferCardData(){
    String a = '';
    for (int i = 0; i < offerCardController.length; i++) {
      if(offerCardController[i].text!="") {
        a += ",${offerCardController[i].text},";
      }
    }
    if(a!="") {
      a = a.substring(0, a.length - 1);
      offerCard = a;
      print(offerCard);
    }
    notifyListeners();
  }

  getUnitData(){
    String a = '';
    for (int i = 0; i < unitList.length; i++) {
      if(unitList[i]!="") {
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
      if (mrpController[i].text != "") {
        if (switchValue[i]) {
          a += "active,";
        }
        else {
          a += "inactive,";
        }
      }
      // a = a.substring(0, a.length - 1);
      status = a;
      print(status);
      notifyListeners();
    }
  }

  getSwitchCardValue(){
    String a = '';
    for (int i = 0; i < switchCardValue.length; i++) {
        if (switchCardValue[i]) {
          a += "active,";
        }
        else {
          a += "inactive,";
        }

      print(a);
      if(a!="") {
        // a = a.substring(0, a.length - 1);
        statusCard =  a;
      }
      print(statusCard);
      notifyListeners();
    }
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
        customdata = result.data;
        categoryData = customdata?.categoryData ?? [];
        brandData = customdata?.brandData;
        taxData = customdata?.taxData;
        unitData = customdata?.unitData;
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
    // valueCardController.removeAt(index);
    // mrpCardController.removeAt(index);
    // offerCardController.removeAt(index);
    valueCardController.add(TextEditingController());
    mrpCardController.add(TextEditingController());
    offerCardController.add(TextEditingController());
    unitList.add("");
    print("unitList${unitList}");
    switchCardValue.add(true);
    imagefiles1.add(XFile(""));
    imagefiles2.add(XFile(""));
    imagefiles3.add(XFile(""));

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

  EditAdminProductReqModel get editAdminProductReqModel=>EditAdminProductReqModel(
    product_id:productId,
  );

  Future getAdminProductData(context)async{
    isEditEnabled=false;
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    editAdminProductRepo
        .getAdminProductDetails(editAdminProductReqModel,pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
      EditAdminProductResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        adminData = result.data;
        categoryName=adminData?.productDetails?.categoryName.toString()??"";
        productNameController.text=adminData?.productDetails?.productName.toString()??"";
        brandName=adminData?.productDetails?.brandName.toString()??"";
        taxName=adminData?.productDetails?.igstTax.toString()??"";
        showUnderRecommendedProducts=adminData?.productDetails?.showUnderRecommandedProducts=="yes"?true:false;
        showUnderSeasonalProducts=adminData?.productDetails?.showUnderSeasonalProducts=="yes"?true:false;
        fullFillCravings=adminData?.productDetails?.showUnderFullfillYourCravings=="yes"?true:false;
        productDescriptionController.text=adminData?.productDetails?.productDescription.toString()??"";
        productFeatureImage=adminData?.productDetails?.productImagePath??"";
        productUnitDetail=adminData?.productDetails?.productUnitDetails??[];
        int length=productUnitDetail?.length??0;
        valueController.clear();
        mrpController.clear();
        offerController.clear();
        unitList.clear();
        for(int i=0;i<length;i++){
          unitList.add(productUnitDetail?[i].unitId.toString()??"");
          valueController.add(TextEditingController(text: productUnitDetail?[i].weight));
          mrpController.add(TextEditingController(text: productUnitDetail?[i].mrpPrice.toString()));
          offerController.add(TextEditingController(text: productUnitDetail?[i].offerPrice.toString()));

        }
        switchValue = List<bool>.filled(length, true,growable: true);
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

  Future<void> uploadAdminProduct(context) async {
    int count=productUnitDetail?.length??0;
    totalRows=count+cards.length;

    if(cards.length!=0){
      await getValueCardData();
      await getMrpCardData();
      await getOfferCardData();
      await getSwitchCardValue();
    }
    await getValueData();
    await getMrpData();
    await getUnitData();
    await getOfferData();
    await getSwitchValue();

    SharedPreferences pref = await SharedPreferences.getInstance();
    await
    uploadAdminProductRepo
        .uploadAdminProduct(uploadAdminProductReqModel,pref.getString("successToken"))
        .then((response) {
      print(response.body);
      final result =
      UploadCustomProductResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print(categoryId);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SMainScreenView(index: 0,screenName:SSelectedProductView(categoryId:categoryId),)),
              (Route<dynamic> route) => false,
        );
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

  UploadAdminProductReqModel get uploadAdminProductReqModel =>UploadAdminProductReqModel(
    productId: productId,
    showUnderFullfillCravings: fullFillCravings?"yes":"no",
    showUnderRecommendedProduct: showUnderRecommendedProducts?"yes":"no",
    showUnderSeasonalProduct: showUnderSeasonalProducts?"yes":"no",
    mrpPrice: mrp+mrpCard ,
    offerPrice: offer+offerCard,
    status: status+statusCard,
    totalRows: totalRows.toString(),
    unitID: unit+unitCard,
    weight: value+valueCard,
  );

  Future uploadImage(context) async {
    print("hellooooo");
    int count=productUnitDetail?.length??0;
    totalRows=count+cards.length;

    if(cards.length!=0){
      await getValueCardData();
      await getMrpCardData();
      await getOfferCardData();
      await getSwitchCardValue();
    }
    await getValueData();
    await getMrpData();
    await getUnitData();
    await getOfferData();
    await getSwitchValue();

    SharedPreferences pref=await SharedPreferences.getInstance();
    String token=pref.getString("successToken").toString();
    var uri = Uri.parse("${Endpoint.uploadAdminProduct}");
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers['Authorization'] ="Bearer $token";
    request.fields['product_id'] = productId;
    request.fields['show_under_fullfill_your_cravings'] = fullFillCravings?"yes":"no";
    request.fields['show_under_recommanded_products'] = showUnderRecommendedProducts?"yes":"no";
    request.fields['show_under_seasonal_products'] = showUnderSeasonalProducts?"yes":"no";
    request.fields["unit_ids"]=unit+unitCard;
    request.fields["weight_ids"]=value+valueCard;
    request.fields["mrp_price_ids"]=mrp+mrpCard;
    request.fields["offer_price_ids"]=offer+offerCard;
    request.fields["status_ids"]=status+statusCard;
    request.fields["total_rows"]=totalRows.toString();
    print(productId);
    print(request.fields);
    //multipartFile = new http.MultipartFile("imagefile", stream, length, filename: basename(imageFile.path));
    List<http.MultipartFile> newList =  <http.MultipartFile>[];
    if(imagefiles1.isNotEmpty) {
      for (int i = 0; i < imagefiles1.length; i++) {
        XFile imageData1 = imagefiles1[i];
        print(imageData1);
        var stream = new http.ByteStream(
            DelegatingStream.typed(imageData1.openRead()));
        var length = await imageData1.length();
        var multipartFile = new http.MultipartFile(
            "unit_based_product_image_1_path[$i]", stream, length,
            filename: basename(imageData1.path));
        newList.add(multipartFile);
      }
    }
    if(imagefiles2.isNotEmpty) {
      for (int i = 0; i < imagefiles2.length; i++) {
        XFile imageData2 = imagefiles2[i];
        print(imageData2);
        var stream = new http.ByteStream(
            DelegatingStream.typed(imageData2.openRead()));
        var length = await imageData2.length();
        var multipartFile = new http.MultipartFile(
            "unit_based_product_image_2_path[$i]", stream, length,
            filename: basename(imageData2.path));
        newList.add(multipartFile);
      }
    }
    if(imagefiles3.isNotEmpty) {
      for (int i = 0; i < imagefiles3.length; i++) {
        XFile imageData3 = imagefiles3[i];
        print(imageData3);
        var stream = new http.ByteStream(
            DelegatingStream.typed(imageData3.openRead()));
        var length = await imageData3.length();
        var multipartFile = new http.MultipartFile(
            "unit_based_product_image_3_path[$i]", stream, length,
            filename: basename(imageData3.path));
        newList.add(multipartFile);
      }
    }
    request.files.addAll(newList);
    print(request.files[2].filename);
    await request.send().then((response)async{
      final respStr = await response.stream.bytesToString();
      print("respStr${respStr}");
      if (response.statusCode == 200) {
        Utils.showPrimarySnackbar(context,"Updated Successfully",
            type: SnackType.success);
        print("Updated Successfully");
      } else {
        Utils.showPrimarySnackbar(context,"Error on uploading",
            type: SnackType.error);
      }
      // response.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
    });
    return true;
  }
}
