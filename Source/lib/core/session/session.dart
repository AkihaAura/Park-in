import '../models/user_model.dart';

/// Penyimpanan sesi user sederhana (in-memory, hilang saat app ditutup).
/// Untuk versi produksi, sebaiknya diganti dengan shared_preferences / secure storage.
class Session {
  Session._();
  static final Session instance = Session._();

  UserModel? currentUser;

  bool get isLoggedIn => currentUser != null;

  void login(UserModel user) => currentUser = user;

  void logout() => currentUser = null;
}
