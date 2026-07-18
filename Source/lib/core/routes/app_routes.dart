import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/register_page.dart'; // Tambahkan import ini
import '../../features/auth/forgot_password_page.dart'; // Tambahkan import ini
import '../../features/home/home_page.dart';
import '../../features/parking/parking_list_page.dart';
import '../../features/booking/booking_page.dart';
import '../../features/payment/payment_page.dart';
import '../../features/ticket/ticket_page.dart';
import '../models/parking_spot_model.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) =>
          const RegisterPage(), // Daftarkan RegisterPage
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) =>
          const ForgotPasswordPage(), // Daftarkan ForgotPasswordPage
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        // Menangkap parameter 'extra' yang dikirim dari login_page
        final name = state.extra as String? ?? 'User';
        return HomePage(userName: name);
      },
    ),
    GoRoute(
      path: '/parking',
      builder: (context, state) => const ParkingListPage(),
    ),
    GoRoute(
      path: '/booking',
      builder: (context, state) {
        final spot = state.extra as ParkingSpotModel;
        return BookingPage(spot: spot);
      },
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return PaymentPage(
          orderId: int.parse(data['orderId'].toString()),
          totalPrice: double.parse(data['totalPrice'].toString()),
          parkingName: data['parkingName'] as String,
        );
      },
    ),
    GoRoute(
      path: '/ticket',
      builder: (context, state) {
        final kodeQr = state.extra as String?;
        return TicketPage(highlightKodeQr: kodeQr);
      },
    ),
  ],
);
