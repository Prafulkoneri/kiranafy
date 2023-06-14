import 'package:local_supper_market/screen/customer/category/model/product_as_per_category_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class ProductFilterReqModel{
  String ? shopId;
  String ? categoryId;
  String ? offerProducts;
  String ? priceLowToHigh;
  String ? priceHighToLow;
  ProductFilterReqModel({
    this.shopId,
    this.categoryId,
    this.offerProducts,
    this.priceHighToLow,
    this.priceLowToHigh
});
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data={};
    data["shop_id"]=shopId;
    data["category_id"]=categoryId;
    data["offer_products"]=offerProducts;
    data["price_low_to_high"]=priceLowToHigh;
    data["price_high_to_low"]=priceHighToLow;
    data["price_high_to_low"]=priceHighToLow;
    return data;
  }
}


class ProductFilterResModel {
  int? status;
  String? message;
  FilterData? data;

  ProductFilterResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  ProductFilterResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? FilterData.fromJson(json['data']) : null;
  }
}

class FilterData {
  List<CustomerProductData>? productList;
  List<AllCategoryList>? allCategoryList;
  int? totalSelectedAndCustomProducts;

  FilterData({
    required this.productList,
    required this.allCategoryList,
    required this.totalSelectedAndCustomProducts,
  });
  FilterData.fromJson(Map<String, dynamic> json) {
    if (json["product_list"] != null) {
      productList = <CustomerProductData>[];
      json["product_list"].forEach((v) {
        productList!.add(CustomerProductData.fromJson(v));
      });
    }
    if (json["all_category_list"] != null) {
      allCategoryList = <AllCategoryList>[];
      json["all_category_list"].forEach((v) {
        allCategoryList!.add(AllCategoryList.fromJson(v));
      });
    }
    totalSelectedAndCustomProducts = json['total_selected_and_custom_products'];
  }
}

// class AllCategoryList {
//   int? id;
//   String? categoryName;
//   String? selectedCategory;
//
//   AllCategoryList({
//     required this.id,
//     required this.categoryName,
//     required this.selectedCategory,
//   });
//
//   AllCategoryList.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     categoryName = json["category_name"];
//     selectedCategory = json["selected_category"];
//   }
// }

// class ProductList {
//   int id;
//   String productName;
//   String productImagePath;
//   String productImageName;
//   String weight;
//   String offerPrice;
//   String mrpPrice;
//   int categoryId;
//   String productType;
//   String discountPercentage;
//   int productId;
//   String status;
//   String unit;
//
//   ProductList({
//     required this.id,
//     required this.productName,
//     required this.productImagePath,
//     required this.productImageName,
//     required this.weight,
//     required this.offerPrice,
//     required this.mrpPrice,
//     required this.categoryId,
//     required this.productType,
//     required this.discountPercentage,
//     required this.productId,
//     required this.status,
//     required this.unit,
//   });
// }
