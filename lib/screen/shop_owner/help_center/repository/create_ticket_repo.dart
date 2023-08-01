import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/model/create_ticket_model.dart';

class CreateTicketRepo {
  Future<http.Response> createTicket(
      CreateTicketRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.createTicket));
    try {
      return await http.post(Uri.parse(Endpoint.createTicket),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
