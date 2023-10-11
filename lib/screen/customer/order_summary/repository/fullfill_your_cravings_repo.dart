import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/fullfill_cravings_model.dart';
import 'package:local_supper_market/screen/customer/order_summary/model/order_summary_model.dart';

class FullFillYourCravingsRepo {
  Future<http.Response> getFullYourCravingsList(
      FullFillCravingsReqModel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.getFullFillCravingList));
    try {
      return await http.post(Uri.parse(Endpoint.getFullFillCravingList),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
