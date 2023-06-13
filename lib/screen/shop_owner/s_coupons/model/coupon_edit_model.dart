class EditCouponRequest {
  String? couponId;

  EditCouponRequest({
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
  EditCouponsData? editCoupons;

  EditCouponsResModel({
    required this.status,
    required this.message,
    required this.editCoupons,
  });
  EditCouponsResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    editCoupons =
        json['data'] != null ? EditCouponsData.fromJson(json['data']) : null;
  }
}

class EditCouponsData {
  CouponDetails? couponDetails;
  List<CategoryList>? categoryList;
  List<AllProductsList>? allProductsList;

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
      categoryList = <CategoryList>[];
      json["category_list"].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }

    ///
    if (json["all_products_list"] != null) {
      allProductsList = <AllProductsList>[];
      json["all_products_list"].forEach((v) {
        allProductsList!.add(AllProductsList.fromJson(v));
      });
    }
  }
}

class AllProductsList {
  int? id;
  String? productName;
  String? productType;

  AllProductsList({
    required this.id,
    required this.productName,
    required this.productType,
  });
  AllProductsList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productName = json["product_name"];
    productType = json["product_type"];
  }
}

class CategoryList {
  int? id;
  String? categoryName;

  CategoryList({
    required this.id,
    required this.categoryName,
  });
  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryName = json["category_name"];
  }
}

class CouponDetails {
  int? id;
  String? couponFromDate;
  String? couponToDate;
  int? couponDiscountPercentage;
  int? couponMinimumOrderAmount;
  int? couponDiscountMaxAmount;
  String? couponCode;
  String? couponType;
  int? shopOwnerCategoryId;
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
