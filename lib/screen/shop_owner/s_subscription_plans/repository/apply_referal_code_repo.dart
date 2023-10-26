import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/s_subscription_plans/model/apply_referal_code_model.dart';

class ReferlCodeRepo {
  Future<http.Response> referCodeApply(
      ApplyReferalCodeReqModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.applyReferCode));
    try {
      return await http.post(Uri.parse(Endpoint.applyReferCode),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
