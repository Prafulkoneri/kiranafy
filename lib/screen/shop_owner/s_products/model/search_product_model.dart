class SearchProductRequestModel {
  String? categoryId;
  String? productName;

  SearchProductRequestModel({
    this.categoryId,
    this.productName,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["category_id"] = categoryId;
    data["product_name"] = productName;
    return data;
  }
}
