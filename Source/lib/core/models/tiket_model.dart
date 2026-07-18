class TiketModel {
  final int idTiket;
  final String kodeQr;
  final bool status; // false = belum dipakai, true = sudah dipakai
  final double totalBiaya;
  final String metodeBayar;
  final String plateNumber;
  final String waktuMasuk;
  final String waktuKeluar;
  final String parkingName;
  final String parkingAddress;

  TiketModel({
    required this.idTiket,
    required this.kodeQr,
    required this.status,
    required this.totalBiaya,
    required this.metodeBayar,
    required this.plateNumber,
    required this.waktuMasuk,
    required this.waktuKeluar,
    required this.parkingName,
    required this.parkingAddress,
  });

  factory TiketModel.fromJson(Map<String, dynamic> json) {
    return TiketModel(
      idTiket: int.parse(json['id_tiket'].toString()),
      kodeQr: json['kode_qr'] ?? '',
      status: json['status'].toString() == '1',
      totalBiaya: double.tryParse(json['total_biaya'].toString()) ?? 0,
      metodeBayar: json['metode_bayar'] ?? '',
      plateNumber: json['plate_number'] ?? '',
      waktuMasuk: json['waktu_masuk'] ?? '',
      waktuKeluar: json['waktu_keluar'] ?? '',
      parkingName: json['parking_name'] ?? '',
      parkingAddress: json['parking_address'] ?? '',
    );
  }
}
