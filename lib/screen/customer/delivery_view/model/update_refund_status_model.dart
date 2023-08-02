class UpdateRefundStatusReqModel{
  String ? orderId;
  String ? paymentStatus;
  UpdateRefundStatusReqModel({
    this.orderId,
    this.paymentStatus
});
  Map<String,dynamic> toJson(){
    Map<String ,dynamic> data={};
    data["order_id"]=orderId;
    data["payment_status"]=paymentStatus;
    return data;
  }
}

class UpdateRefundStatusResModel{
  int ? status;
  String ? message;
  UpdateRefundStatusResModel({
    this.status,
    this.message
});
  UpdateRefundStatusResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}