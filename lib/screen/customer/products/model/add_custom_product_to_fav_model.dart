class AddCustomProductToFavReqModel{
  String ? shopId;
  String ? productId;
  String ? productType;
  AddCustomProductToFavReqModel({
    this.productId,
    this.shopId,
    this.productType,
  });
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data={};
    data["shop_id"]=shopId;
    data["product_id"]=productId;
    data["product_type"]=productType;
    return data;
  }
}

class AddCustomProductToFavResModel{
  String ? status;
  String ? message;
  AddCustomProductToFavResModel({
    this.status,
    this.message,
  });
  AddCustomProductToFavResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}