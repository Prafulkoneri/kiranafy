import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CAllCouponList {
  Future<http.Response> couponList(
      token, uptoValue, categoryId, shopId) async {
    print(Uri.parse(
        "${Endpoint.customerAllCouponList}?uptoValue=$uptoValue&category_id=$categoryId&shop_id=$shopId"));

    try {
      return await http.get(
          Uri.parse(
              "${Endpoint.customerAllCouponList}?uptoValue=$uptoValue&category_id=$categoryId&shop_id=$shopId"),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
