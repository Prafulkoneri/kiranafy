import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_shop_configuration/model/shop_configuration_edit_request_model.dart';

class EditConfigRepo {
  Future<http.Response> EditShopconfig(
      ShopConfigRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.shopconfigurationedit));
    try {
      return await http.post(Uri.parse(Endpoint.shopconfigurationedit),
          body: reqModel.toJson(),
          headers: {
            "Authorization":
                "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
