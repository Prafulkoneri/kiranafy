import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class ShopDeliveryAreaRepo {
  Future<http.Response> deliveryAreaRepo(token, areaname) async {
    print(Uri.parse("${Endpoint.shopDeliveryArealist}?areaname=$areaname"));
    try {
      return await http.get(
          Uri.parse("${Endpoint.shopDeliveryArealist}?areaname=$areaname"),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
