class DeleteAdminProductReqModel{
  String ? productId;
  DeleteAdminProductReqModel({
    this.productId,
});
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data={};
    data["product_id"]=productId;
    return data;
  }
}

class DeleteAdminProductResModel{
  int ? status;
  String ? message;
  DeleteAdminProductResModel({
    this.status,
    this.message,
});
  DeleteAdminProductResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}