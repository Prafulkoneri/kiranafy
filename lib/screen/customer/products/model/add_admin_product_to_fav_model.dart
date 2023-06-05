class AddAdminProductToFavReqModel{
  String ? shopId;
  String ? productId;
  String ? productType;
  AddAdminProductToFavReqModel({
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

class AddAdminProductToFavResModel{
String ? status;
String ? message;
AddAdminProductToFavResModel({
  this.status,
  this.message,
});
AddAdminProductToFavResModel.fromJson(Map<String,dynamic>json){
  status=json["status"];
  message=json["message"];
}
}