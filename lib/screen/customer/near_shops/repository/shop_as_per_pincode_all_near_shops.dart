import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';

class AllNearShopRepo {
  Future<http.Response> allNearShopRepo(
      ShopUpdateProfileReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.allNearShopAsPerPincode));
    try {
      return await http.post(Uri.parse(Endpoint.allNearShopAsPerPincode),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
