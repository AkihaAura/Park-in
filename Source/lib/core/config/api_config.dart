/// Konfigurasi alamat backend PHP.
///
/// - Emulator Android  -> gunakan 10.0.2.2 (alias localhost dari host ke emulator)
/// - iOS Simulator     -> gunakan 127.0.0.1 atau localhost
/// - HP fisik (WiFi)   -> gunakan IP komputer server, misal 192.168.1.5
/// - Chrome/web        -> gunakan localhost
class ApiConfig {
  // Ganti sesuai lokasi folder backend PHP kamu di XAMPP (htdocs/parkin_backend)
  static const String baseUrl = 'http://127.0.0.1:8080/parkin_backend';

  static Uri uri(String path, [Map<String, String>? query]) {
    return Uri.parse('$baseUrl$path').replace(queryParameters: query);
  }
}
