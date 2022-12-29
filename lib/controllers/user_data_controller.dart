import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataController with ChangeNotifier {
  static Future<Map<String, dynamic>> getNextScreen() async {
    final prefs = await SharedPreferences.getInstance();

    String date = DateTime.now().toIso8601String();
    date = date.substring(0, 10);

    final String dateStored = prefs.getString('date') ?? 'Not Found';

    if (dateStored == 'Not Found' || dateStored != date) {
      prefs.setString('date', date);
      prefs.remove('isBpSkipped');
      prefs.remove('isWeightSkipped');
      prefs.remove('isGlucoseSkipped');
      prefs.remove('isHeartSkipped');
      prefs.remove('isOxygenSkipped');
    }

    bool isBpSkipped = prefs.getBool('isBpSkipped') ?? true;
    bool isWeightSkipped = prefs.getBool('isWeightSkipped') ?? true;
    bool isGlucoseSkipped = prefs.getBool('isGlucoseSkipped') ?? true;
    bool isHeartSkipped = prefs.getBool('isHeartSkipped') ?? true;
    bool isOxygenSkipped = prefs.getBool('isOxygenSkipped') ?? true;

    String abc = '';

    if (isBpSkipped) {
      abc = 'blood_pressure';
    } else if (isWeightSkipped) {
      abc = 'body_weight';
    } else if (isGlucoseSkipped) {
      abc = 'glucose_level';
    } else if (isHeartSkipped) {
      abc = 'heart_rate';
    } else if (isOxygenSkipped) {
      abc = 'blood_oxygen';
    } else {
      abc = 'home_screen';
    }

    int progress = 0;

    progress += isBpSkipped ? 0 : 20;
    progress += isHeartSkipped ? 0 : 20;
    progress += isOxygenSkipped ? 0 : 20;
    progress += isWeightSkipped ? 0 : 20;
    progress += isGlucoseSkipped ? 0 : 20;

    return {'page': abc, 'progress': progress};
  }

  static Future<int> getProgress() async {
    final abc = await getNextScreen();

    final int abci = abc['progress'];



    return abci;
  }
}
