class CustomerCouponFilttermodel {
  int? status;
  String? message;
  List<CategoryList>? categoryList;
  List<ShopOwnerList>? shopOwnerList;

  CustomerCouponFilttermodel({
    required this.status,
    required this.message,
    required this.categoryList,
    required this.shopOwnerList,
  });
  CustomerCouponFilttermodel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    if (json["category_list"] != null) {
      categoryList = <CategoryList>[];
      json["category_list"].forEach((v) {
        categoryList!.add(CategoryList.fromJson(v));
      });
    }
    if (json["shop_owner_list"] != null) {
      shopOwnerList = <ShopOwnerList>[];
      json["shop_owner_list"].forEach((v) {
        shopOwnerList!.add(ShopOwnerList.fromJson(v));
      });
    }
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

class ShopOwnerList {
  int? id;
  String? shopName;

  ShopOwnerList({
    required this.id,
    required this.shopName,
  });
  ShopOwnerList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shopName = json["shop_name"];
  }
}
