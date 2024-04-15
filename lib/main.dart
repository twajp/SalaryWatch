import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    // 縦向き
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SalaryWatch',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: const StopwatchPage(title: 'SalaryWatch'),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key, required this.title});

  final String title;

  @override
  StopwatchPageState createState() => StopwatchPageState();
}

class StopwatchPageState extends State<StopwatchPage> {
  Timer? _stopwatchTimer;
  Timer? _clockTimer;
  Duration _elapsed = Duration.zero;
  DateTime _currentTime = DateTime.now();
  bool _isRunning = false;
  int hourlyWage = 1200;

  @override
  void initState() {
    super.initState();
    // 時計用のタイマーを設定して1秒ごとに更新
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    // タイマーのキャンセル
    _stopwatchTimer?.cancel();
    _clockTimer?.cancel();
    super.dispose();
  }

  void _toggleStopwatch() {
    if (_isRunning) {
      // ストップウォッチが動作中の場合、停止
      _stopwatchTimer?.cancel();
    } else {
      // ストップウォッチが停止している場合、開始
      _stopwatchTimer =
          Timer.periodic(const Duration(milliseconds: 10), (timer) {
        setState(() {
          _elapsed += const Duration(milliseconds: 10);
        });
      });
    }
    setState(() {
      _isRunning = !_isRunning; // ストップウォッチの状態をトグル
    });
  }

  void _resetStopwatch() {
    // ストップウォッチをリセット
    _stopwatchTimer?.cancel();
    setState(() {
      _elapsed = Duration.zero;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 端末のロケール情報を取得
    final Locale currentLocale = Localizations.localeOf(context);
    // 通貨マークを取得
    String currencySymbol =
        NumberFormat.simpleCurrency(locale: currentLocale.toString())
            .currencySymbol;
    NumberFormat format = NumberFormat("#,##0.00");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${_elapsed.inHours.toString().padLeft(2, '0')}:'
            '${(_elapsed.inMinutes % 60).toString().padLeft(2, '0')}:'
            '${(_elapsed.inSeconds % 60).toString().padLeft(2, '0')}.'
            '${(_elapsed.inMilliseconds % 1000 / 10).toStringAsFixed(0).padLeft(2, '0')}',
            style: const TextStyle(fontSize: 36),
          ),
          const SizedBox(height: 20),
          Text(
            '$currencySymbol'
            '${format.format((_elapsed.inMilliseconds * (hourlyWage / 60 / 60 / 1000)))}',
            style: const TextStyle(fontSize: 36),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleStopwatch,
                child: Text(_isRunning == false ? '開始' : '停止'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _resetStopwatch,
                child: const Text('リセット'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
