import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';
import 'package:local_supper_market/screen/shop_owner/help_center/model/ticket_reply_view.dart';

class TicketReplyRepo {
  Future<http.Response> replyTicket(
      TicketReplyRequestModel reqModel, token) async {
    print(token);
    print(reqModel.toJson());
    print(Uri.parse(Endpoint.ticketReply));
    try {
      return await http.post(Uri.parse(Endpoint.ticketReply),
          body: reqModel.toJson(),
          headers: {
            "Authorization": "Bearer $token",
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
