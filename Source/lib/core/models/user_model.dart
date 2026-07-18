class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final double saldo;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.saldo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      saldo: double.tryParse(json['saldo'].toString()) ?? 0,
    );
  }
}
