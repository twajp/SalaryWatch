import 'package:shared_preferences/shared_preferences.dart';

// 時給のキー
const String hourlyWageKey = 'hourly_wage';

// 時給を保存する関数
Future<void> saveHourlyWage(int hourlyWage) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(hourlyWageKey, hourlyWage);
}

// 時給を読み込む関数
Future<double> loadHourlyWage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(hourlyWageKey)?.toDouble() ?? 1200.0; // 初期値は1200.0
}
