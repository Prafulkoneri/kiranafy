class ReferAndEarnResModel {
   int ? status;
  String ? message;
  ReferAndEarnCouponDetails ? couponDetails;
  String ? customerName;

  ReferAndEarnResModel({
    required this.status,
    required this.message,
    required this.couponDetails,
    required this.customerName,
  });
   ReferAndEarnResModel.fromJson(Map<String,dynamic>json){
     status=json["status"];
     message=json["message"];
     couponDetails = json['coupon_details'] != null ? ReferAndEarnCouponDetails.fromJson(json['coupon_details']) : null;
     customerName=json["customer_name"];
   }
}

class ReferAndEarnCouponDetails {
  String ? discountAmount;
  String ? customerReferralCode;

  ReferAndEarnCouponDetails({
    required this.discountAmount,
    required this.customerReferralCode,
  });
  ReferAndEarnCouponDetails.fromJson(Map<String,dynamic>json){
    discountAmount=json["discount_amount"];
    customerReferralCode=json["customer_referral_code"];
  }
}
