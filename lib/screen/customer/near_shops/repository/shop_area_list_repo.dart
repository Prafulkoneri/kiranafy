import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/customer_view_all_shop_model.dart';

class ShopAreaListRepo {
  Future<http.Response> getShopAreaList(token) async {
    print(Uri.parse("${Endpoint.getShopAreaList}"));
    try {
      return await http
          .post(Uri.parse(Endpoint.getShopAreaList), body: {}, headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
