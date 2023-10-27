class MyVoucher {
  int? status;
  String? message;
  VoucherDetails? voucherDetails;
  MyVoucher({
    required this.status,
    required this.message,
    required this.voucherDetails,
  });
  MyVoucher.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    voucherDetails = json['coupon_details'] != null
        ? VoucherDetails.fromJson(json['coupon_details'])
        : null;
  }
}

class VoucherDetails {
  List<MyVoucherList>? myvoucherListData;

  VoucherDetails({
    required this.myvoucherListData,
  });
  VoucherDetails.fromJson(Map<String, dynamic> json) {
    if (json["data"] != null) {
      myvoucherListData = <MyVoucherList>[];
      json["data"].forEach((v) {
        myvoucherListData!.add(MyVoucherList.fromJson(v));
      });
    }
  }
}

class MyVoucherList {
  String? shopName;
  String? customerName;
  String? toDate;
  String? referralCode;
  String? discountAmount;
  String? uniqueNo;
  String? status;

  MyVoucherList({
    required this.shopName,
    required this.customerName,
    required this.toDate,
    required this.referralCode,
    required this.discountAmount,
    required this.uniqueNo,
    required this.status,
  });
  MyVoucherList.fromJson(Map<String, dynamic> json) {
    shopName = json["shop_name"];
    toDate = json["to_date"];
    discountAmount = json["discount_amount"];
    uniqueNo = json["unique_no"];
    status = json["status"];
  }
}
