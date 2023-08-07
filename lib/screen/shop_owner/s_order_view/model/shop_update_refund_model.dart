class ShopUpdateRefundReqModel{
  String ? orderId;
  String ? refundOrderStatus;
  String ? refundRejectReason;
  String ? refunPayableAmount;
  String ? refundPaymentType;
  String ? transactionId;
  ShopUpdateRefundReqModel({
    this.orderId,
    this.transactionId,
    this.refundOrderStatus,
    this.refundPaymentType,
    this.refundRejectReason,
    this.refunPayableAmount,
});
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data={};
    data["order_id"]=orderId;
    data["refund_order_status"]=refundOrderStatus;
    data["shop_owner_refund_reject_reason"]=refundRejectReason;
    data["shop_owner_refund_payable_amount"]=refunPayableAmount;
    data["shop_owner_refund_payment_type"]=refundPaymentType;
    data["shop_owner_refund_transaction_id"]=transactionId;
    return data;
  }
}

class ShopUpdateRefundResModel{
  int ? status;
  String ? message;
  ShopUpdateRefundResModel({
    this.status,
    this.message,
});
  ShopUpdateRefundResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}