import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/model/create_ticket_model.dart';

class CustomerCreateTicketRepo {
  Future<http.Response> createTicket(
      CreateTicketRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.customerCreateTicket));
    try {
      return await http.post(Uri.parse(Endpoint.customerCreateTicket),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
