import 'package:local_supper_market/screen/shop_owner/s_products/model/edit_custom_products_model.dart';

class OnBoardingResponseModel {
  int? status;
  String? message;
  List<OnboardingData>? data;

  OnBoardingResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });
  OnBoardingResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];

    if (json["data"] != null) {
      data = <OnboardingData>[];
      json["data"].forEach((v) {
        data!.add(OnboardingData.fromJson(v));
      });
    }
  }
}

class OnboardingData {
  int? id;
  String? title;
  String? subTitle;
  int? screenSequence;
  String? splashScreenImagePath;
  String? splashScreenImageName;

  OnboardingData({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.screenSequence,
    required this.splashScreenImagePath,
    required this.splashScreenImageName,
  });

  OnboardingData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    subTitle = json["sub_title"];
    screenSequence = json["screen_sequence"];
    splashScreenImagePath = json["splash_screen_image_path"];
    splashScreenImageName = json["splash_screen_image_name"];
  }
}
