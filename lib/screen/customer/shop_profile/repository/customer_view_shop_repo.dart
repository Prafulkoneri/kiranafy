import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class CustomerViewShopRepo {
  Future<http.Response> getShopDetails(CustomerViewShopReqModel reqModel,token) async {
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.customerViewShop),body: reqModel.toJson(),headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }

}
