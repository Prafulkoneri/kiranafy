import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/model/s_get_selected_categories_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_category_list/repository/s_get_selected_categories_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/add_coupons_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/coupon_code_exists_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/coupon_edit_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/coupons_update_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/model/product_as_per_category_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/add_coupons_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/coupon_code_exists_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/edit_coupons_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/product_as_per_category_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/repository/update_coupons_repo.dart';
import 'package:local_supper_market/screen/shop_owner/s_coupons/view/s_coupons_view.dart';
import 'package:local_supper_market/screen/shop_owner/s_main_screen/controller/s_main_screen_controller.dart';
import 'package:local_supper_market/utils/utils.dart';
import 'package:local_supper_market/widget/loaderoverlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SAddCouponsController extends ChangeNotifier {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  bool isLoading = true;

  String groupValue = "full_order_amount";
  String categoryId = "";
  String productId = "";
  // List<CategoryData>? categoriesList;
  List<SelectedCategoryData>? selectedcategorydata;
  List<EditCategoryList>? editCategoryList;
  ShopSelectedCategoriesRepo SelectedCategoriesListRepo =
      ShopSelectedCategoriesRepo();

  List<ProductData>? productList;
  // ShopAllCategoriesRepo categoriesListRepo = ShopAllCategoriesRepo();
  TextEditingController couponCodeController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();
  TextEditingController minOrderAmountController = TextEditingController();
  TextEditingController maxDiscountAmountController = TextEditingController();
  TextEditingController termsAndConditionController = TextEditingController();
  ProductListAsPerCategoryRepo productListAsPerCategoryRepo = ProductListAsPerCategoryRepo();
  CouponCodeExistsRepo couponCodeExistsRepo = CouponCodeExistsRepo();
  AddCouponsRepo addCouponsRepo = AddCouponsRepo();
  EditCouponsRepo editCouponsRepo = EditCouponsRepo();
  UpdateEditCouponsRepo updateEditCouponsRepo = UpdateEditCouponsRepo();
  String productType = "";
  String couponId = "";
  CouponDetails? details;

  showLoader(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> initState(context, isEditCoupon, id) async {
    if (isEditCoupon) {
      await getCategoriesList(context);
      await getEditCouponDetails(context, id);
    } else {
      fromDateController.clear();
      toDateController.clear();
      discountPercentageController.clear();
      minOrderAmountController.clear();
      maxDiscountAmountController.clear();
      couponCodeController.clear();
      groupValue = "full_order_amount";
      categoryId = "";
      productId = "";
      termsAndConditionController.clear();
      await getCategoriesList(context);
      notifyListeners();
    }
  }

  void onFromDateSelected(date) {
    print(date);
    fromDateController.text = date;
    notifyListeners();
  }

  void onCategorySelect(value, context) async {
    categoryId = value;

    productId = "";
    await getProductList(context);
    notifyListeners();
  }

  void onProductSelect(value, context) async {
    productId = value;
    int length = productList?.length ?? 0;
    print("productId${productId}");
    for (int i = 0; i < length; i++) {
      if (productList?[i].id.toString() == value.toString()) {
        print("helloooooo");
        productType = productList?[i].productType ?? "";
      }
    }
    print(productType);
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
    showLoader(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    SelectedCategoriesListRepo.shopSelectedCategoriesList(
            pref.getString("successToken"))
        // .shopAllCategoriesList(pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log("response.body${response.body}");
      final result =
          GetSelectedCategoryResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        selectedcategorydata = result.selectedcategorydata;
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

  ProductAsPerCategoryReqModel get productAsPerCategoryReqModel =>
      ProductAsPerCategoryReqModel(
        categoryId: categoryId.toString(),
      );

  Future<void> getProductList(context) async {
    LoadingOverlay.of(context).show();
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
        if (productList?.isEmpty ?? false) {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
        LoadingOverlay.of(context).hide();
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

  void clearProduct(){
    productId="";
    notifyListeners();
  }
  void clearCategory(){
    categoryId="";
    productList?.clear();
    productId="";
    notifyListeners();
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
        if (result.status == 200) {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.success);
        } else {
          Utils.showPrimarySnackbar(context, result.message,
              type: SnackType.error);
        }
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
        shopOwnerCategoryId:
            groupValue == "full_order_amount" ? "" : categoryId,
        couponCode: couponCodeController.text,
        couponDiscountMaxAmount: maxDiscountAmountController.text,
        couponDiscountPercentage: discountPercentageController.text,
        couponMinimumOrderAmount: minOrderAmountController.text,
        couponsTermsAndCondition: termsAndConditionController.text,
        couponType: groupValue,
        productId: groupValue == "full_order_amount" ? "" : productId,
        productType: groupValue == "full_order_amount" ? "" : productType,
      );

  Future<void> uploadCouponDetails(context, isNavFromDashBoard) async {
    if (fromDateController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter From Date",
          type: SnackType.error);
      return;
    }
    if (toDateController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter To Date",
          type: SnackType.error);
      return;
    }
    if (discountPercentageController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Discount Percentage",
          type: SnackType.error);
      return;
    }
    if (minOrderAmountController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Minimum Order Amount",
          type: SnackType.error);
      return;
    }
    if (maxDiscountAmountController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Max Discount Amount",
          type: SnackType.error);
      return;
    }
    if (couponCodeController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Coupon Code",
          type: SnackType.error);
      return;
    }
    if (groupValue == "category_and_product") {
      if (categoryId == "") {
        Utils.showPrimarySnackbar(context, "Select Category",
            type: SnackType.error);
        return;
      }
    }
    if (termsAndConditionController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Terms And Condition",
          type: SnackType.error);
      return;
    }
    LoadingOverlay.of(context).show();
    SharedPreferences pref = await SharedPreferences.getInstance();
    addCouponsRepo
        .addNewCoupons(addCouponsRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log("response.body${response.body}");
      final result = AddCouponsResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        if (isNavFromDashBoard) {
          final read =
              Provider.of<SMainScreenController>(context, listen: false);
          read.onNavigation(
              3,
              ShopCouponsView(
                isRefresh: true,
                isNavFromDashBoard: true,
              ),
              context);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SMainScreenView(
          //           index: 4,
          //           screenName: ShopCouponsView(
          //             isRefresh: true,
          //             isNavFromDashBoard: true,
          //           ))),
          //   (Route<dynamic> route) => false,
          // );
        } else {
          final read =
              Provider.of<SMainScreenController>(context, listen: false);
          read.onNavigation(
              4,
              ShopCouponsView(
                isRefresh: true,
                isNavFromDashBoard: false,
              ),
              context);

          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SMainScreenView(
          //           index: 4,
          //           screenName: ShopCouponsView(
          //             isRefresh: true,
          //             isNavFromDashBoard: false,
          //           ))),
          //   (Route<dynamic> route) => false,
          // );
        }
        LoadingOverlay.of(context).hide();
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

  EditCouponRequestModel get editCouponRequestModel => EditCouponRequestModel(
        couponId: couponId,
      );

  Future<void> getEditCouponDetails(context, id) async {
    showLoader(true);
    couponId = id;
    SharedPreferences pref = await SharedPreferences.getInstance();
    editCouponsRepo
        .editCoupons(editCouponRequestModel, pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log("response.body${response.body}");
      final result = EditCouponsResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        details = result.editCouponsData?.couponDetails;
        // final details=result.editCoupons?.couponDetails;
        fromDateController.text = details?.couponFromDate ?? "";
        toDateController.text = details?.couponToDate ?? "";
        discountPercentageController.text =
            details?.couponDiscountPercentage.toString() ?? "";
        minOrderAmountController.text =
            details?.couponMinimumOrderAmount.toString() ?? "";
        maxDiscountAmountController.text =
            details?.couponDiscountMaxAmount.toString() ?? "";
        couponCodeController.text = details?.couponCode.toString() ?? "";
        termsAndConditionController.text =
            details?.couponTermsAndConditions.toString() ?? "";
        groupValue = details?.couponType ?? "";
        editCategoryList = result.editCouponsData?.categoryList;

        print(selectedcategorydata);
        print("99999999");

        print("99999999");
        productList = result.editCouponsData?.allProductsList;
        categoryId = details?.shopOwnerCategoryId.toString() ?? "";

        print("00000");
        print(categoryId);
        print("00000");
        productId = details?.shopOwnerProductId.toString() ?? "";
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

  UpdateEditCouponReqModel get updateEditCouponReqModel =>
      UpdateEditCouponReqModel(
        couponFromDate: fromDateController.text,
        couponToDate: toDateController.text,
        shopOwnerCategoryId:
            groupValue == "full_order_amount" ? "" : categoryId,
        couponCode: couponCodeController.text,
        couponDiscountMaxAmount: maxDiscountAmountController.text,
        couponDiscountPercentage: discountPercentageController.text,
        couponMinimumOrderAmount: minOrderAmountController.text,
        couponsTermsAndCondition: termsAndConditionController.text,
        couponType: groupValue,
        productId: groupValue == "full_order_amount" ? "" : productId,
        productType: groupValue == "full_order_amount" ? "" : productType,
        couponId: couponId,
      );

  Future<void> uploadEditedCouponDetails(context, isNavFromDashBoard) async {
    if (fromDateController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter From Date",
          type: SnackType.error);
      return;
    }
    if (toDateController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter To Date",
          type: SnackType.error);
      return;
    }
    if (discountPercentageController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Discount Percentage",
          type: SnackType.error);
      return;
    }
    if (minOrderAmountController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Minimum Order Amount",
          type: SnackType.error);
      return;
    }
    if (maxDiscountAmountController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Max Discount Amount",
          type: SnackType.error);
      return;
    }
    if (couponCodeController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Coupon Code",
          type: SnackType.error);
      return;
    }
    if (groupValue == "category_and_product") {
      if (categoryId == "") {
        Utils.showPrimarySnackbar(context, "Select Category",
            type: SnackType.error);
        return;
      }
    }
    if (termsAndConditionController.text == "") {
      Utils.showPrimarySnackbar(context, "Enter Terms And Condition",
          type: SnackType.error);
      return;
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    updateEditCouponsRepo
        .updateEditedCoupons(
            updateEditCouponReqModel, pref.getString("successToken"))
        .then((response) {
      print(response.statusCode);
      log("response.body${response.body}");
      final result =
          UpdateEditCouponsResModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print("isNavFromDashBoard${isNavFromDashBoard}");
        if (isNavFromDashBoard) {
          final read =
              Provider.of<SMainScreenController>(context, listen: false);
          read.onNavigation(
              3,
              ShopCouponsView(
                isRefresh: true,
                isNavFromDashBoard: true,
              ),
              context);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SMainScreenView(
          //           index: 3,
          //           screenName: ShopCouponsView(
          //             isRefresh: true,
          //             isNavFromDashBoard: true,
          //           ))),
          //   (Route<dynamic> route) => false,
          // );
        } else {
          final read =
              Provider.of<SMainScreenController>(context, listen: false);
          read.onNavigation(
              4,
              ShopCouponsView(
                isRefresh: true,
                isNavFromDashBoard: false,
              ),
              context);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SMainScreenView(
          //           index: 4,
          //           screenName: ShopCouponsView(
          //             isRefresh: true,
          //             isNavFromDashBoard: false,
          //           ))),
          //   (Route<dynamic> route) => false,
          // );
        }

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
}
