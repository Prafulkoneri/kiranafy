class UpdateCustomeProductsResponseModel {
  int? status;
  String? message;
  Data? data;

  UpdateCustomeProductsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  UpdateCustomeProductsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    //array Shop Details

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<String>? showUnderSeasonalProducts;
  List<String>? showUnderRecommandedProducts;
  List<String>? showUnderFullfillYourCravings;
  List<String>? totalRows;

  Data({
    required this.showUnderSeasonalProducts,
    required this.showUnderRecommandedProducts,
    required this.showUnderFullfillYourCravings,
    required this.totalRows,
  });

  Data.fromJson(Map<String, dynamic> json) {
    showUnderSeasonalProducts = json["show_under_seasonal_products"];
    showUnderRecommandedProducts = json["show_under_recommanded_products"];
    showUnderFullfillYourCravings = json["show_under_fullfill_your_cravings"];
    totalRows = json["total_rows"];
  }
}
