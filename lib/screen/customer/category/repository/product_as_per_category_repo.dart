import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/category/model/product_as_per_category_model.dart';

class ProductAsPerCategoryRepo{
  Future<http.Response> getProductDetails(ProductAsPerCategoryReqModel reqModel,token) async {
    print(token);
    print(reqModel.toJson());
    try {
      return await http
          .post(Uri.parse(Endpoint.customerProductListAsPerCategory),body: reqModel.toJson(),headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}