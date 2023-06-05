// class CategoryFiltterResModel {
//   int? status;
//   String? message;
//   FiltterData? data;

//   CategoryFiltterResModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//   CategoryFiltterResModel.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     message = json["message"];
//     data = json['data'] != null ? FiltterData.fromJson(json['data']) : null;
//   }
// }

// class FiltterData {
//   List<ProductList>? productList;
//   List<AllCategoryList>? allCategoryList;
//   int? totalSelectedAndCustomProducts;

//   FiltterData({
//     required this.productList,
//     required this.allCategoryList,
//     required this.totalSelectedAndCustomProducts,
//   });
//   FiltterData.fromJson(Map<String, dynamic> json) {
//     if (json["product_list"] != null) {
//       productList = <ProductList>[];
//       json["product_list"].forEach((v) {
//         productList!.add(ProductList.fromJson(v));
//       });
//     }
//     if (json["all_category_list"] != null) {
//       allCategoryList = <AllCategoryList>[];
//       json["all_category_list"].forEach((v) {
//         allCategoryList!.add(AllCategoryList.fromJson(v));
//       });
//     }
//     totalSelectedAndCustomProducts = json['total_selected_and_custom_products'];
//   }
// }

// class AllCategoryList {
//   int? id;
//   String? categoryName;
//   String? selectedCategory;

//   AllCategoryList({
//     required this.id,
//     required this.categoryName,
//     required this.selectedCategory,
//   });

//   AllCategoryList.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     categoryName = json["category_name"];
//     selectedCategory = json["selected_category"];
//   }
// }

// class ProductList {
//   int? id;
//   String? productName;
//   String? productImagePath;
//   String? productImageName;
//   String? weight;
//   String? offerPrice;
//   String? mrpPrice;
//   int? categoryId;
//   String? productType;
//   String? discountPercentage;
//   int? productId;
//   String status;
//   String unit;

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

//    ProductList.fromJson(Map<String, dynamic> json) {
//     id = json["id"];
//     productName = json["product_name"];
//     productImagePath = json["product_image_path"];
//     productImageName = json["product_image_name"];
//     offerPrice = json["offer_price"];
//     mrpPrice = json["mrp_price"];
//     weight = json["weight"];
//     discountPercentage = json["discount_percentage"];
//     productId = json["product_id"];
//     status = json["status"];
//     unit = json["unit"];
//   }
// }
