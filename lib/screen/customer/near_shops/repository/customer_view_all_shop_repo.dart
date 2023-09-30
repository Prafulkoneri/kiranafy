import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/customer_view_all_shop_model.dart';

class CustomerViewAllShopRepo {
  Future<http.Response> getAllShopList(
      CustomerViewAllShopReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse("${Endpoint.customerViewAllShop}"));
    try {
      return await http.post(Uri.parse(Endpoint.customerViewAllShop),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
