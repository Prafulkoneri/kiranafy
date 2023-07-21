import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/review/model/customer_review_list_shop_model.dart';

class ShopReviewListRepo {
  Future<http.Response> shopReviewList(
      CustomerShopReviewListRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.reviewshoplist),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
