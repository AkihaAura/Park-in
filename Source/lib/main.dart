import 'package:flutter/material.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Parkin',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter, // Menggunakan konfigurasi router
    );
  }
}
