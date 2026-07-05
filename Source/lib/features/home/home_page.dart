import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String userName; // <-- Menampung nama dinamis dari Login

  const HomePage({
    super.key,
    this.userName = 'User', // Default-nya 'User' jika data tidak terkirim
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Data Dummy untuk Last Activity (Dapat digeser ke samping)
  final List<Map<String, String>> _lastActivities = [
    {'title': 'Artos Mall Magelang', 'image': 'assets/images/artos_mall.jpg'},
    {
      'title': 'Sleman City Hall Jogjakarta',
      'image': 'assets/images/sleman_city_hall.jpg',
    },
    {
      'title': 'The Aloon Aloon Magelang',
      'image': 'assets/images/aloon_aloon.jpg',
    },
  ];

  // Data Dummy untuk Menu Fitur Utama Grid
  final List<Map<String, dynamic>> _features = [
    {
      'name': 'Maps',
      'icon': Icons.map_outlined,
      'color': const Color(0xFFFFD2D7),
    },
    {
      'name': 'Event',
      'icon': Icons.calendar_month_outlined,
      'color': const Color(0xFFCBEBFF),
    },
    {
      'name': 'Booking',
      'icon': Icons.confirmation_number_outlined,
      'color': const Color(0xFFFFF0C2),
    },
    {
      'name': 'Payment',
      'icon': Icons.credit_card_outlined,
      'color': const Color(0xFFFFE3D1),
    },
    {
      'name': 'Voucher',
      'icon': Icons.local_offer_outlined,
      'color': const Color(0xFFFFE7C4),
    },
    {
      'name': 'More...',
      'icon': Icons.grid_view_rounded,
      'color': const Color(0xFFE5E5E5),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Area Konten Utama (Scrollable Vertikal)
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- AREA HEADER BACKGROUND LANSKAP ---
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: screenSize.height * 0.28,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/home_bg.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Welcome,',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.userName,
                                    style: const TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.8,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 32,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // --- START SEARCH BAR (MELAYANG MEMOTONG HEADER) ---
                    Positioned(
                      bottom: -24,
                      left: 24,
                      right: 24,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF8B1A1A),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Start Search...',
                            hintStyle: TextStyle(
                              color: Colors.black38,
                              fontStyle: FontStyle.italic,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black38,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 45),

                // --- SECTION 1: FEATURE GRID ---
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Feature',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _features.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.85,
                        ),
                    itemBuilder: (context, index) {
                      final item = _features[index];
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: item['color'],
                            child: Icon(
                              item['icon'],
                              color: const Color(0xFF5A5A5A),
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // --- SECTION 2: LAST ACTIVITY (HORIZONTAL LIST) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Last Activity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See More...',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 24, right: 12),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _lastActivities.length,
                    itemBuilder: (context, index) {
                      final activity = _lastActivities[index];
                      return Container(
                        width: 170,
                        margin: const EdgeInsets.only(right: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.grey[300],
                                  image: DecorationImage(
                                    image: AssetImage(activity['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                activity['title']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // --- SECTION 3: WHAT'S NEW ---
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'What\'s New',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.grey[300],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/aloon_aloon.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(24),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.75),
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'THE ALOON ALOON',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'New Mall at your city, "The Aloon Aloon Mall"',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 110),
              ],
            ),
          ),

          // 2. FLOATING BOTTOM NAVIGATION BAR (MENGIKUTI image_53d8a0.png)
          Positioned(
            bottom: 28,
            left: 16,
            right: 16,
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: const Color(
                  0xFFAAAAAA,
                ).withValues(alpha: 0.75), // Latar bar abu-abu agak transparan
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildNavItem(Icons.home_outlined, 'Home', 0),
                  ),
                  Expanded(child: _buildNavItem(Icons.search, 'Search', 1)),

                  // --- TOMBOL TENGAH: TICKET (BULAT & MENONJOL KE ATAS) ---
                  GestureDetector(
                    onTap: () => setState(() => _currentIndex = 2),
                    child: Transform.translate(
                      offset: const Offset(
                        0,
                        -14,
                      ), // Menjorok ke atas memotong bar induk
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(
                            255,
                            8,
                            112,
                            177,
                          ), // Biru muda cerah sesuai gambar
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_scanner_rounded,
                              color: _currentIndex == 2
                                  ? const Color.fromARGB(
                                      255,
                                      170,
                                      205,
                                      255,
                                    ) // Tetap kontras biru tua kalau terpilih
                                  : Colors.white, // Putih standar sesuai gambar
                              size: 32,
                            ),
                            const SizedBox(height: 1),
                            const Text(
                              'Ticket',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: _buildNavItem(Icons.shield_outlined, 'Security', 3),
                  ),
                  Expanded(
                    child: _buildNavItem(
                      Icons.person_outline_rounded,
                      'Account',
                      4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- MODEL ITEM KAPSUL DINAMIS SESUAI image_53d8a0.png ---
  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          // Jika dipilih -> Putih Terang. Jika tidak -> Kapsul Abu-abu Gelap.
          color: isSelected
              ? Colors.white
              : const Color(0xFF666666).withValues(alpha: 0.9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              // Jika dipilih -> Ikon Biru. Jika tidak -> Ikon Putih.
              color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
              size: 22,
            ),
            const SizedBox(height: 1),
            Text(
              label,
              style: TextStyle(
                // Jika dipilih -> Teks Biru. Jika tidak -> Teks Putih.
                color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
