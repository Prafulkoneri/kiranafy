import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/remove_coupon_model.dart';


class RemoveCouponRepo {
  Future<http.Response> removeCoupon(
      CustomerRemoveCouponsRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.removeCoupons));
    try {
      return await http.post(Uri.parse(Endpoint.removeCoupons),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
