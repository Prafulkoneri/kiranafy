import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/return/model/return_model.dart';


class OrderReturnRepo {
  Future<http.Response> orderReturn(
      COrderReturnListRequestModel reqModel, token) async {

    print(reqModel.toJson());
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.returnList),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
