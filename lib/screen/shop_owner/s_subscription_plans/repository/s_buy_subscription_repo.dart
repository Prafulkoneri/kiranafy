import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_edit_profile/model/shop_update_profile_model.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/s_buy_subscription_model.dart';

class ShopBuySubscriptionsRepo {
  Future<http.Response> BuySubScription(
      BuySubscriptionRequestModel reqModel) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.shopbuyscription));
    try {
      return await http.post(Uri.parse(Endpoint.shopbuyscription),
          body: reqModel.toJson(),
          headers: {
            "Authorization":
                "Bearer 10|78G8mC9MzyuxNNvCKtc2n5luBAeG7fDcnpc6Qvcm",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
