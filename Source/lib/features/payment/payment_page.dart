import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/api_client.dart';
import '../../core/services/payment_service.dart';
import '../../core/session/session.dart';

class PaymentPage extends StatefulWidget {
  final int orderId;
  final double totalPrice;
  final String parkingName;

  const PaymentPage({
    super.key,
    required this.orderId,
    required this.totalPrice,
    required this.parkingName,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _metode = 'ewallet'; // pakai saldo internal (kolom users.saldo)
  bool _isLoading = false;

  Future<void> _pay() async {
    final user = Session.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);
    try {
      final result = await PaymentService.pay(
        orderId: widget.orderId,
        userId: user.id,
        metodeBayar: _metode,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pembayaran berhasil! Tiket digital sudah dibuat.'),
          backgroundColor: Colors.green,
        ),
      );
      context.go('/ticket', extra: result['kode_qr']);
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Session.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A60C2),
        foregroundColor: Colors.white,
        title: const Text('Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.parkingName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Bayar'),
                        Text(
                          'Rp${widget.totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xFF0A60C2),
                          ),
                        ),
                      ],
                    ),
                    if (user != null) ...[
                      const SizedBox(height: 4),
                      Text('Saldo Anda: Rp${user.saldo.toStringAsFixed(0)}',
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile(
              value: 'ewallet',
              groupValue: _metode,
              title: const Text('Saldo Park-in (E-Wallet)'),
              onChanged: (v) => setState(() => _metode = v!),
            ),
            RadioListTile(
              value: 'cash',
              groupValue: _metode,
              title: const Text('Cash (bayar di lokasi)'),
              onChanged: (v) => setState(() => _metode = v!),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _pay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A60C2),
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Bayar Sekarang',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
