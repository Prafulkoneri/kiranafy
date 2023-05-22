class AddFavReqModel{
  String ? shopId;
  AddFavReqModel({
    this.shopId,
});
  Map<String,dynamic>toJson(){
    Map<String,dynamic> data={};
    data["shop_id"]=shopId;
    return data;
  }
}

class AddFavResModel{
  int ? status;
  String ? message;
  AddFavResModel({
    this.message,
    this.status,
});
  AddFavResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}