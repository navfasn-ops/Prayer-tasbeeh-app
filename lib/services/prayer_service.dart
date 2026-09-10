import 'dart:convert';

import 'package:http/http.dart' as http;

class PrayerTimes {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  const PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    final timings = json['data']['timings'];

    return PrayerTimes(
      fajr: timings['Fajr'] ?? '--:--',
      sunrise: timings['Sunrise'] ?? '--:--',
      dhuhr: timings['Dhuhr'] ?? '--:--',
      asr: timings['Asr'] ?? '--:--',
      maghrib: timings['Maghrib'] ?? '--:--',
      isha: timings['Isha'] ?? '--:--',
    );
  }
}

class PrayerService {
  static Future<PrayerTimes> getPrayerTimes({
    required double latitude,
    required double longitude,
  }) async {
    final now = DateTime.now();

    final url = Uri.parse(
      'https://api.aladhan.com/v1/timings/${now.day}-'
      '${now.month}-${now.year}'
      '?latitude=$latitude'
      '&longitude=$longitude'
      '&method=4',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load prayer times. '
        'Status code: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;

    if (data['code'] != 200) {
      throw Exception('Prayer time service returned an error.');
    }

    return PrayerTimes.fromJson(data);
  }
}
