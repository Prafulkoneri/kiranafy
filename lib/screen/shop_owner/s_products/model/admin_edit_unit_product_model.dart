class AdminEditUnitProductReqModel{
  String ? productUnitId;
  AdminEditUnitProductReqModel({
    this.productUnitId,
});
  Map<String,dynamic> toJson(){
  Map<String, dynamic> data = {};
  data["product_unit_id"]=productUnitId;
    return data;
}
}

class AdminEditUnitProductResModel{

}