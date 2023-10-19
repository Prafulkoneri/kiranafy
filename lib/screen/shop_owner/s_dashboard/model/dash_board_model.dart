class DashBoardModel {
  int? status;
  String? message;
  Data? data;

  DashBoardModel({
    required this.status,
    required this.message,
    required this.data,
  });

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    // data = json['data'] != null ? Data.fromJson(json['data']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? categoriesCount;
  int? productsCount;
  int? totalCustomersOrderedCount;
  int? customersLinkedToShops;
  int? shopOwnerActiveCouponsCount;
  int? shopOwnerActiveProductsCouponsCount;
  int? seasonalProductsCount;
  int? fullfillYourCravingsProductsCount;
  int? totalOrdersCount;
  int? pendingOrdersCount;
  int? confirmedOrdersCount;
  int? inprocessOrdersCount;
  int? deliveredOrdersCount;
  int? cancelledOrdersCount;
  int? totalBusiness;
  int? acceptRefundOrdersCount;
  int? pendingRefundOrdersCount;
  int? totalRefund;
  int? totalRefundAmountPending; //
  int? totalRefundAmountAccept; //
  int? cancelledAmount; //
  List<BannerImageData>? bannerImages;

  Data({
    required this.categoriesCount,
    required this.productsCount,
    required this.bannerImages,
    required this.totalCustomersOrderedCount,
    required this.customersLinkedToShops,
    required this.shopOwnerActiveCouponsCount,
    required this.shopOwnerActiveProductsCouponsCount,
    required this.seasonalProductsCount,
    required this.fullfillYourCravingsProductsCount,
    required this.totalOrdersCount,
    required this.pendingOrdersCount,
    required this.confirmedOrdersCount,
    required this.inprocessOrdersCount,
    required this.deliveredOrdersCount,
    required this.cancelledOrdersCount,
    required this.totalBusiness,
    required this.cancelledAmount, //
    required this.totalRefundAmountPending, //
    required this.totalRefundAmountAccept, //
    required this.pendingRefundOrdersCount,
    required this.acceptRefundOrdersCount,
    // this.cancelledRefundAmount,
    this.totalRefund,
  });

  Data.fromJson(Map<String, dynamic> json) {
    categoriesCount = json["categories_count"];
    productsCount = json["products_count"];
    totalCustomersOrderedCount = json["total_customers_ordered_count"];
    customersLinkedToShops = json["customers_linked_to_shops"];
    shopOwnerActiveCouponsCount = json["shop_owner_active_coupons_count"];
    shopOwnerActiveProductsCouponsCount =
        json["shop_owner_active_products_coupons_count"];
    seasonalProductsCount = json["seasonal_products_count"];
    fullfillYourCravingsProductsCount =
        json["fullfill_your_cravings_products_count"];
    totalOrdersCount = json["total_orders_count"];
    pendingOrdersCount = json["pending_orders_count"];
    confirmedOrdersCount = json["confirmed_orders_count"];
    inprocessOrdersCount = json["inprocess_orders_count"];
    deliveredOrdersCount = json["delivered_orders_count"];
    cancelledOrdersCount = json["cancelled_orders_count"];
    totalBusiness = json["total_business"];
    // cancelledAmount = json["cancelled_amount"];
    pendingRefundOrdersCount = json["pending_refund_orders_count"];
    acceptRefundOrdersCount = json["accept_refund_orders_count"];
    totalRefund = json["total_refund"];
    cancelledAmount = json["cancelled_amount"]; //
    totalRefundAmountPending = json["total_refund_amount_pending"]; //
    totalRefundAmountAccept = json["total_refund_amount_accept"]; //
    if (json["shop_banner_images"] != null) {
      bannerImages = <BannerImageData>[];
      json["shop_banner_images"].forEach((v) {
        bannerImages!.add(BannerImageData.fromJson(v));
      });
    }
  }
}

class BannerImageData {
  String? imagesPath;
  String? imageName;
  String? rating;

  BannerImageData({
    this.imageName,
    this.imagesPath,
    this.rating,
  });

  BannerImageData.fromJson(Map<String, dynamic> json) {
    imagesPath = json["shop_banner_image_path"];
    imageName = json["shop_banner_image_name"];
    rating = json["ratings"];
  }
}
