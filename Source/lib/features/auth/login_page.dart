import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
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
            // ================= BACKDROP & LOGO AREA =================
            Container(
              height:
                  screenSize.height * 0.27, // Menentukan tinggi area backdrop
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 37, 37, 37),
                image: DecorationImage(
                  image: AssetImage('assets/images/parkingbg.jpg'),
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    Colors.black54,
                    BlendMode.darken,
                  ),
                ),
              ),
              child: SafeArea(child: Center(child: _buildLogo())),
            ),

            // ================= FLOATING CARD LOGIN AREA =================
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
                      color: Colors.black.withValues(
                        alpha: 0.08,
                      ), // Pembaruan API Flutter terbaru agar tidak deprecated
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
                      const Text(
                        'Hi!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          height: 1.1,
                        ),
                      ),
                      const Text(
                        "Let's get your sign in",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Ilustrasi Tengah
                      Center(
                        child: SizedBox(
                          height: 160,
                          child: Image.asset(
                            'assets/images/lock_security.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Input Username & SSO
                      _buildUsernameField(),
                      const SizedBox(height: 16),

                      // Input Password
                      _buildPasswordField(),
                      const SizedBox(height: 20),

                      // Links Navigation
                      _buildNavigationLinks(context),
                      const SizedBox(height: 25),

                      // Tombol Login
                      Center(
                        child: SizedBox(
                          width: 160,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A60C2),
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                              elevation: 2,
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
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

  Widget _buildLogo() {
    return SizedBox(
      height: 60, // sesuaikan tinggi logo
      child: Image.asset(
        'assets/images/parkin_logo.png',
        fit: BoxFit
            .contain, // Menjaga rasio logo agar tidak gepeng atau tertarik
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(
        hintText: 'Username...',
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
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.apple, color: Colors.black, size: 25),
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(4),
                onPressed: () {},
              ),
              // Ganti Icon dengan Image.asset
              IconButton(
                icon: Image.asset(
                  // <-- Ganti di sini
                  'assets/images/google_logo.png',
                  height: 24, // Sesuaikan ukuran kecil agar tidak menimpa teks
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Mohon masukkan username Anda';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
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
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.black54,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mohon masukkan password Anda';
        }
        return null;
      },
    );
  }

  Widget _buildNavigationLinks(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                context.push('/register'), // Jalur ke halaman Create Account
            child: const Text(
              'Create Account',
              style: TextStyle(
                color: Color(0xFF0A60C2),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () => context.push(
              '/forgot-password',
            ), // Jalur ke halaman Forgot Password
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Color(0xFF0A60C2),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mencoba masuk sebagai $username...'),
          backgroundColor: const Color(0xFF0A60C2),
        ),
      );
      context.go('/home');
    }
  }
}
