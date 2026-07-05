import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/register_page.dart'; // Tambahkan import ini
import '../../features/auth/forgot_password_page.dart'; // Tambahkan import ini
import '../../features/home/home_page.dart';

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
    builder: (context, state) => const HomePage(),
),
  ],
);
