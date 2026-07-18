import 'package:flutter/material.dart';
import '../../core/models/tiket_model.dart';
import '../../core/services/ticket_service.dart';
import '../../core/session/session.dart';

class TicketPage extends StatefulWidget {
  final String? highlightKodeQr;
  const TicketPage({super.key, this.highlightKodeQr});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late Future<List<TiketModel>> _future;

  @override
  void initState() {
    super.initState();
    final user = Session.instance.currentUser;
    _future = user != null
        ? TicketService.list(user.id)
        : Future.value(<TiketModel>[]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A60C2),
        foregroundColor: Colors.white,
        title: const Text('Tiket Digital Saya'),
      ),
      body: FutureBuilder<List<TiketModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat tiket: ${snapshot.error}'));
          }
          final tickets = snapshot.data ?? [];
          if (tickets.isEmpty) {
            return const Center(child: Text('Belum ada tiket digital.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: tickets.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final t = tickets[i];
              final isHighlighted = t.kodeQr == widget.highlightKodeQr;
              return Card(
                elevation: isHighlighted ? 4 : 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: isHighlighted
                      ? const BorderSide(color: Color(0xFF0A60C2), width: 2)
                      : BorderSide.none,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.parkingName,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Chip(
                            label: Text(
                              t.status ? 'Sudah Dipakai' : 'Aktif',
                              style: const TextStyle(color: Colors.white, fontSize: 11),
                            ),
                            backgroundColor: t.status ? Colors.grey : Colors.green,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text('Plat: ${t.plateNumber}'),
                      Text('${t.waktuMasuk}  →  ${t.waktuKeluar}'),
                      const Divider(height: 20),
                      Center(
                        child: Column(
                          children: [
                            const Icon(Icons.qr_code_2, size: 96),
                            const SizedBox(height: 8),
                            Text(
                              t.kodeQr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
