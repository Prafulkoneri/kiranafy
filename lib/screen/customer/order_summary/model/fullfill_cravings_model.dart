import 'package:local_supper_market/screen/customer/order_summary/model/order_summary_model.dart';

class FullFillCravingsReqModel{
  String ? shopId;
  String ? offset;
  String ? limit;
  FullFillCravingsReqModel({
    this.shopId,
    this.offset,
    this.limit,
});
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data={};
    data["shop_id"]=shopId;
    data["offset"]=offset;
    data["limit"]=limit;
    return data;
  }
}

class FullFillCravingsResModel{
  int ? status;
  String ? message;
  FullFillData ? data;
  FullFillCravingsResModel({
    this.data,
    this.status,
    this.message,
});
  FullFillCravingsResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    data = json['data'] != null
        ? FullFillData.fromJson(json['data'])
        : null;
  }
}

class FullFillData{
  List<FullFillYourCraving> ? fullFillYourCravingsAdminProduct;
  List<FullFillYourCraving> ? fullFillYourCravingsCustomProduct;
  FullFillData({
    this.fullFillYourCravingsAdminProduct,
    this.fullFillYourCravingsCustomProduct,
});
  FullFillData.fromJson(Map<String,dynamic>json){
    if (json["full_fill_your_cravings"] != null) {
      fullFillYourCravingsAdminProduct = <FullFillYourCraving>[];
      json["full_fill_your_cravings"].forEach((v) {
        fullFillYourCravingsAdminProduct!.add(FullFillYourCraving.fromJson(v));
      });
    }
    if (json["full_fill_your_cravings_custom_products"] != null) {
      fullFillYourCravingsCustomProduct = <FullFillYourCraving>[];
      json["full_fill_your_cravings_custom_products"].forEach((v) {
        fullFillYourCravingsCustomProduct!.add(FullFillYourCraving.fromJson(v));
      });
    }
  }
}