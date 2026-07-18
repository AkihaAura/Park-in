import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/parking_spot_model.dart';
import '../../core/services/api_client.dart';
import '../../core/services/booking_service.dart';
import '../../core/session/session.dart';

class BookingPage extends StatefulWidget {
  final ParkingSpotModel spot;
  const BookingPage({super.key, required this.spot});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  DateTime _waktuMasuk = DateTime.now();
  DateTime _waktuKeluar = DateTime.now().add(const Duration(hours: 1));
  bool _isLoading = false;

  @override
  void dispose() {
    _plateController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime({required bool isMasuk}) async {
    final initial = isMasuk ? _waktuMasuk : _waktuKeluar;
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return;

    final picked = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (isMasuk) {
        _waktuMasuk = picked;
      } else {
        _waktuKeluar = picked;
      }
    });
  }

  double get _estimasiDurasiJam {
    final menit = _waktuKeluar.difference(_waktuMasuk).inMinutes;
    return menit <= 0 ? 0 : (menit / 60).ceilToDouble();
  }

  double get _estimasiHarga => _estimasiDurasiJam * widget.spot.pricePerHour;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_waktuKeluar.isBefore(_waktuMasuk) || _waktuKeluar.isAtSameMomentAs(_waktuMasuk)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Waktu keluar harus setelah waktu masuk')),
      );
      return;
    }

    final user = Session.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sesi login habis, silakan login ulang')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await BookingService.create(
        userId: user.id,
        parkingId: widget.spot.id,
        plateNumber: _plateController.text.trim(),
        waktuMasuk: _waktuMasuk,
        waktuKeluar: _waktuKeluar,
      );

      if (!mounted) return;
      // Lanjut ke halaman pembayaran membawa reservasi_id & total harga
      context.push('/payment', extra: {
        'orderId': result['reservasi_id'],
        'totalPrice': double.parse(result['total_price'].toString()),
        'parkingName': widget.spot.name,
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _fmt(DateTime dt) =>
      '${dt.day}/${dt.month}/${dt.year}  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A60C2),
        foregroundColor: Colors.white,
        title: const Text('Booking Parkir'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.spot.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(widget.spot.address, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _plateController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Plat Kendaraan',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Nomor plat wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Waktu Masuk'),
                subtitle: Text(_fmt(_waktuMasuk)),
                trailing: const Icon(Icons.edit_calendar_outlined),
                onTap: () => _pickDateTime(isMasuk: true),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Waktu Keluar'),
                subtitle: Text(_fmt(_waktuKeluar)),
                trailing: const Icon(Icons.edit_calendar_outlined),
                onTap: () => _pickDateTime(isMasuk: false),
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Estimasi Biaya', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    'Rp${_estimasiHarga.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF0A60C2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A60C2),
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Lanjut ke Pembayaran',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
