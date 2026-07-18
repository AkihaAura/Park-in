import '../models/parking_spot_model.dart';
import 'api_client.dart';

class ParkingService {
  static Future<List<ParkingSpotModel>> list() async {
    final res = await ApiClient.get('/parking/list.php');
    final List spots = res['data']['parking_spots'];
    return spots.map((e) => ParkingSpotModel.fromJson(e)).toList();
  }
}
