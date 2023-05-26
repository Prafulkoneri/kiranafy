import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/customer_view_all_category_shop_model.dart';
import 'package:local_supper_market/screen/customer/near_shops/model/customer_view_all_shop_model.dart';
import 'package:local_supper_market/screen/customer/shop_profile/model/customer_view_shop_model.dart';

class CustomerViewAllCategoryShopRepo {
  Future<http.Response> getAllCategoryShopList(
      CustomerViewAllCategoryShopReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.customerViewAllCategoryShop));
    try {
      return await http.post(Uri.parse(Endpoint.customerViewAllCategoryShop),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
