// class CustomerCouponListRequestModel {
//   int? uptoValue;
//   String? shopId;
//   String? categoryId;
//   CustomerCouponListRequestModel({
//     this.categoryId,
//     this.shopId,
//   });
//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = {};
//     data["uptoValue"] = uptoValue;
//     data["shop_id"] = shopId;
//     data["category_id"] = categoryId;
//     return data;
//   }
// }

/////////////////////////////////
class CustomerCouponListResponseModel {
  int? status;
  String? message;
  List<FilterCouponList>? filterCouponList;
  AllCouponListData? allCouponlistdata;

  CustomerCouponListResponseModel({
    required this.status,
    required this.message,
    required this.filterCouponList,
    required this.allCouponlistdata,
  });
  CustomerCouponListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    allCouponlistdata =
        json['data'] != null ? AllCouponListData.fromJson(json['data']) : null;

    if (json["filter_coupon_list"] != null) {
      filterCouponList = <FilterCouponList>[];
      json["filter_coupon_list"].forEach((v) {
        filterCouponList!.add(FilterCouponList.fromJson(v));
      });
    }
  }
}

class AllCouponListData {
  List<ShopEnquiriesDetail>? shopEnquiriesDetails;

  AllCouponListData({
    required this.shopEnquiriesDetails,
  });
  AllCouponListData.fromJson(Map<String, dynamic> json) {
    if (json["shop_enquiries_details"] != null) {
      shopEnquiriesDetails = <ShopEnquiriesDetail>[];
      json["shop_enquiries_details"].forEach((v) {
        shopEnquiriesDetails!.add(ShopEnquiriesDetail.fromJson(v));
      });
    }
  }
}

class ShopEnquiriesDetail {
  int? id;
  String? shopId;
  String? shopName;
  String? couponTermsAndConditions;
  String? couponToDate;
  int? couponDiscountPercentage;
  String? couponDiscountMaxAmount;
  String? couponCode;
  String? createdAt;

  ShopEnquiriesDetail({
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.couponTermsAndConditions,
    required this.couponToDate,
    required this.couponDiscountPercentage,
    required this.couponDiscountMaxAmount,
    required this.couponCode,
    required this.createdAt,
  });
  ShopEnquiriesDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopId = json["shop_id"];
    shopName = json["shop_name"];
    couponTermsAndConditions = json["coupon_terms_and_conditions"];
    couponToDate = json["coupon_to_date"];
    couponDiscountPercentage = json["coupon_discount_percentage"];
    couponDiscountMaxAmount = json["coupon_discount_max_amount"];
    couponCode = json["coupon_code"];
    createdAt = json["created_at"];
  }
}

class FilterCouponList {
  String? key;
  String? value;

  FilterCouponList({
    required this.key,
    required this.value,
  });
  FilterCouponList.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    value = json["value"];
  }
}
