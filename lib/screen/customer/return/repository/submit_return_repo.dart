import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/return/model/return_model.dart';
import 'package:local_supper_market/screen/customer/return/model/sumbit_return_order_model.dart';


class SubmitReturnRepo {
  Future<http.Response> submitReturn(SubmitReturnOrderReqModel reqModel, token) async {

    print(reqModel.toJson());
    print(token);
    try {
      return await http.post(Uri.parse(Endpoint.submitReturn),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
