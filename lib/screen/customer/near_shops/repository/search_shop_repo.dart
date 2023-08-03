import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/search_shop_model.dart';



class SearchShopRepo{
  Future<http.Response> searchShop(SearchShopRequestModel reqModel,token) async {
    print(token);
    print(reqModel.toJson());
    try {
      return await http
          .post(Uri.parse(Endpoint.searchShop),body: reqModel.toJson(),headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}