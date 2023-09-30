import 'package:local_supper_market/screen/shop_owner/s_auth/model/area_model.dart';

class ShopAreaListResModel {
  int? status;
  String? message;
  List<AreaData>? areaList;

  ShopAreaListResModel({
    required this.status,
    required this.message,
    required this.areaList,
  });
  ShopAreaListResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["area_list"] != null) {
      areaList = <AreaData>[];
      json["area_list"].forEach((v) {
        areaList!.add(AreaData.fromJson(v));
      });
    }
  }
}

// class AreaList {
//     int id;
//     String areaName;

//     AreaList({
//         required this.id,
//         required this.areaName,
//     });

// }
