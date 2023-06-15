import 'package:local_supper_market/screen/shop_owner/s_coupons/model/product_as_per_category_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_select_category/model/s_categories_list_model.dart';

class EditCouponRequestModel {
  String? couponId;

  EditCouponRequestModel({
    this.couponId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["coupon_id"] = couponId;
    return data;
  }
}

/////////////Response Model//////////////////

class EditCouponsResModel {
  int? status;
  String? message;
  EditCouponsData? editCouponsData;

  EditCouponsResModel({
    required this.status,
    required this.message,
    required this.editCouponsData,
  });

  EditCouponsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    editCouponsData =
        json['data'] != null ? EditCouponsData.fromJson(json['data']) : null;
  }
}

class EditCouponsData {
  CouponDetails? couponDetails;
  List<CategoryData>? categoryList;
  List<ProductData>? allProductsList;

  EditCouponsData({
    required this.couponDetails,
    required this.categoryList,
    required this.allProductsList,
  });

  EditCouponsData.fromJson(Map<String, dynamic> json) {
    couponDetails = json['coupon_details'] != null
        ? CouponDetails.fromJson(json['coupon_details'])
        : null;
    if (json["category_list"] != null) {
      categoryList = <CategoryData>[];
      json["category_list"].forEach((v) {
        categoryList!.add(CategoryData.fromJson(v));
      });
    }

    ///
    if (json["all_products_list"] != null) {
      allProductsList = <ProductData>[];
      json["all_products_list"].forEach((v) {
        allProductsList!.add(ProductData.fromJson(v));
      });
    }
  }
}

class CouponDetails {
  int? id;
  String? couponFromDate;
  String? couponToDate;
  String? couponDiscountPercentage;
  String? couponMinimumOrderAmount;
  String? couponDiscountMaxAmount;
  String? couponCode;
  String? couponType;
  String? shopOwnerCategoryId;
  String? shopOwnerProductType;
  int? shopOwnerProductId;
  String? couponTermsAndConditions;

  CouponDetails({
    required this.id,
    required this.couponFromDate,
    required this.couponToDate,
    required this.couponDiscountPercentage,
    required this.couponMinimumOrderAmount,
    required this.couponDiscountMaxAmount,
    required this.couponCode,
    required this.couponType,
    required this.shopOwnerCategoryId,
    required this.shopOwnerProductType,
    required this.shopOwnerProductId,
    required this.couponTermsAndConditions,
  });

  CouponDetails.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    couponFromDate = json["coupon_from_date"];
    couponToDate = json["coupon_to_date"];
    couponDiscountPercentage = json["coupon_discount_percentage"];
    couponMinimumOrderAmount = json["coupon_minimum_order_amount"];
    couponDiscountMaxAmount = json["coupon_discount_max_amount"];
    couponCode = json["coupon_code"];
    couponType = json["coupon_type"];
    shopOwnerCategoryId = json["shop_owner_category_id"];
    shopOwnerProductType = json["shop_owner_product_type"];
    shopOwnerProductId = json["shop_owner_product_id"];
    couponTermsAndConditions = json["coupon_terms_and_conditions"];
  }
}
