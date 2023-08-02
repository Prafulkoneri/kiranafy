class SubmitReturnOrderReqModel{
  String ? orderId;
  String ? reasonId;
  String ? productId;
  String ? customRefundReason;
  String ? customerRefundAmount;
  String ? totalProducts;
  SubmitReturnOrderReqModel({
    this.orderId,
    this.productId,
    this.customRefundReason,
    this.reasonId,
    this.customerRefundAmount,
    this.totalProducts,
});
 Map<String,dynamic> toJson(){
   Map<String,dynamic> data={};
   data["order_id"]=orderId;
   data["reason_id"]=reasonId;
   data["product_id"]=productId;
   data["custom_refund_reason"]=customRefundReason;
   data["customer_refund_amount"]=customerRefundAmount;
   data["refund_product_count"]=totalProducts;
   return data;
 }
}


class SubmitReturnOrderResModel{
  int ? status;
  String ? message;
  SubmitReturnOrderResModel({
    this.status,
    this.message,
});
  SubmitReturnOrderResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}

