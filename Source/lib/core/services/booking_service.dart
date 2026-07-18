import '../models/reservasi_model.dart';
import 'api_client.dart';

class BookingService {
  /// Membuat reservasi baru. Mengembalikan id reservasi untuk dilanjutkan ke pembayaran.
  static Future<Map<String, dynamic>> create({
    required int userId,
    required int parkingId,
    required String plateNumber,
    required DateTime waktuMasuk,
    required DateTime waktuKeluar,
  }) async {
    final res = await ApiClient.post('/booking/create.php', {
      'user_id': userId,
      'parking_id': parkingId,
      'plate_number': plateNumber,
      'waktu_masuk': _format(waktuMasuk),
      'waktu_keluar': _format(waktuKeluar),
    });
    return res['data'];
  }

  static Future<List<ReservasiModel>> list(int userId) async {
    final res = await ApiClient.get(
      '/booking/list.php',
      query: {'user_id': userId.toString()},
    );
    final List items = res['data']['reservasi'];
    return items.map((e) => ReservasiModel.fromJson(e)).toList();
  }

  static String _format(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${dt.year}-${two(dt.month)}-${two(dt.day)} ${two(dt.hour)}:${two(dt.minute)}:00';
  }
}
