class ParkingSpotModel {
  final int id;
  final String name;
  final String address;
  final double? latitude;
  final double? longitude;
  final String status; // available | not_available
  final double pricePerHour;

  ParkingSpotModel({
    required this.id,
    required this.name,
    required this.address,
    this.latitude,
    this.longitude,
    required this.status,
    required this.pricePerHour,
  });

  bool get isAvailable => status == 'available';

  factory ParkingSpotModel.fromJson(Map<String, dynamic> json) {
    return ParkingSpotModel(
      id: int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      status: json['status'] ?? 'not_available',
      pricePerHour: double.tryParse(json['price_per_hour'].toString()) ?? 0,
    );
  }
}
