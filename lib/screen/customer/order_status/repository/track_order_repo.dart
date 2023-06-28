import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/order_status/model/track_order_status_model.dart';

class TrakOrderRepo {
  Future<http.Response> trackOrder(
      TrackOrderRequestodel reqModel, token) async {
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.trackOrder));
    try {
      return await http.post(Uri.parse(Endpoint.trackOrder),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
