import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/shop_coupons_model.dart';

class ShopProfileCouponRepo {
  Future<http.Response> sProfileCouponRepo(
      ShopPCouponsReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.sProfileCoupons),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
