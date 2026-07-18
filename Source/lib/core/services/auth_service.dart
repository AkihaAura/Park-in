import '../models/user_model.dart';
import 'api_client.dart';

class AuthService {
  static Future<UserModel> login(String email, String password) async {
    final res = await ApiClient.post('/auth/login.php', {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(res['data']);
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    await ApiClient.post('/auth/register.php', {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone ?? '',
    });
    // Setelah register sukses, langsung login supaya dapat data lengkap (id, saldo, dst)
    return login(email, password);
  }
}
