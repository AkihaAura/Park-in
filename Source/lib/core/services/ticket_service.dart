import '../models/tiket_model.dart';
import 'api_client.dart';

class TicketService {
  static Future<List<TiketModel>> list(int userId) async {
    final res = await ApiClient.get(
      '/ticket/list.php',
      query: {'user_id': userId.toString()},
    );
    final List items = res['data']['tickets'];
    return items.map((e) => TiketModel.fromJson(e)).toList();
  }
}
