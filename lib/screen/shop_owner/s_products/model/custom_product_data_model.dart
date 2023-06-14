class CustomProductDataResModel {
  int? status;
  String? message;
  CustomData? data;

  CustomProductDataResModel({
    this.status,
    this.message,
    this.data,
  });

  CustomProductDataResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json['data'] != null ? CustomData.fromJson(json['data']) : null;
  }
}

class CustomData {
  List<CategoryData>? categoryData;
  List<BrandData>? brandData;
  List<TaxData>? taxData;
  List<UnitData>? unitData;

  CustomData({
    this.categoryData,
    this.brandData,
    this.taxData,
    this.unitData,
  });

  CustomData.fromJson(Map<String, dynamic> json) {
    if (json["category_data"] != null) {
      categoryData = <CategoryData>[];
      json["category_data"].forEach((v) {
        categoryData!.add(CategoryData.fromJson(v));
      });
    }
    if (json["brand_data"] != null) {
      brandData = <BrandData>[];
      json["brand_data"].forEach((v) {
        brandData!.add(BrandData.fromJson(v));
      });
    }
    if (json["tax_data"] != null) {
      taxData = <TaxData>[];
      json["tax_data"].forEach((v) {
        taxData!.add(TaxData.fromJson(v));
      });
    }
    if (json["unit_data"] != null) {
      unitData = <UnitData>[];
      json["unit_data"].forEach((v) {
        unitData!.add(UnitData.fromJson(v));
      });
    }
  }
}

class BrandData {
  int? id;
  String? brandName;

  BrandData({
    this.id,
    this.brandName,
  });

  BrandData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    brandName = json["brand_name"];
  }
}

class CategoryData {
  int? id;
  String? categoryName;

  CategoryData({
    this.id,
    this.categoryName,
  });

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryName = json["category_name"];
  }
}

class TaxData {
  int? id;
  String? igstTax;

  TaxData({
    this.id,
    this.igstTax,
  });

  TaxData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    igstTax = json["igst_tax"];
  }
}

class UnitData {
  int? id;
  String? unit;

  UnitData({
    this.id,
    this.unit,
  });

  UnitData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    unit = json["unit"];
  }
}
