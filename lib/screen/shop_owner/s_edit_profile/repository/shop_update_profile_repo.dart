import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';
import 'dart:developer';

class UpdateProfileRepo {
  Future<http.Response> UpdateProfile(
      ShopUpdateProfileReqModel reqModel, token) async {
    print(reqModel.toJson());

    print(Uri.parse(Endpoint.shopUpdateAccountDetails));
    log("${reqModel.toJson()}");

    try {
      return await http.post(Uri.parse(Endpoint.shopUpdateAccountDetails),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
