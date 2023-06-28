class CmsModel {
  int? status;
  String? message;
  CmsData? cmsdata;

  CmsModel({
    required this.status,
    required this.message,
    required this.cmsdata,
  });
  CmsModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    cmsdata = json['data'] != null ? CmsData.fromJson(json['data']) : null;
  }
}

class CmsData {
  AboutUs? aboutUs;
  AboutUs? privacyPolicy;
  AboutUs? termsAndCondition;

  CmsData({
    required this.aboutUs,
    required this.privacyPolicy,
    required this.termsAndCondition,
  });
  CmsData.fromJson(Map<String, dynamic> json) {
    aboutUs =
        json['about_us'] != null ? AboutUs.fromJson(json['about_us']) : null;
    privacyPolicy = json['privacy_policy'] != null
        ? AboutUs.fromJson(json['privacy_policy'])
        : null;
    termsAndCondition = json['terms_and_condition'] != null
        ? AboutUs.fromJson(json['terms_and_condition'])
        : null;
  }
}

class AboutUs {
  String? pageName;
  String? description;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;

  AboutUs({
    required this.pageName,
    required this.description,
    required this.metaTitle,
    required this.metaKeywords,
    required this.metaDescription,
  });
  AboutUs.fromJson(Map<String, dynamic> json) {
    pageName = json["page_name"];
    description = json["description"];
    metaTitle = json["meta_title"];
    metaKeywords = json["meta_keywords"];
    metaDescription = json["meta_description"];
  }
}
