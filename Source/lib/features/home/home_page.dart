import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Mengatur index menu bawah yang aktif

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Background abu-abu sangat muda bersih
      body: Stack(
        children: [
          // ================= UTAMA: KONTEN SCROLL =================
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Biru dengan Background Lengkung
                _buildHeader(screenSize),

                const SizedBox(height: 24),

                // 2. Bagian Feature (Menu Grid)
                _buildFeatureSection(),

                const SizedBox(height: 24),

                // 3. Bagian Last Activity (Horizontal List)
                _buildLastActivitySection(),

                const SizedBox(height: 24),

                // 4. Bagian What's New (Card Besar)
                _buildWhatsNewSection(),

                // Beri space tambahan di bawah agar konten tidak tertutup oleh Floating Navbar
                const SizedBox(height: 100),
              ],
            ),
          ),

          // ================= FLOATING BOTTOM NAVIGATION BAR =================
          _buildFloatingBottomNavbar(),
        ],
      ),
    );
  }

  // 1. WIDGET HEADER & SEARCH BAR
  Widget _buildHeader(Size screenSize) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Biru dengan lengkungan di bawah
        Container(
          height: screenSize.height * 0.25,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF0A60C2), // Menyelaraskan warna biru dari login/register
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome,',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Tombol Profil bulat putih halus
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: const Icon(Icons.person, color: Colors.white, size: 28),
                ),
              ],
            ),
          ),
        ),
        // Search Bar yang melayang (Floating) di bawah header biru
        Positioned(
          bottom: -24,
          left: 24,
          right: 24,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Start Search...',
                hintStyle: const TextStyle(color: Colors.black38),
                prefixIcon: const Icon(Icons.search, color: Colors.black38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 2. WIDGET FEATURE GRID
  Widget _buildFeatureSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Feature',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          // Layout menggunakan Wrap agar otomatis turun ke bawah jika penuh (2 baris)
          Wrap(
            spacing: 20, // Jarak horizontal antar item
            runSpacing: 16, // Jarak vertikal antar baris
            alignment: WrapAlignment.spaceBetween,
            children: [
              _buildFeatureItem(Icons.map_outlined, 'Maps', const Color(0xFFFFE5E5), const Color(0xFFE53935)),
              _buildFeatureItem(Icons.event_available_outlined, 'Event', const Color(0xFFE1F5FE), const Color(0xFF03A9F4)),
              _buildFeatureItem(Icons.bookmark_outline, 'Booking', const Color(0xFFFFF8E1), const Color(0xFFFFB300)),
              _buildFeatureItem(Icons.credit_card_outlined, 'Payment', const Color(0xFFFFE0B2), const Color(0xFFFB8C00)),
              _buildFeatureItem(Icons.confirmation_number_outlined, 'Voucher', const Color(0xFFF3E5F5), const Color(0xFF8E24AA)),
              _buildFeatureItem(Icons.grid_view_rounded, 'More...', const Color(0xFFECEFF1), const Color(0xFF78909C)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label, Color bgColor, Color iconColor) {
    // Menyesuaikan ukuran lebar item agar pas 4 kolom di baris pertama
    final itemWidth = (MediaQuery.of(context).size.width - 48 - 60) / 4;

    return SizedBox(
      width: itemWidth,
      child: Column(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // 3. WIDGET LAST ACTIVITY (HORIZONTAL LIST)
  Widget _buildLastActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Last Activity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'See More...',
                  style: TextStyle(fontSize: 12, color: Color(0xFF0A60C2), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildActivityCard('Artos Mall Magelang', 'Magelang', 'assets/images/parkingbg.jpg'),
              _buildActivityCard('Sleman City Hall', 'Yogyakarta', 'assets/images/parkingbg.jpg'),
              _buildActivityCard('The Aloon-Aloon', 'Magelang', 'assets/images/parkingbg.jpg'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityCard(String title, String location, String imagePath) {
    return Container(
      width: 140,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Lokasi
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                color: Colors.grey[300], // Fallback warna jika aset gambar belum ada
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.image, color: Colors.grey));
                  },
                ),
              ),
            ),
          ),
          // Info Teks
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  location,
                  style: const TextStyle(fontSize: 9, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. WIDGET WHAT'S NEW (BANNER CARD BESAR)
  Widget _buildWhatsNewSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What's New",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/parkingbg.jpg'), // Sesuaikan gambar banner nanti
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Lapisan Hitam Transparan di bagian bawah banner untuk teks
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ALOON-ALOON XXI',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          'New Mall at your city, "The New Aloon-Aloon Mall"',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 5. FLOATING BOTTOM NAVIGATION BAR WIDGET
  Widget _buildFloatingBottomNavbar() {
    return Positioned(
      bottom: 20,
      left: 24,
      right: 24,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 43, 43, 43).withValues(alpha: 0.85), // Gelap transparan modis
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavbarItem(Icons.home_outlined, Icons.home, 'Home', 0),
            _buildNavbarItem(Icons.search, Icons.search, 'Search', 1),
            
            // Tombol QR / Ticket Tengah yang Menonjol Tinggi
            Transform.translate(
              offset: const Offset(0, -12),
              child: Container(
                height: 56,
                width: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFB3E5FC), // Biru sangat muda cerah sesuai foto
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.qr_code_scanner_rounded, color: Color(0xFF0A60C2), size: 28),
                  onPressed: () {
                    setState(() => _currentIndex = 2);
                  },
                ),
              ),
            ),

            _buildNavbarItem(Icons.security_outlined, Icons.security, 'Security', 3),
            _buildNavbarItem(Icons.person_outline_rounded, Icons.person, 'Account', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavbarItem(IconData inactiveIcon, IconData activeIcon, String label, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : inactiveIcon,
            color: isSelected ? Colors.white : Colors.white54,
            size: 24,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white54,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}