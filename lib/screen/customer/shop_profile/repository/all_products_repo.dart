import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/view_all_offer_products.dart';

class AllOfferProductsRepo {
  Future<http.Response> getAllOffereProducts(
      AllProductsReqModel reqModel, token) async {
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.AllOfferProducts),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
