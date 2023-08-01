
class CheckProductRequestModel {
  String? productAmount;
  String? productTotalAmount;
  String? checkStatus;
  CheckProductRequestModel({this.productAmount,this.productTotalAmount,this.checkStatus});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["product_amount"] = productAmount;
    data["product_total_amount"] = productTotalAmount;
    data["check_status"] = checkStatus;
    return data;
  }
}

/////////////////////////////Response Model/////////////////////////////
class CheckProductResponseModel {
  int? status;
  String? message;
  CheckProductListData? checkproductlistdata;

  CheckProductResponseModel({
    required this.status,
    required this.message,
    required this.checkproductlistdata,
  });
  CheckProductResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    checkproductlistdata = json['data'] != null ? CheckProductListData.fromJson(json['data']) : null;
  }

}

class CheckProductListData {
  int? refundTotal;
  CheckProductListData({
    required this.refundTotal,
  });
  CheckProductListData.fromJson(Map<String, dynamic> json) {
    refundTotal = json["refundTotal"];


  }

}
