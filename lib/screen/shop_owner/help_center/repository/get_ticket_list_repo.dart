import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class TicketListRepo {
  Future<http.Response> ticketList(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.ticketList), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
