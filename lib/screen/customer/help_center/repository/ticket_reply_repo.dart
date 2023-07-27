import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/model/ticket_reply_view.dart';

class CustomerTicketReplyRepo {
  Future<http.Response> creplyTicket(
      TicketReplyRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.customerViewticketReply));
    try {
      return await http.post(Uri.parse(Endpoint.customerViewticketReply),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
