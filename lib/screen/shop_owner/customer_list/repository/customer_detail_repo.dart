import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/customer_list/model/customer_detail_model.dart';

class ShopCustomerDetailRepo {
  Future<http.Response> getCustomerDetails(
      ShopCustomerDetailReqModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.shopCustomerDetailView));
    try {
      return await http.post(Uri.parse(Endpoint.shopCustomerDetailView),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
