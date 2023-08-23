import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/all_near_shops_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';

class AllNearShopRepo {
  Future<http.Response> getAllNearShop(token) async {
    // print(.toJson());
    print("hdhdhdh");
    print(Uri.parse(Endpoint.allNearShopAsPerPincode));
    print("hdhdhdh");
    try {
      return await http
          .get(Uri.parse(Endpoint.allNearShopAsPerPincode), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
