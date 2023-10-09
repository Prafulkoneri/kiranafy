import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class ProductAsPerCategoryReqModel {
  String? shopId;
  String? categoryId;
  ProductAsPerCategoryReqModel({
    this.categoryId,
    this.shopId,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["category_id"] = categoryId;
    return data;
  }
}

//////////////////////
class ProductAsPerCategoryResModel {
  int? status;
  String? message;
  CategoryProductData? data;

  ProductAsPerCategoryResModel({
    required this.status,
    required this.message,
    required this.data,
  });
  ProductAsPerCategoryResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null
        ? CategoryProductData.fromJson(json['data'])
        : null;
  }
}

class CategoryProductData {
  List<AllCategoryList>? allCategoryList;
  List<CustomerProductData>? productList;
  List<CustomerProductData>? customProductList;
  List<CustomerProductData>? finalFiltterProductList;
  int? totalSelectedAndCustomProducts;

  CategoryProductData({
    required this.allCategoryList,
    required this.productList,
    required this.totalSelectedAndCustomProducts,
    required this.customProductList,
  });
  CategoryProductData.fromJson(Map<String, dynamic> json) {
    if (json["product_list"] != null) {
      productList = <CustomerProductData>[];
      json["product_list"].forEach((v) {
        productList!.add(CustomerProductData.fromJson(v));
      });
    }
    if (json["custom_product_list"] != null) {
      customProductList = <CustomerProductData>[];
      json["custom_product_list"].forEach((v) {
        customProductList!.add(CustomerProductData.fromJson(v));
      });
    }
    if (json["all_category_list"] != null) {
      allCategoryList = <AllCategoryList>[];
      json["all_category_list"].forEach((v) {
        allCategoryList!.add(AllCategoryList.fromJson(v));
      });
    }
    /////////
    ///////////////////////////////////////////
    if (json["final_details_list"] != null) {
      finalFiltterProductList = <CustomerProductData>[];
      json["final_details_list"].forEach((v) {
        finalFiltterProductList!.add(CustomerProductData.fromJson(v));
      });
    }
    totalSelectedAndCustomProducts = json['total_selected_and_custom_products'];
  }
}

class AllCategoryList {
  int? id;
  String? categoryName;
  String? selectedCategory;

  AllCategoryList({
    required this.id,
    required this.categoryName,
    required this.selectedCategory,
  });
  AllCategoryList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryName = json["category_name"];
    selectedCategory = json["selected_category"];
  }
}
