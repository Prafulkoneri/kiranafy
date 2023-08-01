import 'package:http/http.dart' as http;
import 'package:local_supper_market/network/end_points.dart';

class TicketTypeRepo {
  Future<http.Response> ticketType(token) async {
    try {
      return await http.get(Uri.parse(Endpoint.ticketType), headers: {
        "Authorization": "Bearer $token",
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
