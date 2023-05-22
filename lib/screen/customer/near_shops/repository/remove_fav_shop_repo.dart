import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/add_fav_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/all_near_shops_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/remove_fav_shop_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';

class RemoveFavShopRepo {
  Future<http.Response> updateRemoveFavShop(
      RemoveFavReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.customerRemoveFvrtshops));
    try {
      return await http.post(Uri.parse(Endpoint.customerRemoveFvrtshops),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
