import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PrayerTasbeehApp());
}

class AppColors {
  static const Color darkGreen = Color(0xFF0F382C);
  static const Color background = Color(0xFF0D1B1E);
  static const Color card = Color(0xFF162629);
  static const Color gold = Color(0xFFD4AF37);
  static const Color white = Colors.white;
  static const Color muted = Colors.white70;
}

class PrayerTasbeehApp extends StatelessWidget {
  const PrayerTasbeehApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer & Tasbeeh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.gold,
          secondary: AppColors.darkGreen,
          surface: AppColors.card,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkGreen,
          foregroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkGreen,
          selectedItemColor: AppColors.gold,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
        ),
        useMaterial3: true,
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    PrayerScreen(),
    TasbeehScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prayer & Tasbeeh',
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            activeIcon: Icon(Icons.access_time_filled),
            label: 'Prayer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fingerprint),
            activeIcon: Icon(Icons.fingerprint),
            label: 'Tasbeeh',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined),
            activeIcon: Icon(Icons.apps),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreetingCard(),
            const SizedBox(height: 16),
            _buildDateCard(),
            const SizedBox(height: 16),
            _buildNextPrayerCard(),
            const SizedBox(height: 20),
            const Text(
              'Quick Access',
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildQuickAccessGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.darkGreen,
            AppColors.card,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.35),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assalamu Alaikum',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Prayer & Tasbeeh',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateCard() {
    final now = DateTime.now();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_month,
            color: AppColors.gold,
            size: 32,
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${now.day}/${now.month}/${now.year}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Islamic date will appear here',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNextPrayerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.4),
        ),
      ),
      child: const Column(
        children: [
          Text(
            'Next Prayer',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Fajr',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '--:--',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Prayer time will be calculated from your location',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessGrid(BuildContext context) {
    final items = [
      {
        'title': 'Quran',
        'icon': Icons.menu_book,
        'page': const QuranScreen(),
      },
      {
        'title': 'Duas',
        'icon': Icons.auto_awesome,
        'page': const DuasScreen(),
      },
      {
        'title': 'Qibla',
        'icon': Icons.explore,
        'page': const QiblaScreen(),
      },
      {
        'title': 'Calendar',
        'icon': Icons.calendar_month,
        'page': const CalendarScreen(),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.35,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => item['page'] as Widget,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.gold.withOpacity(0.18),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'] as IconData,
                  color: AppColors.gold,
                  size: 34,
                ),
                const SizedBox(height: 10),
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        PrayerInfoCard(
          name: 'Fajr',
          arabicName: 'الفجر',
          icon: Icons.nightlight_round,
        ),
        PrayerInfoCard(
          name: 'Dhuhr',
          arabicName: 'الظهر',
          icon: Icons.wb_sunny_outlined,
        ),
        PrayerInfoCard(
          name: 'Asr',
          arabicName: 'العصر',
          icon: Icons.wb_sunny,
        ),
        PrayerInfoCard(
          name: 'Maghrib',
          arabicName: 'المغرب',
          icon: Icons.wb_twilight,
        ),
        PrayerInfoCard(
          name: 'Isha',
          arabicName: 'العشاء',
          icon: Icons.nightlight,
        ),
        SizedBox(height: 12),
        Card(
          color: AppColors.card,
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              children: [
                Icon(
                  Icons.timer_outlined,
                  color: AppColors.gold,
                  size: 36,
                ),
                SizedBox(height: 10),
                Text(
                  'Iqamah Countdown',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Iqamah countdown will start only after the corresponding Adhan time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PrayerInfoCard extends StatelessWidget {
  final String name;
  final String arabicName;
  final IconData icon;

  const PrayerInfoCard({
    super.key,
    required this.name,
    required this.arabicName,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: AppColors.gold.withOpacity(0.15),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        leading: Icon(
          icon,
          color: AppColors.gold,
          size: 30,
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          arabicName,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 16,
          ),
        ),
        trailing: const Text(
          '--:--',
          style: TextStyle(
            color: AppColors.gold,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class TasbeehScreen extends StatelessWidget {
  const TasbeehScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _tasbeehOption(
          context,
          icon: Icons.mosque_outlined,
          title: 'After Prayer Dhikr',
          subtitle: 'Fixed post-prayer dhikr routine',
          page: const AfterPrayerDhikrScreen(),
        ),
        const SizedBox(height: 14),
        _tasbeehOption(
          context,
          icon: Icons.fingerprint,
          title: 'Personal Dhikr',
          subtitle: 'Unlimited custom dhikr counter',
          page: const PersonalDhikrScreen(),
        ),
      ],
    );
  }

  Widget _tasbeehOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Card(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(18),
        leading: CircleAvatar(
          backgroundColor: AppColors.darkGreen,
          child: Icon(
            icon,
            color: AppColors.gold,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            subtitle,
            style: const TextStyle(color: AppColors.muted),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.gold,
          size: 18,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}

class AfterPrayerDhikrScreen extends StatelessWidget {
  const AfterPrayerDhikrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const dhikr = [
      ['SubhanAllah', 33],
      ['Alhamdulillah', 33],
      ['Allahu Akbar', 33],
      ['La ilaha illallah', 11],
      ['Sallallahu Alaihi Wasallam', 11],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('After Prayer Dhikr'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dhikr.length,
        itemBuilder: (context, index) {
          return Card(
            color: AppColors.card,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.darkGreen,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: AppColors.gold,
                  ),
                ),
              ),
              title: Text(
                dhikr[index][0] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                '${dhikr[index][1]}',
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PersonalDhikrScreen extends StatelessWidget {
  const PersonalDhikrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Dhikr'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.fingerprint,
                size: 90,
                color: AppColors.gold,
              ),
              const SizedBox(height: 20),
              const Text(
                'Unlimited Personal Dhikr',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Custom dhikr selection, persistent counting and date-wise history will be added here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add New Dhikr'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _menuItem(
          context,
          'Quran',
          Icons.menu_book,
          const QuranScreen(),
        ),
        _menuItem(
          context,
          'Duas & Adhkar',
          Icons.auto_awesome,
          const DuasScreen(),
        ),
        _menuItem(
          context,
          'Qibla',
          Icons.explore,
          const QiblaScreen(),
        ),
        _menuItem(
          context,
          'Hijri Calendar',
          Icons.calendar_month,
          const CalendarScreen(),
        ),
        _menuItem(
          context,
          'Settings',
          Icons.settings,
          const SettingsScreen(),
        ),
      ],
    );
  }

  Widget _menuItem(
    BuildContext context,
    String title,
    IconData icon,
    Widget page,
  ) {
    return Card(
      color: AppColors.card,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.gold,
        ),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 17,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleSectionScreen(
      title: 'Quran',
      icon: Icons.menu_book,
      message: 'Quran section will be implemented next.',
    );
  }
}

class DuasScreen extends StatelessWidget {
  const DuasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleSectionScreen(
      title: 'Duas & Adhkar',
      icon: Icons.auto_awesome,
      message: 'Duas and Adhkar section will be implemented next.',
    );
  }
}

class QiblaScreen extends StatelessWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleSectionScreen(
      title: 'Qibla',
      icon: Icons.explore,
      message: 'Qibla compass will be implemented next.',
    );
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleSectionScreen(
      title: 'Hijri Calendar',
      icon: Icons.calendar_month,
      message: 'Hijri calendar will be implemented next.',
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleSectionScreen(
      title: 'Settings',
      icon: Icons.settings,
      message: 'App settings will be implemented next.',
    );
  }
}

class SimpleSectionScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String message;

  const SimpleSectionScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 80,
                color: AppColors.gold,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
