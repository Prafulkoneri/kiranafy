class SGetproductUnitListResModel {
  int status;
  String message;
  Data data;

  SGetproductUnitListResModel({
    required this.status,
    required this.message,
    required this.data,
  });
}

class Data {
  UnitDetails unitDetails;

  Data({
    required this.unitDetails,
  });
}

class UnitDetails {
  The0 the0;
  int productId;
  String productName;
  String productType;

  UnitDetails({
    required this.the0,
    required this.productId,
    required this.productName,
    required this.productType,
  });
}

class The0 {
  int id;
  String weightAndUnit;
  int offerPrice;
  int mrpPrice;
  String status;
  String unitBasedProductImage1Path;
  String unitBasedProductImage1Name;

  The0({
    required this.id,
    required this.weightAndUnit,
    required this.offerPrice,
    required this.mrpPrice,
    required this.status,
    required this.unitBasedProductImage1Path,
    required this.unitBasedProductImage1Name,
  });
}
