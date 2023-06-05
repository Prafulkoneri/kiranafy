import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/category/model/filtter_model.dart';
import 'package:local_supper_market/screen/customer/category/model/seach_product_as_per_category_model.dart';


class ProductAsPerFilterRepo{
  Future<http.Response> getProductAsPerFilter(ProductFilterReqModel reqModel,token) async {
    print(token);
    print(reqModel.toJson());
    try {
      return await http
          .post(Uri.parse(Endpoint.customerProductListAsPerSearch),body: reqModel.toJson(),headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}