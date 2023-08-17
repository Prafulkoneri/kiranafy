class AddProductToCartReqModel{
  String ? shopId;
  String ? productType;
  String ? productUnitId;
  String ? quantity;
  AddProductToCartReqModel({
    this.productType,
    this.shopId,
    this.productUnitId,
    this.quantity
});
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data={};
    data["shop_id"]=shopId;
    data["product_type"]=productType;
    data["product_unit_id"]=productUnitId;
    data["quantity"]=quantity;
    return data;
  }
}

class AddProductToCartResModel{
  int ? status;
  String ? message;
  int ? cartItemId;
  AddProductToCartResModel({
    this.status,
    this.message,
    this.cartItemId,
});
  AddProductToCartResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    cartItemId=json["cart_item_id"];
  }
}