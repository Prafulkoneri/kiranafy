import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/Offer_seasonal_recommanded/model/remove_srf_model.dart';

class RemoveSRFProductsRepo {
  Future<http.Response> SrfRemoveProducts(
      RemoveSRFProductsRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.removeSRFProducts));
    try {
      return await http.post(Uri.parse(Endpoint.removeSRFProducts),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
