import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/model/view_ticket_model.dart';

class CViewTicketRepo {
  Future<http.Response> cviewTicket(
      ViewTicketRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.customerViewticket));
    try {
      return await http.post(Uri.parse(Endpoint.customerViewticket),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
