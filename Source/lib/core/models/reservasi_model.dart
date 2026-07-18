class ReservasiModel {
  final int id;
  final String plateNumber;
  final String waktuMasuk;
  final String waktuKeluar;
  final int totalDurasi; // menit
  final double totalPrice;
  final String status; // pending | active | completed | cancelled
  final String parkingName;
  final String parkingAddress;

  ReservasiModel({
    required this.id,
    required this.plateNumber,
    required this.waktuMasuk,
    required this.waktuKeluar,
    required this.totalDurasi,
    required this.totalPrice,
    required this.status,
    required this.parkingName,
    required this.parkingAddress,
  });

  factory ReservasiModel.fromJson(Map<String, dynamic> json) {
    return ReservasiModel(
      id: int.parse(json['id'].toString()),
      plateNumber: json['plate_number'] ?? '',
      waktuMasuk: json['waktu_masuk'] ?? '',
      waktuKeluar: json['waktu_keluar'] ?? '',
      totalDurasi: int.tryParse(json['total_durasi'].toString()) ?? 0,
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0,
      status: json['status'] ?? 'pending',
      parkingName: json['parking_name'] ?? '',
      parkingAddress: json['parking_address'] ?? '',
    );
  }
}
