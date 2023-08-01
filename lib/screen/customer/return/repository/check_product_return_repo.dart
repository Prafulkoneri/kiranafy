import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/return/model/check_product_model.dart';



class CheckProductReturnRepo {
  Future<http.Response> checkProductReturn(
      CheckProductRequestModel reqModel, token) async {

    print(reqModel.toJson());
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.checkReturnProduct),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
