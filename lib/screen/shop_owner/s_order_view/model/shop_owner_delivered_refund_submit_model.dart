import 'package:intl/intl.dart';

class ShopOwnerDeliveredRefundSubmitReqModel{
  String ? orderId;
  String ? shopDeliveredRefundStatus;
  String ? shopDeliveredPayableAmount;
  String ? shopDeliveredPaymentType;
  String ? shopDeliveredTransactionId;
  ShopOwnerDeliveredRefundSubmitReqModel({
    this.shopDeliveredTransactionId,
    this.shopDeliveredPayableAmount,
    this.orderId,
    this.shopDeliveredRefundStatus,
    this.shopDeliveredPaymentType,
});
  Map<String,dynamic>toJson(){
    Map<String,dynamic> data={};
    data["order_id"]=orderId;
    data["shop_de_refund_status"]=shopDeliveredRefundStatus;
    data["shop_de_payable_amount"]=shopDeliveredPayableAmount;
    data["shop_de_payment_type"]=shopDeliveredPaymentType;
    data["shop_de_transaction_id"]=shopDeliveredTransactionId;
    return data;
  }
}
class ShopOwnerDeliveredRefundSubmitResModel{
  int ? status;
  String ? message;
  ShopOwnerDeliveredRefundSubmitResModel({
    this.status,
    this.message,
});
  ShopOwnerDeliveredRefundSubmitResModel.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }
}