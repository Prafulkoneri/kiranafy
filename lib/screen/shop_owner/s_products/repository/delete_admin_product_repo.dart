import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_products/model/delete_admin_product_model.dart';


class DeleteAdminProductRepo{
  Future<http.Response> deleteProduct(DeleteAdminProductReqModel reqModel,token)async{
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.deleteAdminProduct));
    try {
      return await http.post(Uri.parse(Endpoint.deleteAdminProduct),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}