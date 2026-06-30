import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isCodeSent =
      false; // State pemisah antara input email dan input kode OTP

  @override
  void dispose() {
    _emailController.dispose();
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
                  image: AssetImage('assets/images/parkingbg.jpg'),
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

            // Floating Card Forgot Password
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
                      // Header dengan tombol Back
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (_isCodeSent) {
                                setState(() => _isCodeSent = false);
                              } else {
                                Navigator.pop(context);
                              }
                            },
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _isCodeSent ? 'is this you?' : 'Hi!',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  _isCodeSent
                                      ? 'Check your email box'
                                      : "Let's get back your memories",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Ilustrasi Tengah
                      Center(
                        child: SizedBox(
                          height: 140,
                          child: Image.asset(
                            'assets/images/lock_security.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),

                      // Kondisional Konten Form (Email atau OTP)
                      if (!_isCodeSent) ...[
                        // Tampilan Langkah 1: Input Email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email or Phone Number...',
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
                              ? 'Mohon masukkan akun Anda'
                              : null,
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: GestureDetector(
                            onTap: () => context.push('/register'),
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                color: Color(0xFF0A60C2),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        // Tampilan Langkah 2: Input 6 Kotak Bulat OTP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(6, (index) => _buildOtpBox()),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              // Logika kirim ulang kode
                            },
                            child: const Text(
                              'Resend Code',
                              style: TextStyle(
                                color: Color(0xFF0A60C2),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 30),

                      // Tombol Dinamis (Find My Account / Verify)
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _handleButtonClick,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A60C2),
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                            ),
                            child: Text(
                              _isCodeSent ? 'Verify' : 'Find My Account',
                              style: const TextStyle(
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

  // Desain Kotak OTP Bulat Halus Sesuai Gambar Konfirmasi
  Widget _buildOtpBox() {
    return SizedBox(
      width: 42,
      height: 42,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) FocusScope.of(context).nextFocus();
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFEAEAEA),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _handleButtonClick() {
    if (_formKey.currentState!.validate()) {
      if (!_isCodeSent) {
        setState(() => _isCodeSent = true); // Pindah ke halaman konfirmasi OTP
      } else {
        // Logika verifikasi sukses
      }
    }
  }
}
