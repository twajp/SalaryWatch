import 'package:shared_preferences/shared_preferences.dart';

// 時給のキー
const String hourlyWageKey = 'hourly_wage';

// 時給を保存する関数
Future<void> saveHourlyWage(double hourlyWage) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(hourlyWageKey, hourlyWage);
}

// 時給を読み込む関数
Future<double> loadHourlyWage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble(hourlyWageKey) ?? 1200; // 初期値は1200
}
