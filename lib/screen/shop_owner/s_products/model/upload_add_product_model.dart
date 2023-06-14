////Reqest Model
class UploadAddProductsRequestModel {
  String? category_id;
  String? product_id;

  UploadAddProductsRequestModel({this.category_id, this.product_id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["category_id"] = category_id;
    data["product_id"] = product_id;
    return data;
  }
}

////Response Model
class UploadAddProductResponseModel {
  int? status;
  String? message;

  UploadAddProductResponseModel({
    required this.status,
    required this.message,
  });

  UploadAddProductResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
