import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class CAllCouponList {
  Future<http.Response> couponList(
      token, upto_value, category_id, shop_id) async {
    print(Uri.parse(
        "${Endpoint.customerAllCouponList}?uptoValue=${upto_value}&category_id=${category_id}&shop_id=${shop_id}"));

    try {
      return await http.get(
          Uri.parse(
              "${Endpoint.customerAllCouponList}?uptoValue=${upto_value}&category_id=${category_id}&shop_id=${shop_id}"),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
