import 'package:local_supper_market/screen/customer/category/model/product_as_per_category_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class ProductFilterReqModel {
  String? shopId;
  String? categoryId;
  String? offerProducts;
  String? priceLowToHigh;
  String? priceHighToLow;
  ProductFilterReqModel(
      {this.shopId,
      this.categoryId,
      this.offerProducts,
      this.priceHighToLow,
      this.priceLowToHigh});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["shop_id"] = shopId;
    data["category_id"] = categoryId;
    data["offer_products"] = offerProducts;
    data["price_low_to_high"] = priceLowToHigh;
    data["price_high_to_low"] = priceHighToLow;
    data["price_high_to_low"] = priceHighToLow;
    return data;
  }
}

// class ProductFilterResModel {
//   int? status;
//   String? message;
//   FilterData? data;

//   ProductFilterResModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//   ProductFilterResModel.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     message = json["message"];
//     data = json['data'] != null ? FilterData.fromJson(json['data']) : null;
//   }
// }

// class FilterData {
//   List<CustomerProductData>? productList;
//   List<AllCategoryList>? allCategoryList;
//   List<CustomerProductData>? finalFiltterProductList;
//   int? totalSelectedAndCustomProducts;

//   FilterData({
//     required this.productList,
//     required this.allCategoryList,
//     required this.totalSelectedAndCustomProducts,
//   });
//   FilterData.fromJson(Map<String, dynamic> json) {
//     if (json["product_list"] != null) {
//       productList = <CustomerProductData>[];
//       json["product_list"].forEach((v) {
//         productList!.add(CustomerProductData.fromJson(v));
//       });
//     }
//     if (json["all_category_list"] != null) {
//       allCategoryList = <AllCategoryList>[];
//       json["all_category_list"].forEach((v) {
//         allCategoryList!.add(AllCategoryList.fromJson(v));
//       });
//     }
    // ///////////////////////////////////////////
    // if (json["final_details_list"] != null) {
    //   finalFiltterProductList = <CustomerProductData>[];
    //   json["final_details_list"].forEach((v) {
    //     finalFiltterProductList!.add(CustomerProductData.fromJson(v));
    //   });
    // }
//     totalSelectedAndCustomProducts = json['total_selected_and_custom_products'];
//   }
// }
