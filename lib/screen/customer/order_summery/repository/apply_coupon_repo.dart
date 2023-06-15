import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/order_summery/model/c_apply_coupon_model.dart';

class OrderSummeryRepo {
  Future<http.Response> viewOrderSummery(
      CustomerApplyCouponsRequestModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.applyCoupons));
    try {
      return await http.post(Uri.parse(Endpoint.applyCoupons),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}