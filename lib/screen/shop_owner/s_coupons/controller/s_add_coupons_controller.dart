import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/add_coupons_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/coupon_code_exists_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/product_as_per_category_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/coupon_code_exists_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/coupon_view_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/product_as_per_category_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/model/s_categories_list_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/repository/s_categories_list_repo.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAddCouponsController extends ChangeNotifier {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  bool isLoading = true;
  String groupValue = "FullOrderAmount";
  String catergoryId = "";
  String productId = "";
  List<CategoryData>? categoriesList;
  List<ProductData>? productList;
  ShopAllCategoriesRepo categoriesListRepo = ShopAllCategoriesRepo();
  TextEditingController couponCodeController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();
  TextEditingController minOrderAmountController = TextEditingController();
  TextEditingController maxDiscountAmountController = TextEditingController();
  TextEditingController termsAndConditionController = TextEditingController();
  ProductListAsPerCategoryRepo productListAsPerCategoryRepo =
      ProductListAsPerCategoryRepo();
  CouponCodeExistsRepo couponCodeExistsRepo = CouponCodeExistsRepo();
  Future<void> initState(context) async {
    await getCategoriesList(context);
  }

  void onFromDateSelected(date) {
    print(date);
    fromDateController.text = date;
    notifyListeners();
  }

  void onCategorySelect(value, context) async {
    catergoryId = value;
    await getProductList(context);
    notifyListeners();
  }

  void onProductSelect(value, context) async {
    productId = value;
    notifyListeners();
  }

  void onToDateSelected(date) {
    toDateController.text = date;
    notifyListeners();
  }

  void onRadioBtnToggled(value) {
    groupValue = value;
    notifyListeners();
  }

  Future<void> getCategoriesList(context) async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    categoriesListRepo
        .shopAllCategoriesList(pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log("response.body${response.body}");
      final result =
          AllCategoryResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        categoriesList = result.data;
        // selectedCategoryList =
        // List<bool>.filled(categoriesList?.length ?? 0, false,growable: true);
        // int length=categoriesList?.length??0;
        // selectedCategoryId.clear();
        // for(int i=0;i<length;i++){
        //   if(categoriesList?[i].selectedByShopOwner=="yes"){
        //     selectedCategoryList.insert(i,true);
        //     selectedCategoryId.add(categoriesList?[i].id);
        //   }
        // }
        // print(selectedCategoryList);
        // print(selectedCategoryId);
        isLoading = false;
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

  ProductAsPerCategoryReqModel get productAsPerCategoryReqModel =>
      ProductAsPerCategoryReqModel(
        categoryId: catergoryId.toString(),
      );

  Future<void> getProductList(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    productListAsPerCategoryRepo
        .getProductList(
            productAsPerCategoryReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log("response.body${response.body}");
      final result =
          ProductAsPerCategoryResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        productList = result.data;
        isLoading = false;
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

  CouponCodeExistsRequestModel get couponCodeExistsRequestModel =>
      CouponCodeExistsRequestModel(
        couponCode: couponCodeController.text,
        couponId: "",
      );

  Future<void> checkCouponCodeExist(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    couponCodeExistsRepo
        .checkCouponCodeExists(
            couponCodeExistsRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log("response.body${response.body}");
      final result =
          CouponCodeExistsResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        Utils.showPrimarySnackbar(context, result.message,
            type: SnackType.success);
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

  AddCouponsRequestModel get addCouponsRequestModel => AddCouponsRequestModel(
      couponFromDate: fromDateController.text,
      couponToDate: toDateController.text,
      shopOwnerCategoryId: catergoryId);

  Future<void> uploadCouponDetails(context) async {}
}
