import 'api_client.dart';

class PaymentService {
  /// Memproses pembayaran untuk sebuah reservasi (order_id).
  /// Mengembalikan data tiket digital yang otomatis dibuat backend setelah bayar sukses.
  static Future<Map<String, dynamic>> pay({
    required int orderId,
    required int userId,
    String metodeBayar = 'ewallet',
    String? provider,
  }) async {
    final res = await ApiClient.post('/payment/create.php', {
      'order_id': orderId,
      'user_id': userId,
      'metode_bayar': metodeBayar,
      'provider': provider,
    });
    return res['data'];
  }
}
