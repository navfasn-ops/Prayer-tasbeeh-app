import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const PrayerTasbeehApp());
}

class PrayerTasbeehApp extends StatelessWidget {
  const PrayerTasbeehApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'പ്രയർ & തസ്ബീഹ്',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const MainTabScreen(),
    );
  }
}

class MainTabScreen extends StatelessWidget {
  const MainTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('പ്രയർ & തസ്ബീഹ് കോമ്പാനിയൻ'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.access_time), text: 'നിസ്കാര സമയം'),
              Tab(icon: Icon(Icons.touch_app), text: 'തസ്ബീഹ് കൗണ്ടർ'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PrayerTimesTab(),
            TasbeehCounterTab(),
          ],
        ),
      ),
    );
  }
}
// ---------------- 1. PRAYER TIMES TAB ----------------
class PrayerTimesTab extends StatefulWidget {
  const PrayerTimesTab({super.key});

  @override
  State<PrayerTimesTab> createState() => _PrayerTimesTabState();
}

class _PrayerTimesTabState extends State<PrayerTimesTab> {
  Map<String, dynamic>? _timings;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchPrayerTimes();
  }

  Future<void> _fetchPrayerTimes() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.aladhan.com/v1/timings?latitude=11.0510&longitude=76.0711&method=2'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _timings = data['data']['timings'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'ഡാറ്റ ലഭ്യമായില്ല';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'നെറ്റ്‌വർക്ക് കണക്ഷൻ പരിശോധിക്കുക';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error.isNotEmpty) {
      return Center(child: Text(_error, style: const TextStyle(color: Colors.red)));
    }

    final list = [
      {'name': 'സുബ്ഹി (Fajr)', 'time': _timings?['Fajr']},
      {'name': 'ളൊഹർ (Dhuhr)', 'time': _timings?['Dhuhr']},
      {'name': 'അസർ (Asr)', 'time': _timings?['Asr']},
      {'name': 'മഗ്‌രിബ് (Maghrib)', 'time': _timings?['Maghrib']},
      {'name': 'ഇശാ (Isha)', 'time': _timings?['Isha']},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.mosque, color: Colors.teal),
            title: Text(item['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
            trailing: Text(
              item['time'] ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ),
        );
      },
    );
  }
}
// ---------------- 2. TASBEEH COUNTER TAB ----------------
class TasbeehCounterTab extends StatefulWidget {
  const TasbeehCounterTab({super.key});

  @override
  State<TasbeehCounterTab> createState() => _TasbeehCounterTabState();
}

class _TasbeehCounterTabState extends State<TasbeehCounterTab> {
  int _counter = 0;
  int _dhikrIndex = 0;

  final List<Map<String, dynamic>> _dhikrList = [
    {'arabic': 'سُبْحَانَ اللَّهِ', 'malayalam': 'സുബ്ഹാനല്ലാഹ്', 'target': 33},
    {'arabic': 'الْحَمْدُ لِلَّهِ', 'malayalam': 'അൽഹംദുലില്ലാഹ്', 'target': 33},
    {'arabic': 'اللَّهُ أَكْبَرُ', 'malayalam': 'അല്ലാഹു അക്ബർ', 'target': 33},
    {'arabic': 'صَلَّى اللَّهُ عَلَى مُحَمَّدٍ', 'malayalam': 'സല്ലല്ലാഹു അലാ മുഹമ്മദ്', 'target': 11},
    {'arabic': 'لَا إِلَهَ إِلَّا اللَّهُ', 'malayalam': 'ലാഇലാഹ ഇല്ലല്ലാഹ്', 'target': 11},
  ];

  void _incrementCounter() {
    HapticFeedback.lightImpact();
    setState(() {
      _counter++;
      if (_counter >= _dhikrList[_dhikrIndex]['target']) {
        HapticFeedback.heavyImpact();
        if (_dhikrIndex < _dhikrList.length - 1) {
          _dhikrIndex++;
          _counter = 0;
        } else {
          _showCompletionDialog();
        }
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('തസ്ബീഹ് പൂർത്തിയായി'),
        content: const Text('അല്ലാഹു പ്രാർത്ഥനകൾ സ്വീകരിക്കുമാറാകട്ടെ (ആമീൻ).'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _counter = 0;
                _dhikrIndex = 0;
              });
            },
            child: const Text('വീണ്ടും തുടങ്ങുക'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentDhikr = _dhikrList[_dhikrIndex];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentDhikr['arabic'],
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              currentDhikr['malayalam'],
              style: const TextStyle(fontSize: 20, color: Colors.black54),
            ),
            const SizedBox(height: 35),
            GestureDetector(
              onTap: _incrementCounter,
              child: CircleAvatar(
                radius: 95,
                backgroundColor: Colors.teal.shade500,
                child: Text(
                  '$_counter / ${currentDhikr['target']}',
                  style: const TextStyle(fontSize: 38, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('എണ്ണാൻ വട്ടത്തിൽ ടാപ്പ് ചെയ്യുക', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
