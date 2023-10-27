import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/products/model/product_view_model.dart';

class HomeBannerRepo {
  Future<http.Response> homeBannerNavigate(
      ProductViewRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.bannerNavigation));
    try {
      return await http.post(Uri.parse(Endpoint.bannerNavigation),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
