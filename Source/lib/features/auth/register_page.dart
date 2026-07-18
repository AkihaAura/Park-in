import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/api_client.dart';
import '../../core/session/session.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Backdrop Area Atas
            Container(
              height: screenSize.height * 0.27,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 37, 37, 37),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/parkingbg.jpg',
                  ), // Menggunakan aset nanti
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    Colors.black54,
                    BlendMode.darken,
                  ),
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: SizedBox(
                    height: 60,
                    child: Image.asset(
                      'assets/images/parkin_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            // Floating Card Register
            Transform.translate(
              offset: const Offset(0, -35),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.fromLTRB(28, 40, 28, 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(36),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header dengan Tombol Back (Sesuai Figma)
                      Transform.translate(
                        offset: const Offset(-20, 0), // Mempertahankan posisi agak ke kiri
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                         Transform.translate(
                              offset: const Offset(0, -5), 
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.black,
                                  size: 24,
                            ),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            onPressed: () => Navigator.pop(context),
                          )),
                          
                          const SizedBox(width: 5), 
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi!',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  'Make your first step in here',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),

                      
                      const SizedBox(height: 25),

                      // Ilustrasi Gembok & Kunci
                      Center(
                        child: SizedBox(
                          height: 140,
                          child: Image.asset(
                            'assets/images/lock_security.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Input Nama Lengkap
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Nama Lengkap...',
                          hintStyle: const TextStyle(
                            color: Colors.black38,
                            fontStyle: FontStyle.italic,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF0F0F0),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'Mohon isi nama Anda'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Input Email atau Nomor HP
                      TextFormField(
                        controller: _emailPhoneController,
                        decoration: InputDecoration(
                          hintText: 'Email...',
                          hintStyle: const TextStyle(
                            color: Colors.black38,
                            fontStyle: FontStyle.italic,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF0F0F0),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                            ? 'Mohon isi Email atau Nomor HP'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Input Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Password...',
                          hintStyle: const TextStyle(
                            color: Colors.black38,
                            fontStyle: FontStyle.italic,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF0F0F0),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black54,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Mohon isi password baru Anda'
                            : null,
                      ),
                      const SizedBox(height: 25),

                      // Tombol SSO Apple & Google Berdampingan di Bawah Form (Sesuai Figma)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.apple,
                              color: Colors.black,
                              size: 28,
                            ),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: Image.asset(
                              'assets/images/google_logo.png',
                              height: 28,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.g_mobiledata,
                                color: Colors.red,
                                size: 36,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Tombol Utama Create Account
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A60C2),
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final user = await AuthService.register(
        name: _nameController.text.trim(),
        email: _emailPhoneController.text.trim(),
        password: _passwordController.text,
      );
      Session.instance.login(user);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Akun berhasil dibuat, selamat datang ${user.name}!'),
          backgroundColor: const Color(0xFF0A60C2),
        ),
      );
      context.go('/home', extra: user.name);
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak bisa terhubung ke server. Cek koneksi/API.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}