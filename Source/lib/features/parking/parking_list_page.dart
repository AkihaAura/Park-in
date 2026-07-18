import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/parking_spot_model.dart';
import '../../core/services/parking_service.dart';

class ParkingListPage extends StatefulWidget {
  const ParkingListPage({super.key});

  @override
  State<ParkingListPage> createState() => _ParkingListPageState();
}

class _ParkingListPageState extends State<ParkingListPage> {
  late Future<List<ParkingSpotModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = ParkingService.list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A60C2),
        foregroundColor: Colors.white,
        title: const Text('Pilih Tempat Parkir'),
      ),
      body: FutureBuilder<List<ParkingSpotModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data: ${snapshot.error}'));
          }
          final spots = snapshot.data ?? [];
          if (spots.isEmpty) {
            return const Center(child: Text('Belum ada tempat parkir tersedia.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: spots.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final s = spots[i];
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),
                  title: Text(
                    s.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${s.address}\nRp${s.pricePerHour.toStringAsFixed(0)}/jam',
                    ),
                  ),
                  isThreeLine: true,
                  trailing: Chip(
                    label: Text(
                      s.isAvailable ? 'Tersedia' : 'Penuh',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    backgroundColor: s.isAvailable ? Colors.green : Colors.grey,
                  ),
                  onTap: s.isAvailable
                      ? () => context.push('/booking', extra: s)
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
