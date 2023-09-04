import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/customer_delivered_refund_submit_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/submit_review_model.dart';
import 'package:local_supper_market/screen/customer/delivery_view/model/update_refund_status_model.dart';

class UpdateDeliveredRefundStatusRepo {
  Future<http.Response> updateDeliveredRefundStatus(
      CustomerDeliveredRefundStatusUpdateReqModel reqModel, token) async {
    print(token);
    print("NNNNNNNNNNNNNNNNNNNNNNNNNN");
    print(reqModel.toJson());
    try {
      return await http.post(Uri.parse(Endpoint.updateDeliveredRefundStatus),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
